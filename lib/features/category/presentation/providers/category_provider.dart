import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:pocketly/core/core.dart';
import 'package:pocketly/features/user/user.dart';
import '../../domain/entities/category_entity.dart';
import '../../domain/repositories/category_repository.dart';
import '../../domain/usecases/get_all_categories_usecase.dart';
import '../../domain/usecases/create_custom_category_usecase.dart';
import '../../domain/usecases/delete_custom_category_usecase.dart';
import '../../domain/errors/category_errors.dart';
import '../../data/repositories/category_repository_impl.dart';

part 'category_provider.g.dart';

/// Provider pour SupabaseClient
@riverpod
SupabaseClient supabaseClient(Ref ref) {
  return Supabase.instance.client;
}

/// Provider pour CategoryRepository
@riverpod
CategoryRepository categoryRepository(Ref ref) {
  final supabase = ref.watch(supabaseClientProvider);
  final prefs = ref.watch(sharedPreferencesProvider);

  return CategoryRepositoryImpl(supabase: supabase, prefs: prefs);
}

/// Provider pour les use cases
@riverpod
GetAllCategoriesUseCase getAllCategoriesUseCase(Ref ref) {
  final repository = ref.watch(categoryRepositoryProvider);
  return GetAllCategoriesUseCase(repository);
}

@riverpod
CreateCustomCategoryUseCase createCustomCategoryUseCase(Ref ref) {
  final repository = ref.watch(categoryRepositoryProvider);
  return CreateCustomCategoryUseCase(repository);
}

@riverpod
DeleteCustomCategoryUseCase deleteCustomCategoryUseCase(Ref ref) {
  final repository = ref.watch(categoryRepositoryProvider);
  return DeleteCustomCategoryUseCase(repository);
}


/// Notifier pour la gestion des catégories
@riverpod
class CategoryNotifier extends _$CategoryNotifier {
  @override
  Future<List<CategoryEntity>> build() async {
    // Charger les catégories au démarrage
    ref.read(loggerProvider).d('build() appelé');

    try {
      final useCase = _getAllCategoriesUseCase;
      final categories = await useCase();
      ref.read(loggerProvider).d('build() retourne ${categories.length} catégories');
      return categories;
    } catch (e) {
      ref.read(loggerProvider).e('Erreur dans build()', error: e);
      rethrow;
    }
  }

  GetAllCategoriesUseCase get _getAllCategoriesUseCase =>
      ref.read(getAllCategoriesUseCaseProvider);
  CreateCustomCategoryUseCase get _createCustomCategoryUseCase =>
      ref.read(createCustomCategoryUseCaseProvider);
  DeleteCustomCategoryUseCase get _deleteCustomCategoryUseCase =>
      ref.read(deleteCustomCategoryUseCaseProvider);

  /// Charge toutes les catégories avec retry automatique et progress
  Future<void> loadCategories() async {
    ref.read(loggerProvider).d('Début du chargement des catégories...');

    // Utiliser AsyncLoading avec progress
    state = const AsyncValue.loading(progress: 0.0);

    try {
      // Simuler le progress
      state = const AsyncValue.loading(progress: 0.3);

      final useCase = _getAllCategoriesUseCase;
      ref.read(loggerProvider).d('UseCase récupéré, appel de getAllCategories...');

      final categories = await useCase();
      ref.read(loggerProvider).d('Catégories récupérées: ${categories.length}');

      // Log détaillé des catégories
      for (final category in categories) {
        ref.read(loggerProvider).d('- ${category.name} (${category.isCustom ? 'CUSTOM' : 'DEFAULT'}) - Type: ${category.type}');
      }

      // Finaliser avec les données
      state = AsyncValue.data(categories);
      ref.read(loggerProvider).d('État mis à jour avec ${categories.length} catégories');
    } catch (e, stackTrace) {
      ref.read(loggerProvider).e('Erreur lors du chargement des catégories', error: e, stackTrace: stackTrace);

      // Le retry automatique sera géré par Riverpod 3.0
      // avec backoff exponentiel
      state = AsyncValue.error(e, stackTrace);
    }
  }

  /// Rafraîchit les catégories
  Future<void> refreshCategories() async {
    await loadCategories();
  }

  /// Synchronise les catégories (force la mise à jour depuis le serveur)
  Future<void> syncCategories() async {
    ref.read(loggerProvider).i('Synchronisation des catégories...');

    try {
      // Forcer la synchronisation via le repository
      final repository = ref.read(categoryRepositoryProvider);
      await repository.syncCategories();

      // Recharger les catégories depuis le cache fraîchement mis à jour
      await loadCategories();

      ref.read(loggerProvider).i('Synchronisation terminée');
    } catch (e, stackTrace) {
      ref.read(loggerProvider).e('Erreur lors de la synchronisation', error: e, stackTrace: stackTrace);
      state = AsyncValue.error(e, stackTrace);
      rethrow;
    }
  }

  /// Crée une catégorie custom
  ///
  /// Throws:
  /// - [UserNotAuthenticatedError] si l'utilisateur n'est pas connecté
  /// - [PremiumRequiredError] si l'utilisateur n'est pas premium
  /// - [ValidationError] si les données sont invalides
  Future<void> createCustomCategory({
    required String name,
    required CategoryType type,
    required String iconName,
    required String color,
  }) async {
    try {
      // Vérifier d'abord l'état d'authentification via AuthService
      final authService = AuthService();
      if (!authService.isAuthenticated) {
        throw const UserNotAuthenticatedError(
          userMessage:
              'Vous devez être connecté pour créer une catégorie personnalisée.',
          technicalMessage:
              'User not authenticated when attempting to create category',
        );
      }

      // Récupérer l'utilisateur actuel via le userProvider
      // IMPORTANT: Attendre que les données utilisateur soient chargées
      UserEntity? currentUser;

      try {
        // Attendre que le provider se charge complètement
        currentUser = await ref.read(currentUserProvider.future);
      } catch (e) {
        throw UserNotAuthenticatedError(
          userMessage: 'Erreur lors du chargement des données utilisateur.',
          technicalMessage: 'Error loading user data: $e',
        );
      }

      // Vérifier que l'utilisateur est connecté
      if (currentUser == null) {
        throw const UserNotAuthenticatedError(
          userMessage:
              'Vous devez être connecté pour créer une catégorie personnalisée.',
          technicalMessage:
              'Attempted to create custom category without authenticated user',
        );
      }

      // Vérifier le statut premium de l'utilisateur
      final isPremium = currentUser.canAccessPremium;

      final useCase = _createCustomCategoryUseCase;
      await useCase(
        name: name,
        type: type,
        iconName: iconName,
        color: color,
        userId: currentUser.id,
        isPremium: isPremium,
      );

      // Recharger toutes les catégories depuis le cache
      // Le cache a été mis à jour dans le repository avec la nouvelle catégorie
      // Cette approche garantit que toutes les catégories sont présentes
      await loadCategories();
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      rethrow;
    }
  }

  /// Supprime une catégorie custom
  Future<void> deleteCustomCategory(String categoryId) async {
    try {
      final useCase = _deleteCustomCategoryUseCase;
      await useCase(categoryId);

      // Mettre à jour l'état en supprimant la catégorie
      state = state.when(
        data: (categories) => AsyncValue.data(
          categories.where((cat) => cat.id != categoryId).toList(),
        ),
        loading: () => state,
        error: (error, stackTrace) => state,
      );
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  /// Met à jour une catégorie custom
  ///
  /// Throws:
  /// - [UserNotAuthenticatedError] si l'utilisateur n'est pas connecté
  /// - [ValidationError] si les données sont invalides
  /// - [NotFoundError] si la catégorie n'existe pas
  Future<void> updateCustomCategory({
    required String categoryId,
    required String name,
    required String iconName,
    required String color,
  }) async {
    try {
      // Vérifier l'authentification
      final authService = AuthService();
      if (!authService.isAuthenticated) {
        throw const UserNotAuthenticatedError(
          userMessage: 'Vous devez être connecté pour modifier une catégorie.',
          technicalMessage:
              'User not authenticated when attempting to update category',
        );
      }

      // Récupérer la catégorie existante
      final existingCategory = state.value?.firstWhere(
        (cat) => cat.id == categoryId,
        orElse: () => throw const NotFoundError(
          resourceType: 'Catégorie',
          userMessage: 'La catégorie à modifier n\'existe pas.',
          technicalMessage: 'Category not found for update',
        ),
      );

      if (existingCategory == null) {
        throw const NotFoundError(
          resourceType: 'Catégorie',
          userMessage: 'La catégorie à modifier n\'existe pas.',
          technicalMessage: 'Category not found in state',
        );
      }

      // Créer la catégorie mise à jour (on ne peut pas modifier le type)
      final updatedCategory = existingCategory.copyWith(
        name: name,
        iconName: iconName,
        color: color,
      );

      // Utiliser le repository pour mettre à jour
      final repository = ref.read(categoryRepositoryProvider);
      await repository.updateCustomCategory(updatedCategory);

      // Recharger toutes les catégories depuis le cache
      // Le cache a été mis à jour dans le repository
      await loadCategories();
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      rethrow;
    }
  }

  /// Filtre les catégories par type
  List<CategoryEntity> getCategoriesByType(CategoryType type) {
    return state.when(
      data: (categories) =>
          categories.where((cat) => cat.type == type).toList(),
      loading: () => [],
      error: (_, _) => [],
    );
  }

  /// Récupère les catégories custom
  List<CategoryEntity> get customCategories {
    return state.when(
      data: (categories) => categories.where((cat) => cat.isCustom).toList(),
      loading: () => [],
      error: (_, _) => [],
    );
  }

  /// Récupère les catégories par défaut
  List<CategoryEntity> get defaultCategories {
    return state.when(
      data: (categories) => categories.where((cat) => cat.isDefault).toList(),
      loading: () => [],
      error: (_, _) => [],
    );
  }
}

// Provider généré automatiquement par @riverpod
// Utiliser: categoryProvider

/// Provider pour les catégories filtrées par type
@riverpod
List<CategoryEntity> categoriesByType(Ref ref, CategoryType type) {
  final categoryAsync = ref.watch(categoryProvider);
  return categoryAsync.when(
    data: (categories) =>
        categories.where((cat) => cat.type == type).toList(),
    loading: () => [],
    error: (_, _) => [],
  );
}

/// Provider AsyncValue pour les catégories filtrées par type
/// Préserve les états de loading et error
@riverpod
AsyncValue<List<CategoryEntity>> categoriesByTypeAsync(
  Ref ref,
  CategoryType type,
) {
  final categoryAsync = ref.watch(categoryProvider);
  final logger = ref.read(loggerProvider);

  logger.d('Type recherché: $type');
  logger.d('État du provider: ${categoryAsync.runtimeType}');

  return categoryAsync.whenData((categories) {
    logger.d('Total catégories reçues: ${categories.length}');
    for (final cat in categories) {
      logger.d('- ${cat.name}: type=${cat.type}, typeMatch=${cat.type == type}');
    }

    final filtered = categories.where((cat) => cat.type == type).toList();
    logger.d('Catégories filtrées: ${filtered.length}');

    return filtered;
  });
}

/// Provider pour les catégories custom
@riverpod
List<CategoryEntity> customCategories(Ref ref) {
  final categoryAsync = ref.watch(categoryProvider);
  return categoryAsync.when(
    data: (categories) => categories.where((cat) => cat.isCustom).toList(),
    loading: () => [],
    error: (_, _) => [],
  );
}

/// Provider pour les catégories par défaut
@riverpod
List<CategoryEntity> defaultCategories(Ref ref) {
  final categoryAsync = ref.watch(categoryProvider);
  return categoryAsync.when(
    data: (categories) => categories.where((cat) => cat.isDefault).toList(),
    loading: () => [],
    error: (_, _) => [],
  );
}

/// Provider pour récupérer une catégorie par son ID
@riverpod
CategoryEntity? categoryById(Ref ref, String categoryId) {
  final categoryAsync = ref.watch(categoryProvider);

  return categoryAsync.when(
    data: (categories) {
      try {
        return categories.firstWhere((cat) => cat.id == categoryId);
      } catch (e) {
        return null;
      }
    },
    loading: () => null,
    error: (_, __) => null,
  );
}

// Dart core libraries
import 'dart:async';

// Third-party packages
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Internal packages (core)
import 'package:pocketly/core/core.dart';

// Internal packages (features)
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/user_repository.dart';
import '../../domain/usecases/get_current_user_usecase.dart';
import '../../domain/usecases/create_user_usecase.dart';
import '../../domain/usecases/update_user_usecase.dart';
import '../../domain/usecases/delete_user_usecase.dart';
import '../../domain/usecases/activate_trial_usecase.dart';
import '../../domain/usecases/activate_premium_usecase.dart';
import '../../domain/usecases/complete_onboarding_usecase.dart';
import '../../data/repositories/user_repository_impl.dart';
import '../../data/datasources/user_remote_datasource.dart';
import '../../data/datasources/user_remote_datasource_impl.dart';
import '../../data/datasources/user_local_datasource.dart';
import '../../data/datasources/user_local_datasource_impl.dart';

part 'user_provider.g.dart';

/// Provider pour le datasource remote
@riverpod
UserRemoteDataSource userRemoteDataSource(Ref ref) {
  final supabase = SupabaseConfig.client;
  return UserRemoteDataSourceImpl(supabase);
}

/// Provider pour le datasource local
@riverpod
UserLocalDataSource userLocalDataSource(Ref ref) {
  final secureStorage = ref.watch(secureStorageProvider);
  return UserLocalDataSourceImpl(secureStorage);
}

/// Provider pour le repository utilisateur
@riverpod
Future<UserRepository> userRepository(Ref ref) async {
  final remoteDataSource = ref.watch(userRemoteDataSourceProvider);
  final localDataSource = ref.watch(userLocalDataSourceProvider);
  return UserRepositoryImpl(remoteDataSource, localDataSource);
}

/// Provider pour le use case getCurrentUser
@riverpod
Future<GetCurrentUserUseCase> getCurrentUserUseCase(Ref ref) async {
  final userRepository = await ref.watch(userRepositoryProvider.future);
  return GetCurrentUserUseCase(userRepository);
}

/// Provider pour le use case createUser
@riverpod
Future<CreateUserUseCase> createUserUseCase(Ref ref) async {
  final userRepository = await ref.watch(userRepositoryProvider.future);
  return CreateUserUseCase(userRepository);
}

/// Provider pour le use case updateUser
@riverpod
Future<UpdateUserUseCase> updateUserUseCase(Ref ref) async {
  final userRepository = await ref.watch(userRepositoryProvider.future);
  return UpdateUserUseCase(userRepository);
}

/// Provider pour le use case deleteUser
@riverpod
Future<DeleteUserUseCase> deleteUserUseCase(Ref ref) async {
  final userRepository = await ref.watch(userRepositoryProvider.future);
  return DeleteUserUseCase(userRepository);
}

/// Provider pour le use case activateTrial
@riverpod
Future<ActivateTrialUseCase> activateTrialUseCase(Ref ref) async {
  final userRepository = await ref.watch(userRepositoryProvider.future);
  return ActivateTrialUseCase(userRepository);
}

/// Provider pour le use case activatePremium
@riverpod
Future<ActivatePremiumUseCase> activatePremiumUseCase(Ref ref) async {
  final userRepository = await ref.watch(userRepositoryProvider.future);
  return ActivatePremiumUseCase(userRepository);
}

/// Provider pour le use case completeOnboarding
@riverpod
Future<CompleteOnboardingUseCase> completeOnboardingUseCase(Ref ref) async {
  final userRepository = await ref.watch(userRepositoryProvider.future);
  return CompleteOnboardingUseCase(userRepository);
}

/// Notifier pour la gestion de l'utilisateur actuel
@riverpod
class CurrentUserNotifier extends _$CurrentUserNotifier {
  @override
  Future<UserEntity?> build() async {
    // Charger l'utilisateur initial
    return await _loadUser();
  }

  /// Charge l'utilisateur actuel
  Future<UserEntity?> _loadUser() async {
    try {
      ref.read(loggerProvider).d('🔵 [User] Chargement de l\'utilisateur actuel...');
      final getCurrentUserUseCase = await ref.read(
        getCurrentUserUseCaseProvider.future,
      );
      final user = await getCurrentUserUseCase();

      if (user != null) {
        ref.read(loggerProvider).i('✅ [User] Utilisateur chargé: ${user.email} (ID: ${user.id})');
      } else {
        ref.read(loggerProvider).w('⚠️ [User] Aucun utilisateur trouvé');
      }

      return user;
    } catch (e, stackTrace) {
      // Log l'erreur avec le logger centralisé
      ref
          .read(loggerProvider)
          .e('❌ [User] Erreur lors du chargement de l\'utilisateur', error: e, stackTrace: stackTrace);
      rethrow; // Re-throw l'erreur spécifique
    }
  }

  /// Rafraîchit l'utilisateur
  Future<void> refreshUser() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return await _loadUser();
    });
  }

  /// Met à jour l'utilisateur
  Future<void> updateUser(UserEntity user) async {
    try {
      state = const AsyncValue.loading();
      final updateUserUseCase = await ref.read(
        updateUserUseCaseProvider.future,
      );
      final updatedUser = await updateUserUseCase(user);
      state = AsyncValue.data(updatedUser);
    } catch (e) {
      ref
          .read(loggerProvider)
          .e('Erreur lors de la mise à jour de l\'utilisateur', error: e);
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  /// Active le trial
  Future<void> activateTrial(String userId) async {
    try {
      state = const AsyncValue.loading();
      final activateTrialUseCase = await ref.read(
        activateTrialUseCaseProvider.future,
      );
      final updatedUser = await activateTrialUseCase(userId);
      state = AsyncValue.data(updatedUser);
    } catch (e) {
      ref
          .read(loggerProvider)
          .e('Erreur lors de l\'activation du trial', error: e);
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  /// Active le premium
  Future<void> activatePremium(String userId, DateTime expiresAt) async {
    try {
      state = const AsyncValue.loading();
      final activatePremiumUseCase = await ref.read(
        activatePremiumUseCaseProvider.future,
      );
      final updatedUser = await activatePremiumUseCase(userId, expiresAt);
      state = AsyncValue.data(updatedUser);
    } catch (e) {
      ref
          .read(loggerProvider)
          .e('Erreur lors de l\'activation du premium', error: e);
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  /// Complète l'onboarding
  Future<void> completeOnboarding(String userId) async {
    try {
      state = const AsyncValue.loading();
      final completeOnboardingUseCase = await ref.read(
        completeOnboardingUseCaseProvider.future,
      );
      final updatedUser = await completeOnboardingUseCase(userId);
      state = AsyncValue.data(updatedUser);
    } catch (e) {
      ref
          .read(loggerProvider)
          .e('Erreur lors de la complétion de l\'onboarding', error: e);
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  /// Met à jour la règle budgétaire personnalisée
  Future<void> updateBudgetRule({
    required int needs,
    required int wants,
    required int savings,
  }) async {
    try {
      // Récupérer l'utilisateur actuel
      final currentUser = state.value;
      if (currentUser == null) {
        throw Exception('Utilisateur non connecté');
      }

      ref.read(loggerProvider).d('🔵 [UserProvider] Mise à jour règle budgétaire: $needs/$wants/$savings');

      state = const AsyncValue.loading();

      // Appeler le repository pour mettre à jour la règle
      final userRepository = await ref.read(userRepositoryProvider.future);
      final updatedUser = await userRepository.updateBudgetRule(
        userId: currentUser.id,
        needs: needs,
        wants: wants,
        savings: savings,
      );

      ref.read(loggerProvider).i('✅ [UserProvider] État mis à jour avec: ${updatedUser.budgetRuleNeeds}/${updatedUser.budgetRuleWants}/${updatedUser.budgetRuleSavings}');

      state = AsyncValue.data(updatedUser);
    } catch (e) {
      ref.read(loggerProvider).e(
            'Erreur lors de la mise à jour de la règle budgétaire',
            error: e,
          );
      state = AsyncValue.error(e, StackTrace.current);
      rethrow;
    }
  }

  /// Supprime le compte utilisateur et toutes ses données associées
  /// ⚠️ ATTENTION : Cette opération est IRRÉVERSIBLE
  Future<void> deleteAccount(String userId) async {
    final authService = AuthService();

    try {
      state = const AsyncValue.loading();

      // 1. Supprimer toutes les données de l'utilisateur (transactions, catégories, pockets, users)
      final deleteUserUseCase = await ref.read(
        deleteUserUseCaseProvider.future,
      );
      await deleteUserUseCase(userId);

      // 2. Supprimer le compte Auth (RPC call)
      try {
        await authService.deleteAuthUser();
      } catch (e) {
        ref.read(loggerProvider).d('Suppression Auth: $e');
      }

      // 3. Déconnecter immédiatement (force la déconnexion)
      try {
        await authService.signOut();
      } catch (e) {
        ref.read(loggerProvider).d('SignOut après suppression: $e');
      }

      // 4. Mettre à jour le state à null
      state = const AsyncValue.data(null);
    } catch (e) {
      ref
          .read(loggerProvider)
          .e('Erreur lors de la suppression du compte', error: e);
      state = AsyncValue.error(e, StackTrace.current);
      rethrow;
    }
  }
}

/// Provider pour vérifier si l'utilisateur a accès au premium
@riverpod
class CanAccessPremium extends _$CanAccessPremium {
  @override
  bool build() {
    final userAsync = ref.watch(currentUserProvider);
    return userAsync.when(
      data: (user) => user?.canAccessPremium ?? false,
      loading: () => false,
      error: (_, _) => false,
    );
  }
}

/// Provider pour vérifier si l'utilisateur est en période d'essai
@riverpod
class IsTrialActive extends _$IsTrialActive {
  @override
  bool build() {
    final userAsync = ref.watch(currentUserProvider);
    return userAsync.when(
      data: (user) {
        if (user == null) return false;
        return user.status == 'trial';
      },
      loading: () => false,
      error: (_, _) => false,
    );
  }
}

/// Provider pour obtenir le statut de l'utilisateur (free/trial/premium)
@riverpod
class UserStatus extends _$UserStatus {
  @override
  String build() {
    final userAsync = ref.watch(currentUserProvider);
    return userAsync.when(
      data: (user) => user?.status ?? 'free',
      loading: () => 'loading',
      error: (_, _) => 'error',
    );
  }
}

/// Provider pour les jours restants du trial
@riverpod
class TrialDaysLeft extends _$TrialDaysLeft {
  @override
  int build() {
    final userAsync = ref.watch(currentUserProvider);
    return userAsync.when(
      data: (user) => user?.trialDaysLeft ?? 0,
      loading: () => 0,
      error: (_, _) => 0,
    );
  }
}

/// Provider pour vérifier si l'onboarding est complété
@riverpod
class HasCompletedOnboarding extends _$HasCompletedOnboarding {
  @override
  bool build() {
    final userAsync = ref.watch(currentUserProvider);
    return userAsync.when(
      data: (user) => user?.hasCompletedOnboarding ?? false,
      loading: () => false,
      error: (_, _) => false,
    );
  }
}

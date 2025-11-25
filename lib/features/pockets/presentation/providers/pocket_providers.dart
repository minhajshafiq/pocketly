import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pocketly/core/errors/errors.dart';
import 'package:pocketly/core/services/logger_service.dart';
import 'package:pocketly/features/pockets/data/datasources/pocket_local_datasource.dart';
import 'package:pocketly/features/pockets/data/datasources/pocket_remote_datasource.dart';
import 'package:pocketly/features/pockets/data/repositories/pocket_repository_impl.dart';
import 'package:pocketly/features/pockets/domain/entities/pocket_entity.dart';
import 'package:pocketly/features/pockets/domain/repositories/pocket_repository.dart';
import 'package:pocketly/features/pockets/domain/usecases/get_all_pockets_usecase.dart';
import 'package:pocketly/features/pockets/domain/usecases/get_pockets_by_category_usecase.dart';
import 'package:pocketly/features/pockets/domain/usecases/get_pocket_by_id_usecase.dart';
import 'package:pocketly/features/pockets/domain/usecases/create_pocket_usecase.dart';
import 'package:pocketly/features/pockets/domain/usecases/update_pocket_usecase.dart';
import 'package:pocketly/features/pockets/domain/usecases/delete_pocket_usecase.dart';
import 'package:pocketly/features/pockets/domain/usecases/activate_pocket_usecase.dart';
import 'package:pocketly/features/pockets/domain/usecases/deactivate_pocket_usecase.dart';
import 'package:pocketly/features/pockets/domain/usecases/update_spent_amount_usecase.dart';
import 'package:pocketly/features/pockets/domain/usecases/add_to_savings_usecase.dart';
import 'package:pocketly/features/pockets/domain/usecases/withdraw_from_savings_usecase.dart';
import 'package:pocketly/features/pockets/domain/usecases/set_monthly_savings_usecase.dart';
import 'package:pocketly/features/pockets/domain/usecases/apply_monthly_savings_usecase.dart';
import 'package:pocketly/features/pockets/domain/usecases/create_default_pockets_usecase.dart';
import 'package:pocketly/features/pockets/domain/usecases/get_pocket_summary_usecase.dart';
import 'package:pocketly/core/services/auth_service.dart';
import 'package:flutter/widgets.dart';
import 'package:pocketly/features/notifications/notifications.dart';
import 'package:pocketly/features/transactions/transactions.dart';

part 'pocket_providers.g.dart';

// =====================================================
// 🏗️ INFRASTRUCTURE PROVIDERS
// =====================================================

/// Provider pour SharedPreferences
@Riverpod(keepAlive: true)
Future<SharedPreferences> sharedPreferences(Ref ref) async {
  return await SharedPreferences.getInstance();
}

/// Provider pour PocketRemoteDataSource
@Riverpod(keepAlive: true)
PocketRemoteDataSource pocketRemoteDataSource(Ref ref) {
  return PocketRemoteDataSource();
}

/// Provider pour PocketLocalDataSource
@Riverpod(keepAlive: true)
PocketLocalDataSource pocketLocalDataSource(Ref ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return prefs.when(
    data: (prefs) => PocketLocalDataSource(prefs),
    loading: () => throw const UnknownError(
      userMessage: 'Initialisation en cours',
      technicalMessage: 'SharedPreferences not initialized',
    ),
    error: (error, stack) => throw error,
  );
}

/// Provider pour PocketRepository
@Riverpod(keepAlive: true)
PocketRepository pocketRepository(Ref ref) {
  final remoteDataSource = ref.watch(pocketRemoteDataSourceProvider);
  final localDataSource = ref.watch(pocketLocalDataSourceProvider);

  return PocketRepositoryImpl(
    remoteDataSource: remoteDataSource,
    localDataSource: localDataSource,
  );
}

// =====================================================
// 🎯 USE CASE PROVIDERS
// =====================================================

@Riverpod(keepAlive: true)
GetAllPocketsUseCase getAllPocketsUseCase(Ref ref) {
  return GetAllPocketsUseCase(ref.watch(pocketRepositoryProvider));
}

@Riverpod(keepAlive: true)
GetPocketsByCategoryUseCase getPocketsByCategoryUseCase(Ref ref) {
  return GetPocketsByCategoryUseCase(ref.watch(pocketRepositoryProvider));
}

@Riverpod(keepAlive: true)
GetPocketByIdUseCase getPocketByIdUseCase(Ref ref) {
  return GetPocketByIdUseCase(ref.watch(pocketRepositoryProvider));
}

@Riverpod(keepAlive: true)
CreatePocketUseCase createPocketUseCase(Ref ref) {
  return CreatePocketUseCase(ref.watch(pocketRepositoryProvider));
}

@Riverpod(keepAlive: true)
UpdatePocketUseCase updatePocketUseCase(Ref ref) {
  return UpdatePocketUseCase(ref.watch(pocketRepositoryProvider));
}

@Riverpod(keepAlive: true)
DeletePocketUseCase deletePocketUseCase(Ref ref) {
  return DeletePocketUseCase(ref.watch(pocketRepositoryProvider));
}

@Riverpod(keepAlive: true)
ActivatePocketUseCase activatePocketUseCase(Ref ref) {
  return ActivatePocketUseCase(ref.watch(pocketRepositoryProvider));
}

@Riverpod(keepAlive: true)
DeactivatePocketUseCase deactivatePocketUseCase(Ref ref) {
  return DeactivatePocketUseCase(ref.watch(pocketRepositoryProvider));
}

@Riverpod(keepAlive: true)
UpdateSpentAmountUseCase updateSpentAmountUseCase(Ref ref) {
  return UpdateSpentAmountUseCase(ref.watch(pocketRepositoryProvider));
}

@Riverpod(keepAlive: true)
AddToSavingsUseCase addToSavingsUseCase(Ref ref) {
  return AddToSavingsUseCase(ref.watch(pocketRepositoryProvider));
}

@Riverpod(keepAlive: true)
WithdrawFromSavingsUseCase withdrawFromSavingsUseCase(Ref ref) {
  return WithdrawFromSavingsUseCase(ref.watch(pocketRepositoryProvider));
}

@Riverpod(keepAlive: true)
SetMonthlySavingsUseCase setMonthlySavingsUseCase(Ref ref) {
  return SetMonthlySavingsUseCase(ref.watch(pocketRepositoryProvider));
}

@Riverpod(keepAlive: true)
ApplyMonthlySavingsUseCase applyMonthlySavingsUseCase(Ref ref) {
  return ApplyMonthlySavingsUseCase(ref.watch(pocketRepositoryProvider));
}

@Riverpod(keepAlive: true)
CreateDefaultPocketsUseCase createDefaultPocketsUseCase(Ref ref) {
  return CreateDefaultPocketsUseCase(ref.watch(pocketRepositoryProvider));
}

@Riverpod(keepAlive: true)
GetPocketSummaryUseCase getPocketSummaryUseCase(Ref ref) {
  return GetPocketSummaryUseCase(ref.watch(pocketRepositoryProvider));
}

// =====================================================
// 📋 STATE PROVIDERS
// =====================================================

/// Provider pour tous les pockets de l'utilisateur actuel
@riverpod
Future<List<PocketEntity>> userPockets(Ref ref) async {
  final authService = AuthService();
  final user = authService.currentUser;

  if (user == null) {
    throw const AuthenticationError(
      userMessage: 'Utilisateur non authentifié',
      technicalMessage: 'User not authenticated',
    );
  }

  final useCase = ref.watch(getAllPocketsUseCaseProvider);
  return await useCase(user.id);
}

/// Provider pour les pockets par catégorie
@riverpod
Future<List<PocketEntity>> pocketsByCategory(
  Ref ref,
  PocketCategory category,
) async {
  final authService = AuthService();
  final user = authService.currentUser;

  if (user == null) {
    throw const AuthenticationError(
      userMessage: 'Utilisateur non authentifié',
      technicalMessage: 'User not authenticated',
    );
  }

  final useCase = ref.watch(getPocketsByCategoryUseCaseProvider);
  return await useCase(userId: user.id, category: category);
}

/// Provider pour un pocket spécifique par ID
@riverpod
Future<PocketEntity?> pocketById(
  Ref ref,
  String pocketId,
) async {
  final useCase = ref.watch(getPocketByIdUseCaseProvider);
  return await useCase(pocketId);
}

/// Provider pour le résumé des pockets
@riverpod
Future<Map<PocketCategory, PocketSummary>> pocketSummary(Ref ref) async {
  final authService = AuthService();
  final user = authService.currentUser;

  if (user == null) {
    throw const AuthenticationError(
      userMessage: 'Utilisateur non authentifié',
      technicalMessage: 'User not authenticated',
    );
  }

  final useCase = ref.watch(getPocketSummaryUseCaseProvider);
  return await useCase(user.id);
}

/// Provider pour le total des revenus de l'utilisateur
@riverpod
double totalIncome(Ref ref) {
  // Récupérer toutes les transactions
  final transactionState = ref.watch(transactionProvider);

  // Si les transactions ne sont pas chargées, les charger
  if (transactionState.allTransactions.isEmpty && !transactionState.isLoadingState) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(transactionProvider.notifier).loadTransactions();
    });
  }

  // Calculer le total des revenus à partir de TOUTES les transactions de type income
  final transactions = transactionState.allTransactions;
  return transactions
      .where((t) => t.isIncome) // Filtrer uniquement les transactions de type income
      .fold(0.0, (sum, t) => sum + t.amount);
}

// =====================================================
// 🎛️ CONTROLLER PROVIDERS
// =====================================================

/// Contrôleur pour la gestion des pockets
@Riverpod(keepAlive: true)
class PocketController extends _$PocketController {
  @override
  FutureOr<void> build() async {
    // Initialization if needed
  }

  /// Crée un nouveau pocket
  Future<void> createPocket(PocketEntity pocket) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final useCase = ref.read(createPocketUseCaseProvider);
      await useCase(pocket);

      // Invalider le cache pour rafraîchir la liste
      ref.invalidate(userPocketsProvider);
    });
  }

  /// Met à jour un pocket
  Future<void> updatePocket(PocketEntity pocket) async {
    ref.read(loggerProvider).d('updatePocket() appelé pour pocket: ${pocket.id}');

    try {
      ref.read(loggerProvider).d('Lecture du useCase');
      final useCase = ref.read(updatePocketUseCaseProvider);

      ref.read(loggerProvider).d('Appel du useCase (await)');
      await useCase(pocket);

      ref.read(loggerProvider).i('UseCase terminé avec succès');

      // ⚠️ NE PAS invalider ici car ça peut disposer le provider pendant l'exécution
      // L'invalidation sera faite par l'écran après le retour de cette fonction
    } catch (e) {
      ref.read(loggerProvider).e('Erreur dans updatePocket', error: e);
      // Relancer l'erreur pour que l'écran puisse la gérer
      rethrow;
    }
  }

  /// Supprime un pocket
  Future<void> deletePocket(String pocketId) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final useCase = ref.read(deletePocketUseCaseProvider);
      await useCase(pocketId);

      // Invalider le cache
      ref.invalidate(userPocketsProvider);
      ref.invalidate(pocketByIdProvider(pocketId));
    });
  }

  /// Active un pocket
  Future<void> activatePocket(String pocketId) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final useCase = ref.read(activatePocketUseCaseProvider);
      await useCase(pocketId);

      // Invalider le cache
      ref.invalidate(userPocketsProvider);
      ref.invalidate(pocketByIdProvider(pocketId));
    });
  }

  /// Désactive un pocket
  Future<void> deactivatePocket(String pocketId) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final useCase = ref.read(deactivatePocketUseCaseProvider);
      await useCase(pocketId);

      // Invalider le cache
      ref.invalidate(userPocketsProvider);
      ref.invalidate(pocketByIdProvider(pocketId));
    });
  }

  /// Met à jour le montant dépensé
  Future<void> updateSpentAmount(String pocketId, double amount) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final useCase = ref.read(updateSpentAmountUseCaseProvider);
      await useCase(pocketId: pocketId, amount: amount);

      // Invalider le cache
      ref.invalidate(userPocketsProvider);
      ref.invalidate(pocketByIdProvider(pocketId));
    });
  }

  /// Ajoute un montant à l'épargne
  Future<void> addToSavings(String pocketId, double amount) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final useCase = ref.read(addToSavingsUseCaseProvider);
      await useCase(pocketId: pocketId, amount: amount);

      // Invalider le cache
      ref.invalidate(userPocketsProvider);
      ref.invalidate(pocketByIdProvider(pocketId));

      // ✨ VÉRIFICATION DES NOTIFICATIONS D'OBJECTIF
      // Vérifier si un objectif a été atteint
      _checkGoalNotifications(pocketId);
    });
  }

  /// Vérifie et envoie les notifications d'objectif si nécessaire
  Future<void> _checkGoalNotifications(String pocketId) async {
    try {
      // Récupérer le pocket mis à jour
      final pocket = await ref.read(pocketByIdProvider(pocketId).future);
      if (pocket == null || pocket.id == null) return;

      // Vérifier si c'est un pocket d'épargne avec un objectif
      if (!pocket.isSavingsPocket || pocket.targetAmount == null) return;

      // Récupérer les préférences de notification
      final preferences = await ref.read(notificationPreferencesProvider.future);
      if (preferences == null || !preferences.goalReachedEnabled) return;

      // Récupérer le service de suivi des objectifs
      final goalTracker = ref.read(goalTrackerProvider);

      // Vérifier la progression à 90%
      await goalTracker.checkGoalProgress(
        pocketId: pocket.id!,
        pocketName: pocket.name,
        goalAmount: pocket.targetAmount!,
        currentAmount: pocket.savedAmount,
        preferences: preferences,
      );

      // Vérifier si l'objectif est atteint
      await goalTracker.checkGoalReached(
        pocketId: pocket.id!,
        pocketName: pocket.name,
        goalAmount: pocket.targetAmount!,
        currentAmount: pocket.savedAmount,
        preferences: preferences,
      );
    } catch (e) {
      // Ne pas faire échouer l'ajout d'épargne si les notifications échouent
      debugPrint('⚠️ [PocketController] Erreur lors de la vérification de l\'objectif: $e');
    }
  }

  /// Retire un montant de l'épargne
  Future<void> withdrawFromSavings(String pocketId, double amount) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final useCase = ref.read(withdrawFromSavingsUseCaseProvider);
      await useCase(pocketId: pocketId, amount: amount);

      // Invalider le cache
      ref.invalidate(userPocketsProvider);
      ref.invalidate(pocketByIdProvider(pocketId));
    });
  }

  /// Définit l'épargne mensuelle
  Future<void> setMonthlySavings(String pocketId, double? amount) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final useCase = ref.read(setMonthlySavingsUseCaseProvider);
      await useCase(pocketId: pocketId, amount: amount);

      // Invalider le cache
      ref.invalidate(userPocketsProvider);
      ref.invalidate(pocketByIdProvider(pocketId));
    });
  }

  /// Applique l'épargne mensuelle à tous les pockets
  Future<void> applyMonthlySavings() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final authService = AuthService();
      final user = authService.currentUser;

      if (user == null) {
        throw const AuthenticationError(
          userMessage: 'Utilisateur non authentifié',
          technicalMessage: 'User not authenticated',
        );
      }

      final useCase = ref.read(applyMonthlySavingsUseCaseProvider);
      await useCase(user.id);

      // Invalider tout le cache
      ref.invalidate(userPocketsProvider);
    });
  }

  /// Crée les pockets par défaut
  Future<void> createDefaultPockets() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final authService = AuthService();
      final user = authService.currentUser;

      if (user == null) {
        throw const AuthenticationError(
          userMessage: 'Utilisateur non authentifié',
          technicalMessage: 'User not authenticated',
        );
      }

      final useCase = ref.read(createDefaultPocketsUseCaseProvider);
      await useCase(user.id);

      // Invalider le cache pour rafraîchir la liste
      ref.invalidate(userPocketsProvider);
    });
  }
}

// =====================================================
// 🔍 FILTERED PROVIDERS (CONVENIENCE)
// =====================================================

/// Provider pour les pockets actifs uniquement
@riverpod
Future<List<PocketEntity>> activePockets(Ref ref) async {
  final pockets = await ref.watch(userPocketsProvider.future);
  return pockets.activeOnly;
}

/// Provider pour les pockets de type Needs
@riverpod
Future<List<PocketEntity>> needsPockets(Ref ref) async {
  final pockets = await ref.watch(userPocketsProvider.future);
  return pockets.needs;
}

/// Provider pour les pockets de type Wants
@riverpod
Future<List<PocketEntity>> wantsPockets(Ref ref) async {
  final pockets = await ref.watch(userPocketsProvider.future);
  return pockets.wants;
}

/// Provider pour les pockets de type Savings
@riverpod
Future<List<PocketEntity>> savingsPockets(Ref ref) async {
  final pockets = await ref.watch(userPocketsProvider.future);
  return pockets.savings;
}

/// Provider pour les pockets avec budget dépassé
@riverpod
Future<List<PocketEntity>> overBudgetPockets(Ref ref) async {
  final pockets = await ref.watch(userPocketsProvider.future);
  return pockets.overBudget;
}

/// Provider pour les pockets avec objectif atteint
@riverpod
Future<List<PocketEntity>> goalsReachedPockets(Ref ref) async {
  final pockets = await ref.watch(userPocketsProvider.future);
  return pockets.goalsReached;
}

/// Provider pour compter les transactions d'un pocket
@riverpod
int transactionCountByPocket(Ref ref, String? pocketId) {
  // Si pas de pocketId, retourner 0
  if (pocketId == null) return 0;
  
  // Récupérer toutes les transactions
  final transactionState = ref.watch(transactionProvider);

  // Si les transactions ne sont pas chargées, les charger
  if (transactionState.allTransactions.isEmpty && !transactionState.isLoadingState) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(transactionProvider.notifier).loadTransactions();
    });
  }

  // Compter les transactions avec ce pocketId
  return transactionState.allTransactions
      .where((t) => t.pocketId == pocketId)
      .length;
}

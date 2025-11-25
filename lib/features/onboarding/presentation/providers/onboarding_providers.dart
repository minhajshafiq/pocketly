import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pocketly/features/onboarding/domain/entities/onboarding_state_entity.dart';
import 'package:pocketly/features/onboarding/domain/repositories/onboarding_repository.dart';
import 'package:pocketly/features/onboarding/domain/usecases/save_onboarding_state_usecase.dart';
import 'package:pocketly/features/onboarding/domain/usecases/get_onboarding_state_usecase.dart';
import 'package:pocketly/features/onboarding/domain/usecases/clear_onboarding_state_usecase.dart';
import 'package:pocketly/features/onboarding/data/datasources/onboarding_local_datasource.dart';
import 'package:pocketly/features/onboarding/data/repositories/onboarding_repository_impl.dart';
import 'package:pocketly/features/user/user.dart';

part 'onboarding_providers.g.dart';

// ==================== DATA LAYER PROVIDERS ====================

/// Provider pour SharedPreferences (singleton)
@Riverpod(keepAlive: true)
Future<SharedPreferences> sharedPreferences(Ref ref) async {
  return await SharedPreferences.getInstance();
}

/// Provider pour le datasource local onboarding
@Riverpod(keepAlive: true)
OnboardingLocalDataSource onboardingLocalDataSource(Ref ref) {
  final prefs = ref.watch(sharedPreferencesProvider).requireValue;
  return OnboardingLocalDataSourceImpl(prefs);
}

/// Provider pour le repository onboarding
@Riverpod(keepAlive: true)
OnboardingRepository onboardingRepository(Ref ref) {
  final localDataSource = ref.watch(onboardingLocalDataSourceProvider);
  return OnboardingRepositoryImpl(localDataSource);
}

// ==================== USE CASE PROVIDERS ====================

/// Provider pour le use case de sauvegarde d'état
@riverpod
SaveOnboardingStateUseCase saveOnboardingStateUseCase(Ref ref) {
  final repository = ref.watch(onboardingRepositoryProvider);
  return SaveOnboardingStateUseCase(repository);
}

/// Provider pour le use case de récupération d'état
@riverpod
GetOnboardingStateUseCase getOnboardingStateUseCase(Ref ref) {
  final repository = ref.watch(onboardingRepositoryProvider);
  return GetOnboardingStateUseCase(repository);
}

/// Provider pour le use case de nettoyage d'état
@riverpod
ClearOnboardingStateUseCase clearOnboardingStateUseCase(Ref ref) {
  final repository = ref.watch(onboardingRepositoryProvider);
  return ClearOnboardingStateUseCase(repository);
}

// ==================== STATE MANAGEMENT ====================

/// Provider principal pour gérer l'état de l'onboarding
@Riverpod(keepAlive: true)
class OnboardingNotifier extends _$OnboardingNotifier {
  @override
  Future<OnboardingStateEntity> build() async {
    // Charger l'état sauvegardé au démarrage
    final getStateUseCase = ref.read(getOnboardingStateUseCaseProvider);
    return await getStateUseCase();
  }

  /// Met à jour le revenu mensuel
  Future<void> setMonthlyIncome(double income) async {
    state = await AsyncValue.guard(() async {
      final currentState = state.requireValue;
      final newState = currentState.copyWith(monthlyIncome: income);

      // Sauvegarder localement
      final saveUseCase = ref.read(saveOnboardingStateUseCaseProvider);
      await saveUseCase(newState);

      return newState;
    });
  }

  /// Met à jour la fréquence de revenu
  Future<void> setIncomeFrequency(IncomeFrequency frequency) async {
    state = await AsyncValue.guard(() async {
      final currentState = state.requireValue;
      final newState = currentState.copyWith(incomeFrequency: frequency);

      final saveUseCase = ref.read(saveOnboardingStateUseCaseProvider);
      await saveUseCase(newState);

      return newState;
    });
  }

  /// Met à jour le montant de la première dépense
  Future<void> setFirstExpenseAmount(double amount) async {
    state = await AsyncValue.guard(() async {
      final currentState = state.requireValue;
      final newState = currentState.copyWith(firstExpenseAmount: amount);

      final saveUseCase = ref.read(saveOnboardingStateUseCaseProvider);
      await saveUseCase(newState);

      return newState;
    });
  }

  /// Met à jour la catégorie de la première dépense
  Future<void> setFirstExpenseCategory(ExpenseCategory category) async {
    state = await AsyncValue.guard(() async {
      final currentState = state.requireValue;
      final newState = currentState.copyWith(firstExpenseCategory: category);

      final saveUseCase = ref.read(saveOnboardingStateUseCaseProvider);
      await saveUseCase(newState);

      return newState;
    });
  }

  /// Met à jour la description de la première dépense
  Future<void> setFirstExpenseDescription(String description) async {
    state = await AsyncValue.guard(() async {
      final currentState = state.requireValue;
      final newState = currentState.copyWith(firstExpenseDescription: description);

      final saveUseCase = ref.read(saveOnboardingStateUseCaseProvider);
      await saveUseCase(newState);

      return newState;
    });
  }

  /// Passe à l'étape suivante
  Future<void> nextStep() async {
    state = await AsyncValue.guard(() async {
      final currentState = state.requireValue;
      if (currentState.currentStep < 4) {
        final newState = currentState.copyWith(
          currentStep: currentState.currentStep + 1,
        );

        final saveUseCase = ref.read(saveOnboardingStateUseCaseProvider);
        await saveUseCase(newState);

        return newState;
      }
      return currentState;
    });
  }

  /// Revient à l'étape précédente
  Future<void> previousStep() async {
    state = await AsyncValue.guard(() async {
      final currentState = state.requireValue;
      if (currentState.currentStep > 1) {
        final newState = currentState.copyWith(
          currentStep: currentState.currentStep - 1,
        );

        final saveUseCase = ref.read(saveOnboardingStateUseCaseProvider);
        await saveUseCase(newState);

        return newState;
      }
      return currentState;
    });
  }

  /// Réinitialise l'état de l'onboarding
  Future<void> reset() async {
    state = await AsyncValue.guard(() async {
      final newState = const OnboardingStateEntity();

      final saveUseCase = ref.read(saveOnboardingStateUseCaseProvider);
      await saveUseCase(newState);

      return newState;
    });
  }

  /// Termine l'onboarding et active le trial
  Future<void> completeOnboarding() async {
    state = await AsyncValue.guard(() async {
      final currentState = state.requireValue;

      // Récupérer l'utilisateur actuel via le barrel file
      final currentUser = await ref.read(currentUserProvider.future);
      if (currentUser == null) {
        throw Exception('Utilisateur non connecté');
      }

      // Marquer l'onboarding comme complété
      await ref
          .read(currentUserProvider.notifier)
          .completeOnboarding(currentUser.id);

      // Activer le trial
      await ref
          .read(currentUserProvider.notifier)
          .activateTrial(currentUser.id);

      // Nettoyer l'état local
      final clearUseCase = ref.read(clearOnboardingStateUseCaseProvider);
      await clearUseCase();

      return currentState.copyWith(isCompleted: true);
    });
  }
}

// ==================== HELPER PROVIDERS ====================

/// Provider pour vérifier si l'onboarding est complété
@riverpod
bool hasCompletedOnboarding(Ref ref) {
  final userAsync = ref.watch(currentUserProvider);
  return userAsync.when(
    data: (user) => user?.hasCompletedOnboarding ?? false,
    loading: () => false,
    error: (_, __) => false,
  );
}

/// Provider pour obtenir le revenu mensuel converti selon la fréquence
@riverpod
double? convertedMonthlyIncome(Ref ref) {
  final onboardingAsync = ref.watch(onboardingProvider);
  return onboardingAsync.when(
    data: (state) => state.convertedMonthlyIncome,
    loading: () => null,
    error: (_, __) => null,
  );
}

/// Alias pour la compatibilité avec le code existant
/// Note: Utiliser onboardingNotifierProvider directement pour éviter les conflits

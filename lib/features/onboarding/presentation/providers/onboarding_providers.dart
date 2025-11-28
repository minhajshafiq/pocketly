import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pocketly/core/providers/shared_preferences_provider.dart' as core;
import 'package:pocketly/core/core.dart';
import 'package:pocketly/features/onboarding/domain/entities/onboarding_state_entity.dart';
import 'package:pocketly/features/onboarding/domain/repositories/onboarding_repository.dart';
import 'package:pocketly/features/onboarding/domain/usecases/save_onboarding_state_usecase.dart';
import 'package:pocketly/features/onboarding/domain/usecases/get_onboarding_state_usecase.dart';
import 'package:pocketly/features/onboarding/domain/usecases/clear_onboarding_state_usecase.dart';
import 'package:pocketly/features/onboarding/data/datasources/onboarding_local_datasource.dart';
import 'package:pocketly/features/onboarding/data/repositories/onboarding_repository_impl.dart';
import 'package:pocketly/features/user/user.dart';
import 'package:pocketly/features/transactions/transactions.dart';
import 'package:pocketly/features/category/category.dart';

part 'onboarding_providers.g.dart';

// ==================== DATA LAYER PROVIDERS ====================

/// Provider pour le datasource local onboarding
/// Utilise le provider global sharedPreferencesProvider qui est déjà initialisé dans main.dart
@Riverpod(keepAlive: true)
OnboardingLocalDataSource onboardingLocalDataSource(Ref ref) {
  // Utiliser le provider global qui retourne directement SharedPreferences (pas un Future)
  final prefs = ref.watch(core.sharedPreferencesProvider);
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
    final loadedState = await getStateUseCase();

    // Debug: Afficher l'état chargé
    if (kDebugMode) {
      ref.read(loggerProvider).d('[OnboardingProvider] État chargé: monthlyIncome=${loadedState.monthlyIncome}, frequency=${loadedState.incomeFrequency}, converted=${loadedState.convertedMonthlyIncome}');
    }

    return loadedState;
  }

  /// Met à jour le revenu mensuel
  Future<void> setMonthlyIncome(double income) async {
    if (kDebugMode) {
      ref.read(loggerProvider).d('[OnboardingProvider] setMonthlyIncome appelé avec: $income');
    }
    state = await AsyncValue.guard(() async {
      final currentState = state.value ?? const OnboardingStateEntity();
      if (kDebugMode) {
        ref.read(loggerProvider).d('[OnboardingProvider] État actuel avant modification: monthlyIncome=${currentState.monthlyIncome}');
      }
      final newState = currentState.copyWith(monthlyIncome: income);
      if (kDebugMode) {
        ref.read(loggerProvider).d('[OnboardingProvider] Nouvel état créé: monthlyIncome=${newState.monthlyIncome}');
      }

      // Sauvegarder localement
      final saveUseCase = ref.read(saveOnboardingStateUseCaseProvider);
      await saveUseCase(newState);
      if (kDebugMode) {
        ref.read(loggerProvider).d('[OnboardingProvider] État sauvegardé dans le cache');
      }

      return newState;
    });
    if (kDebugMode) {
      ref.read(loggerProvider).d('[OnboardingProvider] setMonthlyIncome terminé, state.value.monthlyIncome=${state.value?.monthlyIncome}');
    }
  }

  /// Met à jour la fréquence de revenu
  Future<void> setIncomeFrequency(IncomeFrequency frequency) async {
    if (kDebugMode) {
      ref.read(loggerProvider).d('[OnboardingProvider] setIncomeFrequency appelé avec: $frequency');
    }
    state = await AsyncValue.guard(() async {
      final currentState = state.value ?? const OnboardingStateEntity();
      if (kDebugMode) {
        ref.read(loggerProvider).d('[OnboardingProvider] État actuel: monthlyIncome=${currentState.monthlyIncome}, frequency=${currentState.incomeFrequency}');
      }
      final newState = currentState.copyWith(incomeFrequency: frequency);
      if (kDebugMode) {
        ref.read(loggerProvider).d('[OnboardingProvider] Nouvel état: monthlyIncome=${newState.monthlyIncome}, frequency=${newState.incomeFrequency}, converted=${newState.convertedMonthlyIncome}');
      }

      final saveUseCase = ref.read(saveOnboardingStateUseCaseProvider);
      await saveUseCase(newState);
      if (kDebugMode) {
        ref.read(loggerProvider).d('[OnboardingProvider] État sauvegardé dans le cache');
      }

      return newState;
    });
    if (kDebugMode) {
      ref.read(loggerProvider).d('[OnboardingProvider] setIncomeFrequency terminé, converted=${state.value?.convertedMonthlyIncome}');
    }
  }

  /// Met à jour le revenu mensuel et la fréquence en une seule opération
  Future<void> setIncomeData(double income, IncomeFrequency frequency) async {
    if (kDebugMode) {
      ref.read(loggerProvider).d('[OnboardingProvider] setIncomeData appelé avec: income=$income, frequency=$frequency');
    }
    state = await AsyncValue.guard(() async {
      // Utiliser valueOrNull avec fallback pour gérer le cas où le state n'est pas encore chargé
      final currentState = state.value ?? const OnboardingStateEntity();
      if (kDebugMode) {
        ref.read(loggerProvider).d('[OnboardingProvider] État actuel: ${currentState.monthlyIncome}');
      }

      final newState = currentState.copyWith(
        monthlyIncome: income,
        incomeFrequency: frequency,
      );
      if (kDebugMode) {
        ref.read(loggerProvider).d('[OnboardingProvider] Nouvel état: monthlyIncome=${newState.monthlyIncome}, frequency=${newState.incomeFrequency}, converted=${newState.convertedMonthlyIncome}');
      }

      final saveUseCase = ref.read(saveOnboardingStateUseCaseProvider);
      await saveUseCase(newState);
      if (kDebugMode) {
        ref.read(loggerProvider).d('[OnboardingProvider] État sauvegardé dans le cache');
      }

      return newState;
    });
    if (kDebugMode) {
      ref.read(loggerProvider).d('[OnboardingProvider] setIncomeData terminé, converted=${state.value?.convertedMonthlyIncome}');
    }
  }

  /// Met à jour le montant de la première dépense
  Future<void> setFirstExpenseAmount(double amount) async {
    if (kDebugMode) {
      ref.read(loggerProvider).d('[OnboardingProvider] setFirstExpenseAmount appelé avec: $amount');
    }
    state = await AsyncValue.guard(() async {
      final currentState = state.value ?? const OnboardingStateEntity();
      if (kDebugMode) {
        ref.read(loggerProvider).d('[OnboardingProvider] État actuel: firstExpenseAmount=${currentState.firstExpenseAmount}');
      }
      final newState = currentState.copyWith(firstExpenseAmount: amount);
      if (kDebugMode) {
        ref.read(loggerProvider).d('[OnboardingProvider] Nouvel état: firstExpenseAmount=${newState.firstExpenseAmount}');
      }

      final saveUseCase = ref.read(saveOnboardingStateUseCaseProvider);
      await saveUseCase(newState);
      if (kDebugMode) {
        ref.read(loggerProvider).d('[OnboardingProvider] État sauvegardé');
      }

      return newState;
    });
    if (kDebugMode) {
      ref.read(loggerProvider).d('[OnboardingProvider] setFirstExpenseAmount terminé');
    }
  }

  /// Met à jour la catégorie de la première dépense
  Future<void> setFirstExpenseCategory(ExpenseCategory category) async {
    if (kDebugMode) {
      ref.read(loggerProvider).d('[OnboardingProvider] setFirstExpenseCategory appelé avec: $category');
    }
    state = await AsyncValue.guard(() async {
      final currentState = state.value ?? const OnboardingStateEntity();
      final newState = currentState.copyWith(firstExpenseCategory: category);

      final saveUseCase = ref.read(saveOnboardingStateUseCaseProvider);
      await saveUseCase(newState);
      if (kDebugMode) {
        ref.read(loggerProvider).d('[OnboardingProvider] Catégorie sauvegardée');
      }

      return newState;
    });
  }

  /// Met à jour la description de la première dépense
  Future<void> setFirstExpenseDescription(String description) async {
    if (kDebugMode) {
      ref.read(loggerProvider).d('[OnboardingProvider] setFirstExpenseDescription appelé avec: $description');
    }
    state = await AsyncValue.guard(() async {
      final currentState = state.value ?? const OnboardingStateEntity();
      final newState = currentState.copyWith(firstExpenseDescription: description);

      final saveUseCase = ref.read(saveOnboardingStateUseCaseProvider);
      await saveUseCase(newState);
      if (kDebugMode) {
        ref.read(loggerProvider).d('[OnboardingProvider] Description sauvegardée');
      }

      return newState;
    });
  }

  /// Passe à l'étape suivante
  Future<void> nextStep() async {
    state = await AsyncValue.guard(() async {
      final currentState = state.value ?? const OnboardingStateEntity();
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
      final currentState = state.value ?? const OnboardingStateEntity();
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
      final currentState = state.value ?? const OnboardingStateEntity();

      // Récupérer l'utilisateur actuel via le barrel file
      final currentUser = await ref.read(currentUserProvider.future);
      if (currentUser == null) {
        throw Exception('Utilisateur non connecté');
      }

      if (kDebugMode) {
        final logger = ref.read(loggerProvider);
        logger.d('[OnboardingProvider] Création des transactions de l\'onboarding...');
        logger.d('[OnboardingProvider] État actuel complet:');
        logger.d('  - monthlyIncome: ${currentState.monthlyIncome}');
        logger.d('  - incomeFrequency: ${currentState.incomeFrequency}');
        logger.d('  - convertedMonthlyIncome: ${currentState.convertedMonthlyIncome}');
        logger.d('  - firstExpenseAmount: ${currentState.firstExpenseAmount}');
        logger.d('  - firstExpenseCategory: ${currentState.firstExpenseCategory}');
        logger.d('  - firstExpenseDescription: ${currentState.firstExpenseDescription}');
      }

      // Créer les transactions AVANT de nettoyer l'état
      // 1. Créer la transaction de revenu si elle existe
      if (currentState.convertedMonthlyIncome != null && currentState.convertedMonthlyIncome! > 0) {
        final convertedAmount = currentState.convertedMonthlyIncome!;
        if (kDebugMode) {
          ref.read(loggerProvider).d('[OnboardingProvider] Création transaction revenu: ${currentState.monthlyIncome} (${currentState.incomeFrequency.name}) = $convertedAmount mensuel');
        }

        // Récupérer les catégories
        final getAllCategoriesUseCase = ref.read(getAllCategoriesUseCaseProvider);
        final categories = await getAllCategoriesUseCase();
        final incomeCategories = categories.where((c) => c.type == CategoryType.income).toList();

        if (incomeCategories.isNotEmpty) {
          final incomeCategory = incomeCategories.first;

          // Créer la transaction de revenu avec le montant CONVERTI en mensuel
          final createTransactionUseCase = ref.read(createTransactionUseCaseProvider);
          await createTransactionUseCase(
            name: _getIncomeLabel(currentState.incomeFrequency),
            amount: convertedAmount,
            date: DateTime.now(),
            categoryId: incomeCategory.id!,
            type: TransactionType.income,
            userId: currentUser.id,
            notes: 'Transaction créée lors de l\'onboarding',
          );
          if (kDebugMode) {
            ref.read(loggerProvider).d('[OnboardingProvider] Transaction de revenu créée: $convertedAmount€');
          }
        }
      }

      // 2. Créer la transaction de dépense si elle existe
      if (kDebugMode) {
        final logger = ref.read(loggerProvider);
        logger.d('[OnboardingProvider] Vérification transaction de dépense...');
        logger.d('[OnboardingProvider]   firstExpenseAmount: ${currentState.firstExpenseAmount}');
        logger.d('[OnboardingProvider]   Condition remplie: ${currentState.firstExpenseAmount != null && currentState.firstExpenseAmount! > 0}');
      }

      if (currentState.firstExpenseAmount != null && currentState.firstExpenseAmount! > 0) {
        if (kDebugMode) {
          ref.read(loggerProvider).d('[OnboardingProvider] Création transaction dépense: ${currentState.firstExpenseAmount}');
        }

        // Récupérer les catégories
        final getAllCategoriesUseCase = ref.read(getAllCategoriesUseCaseProvider);
        final categories = await getAllCategoriesUseCase();
        final expenseCategories = categories.where((c) => c.type == CategoryType.expense).toList();

        if (expenseCategories.isNotEmpty) {
          final expenseCategory = expenseCategories.first;

          // Créer la transaction de dépense
          final createTransactionUseCase = ref.read(createTransactionUseCaseProvider);
          await createTransactionUseCase(
            name: currentState.firstExpenseDescription ?? 'Première dépense',
            amount: currentState.firstExpenseAmount!,
            date: DateTime.now(),
            categoryId: expenseCategory.id!,
            type: TransactionType.expense,
            userId: currentUser.id,
            notes: 'Première dépense créée lors de l\'onboarding',
          );
          if (kDebugMode) {
            ref.read(loggerProvider).d('[OnboardingProvider] Transaction de dépense créée');
          }
        }
      }

      if (kDebugMode) {
        ref.read(loggerProvider).d('[OnboardingProvider] Toutes les transactions créées avec succès');
      }

      // Marquer l'onboarding comme complété
      await ref
          .read(currentUserProvider.notifier)
          .completeOnboarding(currentUser.id);

      // Note: Le trial est déjà activé dans l'étape 1 pour garantir que l'utilisateur l'ait même s'il skip

      // Nettoyer l'état local
      final clearUseCase = ref.read(clearOnboardingStateUseCaseProvider);
      await clearUseCase();

      return currentState.copyWith(isCompleted: true);
    });
  }

  /// Obtient le label de la transaction de revenu selon la fréquence
  String _getIncomeLabel(IncomeFrequency frequency) {
    return switch (frequency) {
      IncomeFrequency.monthly => 'Revenu mensuel',
      IncomeFrequency.weekly => 'Revenu hebdomadaire',
      IncomeFrequency.other => 'Revenu',
    };
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
    data: (state) {
      if (kDebugMode) {
        ref.read(loggerProvider).d('[convertedMonthlyIncomeProvider] État récupéré: monthlyIncome=${state.monthlyIncome}, frequency=${state.incomeFrequency}, converted=${state.convertedMonthlyIncome}');
      }
      return state.convertedMonthlyIncome;
    },
    loading: () {
      if (kDebugMode) {
        ref.read(loggerProvider).d('[convertedMonthlyIncomeProvider] En cours de chargement...');
      }
      return null;
    },
    error: (error, stack) {
      if (kDebugMode) {
        ref.read(loggerProvider).w('[convertedMonthlyIncomeProvider] Erreur: $error', stackTrace: stack);
      }
      return null;
    },
  );
}

/// Alias pour la compatibilité avec le code existant
/// Note: Utiliser onboardingNotifierProvider directement pour éviter les conflits

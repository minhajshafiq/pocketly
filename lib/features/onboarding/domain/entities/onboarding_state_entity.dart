import 'package:freezed_annotation/freezed_annotation.dart';

part 'onboarding_state_entity.freezed.dart';
part 'onboarding_state_entity.g.dart';

/// Fréquence de revenu pour l'onboarding
enum IncomeFrequency {
  @JsonValue('monthly')
  monthly,
  @JsonValue('weekly')
  weekly,
  @JsonValue('other')
  other,
}

/// Extension pour obtenir le label localisé de la fréquence
extension IncomeFrequencyX on IncomeFrequency {
  String getLabel() {
    return switch (this) {
      IncomeFrequency.monthly => 'Mensuel',
      IncomeFrequency.weekly => 'Hebdomadaire',
      IncomeFrequency.other => 'Autre',
    };
  }

  /// Convertit un revenu vers un montant mensuel
  double convertToMonthly(double income) {
    return switch (this) {
      IncomeFrequency.monthly => income,
      IncomeFrequency.weekly => income * 4.33, // Moyenne de semaines par mois
      IncomeFrequency.other => income,
    };
  }
}

/// Catégorie de pocket pour la première dépense
enum ExpenseCategory {
  @JsonValue('needs')
  needs,
  @JsonValue('wants')
  wants,
  @JsonValue('savings')
  savings,
}

/// Extension pour obtenir le label de la catégorie
extension ExpenseCategoryX on ExpenseCategory {
  String getLabel() {
    return switch (this) {
      ExpenseCategory.needs => 'Besoins',
      ExpenseCategory.wants => 'Envies',
      ExpenseCategory.savings => 'Épargne',
    };
  }
}

/// Entité représentant l'état de l'onboarding
///
/// Stocke toutes les données collectées pendant le processus d'onboarding
@freezed
sealed class OnboardingStateEntity with _$OnboardingStateEntity {
  const factory OnboardingStateEntity({
    /// Revenu mensuel saisi par l'utilisateur
    @Default(null) double? monthlyIncome,

    /// Fréquence du revenu
    @Default(IncomeFrequency.monthly) IncomeFrequency incomeFrequency,

    /// Montant de la première dépense
    @Default(null) double? firstExpenseAmount,

    /// Catégorie de la première dépense
    @Default(null) ExpenseCategory? firstExpenseCategory,

    /// Description de la première dépense
    @Default(null) String? firstExpenseDescription,

    /// Étape actuelle de l'onboarding (1-4)
    @Default(1) int currentStep,

    /// Indique si l'onboarding est complété
    @Default(false) bool isCompleted,
  }) = _OnboardingStateEntity;

  factory OnboardingStateEntity.fromJson(Map<String, dynamic> json) =>
      _$OnboardingStateEntityFromJson(json);
}

/// Extensions sur OnboardingStateEntity pour la logique métier
extension OnboardingStateEntityX on OnboardingStateEntity {
  /// Retourne le revenu mensuel converti selon la fréquence
  double? get convertedMonthlyIncome {
    if (monthlyIncome == null) return null;
    return incomeFrequency.convertToMonthly(monthlyIncome!);
  }

  /// Vérifie si l'étape 1 est valide (revenu saisi)
  bool get isStep1Valid => monthlyIncome != null && monthlyIncome! > 0;

  /// Vérifie si l'étape 2 est valide (première dépense saisie)
  bool get isStep2Valid =>
      firstExpenseAmount != null &&
      firstExpenseAmount! > 0 &&
      firstExpenseCategory != null;

  /// Vérifie si l'onboarding peut être complété
  bool get canComplete => isStep1Valid;

  /// Retourne le pourcentage de progression (0.0 - 1.0)
  double get progress => currentStep / 4;
}

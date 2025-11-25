import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pocketly/features/onboarding/domain/entities/onboarding_state_entity.dart';

part 'onboarding_state_model.freezed.dart';
part 'onboarding_state_model.g.dart';

/// Modèle de données pour l'état de l'onboarding
///
/// Sert de DTO entre le datasource et le domain
@freezed
sealed class OnboardingStateModel with _$OnboardingStateModel {
  const factory OnboardingStateModel({
    required double? monthlyIncome,
    required String incomeFrequency,
    required double? firstExpenseAmount,
    required String? firstExpenseCategory,
    required String? firstExpenseDescription,
    required int currentStep,
    required bool isCompleted,
  }) = _OnboardingStateModel;

  factory OnboardingStateModel.fromJson(Map<String, dynamic> json) =>
      _$OnboardingStateModelFromJson(json);
}

/// Extension pour convertir entre Model et Entity
extension OnboardingStateModelX on OnboardingStateModel {
  /// Convertit le model en entité domain
  OnboardingStateEntity toEntity() {
    return OnboardingStateEntity(
      monthlyIncome: monthlyIncome,
      incomeFrequency: _parseIncomeFrequency(incomeFrequency),
      firstExpenseAmount: firstExpenseAmount,
      firstExpenseCategory: _parseExpenseCategory(firstExpenseCategory),
      firstExpenseDescription: firstExpenseDescription,
      currentStep: currentStep,
      isCompleted: isCompleted,
    );
  }

  /// Parse la fréquence de revenu depuis String
  IncomeFrequency _parseIncomeFrequency(String frequency) {
    return switch (frequency) {
      'monthly' => IncomeFrequency.monthly,
      'weekly' => IncomeFrequency.weekly,
      'other' => IncomeFrequency.other,
      _ => IncomeFrequency.monthly,
    };
  }

  /// Parse la catégorie de dépense depuis String
  ExpenseCategory? _parseExpenseCategory(String? category) {
    if (category == null) return null;
    return switch (category) {
      'needs' => ExpenseCategory.needs,
      'wants' => ExpenseCategory.wants,
      'savings' => ExpenseCategory.savings,
      _ => null,
    };
  }
}

/// Extension pour convertir Entity vers Model
extension OnboardingStateEntityToModelX on OnboardingStateEntity {
  /// Convertit l'entité en model
  OnboardingStateModel toModel() {
    return OnboardingStateModel(
      monthlyIncome: monthlyIncome,
      incomeFrequency: _serializeIncomeFrequency(incomeFrequency),
      firstExpenseAmount: firstExpenseAmount,
      firstExpenseCategory: _serializeExpenseCategory(firstExpenseCategory),
      firstExpenseDescription: firstExpenseDescription,
      currentStep: currentStep,
      isCompleted: isCompleted,
    );
  }

  /// Sérialise la fréquence de revenu en String
  String _serializeIncomeFrequency(IncomeFrequency frequency) {
    return switch (frequency) {
      IncomeFrequency.monthly => 'monthly',
      IncomeFrequency.weekly => 'weekly',
      IncomeFrequency.other => 'other',
    };
  }

  /// Sérialise la catégorie de dépense en String
  String? _serializeExpenseCategory(ExpenseCategory? category) {
    if (category == null) return null;
    return switch (category) {
      ExpenseCategory.needs => 'needs',
      ExpenseCategory.wants => 'wants',
      ExpenseCategory.savings => 'savings',
    };
  }
}

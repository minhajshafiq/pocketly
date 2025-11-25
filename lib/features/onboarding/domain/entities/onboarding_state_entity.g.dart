// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onboarding_state_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_OnboardingStateEntity _$OnboardingStateEntityFromJson(
  Map<String, dynamic> json,
) => _OnboardingStateEntity(
  monthlyIncome: (json['monthlyIncome'] as num?)?.toDouble() ?? null,
  incomeFrequency:
      $enumDecodeNullable(_$IncomeFrequencyEnumMap, json['incomeFrequency']) ??
      IncomeFrequency.monthly,
  firstExpenseAmount: (json['firstExpenseAmount'] as num?)?.toDouble() ?? null,
  firstExpenseCategory:
      $enumDecodeNullable(
        _$ExpenseCategoryEnumMap,
        json['firstExpenseCategory'],
      ) ??
      null,
  firstExpenseDescription: json['firstExpenseDescription'] as String? ?? null,
  currentStep: (json['currentStep'] as num?)?.toInt() ?? 1,
  isCompleted: json['isCompleted'] as bool? ?? false,
);

Map<String, dynamic> _$OnboardingStateEntityToJson(
  _OnboardingStateEntity instance,
) => <String, dynamic>{
  'monthlyIncome': instance.monthlyIncome,
  'incomeFrequency': _$IncomeFrequencyEnumMap[instance.incomeFrequency]!,
  'firstExpenseAmount': instance.firstExpenseAmount,
  'firstExpenseCategory':
      _$ExpenseCategoryEnumMap[instance.firstExpenseCategory],
  'firstExpenseDescription': instance.firstExpenseDescription,
  'currentStep': instance.currentStep,
  'isCompleted': instance.isCompleted,
};

const _$IncomeFrequencyEnumMap = {
  IncomeFrequency.monthly: 'monthly',
  IncomeFrequency.weekly: 'weekly',
  IncomeFrequency.other: 'other',
};

const _$ExpenseCategoryEnumMap = {
  ExpenseCategory.needs: 'needs',
  ExpenseCategory.wants: 'wants',
  ExpenseCategory.savings: 'savings',
};

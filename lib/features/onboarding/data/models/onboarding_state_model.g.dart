// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onboarding_state_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_OnboardingStateModel _$OnboardingStateModelFromJson(
  Map<String, dynamic> json,
) => _OnboardingStateModel(
  monthlyIncome: (json['monthlyIncome'] as num?)?.toDouble(),
  incomeFrequency: json['incomeFrequency'] as String,
  firstExpenseAmount: (json['firstExpenseAmount'] as num?)?.toDouble(),
  firstExpenseCategory: json['firstExpenseCategory'] as String?,
  firstExpenseDescription: json['firstExpenseDescription'] as String?,
  currentStep: (json['currentStep'] as num).toInt(),
  isCompleted: json['isCompleted'] as bool,
);

Map<String, dynamic> _$OnboardingStateModelToJson(
  _OnboardingStateModel instance,
) => <String, dynamic>{
  'monthlyIncome': instance.monthlyIncome,
  'incomeFrequency': instance.incomeFrequency,
  'firstExpenseAmount': instance.firstExpenseAmount,
  'firstExpenseCategory': instance.firstExpenseCategory,
  'firstExpenseDescription': instance.firstExpenseDescription,
  'currentStep': instance.currentStep,
  'isCompleted': instance.isCompleted,
};

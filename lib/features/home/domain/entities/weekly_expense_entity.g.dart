// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weekly_expense_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WeeklyExpenseEntity _$WeeklyExpenseEntityFromJson(Map<String, dynamic> json) =>
    _WeeklyExpenseEntity(
      dayOfWeek: (json['dayOfWeek'] as num).toInt(),
      date: DateTime.parse(json['date'] as String),
      amount: (json['amount'] as num).toDouble(),
      transactionCount: (json['transactionCount'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$WeeklyExpenseEntityToJson(
  _WeeklyExpenseEntity instance,
) => <String, dynamic>{
  'dayOfWeek': instance.dayOfWeek,
  'date': instance.date.toIso8601String(),
  'amount': instance.amount,
  'transactionCount': instance.transactionCount,
};

_WeeklyExpensesEntity _$WeeklyExpensesEntityFromJson(
  Map<String, dynamic> json,
) => _WeeklyExpensesEntity(
  expenses: (json['expenses'] as List<dynamic>)
      .map((e) => WeeklyExpenseEntity.fromJson(e as Map<String, dynamic>))
      .toList(),
  totalWeekAmount: (json['totalWeekAmount'] as num).toDouble(),
  weekStartDate: DateTime.parse(json['weekStartDate'] as String),
  weekEndDate: DateTime.parse(json['weekEndDate'] as String),
);

Map<String, dynamic> _$WeeklyExpensesEntityToJson(
  _WeeklyExpensesEntity instance,
) => <String, dynamic>{
  'expenses': instance.expenses,
  'totalWeekAmount': instance.totalWeekAmount,
  'weekStartDate': instance.weekStartDate.toIso8601String(),
  'weekEndDate': instance.weekEndDate.toIso8601String(),
};

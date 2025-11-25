// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_expense_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DailyExpenseEntity _$DailyExpenseEntityFromJson(Map<String, dynamic> json) =>
    _DailyExpenseEntity(
      date: DateTime.parse(json['date'] as String),
      dayOfWeek: (json['dayOfWeek'] as num).toInt(),
      income: (json['income'] as num).toDouble(),
      expense: (json['expense'] as num).toDouble(),
      transactionCount: (json['transactionCount'] as num).toInt(),
    );

Map<String, dynamic> _$DailyExpenseEntityToJson(_DailyExpenseEntity instance) =>
    <String, dynamic>{
      'date': instance.date.toIso8601String(),
      'dayOfWeek': instance.dayOfWeek,
      'income': instance.income,
      'expense': instance.expense,
      'transactionCount': instance.transactionCount,
    };

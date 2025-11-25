// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_summary_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TransactionSummaryEntity _$TransactionSummaryEntityFromJson(
  Map<String, dynamic> json,
) => _TransactionSummaryEntity(
  startDate: DateTime.parse(json['startDate'] as String),
  endDate: DateTime.parse(json['endDate'] as String),
  totalExpense: (json['totalExpense'] as num).toDouble(),
  totalIncome: (json['totalIncome'] as num).toDouble(),
  expenseCount: (json['expenseCount'] as num).toInt(),
  incomeCount: (json['incomeCount'] as num).toInt(),
  periodLabel: json['periodLabel'] as String? ?? '',
);

Map<String, dynamic> _$TransactionSummaryEntityToJson(
  _TransactionSummaryEntity instance,
) => <String, dynamic>{
  'startDate': instance.startDate.toIso8601String(),
  'endDate': instance.endDate.toIso8601String(),
  'totalExpense': instance.totalExpense,
  'totalIncome': instance.totalIncome,
  'expenseCount': instance.expenseCount,
  'incomeCount': instance.incomeCount,
  'periodLabel': instance.periodLabel,
};

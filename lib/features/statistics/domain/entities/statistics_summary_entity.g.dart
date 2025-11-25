// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'statistics_summary_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_StatisticsSummaryEntity _$StatisticsSummaryEntityFromJson(
  Map<String, dynamic> json,
) => _StatisticsSummaryEntity(
  totalIncome: (json['totalIncome'] as num).toDouble(),
  totalExpense: (json['totalExpense'] as num).toDouble(),
  balance: (json['balance'] as num).toDouble(),
  transactionCount: (json['transactionCount'] as num).toInt(),
  startDate: DateTime.parse(json['startDate'] as String),
  endDate: DateTime.parse(json['endDate'] as String),
);

Map<String, dynamic> _$StatisticsSummaryEntityToJson(
  _StatisticsSummaryEntity instance,
) => <String, dynamic>{
  'totalIncome': instance.totalIncome,
  'totalExpense': instance.totalExpense,
  'balance': instance.balance,
  'transactionCount': instance.transactionCount,
  'startDate': instance.startDate.toIso8601String(),
  'endDate': instance.endDate.toIso8601String(),
};

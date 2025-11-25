// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chart_data_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ChartDataEntity _$ChartDataEntityFromJson(Map<String, dynamic> json) =>
    _ChartDataEntity(
      dailyExpenses: (json['dailyExpenses'] as List<dynamic>)
          .map((e) => DailyExpenseEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      period: $enumDecode(_$TimePeriodEnumMap, json['period']),
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      maxExpense: (json['maxExpense'] as num).toDouble(),
      totalExpense: (json['totalExpense'] as num).toDouble(),
      totalIncome: (json['totalIncome'] as num).toDouble(),
    );

Map<String, dynamic> _$ChartDataEntityToJson(_ChartDataEntity instance) =>
    <String, dynamic>{
      'dailyExpenses': instance.dailyExpenses,
      'period': _$TimePeriodEnumMap[instance.period]!,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
      'maxExpense': instance.maxExpense,
      'totalExpense': instance.totalExpense,
      'totalIncome': instance.totalIncome,
    };

const _$TimePeriodEnumMap = {
  TimePeriod.week: 'week',
  TimePeriod.month: 'month',
  TimePeriod.year: 'year',
};

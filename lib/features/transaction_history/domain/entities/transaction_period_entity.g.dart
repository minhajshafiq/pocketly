// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_period_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TransactionPeriodEntity _$TransactionPeriodEntityFromJson(
  Map<String, dynamic> json,
) => _TransactionPeriodEntity(
  type: $enumDecode(_$PeriodTypeEnumMap, json['type']),
  startDate: DateTime.parse(json['startDate'] as String),
  endDate: DateTime.parse(json['endDate'] as String),
  label: json['label'] as String?,
);

Map<String, dynamic> _$TransactionPeriodEntityToJson(
  _TransactionPeriodEntity instance,
) => <String, dynamic>{
  'type': _$PeriodTypeEnumMap[instance.type]!,
  'startDate': instance.startDate.toIso8601String(),
  'endDate': instance.endDate.toIso8601String(),
  'label': instance.label,
};

const _$PeriodTypeEnumMap = {
  PeriodType.today: 'today',
  PeriodType.week: 'week',
  PeriodType.month: 'month',
  PeriodType.year: 'year',
  PeriodType.custom: 'custom',
};

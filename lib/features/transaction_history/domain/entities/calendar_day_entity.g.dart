// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar_day_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CalendarTransactionItem _$CalendarTransactionItemFromJson(
  Map<String, dynamic> json,
) => _CalendarTransactionItem(
  imageUrl: json['imageUrl'] as String?,
  type: json['type'] as String,
);

Map<String, dynamic> _$CalendarTransactionItemToJson(
  _CalendarTransactionItem instance,
) => <String, dynamic>{'imageUrl': instance.imageUrl, 'type': instance.type};

_CalendarDayEntity _$CalendarDayEntityFromJson(Map<String, dynamic> json) =>
    _CalendarDayEntity(
      date: DateTime.parse(json['date'] as String),
      transactionCount: (json['transactionCount'] as num).toInt(),
      totalExpense: (json['totalExpense'] as num).toDouble(),
      totalIncome: (json['totalIncome'] as num).toDouble(),
      transactions:
          (json['transactions'] as List<dynamic>?)
              ?.map(
                (e) =>
                    CalendarTransactionItem.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const [],
      hasTransactions: json['hasTransactions'] as bool? ?? false,
      isToday: json['isToday'] as bool? ?? false,
      isSelected: json['isSelected'] as bool? ?? false,
      isCurrentMonth: json['isCurrentMonth'] as bool? ?? false,
    );

Map<String, dynamic> _$CalendarDayEntityToJson(_CalendarDayEntity instance) =>
    <String, dynamic>{
      'date': instance.date.toIso8601String(),
      'transactionCount': instance.transactionCount,
      'totalExpense': instance.totalExpense,
      'totalIncome': instance.totalIncome,
      'transactions': instance.transactions,
      'hasTransactions': instance.hasTransactions,
      'isToday': instance.isToday,
      'isSelected': instance.isSelected,
      'isCurrentMonth': instance.isCurrentMonth,
    };

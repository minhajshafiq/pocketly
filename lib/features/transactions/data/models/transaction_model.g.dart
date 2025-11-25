// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TransactionModel _$TransactionModelFromJson(Map<String, dynamic> json) =>
    _TransactionModel(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String,
      amount: (json['amount'] as num).toDouble(),
      date: DateTime.parse(json['date'] as String),
      categoryId: (json['category_id'] as num).toInt(),
      type: $enumDecode(_$TransactionTypeEnumMap, json['type']),
      recurrence:
          $enumDecodeNullable(_$RecurrenceTypeEnumMap, json['recurrence']) ??
          RecurrenceType.none,
      imageUrl: json['image_url'] as String?,
      notes: json['notes'] as String?,
      userId: json['user_id'] as String,
      pocketId: json['pocket_id'] as String?,
      recurrenceGroupId: (json['recurrence_group_id'] as num?)?.toInt(),
      recurrenceStartDate: json['recurrence_start_date'] == null
          ? null
          : DateTime.parse(json['recurrence_start_date'] as String),
      recurrenceEndDate: json['recurrence_end_date'] == null
          ? null
          : DateTime.parse(json['recurrence_end_date'] as String),
      recurrenceDayOfMonth: (json['recurrence_day_of_month'] as num?)?.toInt(),
      isRecurrenceActive: json['is_recurrence_active'] as bool? ?? false,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$TransactionModelToJson(_TransactionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'amount': instance.amount,
      'date': instance.date.toIso8601String(),
      'category_id': instance.categoryId,
      'type': _$TransactionTypeEnumMap[instance.type]!,
      'recurrence': _$RecurrenceTypeEnumMap[instance.recurrence]!,
      'image_url': instance.imageUrl,
      'notes': instance.notes,
      'user_id': instance.userId,
      'pocket_id': instance.pocketId,
      'recurrence_group_id': instance.recurrenceGroupId,
      'recurrence_start_date': instance.recurrenceStartDate?.toIso8601String(),
      'recurrence_end_date': instance.recurrenceEndDate?.toIso8601String(),
      'recurrence_day_of_month': instance.recurrenceDayOfMonth,
      'is_recurrence_active': instance.isRecurrenceActive,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };

const _$TransactionTypeEnumMap = {
  TransactionType.income: 'income',
  TransactionType.expense: 'expense',
};

const _$RecurrenceTypeEnumMap = {
  RecurrenceType.none: 'none',
  RecurrenceType.daily: 'daily',
  RecurrenceType.weekly: 'weekly',
  RecurrenceType.biweekly: 'biweekly',
  RecurrenceType.monthly: 'monthly',
  RecurrenceType.quarterly: 'quarterly',
  RecurrenceType.yearly: 'yearly',
};

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pocket_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PocketEntity _$PocketEntityFromJson(Map<String, dynamic> json) =>
    _PocketEntity(
      id: json['id'] as String?,
      name: json['name'] as String,
      icon: json['icon'] as String,
      color: json['color'] as String,
      category: $enumDecode(_$PocketCategoryEnumMap, json['category']),
      budget: (json['budget'] as num?)?.toDouble() ?? 0.0,
      spent: (json['spent'] as num?)?.toDouble() ?? 0.0,
      savedAmount: (json['savedAmount'] as num?)?.toDouble() ?? 0.0,
      monthlySavingsAmount: (json['monthlySavingsAmount'] as num?)?.toDouble(),
      savingsGoalType:
          $enumDecodeNullable(
            _$SavingsGoalTypeEnumMap,
            json['savingsGoalType'],
          ) ??
          SavingsGoalType.none,
      targetAmount: (json['targetAmount'] as num?)?.toDouble(),
      targetDate: json['targetDate'] == null
          ? null
          : DateTime.parse(json['targetDate'] as String),
      userId: json['userId'] as String,
      isActive: json['isActive'] as bool? ?? true,
      isDefault: json['isDefault'] as bool? ?? false,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$PocketEntityToJson(_PocketEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'icon': instance.icon,
      'color': instance.color,
      'category': _$PocketCategoryEnumMap[instance.category]!,
      'budget': instance.budget,
      'spent': instance.spent,
      'savedAmount': instance.savedAmount,
      'monthlySavingsAmount': instance.monthlySavingsAmount,
      'savingsGoalType': _$SavingsGoalTypeEnumMap[instance.savingsGoalType]!,
      'targetAmount': instance.targetAmount,
      'targetDate': instance.targetDate?.toIso8601String(),
      'userId': instance.userId,
      'isActive': instance.isActive,
      'isDefault': instance.isDefault,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

const _$PocketCategoryEnumMap = {
  PocketCategory.needs: 'needs',
  PocketCategory.wants: 'wants',
  PocketCategory.savings: 'savings',
};

const _$SavingsGoalTypeEnumMap = {
  SavingsGoalType.none: 'none',
  SavingsGoalType.fixedAmount: 'fixedAmount',
  SavingsGoalType.targetDate: 'targetDate',
};

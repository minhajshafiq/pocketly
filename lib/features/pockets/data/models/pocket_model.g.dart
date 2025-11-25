// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pocket_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PocketModel _$PocketModelFromJson(Map<String, dynamic> json) => _PocketModel(
  id: json['id'] as String?,
  name: json['name'] as String,
  icon: json['icon'] as String,
  color: json['color'] as String,
  category: json['category'] as String,
  budget: (json['budget'] as num?)?.toDouble() ?? 0.0,
  spent: (json['spent'] as num?)?.toDouble() ?? 0.0,
  savedAmount: (json['saved_amount'] as num?)?.toDouble() ?? 0.0,
  monthlySavingsAmount: (json['monthly_savings_amount'] as num?)?.toDouble(),
  savingsGoalType: json['savings_goal_type'] as String? ?? 'none',
  targetAmount: (json['target_amount'] as num?)?.toDouble(),
  targetDate: json['target_date'] == null
      ? null
      : DateTime.parse(json['target_date'] as String),
  userId: json['user_id'] as String,
  isActive: json['is_active'] as bool? ?? true,
  isDefault: json['is_default'] as bool? ?? false,
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
  updatedAt: json['updated_at'] == null
      ? null
      : DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$PocketModelToJson(_PocketModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'icon': instance.icon,
      'color': instance.color,
      'category': instance.category,
      'budget': instance.budget,
      'spent': instance.spent,
      'saved_amount': instance.savedAmount,
      'monthly_savings_amount': instance.monthlySavingsAmount,
      'savings_goal_type': instance.savingsGoalType,
      'target_amount': instance.targetAmount,
      'target_date': instance.targetDate?.toIso8601String(),
      'user_id': instance.userId,
      'is_active': instance.isActive,
      'is_default': instance.isDefault,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };

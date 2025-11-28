// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CategoryModel _$CategoryModelFromJson(Map<String, dynamic> json) =>
    _CategoryModel(
      id: json['id'] as String?,
      name: json['name'] as String,
      type: $enumDecode(_$CategoryTypeEnumMap, json['type']),
      iconName: json['icon_name'] as String,
      color: json['color'] as String,
      isCustom: json['is_custom'] as bool? ?? false,
      userId: json['user_id'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$CategoryModelToJson(_CategoryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': _$CategoryTypeEnumMap[instance.type]!,
      'icon_name': instance.iconName,
      'color': instance.color,
      'is_custom': instance.isCustom,
      'user_id': instance.userId,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };

const _$CategoryTypeEnumMap = {
  CategoryType.income: 'income',
  CategoryType.expense: 'expense',
};

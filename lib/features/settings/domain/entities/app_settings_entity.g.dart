// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_settings_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AppSettingsEntity _$AppSettingsEntityFromJson(Map<String, dynamic> json) =>
    _AppSettingsEntity(
      themeMode: json['themeMode'] as String,
      notificationsEnabled: json['notificationsEnabled'] as bool? ?? true,
      dateFormat: json['dateFormat'] as String? ?? 'dd/MM/yyyy',
    );

Map<String, dynamic> _$AppSettingsEntityToJson(_AppSettingsEntity instance) =>
    <String, dynamic>{
      'themeMode': instance.themeMode,
      'notificationsEnabled': instance.notificationsEnabled,
      'dateFormat': instance.dateFormat,
    };

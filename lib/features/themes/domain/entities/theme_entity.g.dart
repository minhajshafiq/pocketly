// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ThemeEntity _$ThemeEntityFromJson(Map<String, dynamic> json) => _ThemeEntity(
  mode: $enumDecode(_$ThemeModeEnumMap, json['mode']),
  isDark: json['isDark'] as bool,
  isLight: json['isLight'] as bool,
  isSystem: json['isSystem'] as bool,
  displayName: json['displayName'] as String,
  iconName: json['iconName'] as String,
);

Map<String, dynamic> _$ThemeEntityToJson(_ThemeEntity instance) =>
    <String, dynamic>{
      'mode': _$ThemeModeEnumMap[instance.mode]!,
      'isDark': instance.isDark,
      'isLight': instance.isLight,
      'isSystem': instance.isSystem,
      'displayName': instance.displayName,
      'iconName': instance.iconName,
    };

const _$ThemeModeEnumMap = {
  ThemeMode.system: 'system',
  ThemeMode.light: 'light',
  ThemeMode.dark: 'dark',
};

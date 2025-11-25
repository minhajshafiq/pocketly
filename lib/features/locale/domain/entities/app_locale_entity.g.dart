// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_locale_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AppLocaleEntity _$AppLocaleEntityFromJson(Map<String, dynamic> json) =>
    _AppLocaleEntity(
      languageCode: json['languageCode'] as String,
      nativeName: json['nativeName'] as String,
      englishName: json['englishName'] as String,
      countryCode: json['countryCode'] as String?,
    );

Map<String, dynamic> _$AppLocaleEntityToJson(_AppLocaleEntity instance) =>
    <String, dynamic>{
      'languageCode': instance.languageCode,
      'nativeName': instance.nativeName,
      'englishName': instance.englishName,
      'countryCode': instance.countryCode,
    };

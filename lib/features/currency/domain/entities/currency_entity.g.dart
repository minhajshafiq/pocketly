// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currency_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CurrencyEntity _$CurrencyEntityFromJson(Map<String, dynamic> json) =>
    _CurrencyEntity(
      code: json['code'] as String,
      symbol: json['symbol'] as String,
      name: json['name'] as String,
      flag: json['flag'] as String,
    );

Map<String, dynamic> _$CurrencyEntityToJson(_CurrencyEntity instance) =>
    <String, dynamic>{
      'code': instance.code,
      'symbol': instance.symbol,
      'name': instance.name,
      'flag': instance.flag,
    };

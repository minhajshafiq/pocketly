// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_summary_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_HomeSummaryEntity _$HomeSummaryEntityFromJson(Map<String, dynamic> json) =>
    _HomeSummaryEntity(
      totalBalance: (json['totalBalance'] as num).toDouble(),
      totalSavings: (json['totalSavings'] as num?)?.toDouble() ?? 0.0,
      availableBalance: (json['availableBalance'] as num?)?.toDouble() ?? 0.0,
      variation24h: (json['variation24h'] as num).toDouble(),
      variationPercentage24h: (json['variationPercentage24h'] as num)
          .toDouble(),
      totalTransactions: (json['totalTransactions'] as num?)?.toInt() ?? 0,
      todayTransactions: (json['todayTransactions'] as num?)?.toInt() ?? 0,
      lastUpdate: DateTime.parse(json['lastUpdate'] as String),
    );

Map<String, dynamic> _$HomeSummaryEntityToJson(_HomeSummaryEntity instance) =>
    <String, dynamic>{
      'totalBalance': instance.totalBalance,
      'totalSavings': instance.totalSavings,
      'availableBalance': instance.availableBalance,
      'variation24h': instance.variation24h,
      'variationPercentage24h': instance.variationPercentage24h,
      'totalTransactions': instance.totalTransactions,
      'todayTransactions': instance.todayTransactions,
      'lastUpdate': instance.lastUpdate.toIso8601String(),
    };

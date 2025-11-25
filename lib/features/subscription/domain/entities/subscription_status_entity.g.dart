// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_status_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SubscriptionStatusEntity _$SubscriptionStatusEntityFromJson(
  Map<String, dynamic> json,
) => _SubscriptionStatusEntity(
  status: $enumDecode(_$SubscriptionStatusEnumMap, json['status']),
  isPremium: json['isPremium'] as bool,
  expirationDate: json['expirationDate'] == null
      ? null
      : DateTime.parse(json['expirationDate'] as String),
  renewalDate: json['renewalDate'] == null
      ? null
      : DateTime.parse(json['renewalDate'] as String),
  activeSubscriptionType: json['activeSubscriptionType'] as String?,
  willRenew: json['willRenew'] as bool? ?? false,
  isInTrial: json['isInTrial'] as bool? ?? false,
  daysRemaining: (json['daysRemaining'] as num?)?.toInt(),
);

Map<String, dynamic> _$SubscriptionStatusEntityToJson(
  _SubscriptionStatusEntity instance,
) => <String, dynamic>{
  'status': _$SubscriptionStatusEnumMap[instance.status]!,
  'isPremium': instance.isPremium,
  'expirationDate': instance.expirationDate?.toIso8601String(),
  'renewalDate': instance.renewalDate?.toIso8601String(),
  'activeSubscriptionType': instance.activeSubscriptionType,
  'willRenew': instance.willRenew,
  'isInTrial': instance.isInTrial,
  'daysRemaining': instance.daysRemaining,
};

const _$SubscriptionStatusEnumMap = {
  SubscriptionStatus.free: 'free',
  SubscriptionStatus.trial: 'trial',
  SubscriptionStatus.premium: 'premium',
  SubscriptionStatus.expired: 'expired',
};

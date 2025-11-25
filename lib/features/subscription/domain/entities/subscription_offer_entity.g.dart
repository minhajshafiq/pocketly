// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_offer_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SubscriptionOfferEntity _$SubscriptionOfferEntityFromJson(
  Map<String, dynamic> json,
) => _SubscriptionOfferEntity(
  id: json['id'] as String,
  type: $enumDecode(_$SubscriptionOfferTypeEnumMap, json['type']),
  title: json['title'] as String,
  description: json['description'] as String,
  priceString: json['priceString'] as String,
  price: (json['price'] as num).toDouble(),
  currencyCode: json['currencyCode'] as String,
  period: json['period'] as String,
  isBestValue: json['isBestValue'] as bool? ?? false,
  monthlyEquivalentPrice: json['monthlyEquivalentPrice'] as String?,
  savingsPercentage: (json['savingsPercentage'] as num?)?.toInt(),
  hasFreeTrial: json['hasFreeTrial'] as bool? ?? false,
  freeTrialDuration: (json['freeTrialDuration'] as num?)?.toInt(),
  freeTrialPeriodUnit: json['freeTrialPeriodUnit'] as String?,
  freeTrialPriceString: json['freeTrialPriceString'] as String?,
);

Map<String, dynamic> _$SubscriptionOfferEntityToJson(
  _SubscriptionOfferEntity instance,
) => <String, dynamic>{
  'id': instance.id,
  'type': _$SubscriptionOfferTypeEnumMap[instance.type]!,
  'title': instance.title,
  'description': instance.description,
  'priceString': instance.priceString,
  'price': instance.price,
  'currencyCode': instance.currencyCode,
  'period': instance.period,
  'isBestValue': instance.isBestValue,
  'monthlyEquivalentPrice': instance.monthlyEquivalentPrice,
  'savingsPercentage': instance.savingsPercentage,
  'hasFreeTrial': instance.hasFreeTrial,
  'freeTrialDuration': instance.freeTrialDuration,
  'freeTrialPeriodUnit': instance.freeTrialPeriodUnit,
  'freeTrialPriceString': instance.freeTrialPriceString,
};

const _$SubscriptionOfferTypeEnumMap = {
  SubscriptionOfferType.monthly: 'monthly',
  SubscriptionOfferType.yearly: 'yearly',
};

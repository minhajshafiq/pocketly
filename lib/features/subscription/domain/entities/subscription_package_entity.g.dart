// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_package_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SubscriptionPackageEntity _$SubscriptionPackageEntityFromJson(
  Map<String, dynamic> json,
) => _SubscriptionPackageEntity(
  identifier: json['identifier'] as String,
  offerType: $enumDecode(_$SubscriptionOfferTypeEnumMap, json['offerType']),
  productIdentifier: json['productIdentifier'] as String,
  priceString: json['priceString'] as String,
  price: (json['price'] as num).toDouble(),
  currencyCode: json['currencyCode'] as String,
  introPrice: json['introPrice'] as String?,
  introPeriod: json['introPeriod'] as String?,
);

Map<String, dynamic> _$SubscriptionPackageEntityToJson(
  _SubscriptionPackageEntity instance,
) => <String, dynamic>{
  'identifier': instance.identifier,
  'offerType': _$SubscriptionOfferTypeEnumMap[instance.offerType]!,
  'productIdentifier': instance.productIdentifier,
  'priceString': instance.priceString,
  'price': instance.price,
  'currencyCode': instance.currencyCode,
  'introPrice': instance.introPrice,
  'introPeriod': instance.introPeriod,
};

const _$SubscriptionOfferTypeEnumMap = {
  SubscriptionOfferType.monthly: 'monthly',
  SubscriptionOfferType.yearly: 'yearly',
};

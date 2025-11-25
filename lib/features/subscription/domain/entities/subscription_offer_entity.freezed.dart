// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'subscription_offer_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SubscriptionOfferEntity {

/// Identifiant de l'offre
 String get id;/// Type d'offre (monthly/yearly)
 SubscriptionOfferType get type;/// Titre de l'offre (ex: "Premium Monthly")
 String get title;/// Description de l'offre
 String get description;/// Prix formaté (ex: "5,99€")
 String get priceString;/// Prix en nombre (ex: 5.99)
 double get price;/// Devise (ex: "EUR")
 String get currencyCode;/// Période d'abonnement (ex: "mois", "an")
 String get period;/// Indicateur "Meilleure valeur"
 bool get isBestValue;/// Prix mensuel équivalent pour les offres annuelles
 String? get monthlyEquivalentPrice;/// Pourcentage d'économie par rapport au mensuel
 int? get savingsPercentage;/// Indique si cette offre a un essai gratuit
 bool get hasFreeTrial;/// Durée de l'essai gratuit (ex: 7, 14, 30)
 int? get freeTrialDuration;/// Unité de la période d'essai (ex: "jour", "jours", "day", "days")
 String? get freeTrialPeriodUnit;/// Prix formaté de l'essai (généralement "0€" ou "Gratuit")
 String? get freeTrialPriceString;
/// Create a copy of SubscriptionOfferEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SubscriptionOfferEntityCopyWith<SubscriptionOfferEntity> get copyWith => _$SubscriptionOfferEntityCopyWithImpl<SubscriptionOfferEntity>(this as SubscriptionOfferEntity, _$identity);

  /// Serializes this SubscriptionOfferEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SubscriptionOfferEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.priceString, priceString) || other.priceString == priceString)&&(identical(other.price, price) || other.price == price)&&(identical(other.currencyCode, currencyCode) || other.currencyCode == currencyCode)&&(identical(other.period, period) || other.period == period)&&(identical(other.isBestValue, isBestValue) || other.isBestValue == isBestValue)&&(identical(other.monthlyEquivalentPrice, monthlyEquivalentPrice) || other.monthlyEquivalentPrice == monthlyEquivalentPrice)&&(identical(other.savingsPercentage, savingsPercentage) || other.savingsPercentage == savingsPercentage)&&(identical(other.hasFreeTrial, hasFreeTrial) || other.hasFreeTrial == hasFreeTrial)&&(identical(other.freeTrialDuration, freeTrialDuration) || other.freeTrialDuration == freeTrialDuration)&&(identical(other.freeTrialPeriodUnit, freeTrialPeriodUnit) || other.freeTrialPeriodUnit == freeTrialPeriodUnit)&&(identical(other.freeTrialPriceString, freeTrialPriceString) || other.freeTrialPriceString == freeTrialPriceString));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,title,description,priceString,price,currencyCode,period,isBestValue,monthlyEquivalentPrice,savingsPercentage,hasFreeTrial,freeTrialDuration,freeTrialPeriodUnit,freeTrialPriceString);

@override
String toString() {
  return 'SubscriptionOfferEntity(id: $id, type: $type, title: $title, description: $description, priceString: $priceString, price: $price, currencyCode: $currencyCode, period: $period, isBestValue: $isBestValue, monthlyEquivalentPrice: $monthlyEquivalentPrice, savingsPercentage: $savingsPercentage, hasFreeTrial: $hasFreeTrial, freeTrialDuration: $freeTrialDuration, freeTrialPeriodUnit: $freeTrialPeriodUnit, freeTrialPriceString: $freeTrialPriceString)';
}


}

/// @nodoc
abstract mixin class $SubscriptionOfferEntityCopyWith<$Res>  {
  factory $SubscriptionOfferEntityCopyWith(SubscriptionOfferEntity value, $Res Function(SubscriptionOfferEntity) _then) = _$SubscriptionOfferEntityCopyWithImpl;
@useResult
$Res call({
 String id, SubscriptionOfferType type, String title, String description, String priceString, double price, String currencyCode, String period, bool isBestValue, String? monthlyEquivalentPrice, int? savingsPercentage, bool hasFreeTrial, int? freeTrialDuration, String? freeTrialPeriodUnit, String? freeTrialPriceString
});




}
/// @nodoc
class _$SubscriptionOfferEntityCopyWithImpl<$Res>
    implements $SubscriptionOfferEntityCopyWith<$Res> {
  _$SubscriptionOfferEntityCopyWithImpl(this._self, this._then);

  final SubscriptionOfferEntity _self;
  final $Res Function(SubscriptionOfferEntity) _then;

/// Create a copy of SubscriptionOfferEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? type = null,Object? title = null,Object? description = null,Object? priceString = null,Object? price = null,Object? currencyCode = null,Object? period = null,Object? isBestValue = null,Object? monthlyEquivalentPrice = freezed,Object? savingsPercentage = freezed,Object? hasFreeTrial = null,Object? freeTrialDuration = freezed,Object? freeTrialPeriodUnit = freezed,Object? freeTrialPriceString = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as SubscriptionOfferType,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,priceString: null == priceString ? _self.priceString : priceString // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,currencyCode: null == currencyCode ? _self.currencyCode : currencyCode // ignore: cast_nullable_to_non_nullable
as String,period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as String,isBestValue: null == isBestValue ? _self.isBestValue : isBestValue // ignore: cast_nullable_to_non_nullable
as bool,monthlyEquivalentPrice: freezed == monthlyEquivalentPrice ? _self.monthlyEquivalentPrice : monthlyEquivalentPrice // ignore: cast_nullable_to_non_nullable
as String?,savingsPercentage: freezed == savingsPercentage ? _self.savingsPercentage : savingsPercentage // ignore: cast_nullable_to_non_nullable
as int?,hasFreeTrial: null == hasFreeTrial ? _self.hasFreeTrial : hasFreeTrial // ignore: cast_nullable_to_non_nullable
as bool,freeTrialDuration: freezed == freeTrialDuration ? _self.freeTrialDuration : freeTrialDuration // ignore: cast_nullable_to_non_nullable
as int?,freeTrialPeriodUnit: freezed == freeTrialPeriodUnit ? _self.freeTrialPeriodUnit : freeTrialPeriodUnit // ignore: cast_nullable_to_non_nullable
as String?,freeTrialPriceString: freezed == freeTrialPriceString ? _self.freeTrialPriceString : freeTrialPriceString // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SubscriptionOfferEntity].
extension SubscriptionOfferEntityPatterns on SubscriptionOfferEntity {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SubscriptionOfferEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SubscriptionOfferEntity() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SubscriptionOfferEntity value)  $default,){
final _that = this;
switch (_that) {
case _SubscriptionOfferEntity():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SubscriptionOfferEntity value)?  $default,){
final _that = this;
switch (_that) {
case _SubscriptionOfferEntity() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  SubscriptionOfferType type,  String title,  String description,  String priceString,  double price,  String currencyCode,  String period,  bool isBestValue,  String? monthlyEquivalentPrice,  int? savingsPercentage,  bool hasFreeTrial,  int? freeTrialDuration,  String? freeTrialPeriodUnit,  String? freeTrialPriceString)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SubscriptionOfferEntity() when $default != null:
return $default(_that.id,_that.type,_that.title,_that.description,_that.priceString,_that.price,_that.currencyCode,_that.period,_that.isBestValue,_that.monthlyEquivalentPrice,_that.savingsPercentage,_that.hasFreeTrial,_that.freeTrialDuration,_that.freeTrialPeriodUnit,_that.freeTrialPriceString);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  SubscriptionOfferType type,  String title,  String description,  String priceString,  double price,  String currencyCode,  String period,  bool isBestValue,  String? monthlyEquivalentPrice,  int? savingsPercentage,  bool hasFreeTrial,  int? freeTrialDuration,  String? freeTrialPeriodUnit,  String? freeTrialPriceString)  $default,) {final _that = this;
switch (_that) {
case _SubscriptionOfferEntity():
return $default(_that.id,_that.type,_that.title,_that.description,_that.priceString,_that.price,_that.currencyCode,_that.period,_that.isBestValue,_that.monthlyEquivalentPrice,_that.savingsPercentage,_that.hasFreeTrial,_that.freeTrialDuration,_that.freeTrialPeriodUnit,_that.freeTrialPriceString);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  SubscriptionOfferType type,  String title,  String description,  String priceString,  double price,  String currencyCode,  String period,  bool isBestValue,  String? monthlyEquivalentPrice,  int? savingsPercentage,  bool hasFreeTrial,  int? freeTrialDuration,  String? freeTrialPeriodUnit,  String? freeTrialPriceString)?  $default,) {final _that = this;
switch (_that) {
case _SubscriptionOfferEntity() when $default != null:
return $default(_that.id,_that.type,_that.title,_that.description,_that.priceString,_that.price,_that.currencyCode,_that.period,_that.isBestValue,_that.monthlyEquivalentPrice,_that.savingsPercentage,_that.hasFreeTrial,_that.freeTrialDuration,_that.freeTrialPeriodUnit,_that.freeTrialPriceString);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SubscriptionOfferEntity implements SubscriptionOfferEntity {
  const _SubscriptionOfferEntity({required this.id, required this.type, required this.title, required this.description, required this.priceString, required this.price, required this.currencyCode, required this.period, this.isBestValue = false, this.monthlyEquivalentPrice, this.savingsPercentage, this.hasFreeTrial = false, this.freeTrialDuration, this.freeTrialPeriodUnit, this.freeTrialPriceString});
  factory _SubscriptionOfferEntity.fromJson(Map<String, dynamic> json) => _$SubscriptionOfferEntityFromJson(json);

/// Identifiant de l'offre
@override final  String id;
/// Type d'offre (monthly/yearly)
@override final  SubscriptionOfferType type;
/// Titre de l'offre (ex: "Premium Monthly")
@override final  String title;
/// Description de l'offre
@override final  String description;
/// Prix formaté (ex: "5,99€")
@override final  String priceString;
/// Prix en nombre (ex: 5.99)
@override final  double price;
/// Devise (ex: "EUR")
@override final  String currencyCode;
/// Période d'abonnement (ex: "mois", "an")
@override final  String period;
/// Indicateur "Meilleure valeur"
@override@JsonKey() final  bool isBestValue;
/// Prix mensuel équivalent pour les offres annuelles
@override final  String? monthlyEquivalentPrice;
/// Pourcentage d'économie par rapport au mensuel
@override final  int? savingsPercentage;
/// Indique si cette offre a un essai gratuit
@override@JsonKey() final  bool hasFreeTrial;
/// Durée de l'essai gratuit (ex: 7, 14, 30)
@override final  int? freeTrialDuration;
/// Unité de la période d'essai (ex: "jour", "jours", "day", "days")
@override final  String? freeTrialPeriodUnit;
/// Prix formaté de l'essai (généralement "0€" ou "Gratuit")
@override final  String? freeTrialPriceString;

/// Create a copy of SubscriptionOfferEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SubscriptionOfferEntityCopyWith<_SubscriptionOfferEntity> get copyWith => __$SubscriptionOfferEntityCopyWithImpl<_SubscriptionOfferEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SubscriptionOfferEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SubscriptionOfferEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.priceString, priceString) || other.priceString == priceString)&&(identical(other.price, price) || other.price == price)&&(identical(other.currencyCode, currencyCode) || other.currencyCode == currencyCode)&&(identical(other.period, period) || other.period == period)&&(identical(other.isBestValue, isBestValue) || other.isBestValue == isBestValue)&&(identical(other.monthlyEquivalentPrice, monthlyEquivalentPrice) || other.monthlyEquivalentPrice == monthlyEquivalentPrice)&&(identical(other.savingsPercentage, savingsPercentage) || other.savingsPercentage == savingsPercentage)&&(identical(other.hasFreeTrial, hasFreeTrial) || other.hasFreeTrial == hasFreeTrial)&&(identical(other.freeTrialDuration, freeTrialDuration) || other.freeTrialDuration == freeTrialDuration)&&(identical(other.freeTrialPeriodUnit, freeTrialPeriodUnit) || other.freeTrialPeriodUnit == freeTrialPeriodUnit)&&(identical(other.freeTrialPriceString, freeTrialPriceString) || other.freeTrialPriceString == freeTrialPriceString));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,title,description,priceString,price,currencyCode,period,isBestValue,monthlyEquivalentPrice,savingsPercentage,hasFreeTrial,freeTrialDuration,freeTrialPeriodUnit,freeTrialPriceString);

@override
String toString() {
  return 'SubscriptionOfferEntity(id: $id, type: $type, title: $title, description: $description, priceString: $priceString, price: $price, currencyCode: $currencyCode, period: $period, isBestValue: $isBestValue, monthlyEquivalentPrice: $monthlyEquivalentPrice, savingsPercentage: $savingsPercentage, hasFreeTrial: $hasFreeTrial, freeTrialDuration: $freeTrialDuration, freeTrialPeriodUnit: $freeTrialPeriodUnit, freeTrialPriceString: $freeTrialPriceString)';
}


}

/// @nodoc
abstract mixin class _$SubscriptionOfferEntityCopyWith<$Res> implements $SubscriptionOfferEntityCopyWith<$Res> {
  factory _$SubscriptionOfferEntityCopyWith(_SubscriptionOfferEntity value, $Res Function(_SubscriptionOfferEntity) _then) = __$SubscriptionOfferEntityCopyWithImpl;
@override @useResult
$Res call({
 String id, SubscriptionOfferType type, String title, String description, String priceString, double price, String currencyCode, String period, bool isBestValue, String? monthlyEquivalentPrice, int? savingsPercentage, bool hasFreeTrial, int? freeTrialDuration, String? freeTrialPeriodUnit, String? freeTrialPriceString
});




}
/// @nodoc
class __$SubscriptionOfferEntityCopyWithImpl<$Res>
    implements _$SubscriptionOfferEntityCopyWith<$Res> {
  __$SubscriptionOfferEntityCopyWithImpl(this._self, this._then);

  final _SubscriptionOfferEntity _self;
  final $Res Function(_SubscriptionOfferEntity) _then;

/// Create a copy of SubscriptionOfferEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? type = null,Object? title = null,Object? description = null,Object? priceString = null,Object? price = null,Object? currencyCode = null,Object? period = null,Object? isBestValue = null,Object? monthlyEquivalentPrice = freezed,Object? savingsPercentage = freezed,Object? hasFreeTrial = null,Object? freeTrialDuration = freezed,Object? freeTrialPeriodUnit = freezed,Object? freeTrialPriceString = freezed,}) {
  return _then(_SubscriptionOfferEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as SubscriptionOfferType,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,priceString: null == priceString ? _self.priceString : priceString // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,currencyCode: null == currencyCode ? _self.currencyCode : currencyCode // ignore: cast_nullable_to_non_nullable
as String,period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as String,isBestValue: null == isBestValue ? _self.isBestValue : isBestValue // ignore: cast_nullable_to_non_nullable
as bool,monthlyEquivalentPrice: freezed == monthlyEquivalentPrice ? _self.monthlyEquivalentPrice : monthlyEquivalentPrice // ignore: cast_nullable_to_non_nullable
as String?,savingsPercentage: freezed == savingsPercentage ? _self.savingsPercentage : savingsPercentage // ignore: cast_nullable_to_non_nullable
as int?,hasFreeTrial: null == hasFreeTrial ? _self.hasFreeTrial : hasFreeTrial // ignore: cast_nullable_to_non_nullable
as bool,freeTrialDuration: freezed == freeTrialDuration ? _self.freeTrialDuration : freeTrialDuration // ignore: cast_nullable_to_non_nullable
as int?,freeTrialPeriodUnit: freezed == freeTrialPeriodUnit ? _self.freeTrialPeriodUnit : freeTrialPeriodUnit // ignore: cast_nullable_to_non_nullable
as String?,freeTrialPriceString: freezed == freeTrialPriceString ? _self.freeTrialPriceString : freeTrialPriceString // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on

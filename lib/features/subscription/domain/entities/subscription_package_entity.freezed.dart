// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'subscription_package_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SubscriptionPackageEntity {

/// Identifiant du package
 String get identifier;/// Type d'offre
 SubscriptionOfferType get offerType;/// Identifiant du produit
 String get productIdentifier;/// Prix formaté
 String get priceString;/// Prix en nombre
 double get price;/// Code de devise
 String get currencyCode;/// Durée d'introduction (pour les essais gratuits)
 String? get introPrice;/// Période d'introduction
 String? get introPeriod;/// Package RevenueCat original (pour l'achat)
/// Note: Ne peut pas être sérialisé, utilisé uniquement en runtime
@JsonKey(includeFromJson: false, includeToJson: false) Object? get package;
/// Create a copy of SubscriptionPackageEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SubscriptionPackageEntityCopyWith<SubscriptionPackageEntity> get copyWith => _$SubscriptionPackageEntityCopyWithImpl<SubscriptionPackageEntity>(this as SubscriptionPackageEntity, _$identity);

  /// Serializes this SubscriptionPackageEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SubscriptionPackageEntity&&(identical(other.identifier, identifier) || other.identifier == identifier)&&(identical(other.offerType, offerType) || other.offerType == offerType)&&(identical(other.productIdentifier, productIdentifier) || other.productIdentifier == productIdentifier)&&(identical(other.priceString, priceString) || other.priceString == priceString)&&(identical(other.price, price) || other.price == price)&&(identical(other.currencyCode, currencyCode) || other.currencyCode == currencyCode)&&(identical(other.introPrice, introPrice) || other.introPrice == introPrice)&&(identical(other.introPeriod, introPeriod) || other.introPeriod == introPeriod)&&const DeepCollectionEquality().equals(other.package, package));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,identifier,offerType,productIdentifier,priceString,price,currencyCode,introPrice,introPeriod,const DeepCollectionEquality().hash(package));

@override
String toString() {
  return 'SubscriptionPackageEntity(identifier: $identifier, offerType: $offerType, productIdentifier: $productIdentifier, priceString: $priceString, price: $price, currencyCode: $currencyCode, introPrice: $introPrice, introPeriod: $introPeriod, package: $package)';
}


}

/// @nodoc
abstract mixin class $SubscriptionPackageEntityCopyWith<$Res>  {
  factory $SubscriptionPackageEntityCopyWith(SubscriptionPackageEntity value, $Res Function(SubscriptionPackageEntity) _then) = _$SubscriptionPackageEntityCopyWithImpl;
@useResult
$Res call({
 String identifier, SubscriptionOfferType offerType, String productIdentifier, String priceString, double price, String currencyCode, String? introPrice, String? introPeriod,@JsonKey(includeFromJson: false, includeToJson: false) Object? package
});




}
/// @nodoc
class _$SubscriptionPackageEntityCopyWithImpl<$Res>
    implements $SubscriptionPackageEntityCopyWith<$Res> {
  _$SubscriptionPackageEntityCopyWithImpl(this._self, this._then);

  final SubscriptionPackageEntity _self;
  final $Res Function(SubscriptionPackageEntity) _then;

/// Create a copy of SubscriptionPackageEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? identifier = null,Object? offerType = null,Object? productIdentifier = null,Object? priceString = null,Object? price = null,Object? currencyCode = null,Object? introPrice = freezed,Object? introPeriod = freezed,Object? package = freezed,}) {
  return _then(_self.copyWith(
identifier: null == identifier ? _self.identifier : identifier // ignore: cast_nullable_to_non_nullable
as String,offerType: null == offerType ? _self.offerType : offerType // ignore: cast_nullable_to_non_nullable
as SubscriptionOfferType,productIdentifier: null == productIdentifier ? _self.productIdentifier : productIdentifier // ignore: cast_nullable_to_non_nullable
as String,priceString: null == priceString ? _self.priceString : priceString // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,currencyCode: null == currencyCode ? _self.currencyCode : currencyCode // ignore: cast_nullable_to_non_nullable
as String,introPrice: freezed == introPrice ? _self.introPrice : introPrice // ignore: cast_nullable_to_non_nullable
as String?,introPeriod: freezed == introPeriod ? _self.introPeriod : introPeriod // ignore: cast_nullable_to_non_nullable
as String?,package: freezed == package ? _self.package : package ,
  ));
}

}


/// Adds pattern-matching-related methods to [SubscriptionPackageEntity].
extension SubscriptionPackageEntityPatterns on SubscriptionPackageEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SubscriptionPackageEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SubscriptionPackageEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SubscriptionPackageEntity value)  $default,){
final _that = this;
switch (_that) {
case _SubscriptionPackageEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SubscriptionPackageEntity value)?  $default,){
final _that = this;
switch (_that) {
case _SubscriptionPackageEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String identifier,  SubscriptionOfferType offerType,  String productIdentifier,  String priceString,  double price,  String currencyCode,  String? introPrice,  String? introPeriod, @JsonKey(includeFromJson: false, includeToJson: false)  Object? package)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SubscriptionPackageEntity() when $default != null:
return $default(_that.identifier,_that.offerType,_that.productIdentifier,_that.priceString,_that.price,_that.currencyCode,_that.introPrice,_that.introPeriod,_that.package);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String identifier,  SubscriptionOfferType offerType,  String productIdentifier,  String priceString,  double price,  String currencyCode,  String? introPrice,  String? introPeriod, @JsonKey(includeFromJson: false, includeToJson: false)  Object? package)  $default,) {final _that = this;
switch (_that) {
case _SubscriptionPackageEntity():
return $default(_that.identifier,_that.offerType,_that.productIdentifier,_that.priceString,_that.price,_that.currencyCode,_that.introPrice,_that.introPeriod,_that.package);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String identifier,  SubscriptionOfferType offerType,  String productIdentifier,  String priceString,  double price,  String currencyCode,  String? introPrice,  String? introPeriod, @JsonKey(includeFromJson: false, includeToJson: false)  Object? package)?  $default,) {final _that = this;
switch (_that) {
case _SubscriptionPackageEntity() when $default != null:
return $default(_that.identifier,_that.offerType,_that.productIdentifier,_that.priceString,_that.price,_that.currencyCode,_that.introPrice,_that.introPeriod,_that.package);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SubscriptionPackageEntity implements SubscriptionPackageEntity {
  const _SubscriptionPackageEntity({required this.identifier, required this.offerType, required this.productIdentifier, required this.priceString, required this.price, required this.currencyCode, this.introPrice, this.introPeriod, @JsonKey(includeFromJson: false, includeToJson: false) this.package});
  factory _SubscriptionPackageEntity.fromJson(Map<String, dynamic> json) => _$SubscriptionPackageEntityFromJson(json);

/// Identifiant du package
@override final  String identifier;
/// Type d'offre
@override final  SubscriptionOfferType offerType;
/// Identifiant du produit
@override final  String productIdentifier;
/// Prix formaté
@override final  String priceString;
/// Prix en nombre
@override final  double price;
/// Code de devise
@override final  String currencyCode;
/// Durée d'introduction (pour les essais gratuits)
@override final  String? introPrice;
/// Période d'introduction
@override final  String? introPeriod;
/// Package RevenueCat original (pour l'achat)
/// Note: Ne peut pas être sérialisé, utilisé uniquement en runtime
@override@JsonKey(includeFromJson: false, includeToJson: false) final  Object? package;

/// Create a copy of SubscriptionPackageEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SubscriptionPackageEntityCopyWith<_SubscriptionPackageEntity> get copyWith => __$SubscriptionPackageEntityCopyWithImpl<_SubscriptionPackageEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SubscriptionPackageEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SubscriptionPackageEntity&&(identical(other.identifier, identifier) || other.identifier == identifier)&&(identical(other.offerType, offerType) || other.offerType == offerType)&&(identical(other.productIdentifier, productIdentifier) || other.productIdentifier == productIdentifier)&&(identical(other.priceString, priceString) || other.priceString == priceString)&&(identical(other.price, price) || other.price == price)&&(identical(other.currencyCode, currencyCode) || other.currencyCode == currencyCode)&&(identical(other.introPrice, introPrice) || other.introPrice == introPrice)&&(identical(other.introPeriod, introPeriod) || other.introPeriod == introPeriod)&&const DeepCollectionEquality().equals(other.package, package));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,identifier,offerType,productIdentifier,priceString,price,currencyCode,introPrice,introPeriod,const DeepCollectionEquality().hash(package));

@override
String toString() {
  return 'SubscriptionPackageEntity(identifier: $identifier, offerType: $offerType, productIdentifier: $productIdentifier, priceString: $priceString, price: $price, currencyCode: $currencyCode, introPrice: $introPrice, introPeriod: $introPeriod, package: $package)';
}


}

/// @nodoc
abstract mixin class _$SubscriptionPackageEntityCopyWith<$Res> implements $SubscriptionPackageEntityCopyWith<$Res> {
  factory _$SubscriptionPackageEntityCopyWith(_SubscriptionPackageEntity value, $Res Function(_SubscriptionPackageEntity) _then) = __$SubscriptionPackageEntityCopyWithImpl;
@override @useResult
$Res call({
 String identifier, SubscriptionOfferType offerType, String productIdentifier, String priceString, double price, String currencyCode, String? introPrice, String? introPeriod,@JsonKey(includeFromJson: false, includeToJson: false) Object? package
});




}
/// @nodoc
class __$SubscriptionPackageEntityCopyWithImpl<$Res>
    implements _$SubscriptionPackageEntityCopyWith<$Res> {
  __$SubscriptionPackageEntityCopyWithImpl(this._self, this._then);

  final _SubscriptionPackageEntity _self;
  final $Res Function(_SubscriptionPackageEntity) _then;

/// Create a copy of SubscriptionPackageEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? identifier = null,Object? offerType = null,Object? productIdentifier = null,Object? priceString = null,Object? price = null,Object? currencyCode = null,Object? introPrice = freezed,Object? introPeriod = freezed,Object? package = freezed,}) {
  return _then(_SubscriptionPackageEntity(
identifier: null == identifier ? _self.identifier : identifier // ignore: cast_nullable_to_non_nullable
as String,offerType: null == offerType ? _self.offerType : offerType // ignore: cast_nullable_to_non_nullable
as SubscriptionOfferType,productIdentifier: null == productIdentifier ? _self.productIdentifier : productIdentifier // ignore: cast_nullable_to_non_nullable
as String,priceString: null == priceString ? _self.priceString : priceString // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,currencyCode: null == currencyCode ? _self.currencyCode : currencyCode // ignore: cast_nullable_to_non_nullable
as String,introPrice: freezed == introPrice ? _self.introPrice : introPrice // ignore: cast_nullable_to_non_nullable
as String?,introPeriod: freezed == introPeriod ? _self.introPeriod : introPeriod // ignore: cast_nullable_to_non_nullable
as String?,package: freezed == package ? _self.package : package ,
  ));
}


}

// dart format on

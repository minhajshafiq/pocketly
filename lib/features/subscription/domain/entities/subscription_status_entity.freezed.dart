// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'subscription_status_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SubscriptionStatusEntity {

/// Statut de l'abonnement
 SubscriptionStatus get status;/// L'utilisateur a-t-il accès aux fonctionnalités premium
 bool get isPremium;/// Date d'expiration de l'abonnement
 DateTime? get expirationDate;/// Date de renouvellement automatique
 DateTime? get renewalDate;/// Type d'abonnement actif
 String? get activeSubscriptionType;/// L'abonnement se renouvelle-t-il automatiquement
 bool get willRenew;/// L'utilisateur est-il en période d'essai
 bool get isInTrial;/// Nombre de jours restants avant expiration
 int? get daysRemaining;
/// Create a copy of SubscriptionStatusEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SubscriptionStatusEntityCopyWith<SubscriptionStatusEntity> get copyWith => _$SubscriptionStatusEntityCopyWithImpl<SubscriptionStatusEntity>(this as SubscriptionStatusEntity, _$identity);

  /// Serializes this SubscriptionStatusEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SubscriptionStatusEntity&&(identical(other.status, status) || other.status == status)&&(identical(other.isPremium, isPremium) || other.isPremium == isPremium)&&(identical(other.expirationDate, expirationDate) || other.expirationDate == expirationDate)&&(identical(other.renewalDate, renewalDate) || other.renewalDate == renewalDate)&&(identical(other.activeSubscriptionType, activeSubscriptionType) || other.activeSubscriptionType == activeSubscriptionType)&&(identical(other.willRenew, willRenew) || other.willRenew == willRenew)&&(identical(other.isInTrial, isInTrial) || other.isInTrial == isInTrial)&&(identical(other.daysRemaining, daysRemaining) || other.daysRemaining == daysRemaining));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,isPremium,expirationDate,renewalDate,activeSubscriptionType,willRenew,isInTrial,daysRemaining);

@override
String toString() {
  return 'SubscriptionStatusEntity(status: $status, isPremium: $isPremium, expirationDate: $expirationDate, renewalDate: $renewalDate, activeSubscriptionType: $activeSubscriptionType, willRenew: $willRenew, isInTrial: $isInTrial, daysRemaining: $daysRemaining)';
}


}

/// @nodoc
abstract mixin class $SubscriptionStatusEntityCopyWith<$Res>  {
  factory $SubscriptionStatusEntityCopyWith(SubscriptionStatusEntity value, $Res Function(SubscriptionStatusEntity) _then) = _$SubscriptionStatusEntityCopyWithImpl;
@useResult
$Res call({
 SubscriptionStatus status, bool isPremium, DateTime? expirationDate, DateTime? renewalDate, String? activeSubscriptionType, bool willRenew, bool isInTrial, int? daysRemaining
});




}
/// @nodoc
class _$SubscriptionStatusEntityCopyWithImpl<$Res>
    implements $SubscriptionStatusEntityCopyWith<$Res> {
  _$SubscriptionStatusEntityCopyWithImpl(this._self, this._then);

  final SubscriptionStatusEntity _self;
  final $Res Function(SubscriptionStatusEntity) _then;

/// Create a copy of SubscriptionStatusEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? isPremium = null,Object? expirationDate = freezed,Object? renewalDate = freezed,Object? activeSubscriptionType = freezed,Object? willRenew = null,Object? isInTrial = null,Object? daysRemaining = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SubscriptionStatus,isPremium: null == isPremium ? _self.isPremium : isPremium // ignore: cast_nullable_to_non_nullable
as bool,expirationDate: freezed == expirationDate ? _self.expirationDate : expirationDate // ignore: cast_nullable_to_non_nullable
as DateTime?,renewalDate: freezed == renewalDate ? _self.renewalDate : renewalDate // ignore: cast_nullable_to_non_nullable
as DateTime?,activeSubscriptionType: freezed == activeSubscriptionType ? _self.activeSubscriptionType : activeSubscriptionType // ignore: cast_nullable_to_non_nullable
as String?,willRenew: null == willRenew ? _self.willRenew : willRenew // ignore: cast_nullable_to_non_nullable
as bool,isInTrial: null == isInTrial ? _self.isInTrial : isInTrial // ignore: cast_nullable_to_non_nullable
as bool,daysRemaining: freezed == daysRemaining ? _self.daysRemaining : daysRemaining // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [SubscriptionStatusEntity].
extension SubscriptionStatusEntityPatterns on SubscriptionStatusEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SubscriptionStatusEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SubscriptionStatusEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SubscriptionStatusEntity value)  $default,){
final _that = this;
switch (_that) {
case _SubscriptionStatusEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SubscriptionStatusEntity value)?  $default,){
final _that = this;
switch (_that) {
case _SubscriptionStatusEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( SubscriptionStatus status,  bool isPremium,  DateTime? expirationDate,  DateTime? renewalDate,  String? activeSubscriptionType,  bool willRenew,  bool isInTrial,  int? daysRemaining)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SubscriptionStatusEntity() when $default != null:
return $default(_that.status,_that.isPremium,_that.expirationDate,_that.renewalDate,_that.activeSubscriptionType,_that.willRenew,_that.isInTrial,_that.daysRemaining);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( SubscriptionStatus status,  bool isPremium,  DateTime? expirationDate,  DateTime? renewalDate,  String? activeSubscriptionType,  bool willRenew,  bool isInTrial,  int? daysRemaining)  $default,) {final _that = this;
switch (_that) {
case _SubscriptionStatusEntity():
return $default(_that.status,_that.isPremium,_that.expirationDate,_that.renewalDate,_that.activeSubscriptionType,_that.willRenew,_that.isInTrial,_that.daysRemaining);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( SubscriptionStatus status,  bool isPremium,  DateTime? expirationDate,  DateTime? renewalDate,  String? activeSubscriptionType,  bool willRenew,  bool isInTrial,  int? daysRemaining)?  $default,) {final _that = this;
switch (_that) {
case _SubscriptionStatusEntity() when $default != null:
return $default(_that.status,_that.isPremium,_that.expirationDate,_that.renewalDate,_that.activeSubscriptionType,_that.willRenew,_that.isInTrial,_that.daysRemaining);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SubscriptionStatusEntity implements SubscriptionStatusEntity {
  const _SubscriptionStatusEntity({required this.status, required this.isPremium, this.expirationDate, this.renewalDate, this.activeSubscriptionType, this.willRenew = false, this.isInTrial = false, this.daysRemaining});
  factory _SubscriptionStatusEntity.fromJson(Map<String, dynamic> json) => _$SubscriptionStatusEntityFromJson(json);

/// Statut de l'abonnement
@override final  SubscriptionStatus status;
/// L'utilisateur a-t-il accès aux fonctionnalités premium
@override final  bool isPremium;
/// Date d'expiration de l'abonnement
@override final  DateTime? expirationDate;
/// Date de renouvellement automatique
@override final  DateTime? renewalDate;
/// Type d'abonnement actif
@override final  String? activeSubscriptionType;
/// L'abonnement se renouvelle-t-il automatiquement
@override@JsonKey() final  bool willRenew;
/// L'utilisateur est-il en période d'essai
@override@JsonKey() final  bool isInTrial;
/// Nombre de jours restants avant expiration
@override final  int? daysRemaining;

/// Create a copy of SubscriptionStatusEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SubscriptionStatusEntityCopyWith<_SubscriptionStatusEntity> get copyWith => __$SubscriptionStatusEntityCopyWithImpl<_SubscriptionStatusEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SubscriptionStatusEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SubscriptionStatusEntity&&(identical(other.status, status) || other.status == status)&&(identical(other.isPremium, isPremium) || other.isPremium == isPremium)&&(identical(other.expirationDate, expirationDate) || other.expirationDate == expirationDate)&&(identical(other.renewalDate, renewalDate) || other.renewalDate == renewalDate)&&(identical(other.activeSubscriptionType, activeSubscriptionType) || other.activeSubscriptionType == activeSubscriptionType)&&(identical(other.willRenew, willRenew) || other.willRenew == willRenew)&&(identical(other.isInTrial, isInTrial) || other.isInTrial == isInTrial)&&(identical(other.daysRemaining, daysRemaining) || other.daysRemaining == daysRemaining));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,isPremium,expirationDate,renewalDate,activeSubscriptionType,willRenew,isInTrial,daysRemaining);

@override
String toString() {
  return 'SubscriptionStatusEntity(status: $status, isPremium: $isPremium, expirationDate: $expirationDate, renewalDate: $renewalDate, activeSubscriptionType: $activeSubscriptionType, willRenew: $willRenew, isInTrial: $isInTrial, daysRemaining: $daysRemaining)';
}


}

/// @nodoc
abstract mixin class _$SubscriptionStatusEntityCopyWith<$Res> implements $SubscriptionStatusEntityCopyWith<$Res> {
  factory _$SubscriptionStatusEntityCopyWith(_SubscriptionStatusEntity value, $Res Function(_SubscriptionStatusEntity) _then) = __$SubscriptionStatusEntityCopyWithImpl;
@override @useResult
$Res call({
 SubscriptionStatus status, bool isPremium, DateTime? expirationDate, DateTime? renewalDate, String? activeSubscriptionType, bool willRenew, bool isInTrial, int? daysRemaining
});




}
/// @nodoc
class __$SubscriptionStatusEntityCopyWithImpl<$Res>
    implements _$SubscriptionStatusEntityCopyWith<$Res> {
  __$SubscriptionStatusEntityCopyWithImpl(this._self, this._then);

  final _SubscriptionStatusEntity _self;
  final $Res Function(_SubscriptionStatusEntity) _then;

/// Create a copy of SubscriptionStatusEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? isPremium = null,Object? expirationDate = freezed,Object? renewalDate = freezed,Object? activeSubscriptionType = freezed,Object? willRenew = null,Object? isInTrial = null,Object? daysRemaining = freezed,}) {
  return _then(_SubscriptionStatusEntity(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SubscriptionStatus,isPremium: null == isPremium ? _self.isPremium : isPremium // ignore: cast_nullable_to_non_nullable
as bool,expirationDate: freezed == expirationDate ? _self.expirationDate : expirationDate // ignore: cast_nullable_to_non_nullable
as DateTime?,renewalDate: freezed == renewalDate ? _self.renewalDate : renewalDate // ignore: cast_nullable_to_non_nullable
as DateTime?,activeSubscriptionType: freezed == activeSubscriptionType ? _self.activeSubscriptionType : activeSubscriptionType // ignore: cast_nullable_to_non_nullable
as String?,willRenew: null == willRenew ? _self.willRenew : willRenew // ignore: cast_nullable_to_non_nullable
as bool,isInTrial: null == isInTrial ? _self.isInTrial : isInTrial // ignore: cast_nullable_to_non_nullable
as bool,daysRemaining: freezed == daysRemaining ? _self.daysRemaining : daysRemaining // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on

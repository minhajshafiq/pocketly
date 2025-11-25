// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_summary_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$HomeSummaryEntity {

/// Solde total actuel (revenus - dépenses)
 double get totalBalance;/// Montant total épargné dans les pockets savings
 double get totalSavings;/// Solde disponible (totalBalance - totalSavings)
 double get availableBalance;/// Variation du solde sur les dernières 24h
 double get variation24h;/// Pourcentage de variation sur 24h
 double get variationPercentage24h;/// Nombre total de transactions
 int get totalTransactions;/// Nombre de transactions du jour
 int get todayTransactions;/// Dernière mise à jour
 DateTime get lastUpdate;
/// Create a copy of HomeSummaryEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeSummaryEntityCopyWith<HomeSummaryEntity> get copyWith => _$HomeSummaryEntityCopyWithImpl<HomeSummaryEntity>(this as HomeSummaryEntity, _$identity);

  /// Serializes this HomeSummaryEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeSummaryEntity&&(identical(other.totalBalance, totalBalance) || other.totalBalance == totalBalance)&&(identical(other.totalSavings, totalSavings) || other.totalSavings == totalSavings)&&(identical(other.availableBalance, availableBalance) || other.availableBalance == availableBalance)&&(identical(other.variation24h, variation24h) || other.variation24h == variation24h)&&(identical(other.variationPercentage24h, variationPercentage24h) || other.variationPercentage24h == variationPercentage24h)&&(identical(other.totalTransactions, totalTransactions) || other.totalTransactions == totalTransactions)&&(identical(other.todayTransactions, todayTransactions) || other.todayTransactions == todayTransactions)&&(identical(other.lastUpdate, lastUpdate) || other.lastUpdate == lastUpdate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalBalance,totalSavings,availableBalance,variation24h,variationPercentage24h,totalTransactions,todayTransactions,lastUpdate);

@override
String toString() {
  return 'HomeSummaryEntity(totalBalance: $totalBalance, totalSavings: $totalSavings, availableBalance: $availableBalance, variation24h: $variation24h, variationPercentage24h: $variationPercentage24h, totalTransactions: $totalTransactions, todayTransactions: $todayTransactions, lastUpdate: $lastUpdate)';
}


}

/// @nodoc
abstract mixin class $HomeSummaryEntityCopyWith<$Res>  {
  factory $HomeSummaryEntityCopyWith(HomeSummaryEntity value, $Res Function(HomeSummaryEntity) _then) = _$HomeSummaryEntityCopyWithImpl;
@useResult
$Res call({
 double totalBalance, double totalSavings, double availableBalance, double variation24h, double variationPercentage24h, int totalTransactions, int todayTransactions, DateTime lastUpdate
});




}
/// @nodoc
class _$HomeSummaryEntityCopyWithImpl<$Res>
    implements $HomeSummaryEntityCopyWith<$Res> {
  _$HomeSummaryEntityCopyWithImpl(this._self, this._then);

  final HomeSummaryEntity _self;
  final $Res Function(HomeSummaryEntity) _then;

/// Create a copy of HomeSummaryEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalBalance = null,Object? totalSavings = null,Object? availableBalance = null,Object? variation24h = null,Object? variationPercentage24h = null,Object? totalTransactions = null,Object? todayTransactions = null,Object? lastUpdate = null,}) {
  return _then(_self.copyWith(
totalBalance: null == totalBalance ? _self.totalBalance : totalBalance // ignore: cast_nullable_to_non_nullable
as double,totalSavings: null == totalSavings ? _self.totalSavings : totalSavings // ignore: cast_nullable_to_non_nullable
as double,availableBalance: null == availableBalance ? _self.availableBalance : availableBalance // ignore: cast_nullable_to_non_nullable
as double,variation24h: null == variation24h ? _self.variation24h : variation24h // ignore: cast_nullable_to_non_nullable
as double,variationPercentage24h: null == variationPercentage24h ? _self.variationPercentage24h : variationPercentage24h // ignore: cast_nullable_to_non_nullable
as double,totalTransactions: null == totalTransactions ? _self.totalTransactions : totalTransactions // ignore: cast_nullable_to_non_nullable
as int,todayTransactions: null == todayTransactions ? _self.todayTransactions : todayTransactions // ignore: cast_nullable_to_non_nullable
as int,lastUpdate: null == lastUpdate ? _self.lastUpdate : lastUpdate // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [HomeSummaryEntity].
extension HomeSummaryEntityPatterns on HomeSummaryEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HomeSummaryEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HomeSummaryEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HomeSummaryEntity value)  $default,){
final _that = this;
switch (_that) {
case _HomeSummaryEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HomeSummaryEntity value)?  $default,){
final _that = this;
switch (_that) {
case _HomeSummaryEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double totalBalance,  double totalSavings,  double availableBalance,  double variation24h,  double variationPercentage24h,  int totalTransactions,  int todayTransactions,  DateTime lastUpdate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HomeSummaryEntity() when $default != null:
return $default(_that.totalBalance,_that.totalSavings,_that.availableBalance,_that.variation24h,_that.variationPercentage24h,_that.totalTransactions,_that.todayTransactions,_that.lastUpdate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double totalBalance,  double totalSavings,  double availableBalance,  double variation24h,  double variationPercentage24h,  int totalTransactions,  int todayTransactions,  DateTime lastUpdate)  $default,) {final _that = this;
switch (_that) {
case _HomeSummaryEntity():
return $default(_that.totalBalance,_that.totalSavings,_that.availableBalance,_that.variation24h,_that.variationPercentage24h,_that.totalTransactions,_that.todayTransactions,_that.lastUpdate);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double totalBalance,  double totalSavings,  double availableBalance,  double variation24h,  double variationPercentage24h,  int totalTransactions,  int todayTransactions,  DateTime lastUpdate)?  $default,) {final _that = this;
switch (_that) {
case _HomeSummaryEntity() when $default != null:
return $default(_that.totalBalance,_that.totalSavings,_that.availableBalance,_that.variation24h,_that.variationPercentage24h,_that.totalTransactions,_that.todayTransactions,_that.lastUpdate);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HomeSummaryEntity implements HomeSummaryEntity {
  const _HomeSummaryEntity({required this.totalBalance, this.totalSavings = 0.0, this.availableBalance = 0.0, required this.variation24h, required this.variationPercentage24h, this.totalTransactions = 0, this.todayTransactions = 0, required this.lastUpdate});
  factory _HomeSummaryEntity.fromJson(Map<String, dynamic> json) => _$HomeSummaryEntityFromJson(json);

/// Solde total actuel (revenus - dépenses)
@override final  double totalBalance;
/// Montant total épargné dans les pockets savings
@override@JsonKey() final  double totalSavings;
/// Solde disponible (totalBalance - totalSavings)
@override@JsonKey() final  double availableBalance;
/// Variation du solde sur les dernières 24h
@override final  double variation24h;
/// Pourcentage de variation sur 24h
@override final  double variationPercentage24h;
/// Nombre total de transactions
@override@JsonKey() final  int totalTransactions;
/// Nombre de transactions du jour
@override@JsonKey() final  int todayTransactions;
/// Dernière mise à jour
@override final  DateTime lastUpdate;

/// Create a copy of HomeSummaryEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HomeSummaryEntityCopyWith<_HomeSummaryEntity> get copyWith => __$HomeSummaryEntityCopyWithImpl<_HomeSummaryEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HomeSummaryEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HomeSummaryEntity&&(identical(other.totalBalance, totalBalance) || other.totalBalance == totalBalance)&&(identical(other.totalSavings, totalSavings) || other.totalSavings == totalSavings)&&(identical(other.availableBalance, availableBalance) || other.availableBalance == availableBalance)&&(identical(other.variation24h, variation24h) || other.variation24h == variation24h)&&(identical(other.variationPercentage24h, variationPercentage24h) || other.variationPercentage24h == variationPercentage24h)&&(identical(other.totalTransactions, totalTransactions) || other.totalTransactions == totalTransactions)&&(identical(other.todayTransactions, todayTransactions) || other.todayTransactions == todayTransactions)&&(identical(other.lastUpdate, lastUpdate) || other.lastUpdate == lastUpdate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalBalance,totalSavings,availableBalance,variation24h,variationPercentage24h,totalTransactions,todayTransactions,lastUpdate);

@override
String toString() {
  return 'HomeSummaryEntity(totalBalance: $totalBalance, totalSavings: $totalSavings, availableBalance: $availableBalance, variation24h: $variation24h, variationPercentage24h: $variationPercentage24h, totalTransactions: $totalTransactions, todayTransactions: $todayTransactions, lastUpdate: $lastUpdate)';
}


}

/// @nodoc
abstract mixin class _$HomeSummaryEntityCopyWith<$Res> implements $HomeSummaryEntityCopyWith<$Res> {
  factory _$HomeSummaryEntityCopyWith(_HomeSummaryEntity value, $Res Function(_HomeSummaryEntity) _then) = __$HomeSummaryEntityCopyWithImpl;
@override @useResult
$Res call({
 double totalBalance, double totalSavings, double availableBalance, double variation24h, double variationPercentage24h, int totalTransactions, int todayTransactions, DateTime lastUpdate
});




}
/// @nodoc
class __$HomeSummaryEntityCopyWithImpl<$Res>
    implements _$HomeSummaryEntityCopyWith<$Res> {
  __$HomeSummaryEntityCopyWithImpl(this._self, this._then);

  final _HomeSummaryEntity _self;
  final $Res Function(_HomeSummaryEntity) _then;

/// Create a copy of HomeSummaryEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalBalance = null,Object? totalSavings = null,Object? availableBalance = null,Object? variation24h = null,Object? variationPercentage24h = null,Object? totalTransactions = null,Object? todayTransactions = null,Object? lastUpdate = null,}) {
  return _then(_HomeSummaryEntity(
totalBalance: null == totalBalance ? _self.totalBalance : totalBalance // ignore: cast_nullable_to_non_nullable
as double,totalSavings: null == totalSavings ? _self.totalSavings : totalSavings // ignore: cast_nullable_to_non_nullable
as double,availableBalance: null == availableBalance ? _self.availableBalance : availableBalance // ignore: cast_nullable_to_non_nullable
as double,variation24h: null == variation24h ? _self.variation24h : variation24h // ignore: cast_nullable_to_non_nullable
as double,variationPercentage24h: null == variationPercentage24h ? _self.variationPercentage24h : variationPercentage24h // ignore: cast_nullable_to_non_nullable
as double,totalTransactions: null == totalTransactions ? _self.totalTransactions : totalTransactions // ignore: cast_nullable_to_non_nullable
as int,todayTransactions: null == todayTransactions ? _self.todayTransactions : todayTransactions // ignore: cast_nullable_to_non_nullable
as int,lastUpdate: null == lastUpdate ? _self.lastUpdate : lastUpdate // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on

// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transaction_period_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TransactionPeriodEntity {

 PeriodType get type; DateTime get startDate; DateTime get endDate; String? get label;
/// Create a copy of TransactionPeriodEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TransactionPeriodEntityCopyWith<TransactionPeriodEntity> get copyWith => _$TransactionPeriodEntityCopyWithImpl<TransactionPeriodEntity>(this as TransactionPeriodEntity, _$identity);

  /// Serializes this TransactionPeriodEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TransactionPeriodEntity&&(identical(other.type, type) || other.type == type)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.label, label) || other.label == label));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,startDate,endDate,label);

@override
String toString() {
  return 'TransactionPeriodEntity(type: $type, startDate: $startDate, endDate: $endDate, label: $label)';
}


}

/// @nodoc
abstract mixin class $TransactionPeriodEntityCopyWith<$Res>  {
  factory $TransactionPeriodEntityCopyWith(TransactionPeriodEntity value, $Res Function(TransactionPeriodEntity) _then) = _$TransactionPeriodEntityCopyWithImpl;
@useResult
$Res call({
 PeriodType type, DateTime startDate, DateTime endDate, String? label
});




}
/// @nodoc
class _$TransactionPeriodEntityCopyWithImpl<$Res>
    implements $TransactionPeriodEntityCopyWith<$Res> {
  _$TransactionPeriodEntityCopyWithImpl(this._self, this._then);

  final TransactionPeriodEntity _self;
  final $Res Function(TransactionPeriodEntity) _then;

/// Create a copy of TransactionPeriodEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? startDate = null,Object? endDate = null,Object? label = freezed,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as PeriodType,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,endDate: null == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime,label: freezed == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TransactionPeriodEntity].
extension TransactionPeriodEntityPatterns on TransactionPeriodEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TransactionPeriodEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TransactionPeriodEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TransactionPeriodEntity value)  $default,){
final _that = this;
switch (_that) {
case _TransactionPeriodEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TransactionPeriodEntity value)?  $default,){
final _that = this;
switch (_that) {
case _TransactionPeriodEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( PeriodType type,  DateTime startDate,  DateTime endDate,  String? label)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TransactionPeriodEntity() when $default != null:
return $default(_that.type,_that.startDate,_that.endDate,_that.label);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( PeriodType type,  DateTime startDate,  DateTime endDate,  String? label)  $default,) {final _that = this;
switch (_that) {
case _TransactionPeriodEntity():
return $default(_that.type,_that.startDate,_that.endDate,_that.label);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( PeriodType type,  DateTime startDate,  DateTime endDate,  String? label)?  $default,) {final _that = this;
switch (_that) {
case _TransactionPeriodEntity() when $default != null:
return $default(_that.type,_that.startDate,_that.endDate,_that.label);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TransactionPeriodEntity implements TransactionPeriodEntity {
  const _TransactionPeriodEntity({required this.type, required this.startDate, required this.endDate, this.label});
  factory _TransactionPeriodEntity.fromJson(Map<String, dynamic> json) => _$TransactionPeriodEntityFromJson(json);

@override final  PeriodType type;
@override final  DateTime startDate;
@override final  DateTime endDate;
@override final  String? label;

/// Create a copy of TransactionPeriodEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TransactionPeriodEntityCopyWith<_TransactionPeriodEntity> get copyWith => __$TransactionPeriodEntityCopyWithImpl<_TransactionPeriodEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TransactionPeriodEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TransactionPeriodEntity&&(identical(other.type, type) || other.type == type)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.label, label) || other.label == label));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,startDate,endDate,label);

@override
String toString() {
  return 'TransactionPeriodEntity(type: $type, startDate: $startDate, endDate: $endDate, label: $label)';
}


}

/// @nodoc
abstract mixin class _$TransactionPeriodEntityCopyWith<$Res> implements $TransactionPeriodEntityCopyWith<$Res> {
  factory _$TransactionPeriodEntityCopyWith(_TransactionPeriodEntity value, $Res Function(_TransactionPeriodEntity) _then) = __$TransactionPeriodEntityCopyWithImpl;
@override @useResult
$Res call({
 PeriodType type, DateTime startDate, DateTime endDate, String? label
});




}
/// @nodoc
class __$TransactionPeriodEntityCopyWithImpl<$Res>
    implements _$TransactionPeriodEntityCopyWith<$Res> {
  __$TransactionPeriodEntityCopyWithImpl(this._self, this._then);

  final _TransactionPeriodEntity _self;
  final $Res Function(_TransactionPeriodEntity) _then;

/// Create a copy of TransactionPeriodEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? startDate = null,Object? endDate = null,Object? label = freezed,}) {
  return _then(_TransactionPeriodEntity(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as PeriodType,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,endDate: null == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime,label: freezed == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on

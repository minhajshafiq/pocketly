// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'currency_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CurrencyEntity {

/// Code ISO 4217 de la devise (ex: EUR, USD)
 String get code;/// Symbole de la devise (ex: €, $)
 String get symbol;/// Nom complet de la devise
 String get name;/// Emoji du drapeau du pays principal
 String get flag;
/// Create a copy of CurrencyEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CurrencyEntityCopyWith<CurrencyEntity> get copyWith => _$CurrencyEntityCopyWithImpl<CurrencyEntity>(this as CurrencyEntity, _$identity);

  /// Serializes this CurrencyEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CurrencyEntity&&(identical(other.code, code) || other.code == code)&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.name, name) || other.name == name)&&(identical(other.flag, flag) || other.flag == flag));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,symbol,name,flag);

@override
String toString() {
  return 'CurrencyEntity(code: $code, symbol: $symbol, name: $name, flag: $flag)';
}


}

/// @nodoc
abstract mixin class $CurrencyEntityCopyWith<$Res>  {
  factory $CurrencyEntityCopyWith(CurrencyEntity value, $Res Function(CurrencyEntity) _then) = _$CurrencyEntityCopyWithImpl;
@useResult
$Res call({
 String code, String symbol, String name, String flag
});




}
/// @nodoc
class _$CurrencyEntityCopyWithImpl<$Res>
    implements $CurrencyEntityCopyWith<$Res> {
  _$CurrencyEntityCopyWithImpl(this._self, this._then);

  final CurrencyEntity _self;
  final $Res Function(CurrencyEntity) _then;

/// Create a copy of CurrencyEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? symbol = null,Object? name = null,Object? flag = null,}) {
  return _then(_self.copyWith(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,flag: null == flag ? _self.flag : flag // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [CurrencyEntity].
extension CurrencyEntityPatterns on CurrencyEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CurrencyEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CurrencyEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CurrencyEntity value)  $default,){
final _that = this;
switch (_that) {
case _CurrencyEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CurrencyEntity value)?  $default,){
final _that = this;
switch (_that) {
case _CurrencyEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String code,  String symbol,  String name,  String flag)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CurrencyEntity() when $default != null:
return $default(_that.code,_that.symbol,_that.name,_that.flag);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String code,  String symbol,  String name,  String flag)  $default,) {final _that = this;
switch (_that) {
case _CurrencyEntity():
return $default(_that.code,_that.symbol,_that.name,_that.flag);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String code,  String symbol,  String name,  String flag)?  $default,) {final _that = this;
switch (_that) {
case _CurrencyEntity() when $default != null:
return $default(_that.code,_that.symbol,_that.name,_that.flag);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CurrencyEntity implements CurrencyEntity {
  const _CurrencyEntity({required this.code, required this.symbol, required this.name, required this.flag});
  factory _CurrencyEntity.fromJson(Map<String, dynamic> json) => _$CurrencyEntityFromJson(json);

/// Code ISO 4217 de la devise (ex: EUR, USD)
@override final  String code;
/// Symbole de la devise (ex: €, $)
@override final  String symbol;
/// Nom complet de la devise
@override final  String name;
/// Emoji du drapeau du pays principal
@override final  String flag;

/// Create a copy of CurrencyEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CurrencyEntityCopyWith<_CurrencyEntity> get copyWith => __$CurrencyEntityCopyWithImpl<_CurrencyEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CurrencyEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CurrencyEntity&&(identical(other.code, code) || other.code == code)&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.name, name) || other.name == name)&&(identical(other.flag, flag) || other.flag == flag));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,symbol,name,flag);

@override
String toString() {
  return 'CurrencyEntity(code: $code, symbol: $symbol, name: $name, flag: $flag)';
}


}

/// @nodoc
abstract mixin class _$CurrencyEntityCopyWith<$Res> implements $CurrencyEntityCopyWith<$Res> {
  factory _$CurrencyEntityCopyWith(_CurrencyEntity value, $Res Function(_CurrencyEntity) _then) = __$CurrencyEntityCopyWithImpl;
@override @useResult
$Res call({
 String code, String symbol, String name, String flag
});




}
/// @nodoc
class __$CurrencyEntityCopyWithImpl<$Res>
    implements _$CurrencyEntityCopyWith<$Res> {
  __$CurrencyEntityCopyWithImpl(this._self, this._then);

  final _CurrencyEntity _self;
  final $Res Function(_CurrencyEntity) _then;

/// Create a copy of CurrencyEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? symbol = null,Object? name = null,Object? flag = null,}) {
  return _then(_CurrencyEntity(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,flag: null == flag ? _self.flag : flag // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on

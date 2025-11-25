// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_locale_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AppLocaleEntity {

/// Code de la langue (ex: 'en', 'fr')
 String get languageCode;/// Nom de la langue dans sa propre langue
 String get nativeName;/// Nom de la langue en anglais
 String get englishName;/// Code pays optionnel (ex: 'US', 'FR')
 String? get countryCode;
/// Create a copy of AppLocaleEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppLocaleEntityCopyWith<AppLocaleEntity> get copyWith => _$AppLocaleEntityCopyWithImpl<AppLocaleEntity>(this as AppLocaleEntity, _$identity);

  /// Serializes this AppLocaleEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppLocaleEntity&&(identical(other.languageCode, languageCode) || other.languageCode == languageCode)&&(identical(other.nativeName, nativeName) || other.nativeName == nativeName)&&(identical(other.englishName, englishName) || other.englishName == englishName)&&(identical(other.countryCode, countryCode) || other.countryCode == countryCode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,languageCode,nativeName,englishName,countryCode);

@override
String toString() {
  return 'AppLocaleEntity(languageCode: $languageCode, nativeName: $nativeName, englishName: $englishName, countryCode: $countryCode)';
}


}

/// @nodoc
abstract mixin class $AppLocaleEntityCopyWith<$Res>  {
  factory $AppLocaleEntityCopyWith(AppLocaleEntity value, $Res Function(AppLocaleEntity) _then) = _$AppLocaleEntityCopyWithImpl;
@useResult
$Res call({
 String languageCode, String nativeName, String englishName, String? countryCode
});




}
/// @nodoc
class _$AppLocaleEntityCopyWithImpl<$Res>
    implements $AppLocaleEntityCopyWith<$Res> {
  _$AppLocaleEntityCopyWithImpl(this._self, this._then);

  final AppLocaleEntity _self;
  final $Res Function(AppLocaleEntity) _then;

/// Create a copy of AppLocaleEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? languageCode = null,Object? nativeName = null,Object? englishName = null,Object? countryCode = freezed,}) {
  return _then(_self.copyWith(
languageCode: null == languageCode ? _self.languageCode : languageCode // ignore: cast_nullable_to_non_nullable
as String,nativeName: null == nativeName ? _self.nativeName : nativeName // ignore: cast_nullable_to_non_nullable
as String,englishName: null == englishName ? _self.englishName : englishName // ignore: cast_nullable_to_non_nullable
as String,countryCode: freezed == countryCode ? _self.countryCode : countryCode // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [AppLocaleEntity].
extension AppLocaleEntityPatterns on AppLocaleEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AppLocaleEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AppLocaleEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AppLocaleEntity value)  $default,){
final _that = this;
switch (_that) {
case _AppLocaleEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AppLocaleEntity value)?  $default,){
final _that = this;
switch (_that) {
case _AppLocaleEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String languageCode,  String nativeName,  String englishName,  String? countryCode)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AppLocaleEntity() when $default != null:
return $default(_that.languageCode,_that.nativeName,_that.englishName,_that.countryCode);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String languageCode,  String nativeName,  String englishName,  String? countryCode)  $default,) {final _that = this;
switch (_that) {
case _AppLocaleEntity():
return $default(_that.languageCode,_that.nativeName,_that.englishName,_that.countryCode);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String languageCode,  String nativeName,  String englishName,  String? countryCode)?  $default,) {final _that = this;
switch (_that) {
case _AppLocaleEntity() when $default != null:
return $default(_that.languageCode,_that.nativeName,_that.englishName,_that.countryCode);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AppLocaleEntity implements AppLocaleEntity {
  const _AppLocaleEntity({required this.languageCode, required this.nativeName, required this.englishName, this.countryCode});
  factory _AppLocaleEntity.fromJson(Map<String, dynamic> json) => _$AppLocaleEntityFromJson(json);

/// Code de la langue (ex: 'en', 'fr')
@override final  String languageCode;
/// Nom de la langue dans sa propre langue
@override final  String nativeName;
/// Nom de la langue en anglais
@override final  String englishName;
/// Code pays optionnel (ex: 'US', 'FR')
@override final  String? countryCode;

/// Create a copy of AppLocaleEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppLocaleEntityCopyWith<_AppLocaleEntity> get copyWith => __$AppLocaleEntityCopyWithImpl<_AppLocaleEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AppLocaleEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppLocaleEntity&&(identical(other.languageCode, languageCode) || other.languageCode == languageCode)&&(identical(other.nativeName, nativeName) || other.nativeName == nativeName)&&(identical(other.englishName, englishName) || other.englishName == englishName)&&(identical(other.countryCode, countryCode) || other.countryCode == countryCode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,languageCode,nativeName,englishName,countryCode);

@override
String toString() {
  return 'AppLocaleEntity(languageCode: $languageCode, nativeName: $nativeName, englishName: $englishName, countryCode: $countryCode)';
}


}

/// @nodoc
abstract mixin class _$AppLocaleEntityCopyWith<$Res> implements $AppLocaleEntityCopyWith<$Res> {
  factory _$AppLocaleEntityCopyWith(_AppLocaleEntity value, $Res Function(_AppLocaleEntity) _then) = __$AppLocaleEntityCopyWithImpl;
@override @useResult
$Res call({
 String languageCode, String nativeName, String englishName, String? countryCode
});




}
/// @nodoc
class __$AppLocaleEntityCopyWithImpl<$Res>
    implements _$AppLocaleEntityCopyWith<$Res> {
  __$AppLocaleEntityCopyWithImpl(this._self, this._then);

  final _AppLocaleEntity _self;
  final $Res Function(_AppLocaleEntity) _then;

/// Create a copy of AppLocaleEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? languageCode = null,Object? nativeName = null,Object? englishName = null,Object? countryCode = freezed,}) {
  return _then(_AppLocaleEntity(
languageCode: null == languageCode ? _self.languageCode : languageCode // ignore: cast_nullable_to_non_nullable
as String,nativeName: null == nativeName ? _self.nativeName : nativeName // ignore: cast_nullable_to_non_nullable
as String,englishName: null == englishName ? _self.englishName : englishName // ignore: cast_nullable_to_non_nullable
as String,countryCode: freezed == countryCode ? _self.countryCode : countryCode // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on

// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_settings_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AppSettingsEntity {

/// Mode du thème (ex: 'light', 'dark', 'system')
 String get themeMode;/// Activer les notifications
 bool get notificationsEnabled;/// Format de date (ex: 'dd/MM/yyyy', 'MM/dd/yyyy')
 String get dateFormat;
/// Create a copy of AppSettingsEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppSettingsEntityCopyWith<AppSettingsEntity> get copyWith => _$AppSettingsEntityCopyWithImpl<AppSettingsEntity>(this as AppSettingsEntity, _$identity);

  /// Serializes this AppSettingsEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppSettingsEntity&&(identical(other.themeMode, themeMode) || other.themeMode == themeMode)&&(identical(other.notificationsEnabled, notificationsEnabled) || other.notificationsEnabled == notificationsEnabled)&&(identical(other.dateFormat, dateFormat) || other.dateFormat == dateFormat));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,themeMode,notificationsEnabled,dateFormat);

@override
String toString() {
  return 'AppSettingsEntity(themeMode: $themeMode, notificationsEnabled: $notificationsEnabled, dateFormat: $dateFormat)';
}


}

/// @nodoc
abstract mixin class $AppSettingsEntityCopyWith<$Res>  {
  factory $AppSettingsEntityCopyWith(AppSettingsEntity value, $Res Function(AppSettingsEntity) _then) = _$AppSettingsEntityCopyWithImpl;
@useResult
$Res call({
 String themeMode, bool notificationsEnabled, String dateFormat
});




}
/// @nodoc
class _$AppSettingsEntityCopyWithImpl<$Res>
    implements $AppSettingsEntityCopyWith<$Res> {
  _$AppSettingsEntityCopyWithImpl(this._self, this._then);

  final AppSettingsEntity _self;
  final $Res Function(AppSettingsEntity) _then;

/// Create a copy of AppSettingsEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? themeMode = null,Object? notificationsEnabled = null,Object? dateFormat = null,}) {
  return _then(_self.copyWith(
themeMode: null == themeMode ? _self.themeMode : themeMode // ignore: cast_nullable_to_non_nullable
as String,notificationsEnabled: null == notificationsEnabled ? _self.notificationsEnabled : notificationsEnabled // ignore: cast_nullable_to_non_nullable
as bool,dateFormat: null == dateFormat ? _self.dateFormat : dateFormat // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [AppSettingsEntity].
extension AppSettingsEntityPatterns on AppSettingsEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AppSettingsEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AppSettingsEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AppSettingsEntity value)  $default,){
final _that = this;
switch (_that) {
case _AppSettingsEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AppSettingsEntity value)?  $default,){
final _that = this;
switch (_that) {
case _AppSettingsEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String themeMode,  bool notificationsEnabled,  String dateFormat)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AppSettingsEntity() when $default != null:
return $default(_that.themeMode,_that.notificationsEnabled,_that.dateFormat);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String themeMode,  bool notificationsEnabled,  String dateFormat)  $default,) {final _that = this;
switch (_that) {
case _AppSettingsEntity():
return $default(_that.themeMode,_that.notificationsEnabled,_that.dateFormat);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String themeMode,  bool notificationsEnabled,  String dateFormat)?  $default,) {final _that = this;
switch (_that) {
case _AppSettingsEntity() when $default != null:
return $default(_that.themeMode,_that.notificationsEnabled,_that.dateFormat);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AppSettingsEntity implements AppSettingsEntity {
  const _AppSettingsEntity({required this.themeMode, this.notificationsEnabled = true, this.dateFormat = 'dd/MM/yyyy'});
  factory _AppSettingsEntity.fromJson(Map<String, dynamic> json) => _$AppSettingsEntityFromJson(json);

/// Mode du thème (ex: 'light', 'dark', 'system')
@override final  String themeMode;
/// Activer les notifications
@override@JsonKey() final  bool notificationsEnabled;
/// Format de date (ex: 'dd/MM/yyyy', 'MM/dd/yyyy')
@override@JsonKey() final  String dateFormat;

/// Create a copy of AppSettingsEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppSettingsEntityCopyWith<_AppSettingsEntity> get copyWith => __$AppSettingsEntityCopyWithImpl<_AppSettingsEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AppSettingsEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppSettingsEntity&&(identical(other.themeMode, themeMode) || other.themeMode == themeMode)&&(identical(other.notificationsEnabled, notificationsEnabled) || other.notificationsEnabled == notificationsEnabled)&&(identical(other.dateFormat, dateFormat) || other.dateFormat == dateFormat));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,themeMode,notificationsEnabled,dateFormat);

@override
String toString() {
  return 'AppSettingsEntity(themeMode: $themeMode, notificationsEnabled: $notificationsEnabled, dateFormat: $dateFormat)';
}


}

/// @nodoc
abstract mixin class _$AppSettingsEntityCopyWith<$Res> implements $AppSettingsEntityCopyWith<$Res> {
  factory _$AppSettingsEntityCopyWith(_AppSettingsEntity value, $Res Function(_AppSettingsEntity) _then) = __$AppSettingsEntityCopyWithImpl;
@override @useResult
$Res call({
 String themeMode, bool notificationsEnabled, String dateFormat
});




}
/// @nodoc
class __$AppSettingsEntityCopyWithImpl<$Res>
    implements _$AppSettingsEntityCopyWith<$Res> {
  __$AppSettingsEntityCopyWithImpl(this._self, this._then);

  final _AppSettingsEntity _self;
  final $Res Function(_AppSettingsEntity) _then;

/// Create a copy of AppSettingsEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? themeMode = null,Object? notificationsEnabled = null,Object? dateFormat = null,}) {
  return _then(_AppSettingsEntity(
themeMode: null == themeMode ? _self.themeMode : themeMode // ignore: cast_nullable_to_non_nullable
as String,notificationsEnabled: null == notificationsEnabled ? _self.notificationsEnabled : notificationsEnabled // ignore: cast_nullable_to_non_nullable
as bool,dateFormat: null == dateFormat ? _self.dateFormat : dateFormat // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on

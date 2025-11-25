// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'theme_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ThemeModel {

 ThemeMode get mode; bool get isDark; bool get isLight; bool get isSystem; String get displayName; String get iconName;
/// Create a copy of ThemeModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ThemeModelCopyWith<ThemeModel> get copyWith => _$ThemeModelCopyWithImpl<ThemeModel>(this as ThemeModel, _$identity);

  /// Serializes this ThemeModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ThemeModel&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.isDark, isDark) || other.isDark == isDark)&&(identical(other.isLight, isLight) || other.isLight == isLight)&&(identical(other.isSystem, isSystem) || other.isSystem == isSystem)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.iconName, iconName) || other.iconName == iconName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,mode,isDark,isLight,isSystem,displayName,iconName);

@override
String toString() {
  return 'ThemeModel(mode: $mode, isDark: $isDark, isLight: $isLight, isSystem: $isSystem, displayName: $displayName, iconName: $iconName)';
}


}

/// @nodoc
abstract mixin class $ThemeModelCopyWith<$Res>  {
  factory $ThemeModelCopyWith(ThemeModel value, $Res Function(ThemeModel) _then) = _$ThemeModelCopyWithImpl;
@useResult
$Res call({
 ThemeMode mode, bool isDark, bool isLight, bool isSystem, String displayName, String iconName
});




}
/// @nodoc
class _$ThemeModelCopyWithImpl<$Res>
    implements $ThemeModelCopyWith<$Res> {
  _$ThemeModelCopyWithImpl(this._self, this._then);

  final ThemeModel _self;
  final $Res Function(ThemeModel) _then;

/// Create a copy of ThemeModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? mode = null,Object? isDark = null,Object? isLight = null,Object? isSystem = null,Object? displayName = null,Object? iconName = null,}) {
  return _then(_self.copyWith(
mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as ThemeMode,isDark: null == isDark ? _self.isDark : isDark // ignore: cast_nullable_to_non_nullable
as bool,isLight: null == isLight ? _self.isLight : isLight // ignore: cast_nullable_to_non_nullable
as bool,isSystem: null == isSystem ? _self.isSystem : isSystem // ignore: cast_nullable_to_non_nullable
as bool,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,iconName: null == iconName ? _self.iconName : iconName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ThemeModel].
extension ThemeModelPatterns on ThemeModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ThemeModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ThemeModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ThemeModel value)  $default,){
final _that = this;
switch (_that) {
case _ThemeModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ThemeModel value)?  $default,){
final _that = this;
switch (_that) {
case _ThemeModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ThemeMode mode,  bool isDark,  bool isLight,  bool isSystem,  String displayName,  String iconName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ThemeModel() when $default != null:
return $default(_that.mode,_that.isDark,_that.isLight,_that.isSystem,_that.displayName,_that.iconName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ThemeMode mode,  bool isDark,  bool isLight,  bool isSystem,  String displayName,  String iconName)  $default,) {final _that = this;
switch (_that) {
case _ThemeModel():
return $default(_that.mode,_that.isDark,_that.isLight,_that.isSystem,_that.displayName,_that.iconName);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ThemeMode mode,  bool isDark,  bool isLight,  bool isSystem,  String displayName,  String iconName)?  $default,) {final _that = this;
switch (_that) {
case _ThemeModel() when $default != null:
return $default(_that.mode,_that.isDark,_that.isLight,_that.isSystem,_that.displayName,_that.iconName);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ThemeModel implements ThemeModel {
  const _ThemeModel({required this.mode, required this.isDark, required this.isLight, required this.isSystem, required this.displayName, required this.iconName});
  factory _ThemeModel.fromJson(Map<String, dynamic> json) => _$ThemeModelFromJson(json);

@override final  ThemeMode mode;
@override final  bool isDark;
@override final  bool isLight;
@override final  bool isSystem;
@override final  String displayName;
@override final  String iconName;

/// Create a copy of ThemeModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ThemeModelCopyWith<_ThemeModel> get copyWith => __$ThemeModelCopyWithImpl<_ThemeModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ThemeModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ThemeModel&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.isDark, isDark) || other.isDark == isDark)&&(identical(other.isLight, isLight) || other.isLight == isLight)&&(identical(other.isSystem, isSystem) || other.isSystem == isSystem)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.iconName, iconName) || other.iconName == iconName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,mode,isDark,isLight,isSystem,displayName,iconName);

@override
String toString() {
  return 'ThemeModel(mode: $mode, isDark: $isDark, isLight: $isLight, isSystem: $isSystem, displayName: $displayName, iconName: $iconName)';
}


}

/// @nodoc
abstract mixin class _$ThemeModelCopyWith<$Res> implements $ThemeModelCopyWith<$Res> {
  factory _$ThemeModelCopyWith(_ThemeModel value, $Res Function(_ThemeModel) _then) = __$ThemeModelCopyWithImpl;
@override @useResult
$Res call({
 ThemeMode mode, bool isDark, bool isLight, bool isSystem, String displayName, String iconName
});




}
/// @nodoc
class __$ThemeModelCopyWithImpl<$Res>
    implements _$ThemeModelCopyWith<$Res> {
  __$ThemeModelCopyWithImpl(this._self, this._then);

  final _ThemeModel _self;
  final $Res Function(_ThemeModel) _then;

/// Create a copy of ThemeModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? mode = null,Object? isDark = null,Object? isLight = null,Object? isSystem = null,Object? displayName = null,Object? iconName = null,}) {
  return _then(_ThemeModel(
mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as ThemeMode,isDark: null == isDark ? _self.isDark : isDark // ignore: cast_nullable_to_non_nullable
as bool,isLight: null == isLight ? _self.isLight : isLight // ignore: cast_nullable_to_non_nullable
as bool,isSystem: null == isSystem ? _self.isSystem : isSystem // ignore: cast_nullable_to_non_nullable
as bool,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,iconName: null == iconName ? _self.iconName : iconName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on

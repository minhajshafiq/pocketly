// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_notification_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AppNotificationEntity {

 String get id; String get userId; String get title; String get message; AppNotificationType get type; DateTime get createdAt; bool get isRead; String? get payload; String? get relatedEntityId;
/// Create a copy of AppNotificationEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppNotificationEntityCopyWith<AppNotificationEntity> get copyWith => _$AppNotificationEntityCopyWithImpl<AppNotificationEntity>(this as AppNotificationEntity, _$identity);

  /// Serializes this AppNotificationEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppNotificationEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.title, title) || other.title == title)&&(identical(other.message, message) || other.message == message)&&(identical(other.type, type) || other.type == type)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.isRead, isRead) || other.isRead == isRead)&&(identical(other.payload, payload) || other.payload == payload)&&(identical(other.relatedEntityId, relatedEntityId) || other.relatedEntityId == relatedEntityId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,title,message,type,createdAt,isRead,payload,relatedEntityId);

@override
String toString() {
  return 'AppNotificationEntity(id: $id, userId: $userId, title: $title, message: $message, type: $type, createdAt: $createdAt, isRead: $isRead, payload: $payload, relatedEntityId: $relatedEntityId)';
}


}

/// @nodoc
abstract mixin class $AppNotificationEntityCopyWith<$Res>  {
  factory $AppNotificationEntityCopyWith(AppNotificationEntity value, $Res Function(AppNotificationEntity) _then) = _$AppNotificationEntityCopyWithImpl;
@useResult
$Res call({
 String id, String userId, String title, String message, AppNotificationType type, DateTime createdAt, bool isRead, String? payload, String? relatedEntityId
});




}
/// @nodoc
class _$AppNotificationEntityCopyWithImpl<$Res>
    implements $AppNotificationEntityCopyWith<$Res> {
  _$AppNotificationEntityCopyWithImpl(this._self, this._then);

  final AppNotificationEntity _self;
  final $Res Function(AppNotificationEntity) _then;

/// Create a copy of AppNotificationEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? title = null,Object? message = null,Object? type = null,Object? createdAt = null,Object? isRead = null,Object? payload = freezed,Object? relatedEntityId = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as AppNotificationType,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,isRead: null == isRead ? _self.isRead : isRead // ignore: cast_nullable_to_non_nullable
as bool,payload: freezed == payload ? _self.payload : payload // ignore: cast_nullable_to_non_nullable
as String?,relatedEntityId: freezed == relatedEntityId ? _self.relatedEntityId : relatedEntityId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [AppNotificationEntity].
extension AppNotificationEntityPatterns on AppNotificationEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AppNotificationEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AppNotificationEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AppNotificationEntity value)  $default,){
final _that = this;
switch (_that) {
case _AppNotificationEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AppNotificationEntity value)?  $default,){
final _that = this;
switch (_that) {
case _AppNotificationEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String userId,  String title,  String message,  AppNotificationType type,  DateTime createdAt,  bool isRead,  String? payload,  String? relatedEntityId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AppNotificationEntity() when $default != null:
return $default(_that.id,_that.userId,_that.title,_that.message,_that.type,_that.createdAt,_that.isRead,_that.payload,_that.relatedEntityId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String userId,  String title,  String message,  AppNotificationType type,  DateTime createdAt,  bool isRead,  String? payload,  String? relatedEntityId)  $default,) {final _that = this;
switch (_that) {
case _AppNotificationEntity():
return $default(_that.id,_that.userId,_that.title,_that.message,_that.type,_that.createdAt,_that.isRead,_that.payload,_that.relatedEntityId);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String userId,  String title,  String message,  AppNotificationType type,  DateTime createdAt,  bool isRead,  String? payload,  String? relatedEntityId)?  $default,) {final _that = this;
switch (_that) {
case _AppNotificationEntity() when $default != null:
return $default(_that.id,_that.userId,_that.title,_that.message,_that.type,_that.createdAt,_that.isRead,_that.payload,_that.relatedEntityId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AppNotificationEntity implements AppNotificationEntity {
  const _AppNotificationEntity({required this.id, required this.userId, required this.title, required this.message, required this.type, required this.createdAt, this.isRead = false, this.payload, this.relatedEntityId});
  factory _AppNotificationEntity.fromJson(Map<String, dynamic> json) => _$AppNotificationEntityFromJson(json);

@override final  String id;
@override final  String userId;
@override final  String title;
@override final  String message;
@override final  AppNotificationType type;
@override final  DateTime createdAt;
@override@JsonKey() final  bool isRead;
@override final  String? payload;
@override final  String? relatedEntityId;

/// Create a copy of AppNotificationEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppNotificationEntityCopyWith<_AppNotificationEntity> get copyWith => __$AppNotificationEntityCopyWithImpl<_AppNotificationEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AppNotificationEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppNotificationEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.title, title) || other.title == title)&&(identical(other.message, message) || other.message == message)&&(identical(other.type, type) || other.type == type)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.isRead, isRead) || other.isRead == isRead)&&(identical(other.payload, payload) || other.payload == payload)&&(identical(other.relatedEntityId, relatedEntityId) || other.relatedEntityId == relatedEntityId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,title,message,type,createdAt,isRead,payload,relatedEntityId);

@override
String toString() {
  return 'AppNotificationEntity(id: $id, userId: $userId, title: $title, message: $message, type: $type, createdAt: $createdAt, isRead: $isRead, payload: $payload, relatedEntityId: $relatedEntityId)';
}


}

/// @nodoc
abstract mixin class _$AppNotificationEntityCopyWith<$Res> implements $AppNotificationEntityCopyWith<$Res> {
  factory _$AppNotificationEntityCopyWith(_AppNotificationEntity value, $Res Function(_AppNotificationEntity) _then) = __$AppNotificationEntityCopyWithImpl;
@override @useResult
$Res call({
 String id, String userId, String title, String message, AppNotificationType type, DateTime createdAt, bool isRead, String? payload, String? relatedEntityId
});




}
/// @nodoc
class __$AppNotificationEntityCopyWithImpl<$Res>
    implements _$AppNotificationEntityCopyWith<$Res> {
  __$AppNotificationEntityCopyWithImpl(this._self, this._then);

  final _AppNotificationEntity _self;
  final $Res Function(_AppNotificationEntity) _then;

/// Create a copy of AppNotificationEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? title = null,Object? message = null,Object? type = null,Object? createdAt = null,Object? isRead = null,Object? payload = freezed,Object? relatedEntityId = freezed,}) {
  return _then(_AppNotificationEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as AppNotificationType,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,isRead: null == isRead ? _self.isRead : isRead // ignore: cast_nullable_to_non_nullable
as bool,payload: freezed == payload ? _self.payload : payload // ignore: cast_nullable_to_non_nullable
as String?,relatedEntityId: freezed == relatedEntityId ? _self.relatedEntityId : relatedEntityId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on

// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_preferences_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NotificationPreferencesEntity {

 String get userId; bool get budgetExceededEnabled; bool get goalReachedEnabled; bool get monthEndReminderEnabled; bool get weeklySummaryEnabled; bool get monthlyReportEnabled;
/// Create a copy of NotificationPreferencesEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationPreferencesEntityCopyWith<NotificationPreferencesEntity> get copyWith => _$NotificationPreferencesEntityCopyWithImpl<NotificationPreferencesEntity>(this as NotificationPreferencesEntity, _$identity);

  /// Serializes this NotificationPreferencesEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationPreferencesEntity&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.budgetExceededEnabled, budgetExceededEnabled) || other.budgetExceededEnabled == budgetExceededEnabled)&&(identical(other.goalReachedEnabled, goalReachedEnabled) || other.goalReachedEnabled == goalReachedEnabled)&&(identical(other.monthEndReminderEnabled, monthEndReminderEnabled) || other.monthEndReminderEnabled == monthEndReminderEnabled)&&(identical(other.weeklySummaryEnabled, weeklySummaryEnabled) || other.weeklySummaryEnabled == weeklySummaryEnabled)&&(identical(other.monthlyReportEnabled, monthlyReportEnabled) || other.monthlyReportEnabled == monthlyReportEnabled));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,budgetExceededEnabled,goalReachedEnabled,monthEndReminderEnabled,weeklySummaryEnabled,monthlyReportEnabled);

@override
String toString() {
  return 'NotificationPreferencesEntity(userId: $userId, budgetExceededEnabled: $budgetExceededEnabled, goalReachedEnabled: $goalReachedEnabled, monthEndReminderEnabled: $monthEndReminderEnabled, weeklySummaryEnabled: $weeklySummaryEnabled, monthlyReportEnabled: $monthlyReportEnabled)';
}


}

/// @nodoc
abstract mixin class $NotificationPreferencesEntityCopyWith<$Res>  {
  factory $NotificationPreferencesEntityCopyWith(NotificationPreferencesEntity value, $Res Function(NotificationPreferencesEntity) _then) = _$NotificationPreferencesEntityCopyWithImpl;
@useResult
$Res call({
 String userId, bool budgetExceededEnabled, bool goalReachedEnabled, bool monthEndReminderEnabled, bool weeklySummaryEnabled, bool monthlyReportEnabled
});




}
/// @nodoc
class _$NotificationPreferencesEntityCopyWithImpl<$Res>
    implements $NotificationPreferencesEntityCopyWith<$Res> {
  _$NotificationPreferencesEntityCopyWithImpl(this._self, this._then);

  final NotificationPreferencesEntity _self;
  final $Res Function(NotificationPreferencesEntity) _then;

/// Create a copy of NotificationPreferencesEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? budgetExceededEnabled = null,Object? goalReachedEnabled = null,Object? monthEndReminderEnabled = null,Object? weeklySummaryEnabled = null,Object? monthlyReportEnabled = null,}) {
  return _then(_self.copyWith(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,budgetExceededEnabled: null == budgetExceededEnabled ? _self.budgetExceededEnabled : budgetExceededEnabled // ignore: cast_nullable_to_non_nullable
as bool,goalReachedEnabled: null == goalReachedEnabled ? _self.goalReachedEnabled : goalReachedEnabled // ignore: cast_nullable_to_non_nullable
as bool,monthEndReminderEnabled: null == monthEndReminderEnabled ? _self.monthEndReminderEnabled : monthEndReminderEnabled // ignore: cast_nullable_to_non_nullable
as bool,weeklySummaryEnabled: null == weeklySummaryEnabled ? _self.weeklySummaryEnabled : weeklySummaryEnabled // ignore: cast_nullable_to_non_nullable
as bool,monthlyReportEnabled: null == monthlyReportEnabled ? _self.monthlyReportEnabled : monthlyReportEnabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [NotificationPreferencesEntity].
extension NotificationPreferencesEntityPatterns on NotificationPreferencesEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NotificationPreferencesEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NotificationPreferencesEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NotificationPreferencesEntity value)  $default,){
final _that = this;
switch (_that) {
case _NotificationPreferencesEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NotificationPreferencesEntity value)?  $default,){
final _that = this;
switch (_that) {
case _NotificationPreferencesEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String userId,  bool budgetExceededEnabled,  bool goalReachedEnabled,  bool monthEndReminderEnabled,  bool weeklySummaryEnabled,  bool monthlyReportEnabled)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NotificationPreferencesEntity() when $default != null:
return $default(_that.userId,_that.budgetExceededEnabled,_that.goalReachedEnabled,_that.monthEndReminderEnabled,_that.weeklySummaryEnabled,_that.monthlyReportEnabled);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String userId,  bool budgetExceededEnabled,  bool goalReachedEnabled,  bool monthEndReminderEnabled,  bool weeklySummaryEnabled,  bool monthlyReportEnabled)  $default,) {final _that = this;
switch (_that) {
case _NotificationPreferencesEntity():
return $default(_that.userId,_that.budgetExceededEnabled,_that.goalReachedEnabled,_that.monthEndReminderEnabled,_that.weeklySummaryEnabled,_that.monthlyReportEnabled);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String userId,  bool budgetExceededEnabled,  bool goalReachedEnabled,  bool monthEndReminderEnabled,  bool weeklySummaryEnabled,  bool monthlyReportEnabled)?  $default,) {final _that = this;
switch (_that) {
case _NotificationPreferencesEntity() when $default != null:
return $default(_that.userId,_that.budgetExceededEnabled,_that.goalReachedEnabled,_that.monthEndReminderEnabled,_that.weeklySummaryEnabled,_that.monthlyReportEnabled);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NotificationPreferencesEntity implements NotificationPreferencesEntity {
  const _NotificationPreferencesEntity({required this.userId, this.budgetExceededEnabled = true, this.goalReachedEnabled = true, this.monthEndReminderEnabled = true, this.weeklySummaryEnabled = true, this.monthlyReportEnabled = true});
  factory _NotificationPreferencesEntity.fromJson(Map<String, dynamic> json) => _$NotificationPreferencesEntityFromJson(json);

@override final  String userId;
@override@JsonKey() final  bool budgetExceededEnabled;
@override@JsonKey() final  bool goalReachedEnabled;
@override@JsonKey() final  bool monthEndReminderEnabled;
@override@JsonKey() final  bool weeklySummaryEnabled;
@override@JsonKey() final  bool monthlyReportEnabled;

/// Create a copy of NotificationPreferencesEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationPreferencesEntityCopyWith<_NotificationPreferencesEntity> get copyWith => __$NotificationPreferencesEntityCopyWithImpl<_NotificationPreferencesEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NotificationPreferencesEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationPreferencesEntity&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.budgetExceededEnabled, budgetExceededEnabled) || other.budgetExceededEnabled == budgetExceededEnabled)&&(identical(other.goalReachedEnabled, goalReachedEnabled) || other.goalReachedEnabled == goalReachedEnabled)&&(identical(other.monthEndReminderEnabled, monthEndReminderEnabled) || other.monthEndReminderEnabled == monthEndReminderEnabled)&&(identical(other.weeklySummaryEnabled, weeklySummaryEnabled) || other.weeklySummaryEnabled == weeklySummaryEnabled)&&(identical(other.monthlyReportEnabled, monthlyReportEnabled) || other.monthlyReportEnabled == monthlyReportEnabled));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,budgetExceededEnabled,goalReachedEnabled,monthEndReminderEnabled,weeklySummaryEnabled,monthlyReportEnabled);

@override
String toString() {
  return 'NotificationPreferencesEntity(userId: $userId, budgetExceededEnabled: $budgetExceededEnabled, goalReachedEnabled: $goalReachedEnabled, monthEndReminderEnabled: $monthEndReminderEnabled, weeklySummaryEnabled: $weeklySummaryEnabled, monthlyReportEnabled: $monthlyReportEnabled)';
}


}

/// @nodoc
abstract mixin class _$NotificationPreferencesEntityCopyWith<$Res> implements $NotificationPreferencesEntityCopyWith<$Res> {
  factory _$NotificationPreferencesEntityCopyWith(_NotificationPreferencesEntity value, $Res Function(_NotificationPreferencesEntity) _then) = __$NotificationPreferencesEntityCopyWithImpl;
@override @useResult
$Res call({
 String userId, bool budgetExceededEnabled, bool goalReachedEnabled, bool monthEndReminderEnabled, bool weeklySummaryEnabled, bool monthlyReportEnabled
});




}
/// @nodoc
class __$NotificationPreferencesEntityCopyWithImpl<$Res>
    implements _$NotificationPreferencesEntityCopyWith<$Res> {
  __$NotificationPreferencesEntityCopyWithImpl(this._self, this._then);

  final _NotificationPreferencesEntity _self;
  final $Res Function(_NotificationPreferencesEntity) _then;

/// Create a copy of NotificationPreferencesEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? budgetExceededEnabled = null,Object? goalReachedEnabled = null,Object? monthEndReminderEnabled = null,Object? weeklySummaryEnabled = null,Object? monthlyReportEnabled = null,}) {
  return _then(_NotificationPreferencesEntity(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,budgetExceededEnabled: null == budgetExceededEnabled ? _self.budgetExceededEnabled : budgetExceededEnabled // ignore: cast_nullable_to_non_nullable
as bool,goalReachedEnabled: null == goalReachedEnabled ? _self.goalReachedEnabled : goalReachedEnabled // ignore: cast_nullable_to_non_nullable
as bool,monthEndReminderEnabled: null == monthEndReminderEnabled ? _self.monthEndReminderEnabled : monthEndReminderEnabled // ignore: cast_nullable_to_non_nullable
as bool,weeklySummaryEnabled: null == weeklySummaryEnabled ? _self.weeklySummaryEnabled : weeklySummaryEnabled // ignore: cast_nullable_to_non_nullable
as bool,monthlyReportEnabled: null == monthlyReportEnabled ? _self.monthlyReportEnabled : monthlyReportEnabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on

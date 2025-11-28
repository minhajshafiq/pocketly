// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transaction_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TransactionModel {

 String? get id; String get name; double get amount; DateTime get date;@JsonKey(name: 'category_id') String get categoryId; TransactionType get type; RecurrenceType get recurrence;@JsonKey(name: 'image_url') String? get imageUrl; String? get notes;@JsonKey(name: 'user_id') String get userId;@JsonKey(name: 'pocket_id') String? get pocketId;@JsonKey(name: 'recurrence_group_id') int? get recurrenceGroupId;@JsonKey(name: 'recurrence_start_date') DateTime? get recurrenceStartDate;@JsonKey(name: 'recurrence_end_date') DateTime? get recurrenceEndDate;@JsonKey(name: 'recurrence_day_of_month') int? get recurrenceDayOfMonth;@JsonKey(name: 'is_recurrence_active') bool get isRecurrenceActive;@JsonKey(name: 'created_at') DateTime? get createdAt;@JsonKey(name: 'updated_at') DateTime? get updatedAt;
/// Create a copy of TransactionModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TransactionModelCopyWith<TransactionModel> get copyWith => _$TransactionModelCopyWithImpl<TransactionModel>(this as TransactionModel, _$identity);

  /// Serializes this TransactionModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TransactionModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.date, date) || other.date == date)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.type, type) || other.type == type)&&(identical(other.recurrence, recurrence) || other.recurrence == recurrence)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.pocketId, pocketId) || other.pocketId == pocketId)&&(identical(other.recurrenceGroupId, recurrenceGroupId) || other.recurrenceGroupId == recurrenceGroupId)&&(identical(other.recurrenceStartDate, recurrenceStartDate) || other.recurrenceStartDate == recurrenceStartDate)&&(identical(other.recurrenceEndDate, recurrenceEndDate) || other.recurrenceEndDate == recurrenceEndDate)&&(identical(other.recurrenceDayOfMonth, recurrenceDayOfMonth) || other.recurrenceDayOfMonth == recurrenceDayOfMonth)&&(identical(other.isRecurrenceActive, isRecurrenceActive) || other.isRecurrenceActive == isRecurrenceActive)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,amount,date,categoryId,type,recurrence,imageUrl,notes,userId,pocketId,recurrenceGroupId,recurrenceStartDate,recurrenceEndDate,recurrenceDayOfMonth,isRecurrenceActive,createdAt,updatedAt);

@override
String toString() {
  return 'TransactionModel(id: $id, name: $name, amount: $amount, date: $date, categoryId: $categoryId, type: $type, recurrence: $recurrence, imageUrl: $imageUrl, notes: $notes, userId: $userId, pocketId: $pocketId, recurrenceGroupId: $recurrenceGroupId, recurrenceStartDate: $recurrenceStartDate, recurrenceEndDate: $recurrenceEndDate, recurrenceDayOfMonth: $recurrenceDayOfMonth, isRecurrenceActive: $isRecurrenceActive, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $TransactionModelCopyWith<$Res>  {
  factory $TransactionModelCopyWith(TransactionModel value, $Res Function(TransactionModel) _then) = _$TransactionModelCopyWithImpl;
@useResult
$Res call({
 String? id, String name, double amount, DateTime date,@JsonKey(name: 'category_id') String categoryId, TransactionType type, RecurrenceType recurrence,@JsonKey(name: 'image_url') String? imageUrl, String? notes,@JsonKey(name: 'user_id') String userId,@JsonKey(name: 'pocket_id') String? pocketId,@JsonKey(name: 'recurrence_group_id') int? recurrenceGroupId,@JsonKey(name: 'recurrence_start_date') DateTime? recurrenceStartDate,@JsonKey(name: 'recurrence_end_date') DateTime? recurrenceEndDate,@JsonKey(name: 'recurrence_day_of_month') int? recurrenceDayOfMonth,@JsonKey(name: 'is_recurrence_active') bool isRecurrenceActive,@JsonKey(name: 'created_at') DateTime? createdAt,@JsonKey(name: 'updated_at') DateTime? updatedAt
});




}
/// @nodoc
class _$TransactionModelCopyWithImpl<$Res>
    implements $TransactionModelCopyWith<$Res> {
  _$TransactionModelCopyWithImpl(this._self, this._then);

  final TransactionModel _self;
  final $Res Function(TransactionModel) _then;

/// Create a copy of TransactionModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? name = null,Object? amount = null,Object? date = null,Object? categoryId = null,Object? type = null,Object? recurrence = null,Object? imageUrl = freezed,Object? notes = freezed,Object? userId = null,Object? pocketId = freezed,Object? recurrenceGroupId = freezed,Object? recurrenceStartDate = freezed,Object? recurrenceEndDate = freezed,Object? recurrenceDayOfMonth = freezed,Object? isRecurrenceActive = null,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as TransactionType,recurrence: null == recurrence ? _self.recurrence : recurrence // ignore: cast_nullable_to_non_nullable
as RecurrenceType,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,pocketId: freezed == pocketId ? _self.pocketId : pocketId // ignore: cast_nullable_to_non_nullable
as String?,recurrenceGroupId: freezed == recurrenceGroupId ? _self.recurrenceGroupId : recurrenceGroupId // ignore: cast_nullable_to_non_nullable
as int?,recurrenceStartDate: freezed == recurrenceStartDate ? _self.recurrenceStartDate : recurrenceStartDate // ignore: cast_nullable_to_non_nullable
as DateTime?,recurrenceEndDate: freezed == recurrenceEndDate ? _self.recurrenceEndDate : recurrenceEndDate // ignore: cast_nullable_to_non_nullable
as DateTime?,recurrenceDayOfMonth: freezed == recurrenceDayOfMonth ? _self.recurrenceDayOfMonth : recurrenceDayOfMonth // ignore: cast_nullable_to_non_nullable
as int?,isRecurrenceActive: null == isRecurrenceActive ? _self.isRecurrenceActive : isRecurrenceActive // ignore: cast_nullable_to_non_nullable
as bool,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [TransactionModel].
extension TransactionModelPatterns on TransactionModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TransactionModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TransactionModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TransactionModel value)  $default,){
final _that = this;
switch (_that) {
case _TransactionModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TransactionModel value)?  $default,){
final _that = this;
switch (_that) {
case _TransactionModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  String name,  double amount,  DateTime date, @JsonKey(name: 'category_id')  String categoryId,  TransactionType type,  RecurrenceType recurrence, @JsonKey(name: 'image_url')  String? imageUrl,  String? notes, @JsonKey(name: 'user_id')  String userId, @JsonKey(name: 'pocket_id')  String? pocketId, @JsonKey(name: 'recurrence_group_id')  int? recurrenceGroupId, @JsonKey(name: 'recurrence_start_date')  DateTime? recurrenceStartDate, @JsonKey(name: 'recurrence_end_date')  DateTime? recurrenceEndDate, @JsonKey(name: 'recurrence_day_of_month')  int? recurrenceDayOfMonth, @JsonKey(name: 'is_recurrence_active')  bool isRecurrenceActive, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'updated_at')  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TransactionModel() when $default != null:
return $default(_that.id,_that.name,_that.amount,_that.date,_that.categoryId,_that.type,_that.recurrence,_that.imageUrl,_that.notes,_that.userId,_that.pocketId,_that.recurrenceGroupId,_that.recurrenceStartDate,_that.recurrenceEndDate,_that.recurrenceDayOfMonth,_that.isRecurrenceActive,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  String name,  double amount,  DateTime date, @JsonKey(name: 'category_id')  String categoryId,  TransactionType type,  RecurrenceType recurrence, @JsonKey(name: 'image_url')  String? imageUrl,  String? notes, @JsonKey(name: 'user_id')  String userId, @JsonKey(name: 'pocket_id')  String? pocketId, @JsonKey(name: 'recurrence_group_id')  int? recurrenceGroupId, @JsonKey(name: 'recurrence_start_date')  DateTime? recurrenceStartDate, @JsonKey(name: 'recurrence_end_date')  DateTime? recurrenceEndDate, @JsonKey(name: 'recurrence_day_of_month')  int? recurrenceDayOfMonth, @JsonKey(name: 'is_recurrence_active')  bool isRecurrenceActive, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'updated_at')  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _TransactionModel():
return $default(_that.id,_that.name,_that.amount,_that.date,_that.categoryId,_that.type,_that.recurrence,_that.imageUrl,_that.notes,_that.userId,_that.pocketId,_that.recurrenceGroupId,_that.recurrenceStartDate,_that.recurrenceEndDate,_that.recurrenceDayOfMonth,_that.isRecurrenceActive,_that.createdAt,_that.updatedAt);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  String name,  double amount,  DateTime date, @JsonKey(name: 'category_id')  String categoryId,  TransactionType type,  RecurrenceType recurrence, @JsonKey(name: 'image_url')  String? imageUrl,  String? notes, @JsonKey(name: 'user_id')  String userId, @JsonKey(name: 'pocket_id')  String? pocketId, @JsonKey(name: 'recurrence_group_id')  int? recurrenceGroupId, @JsonKey(name: 'recurrence_start_date')  DateTime? recurrenceStartDate, @JsonKey(name: 'recurrence_end_date')  DateTime? recurrenceEndDate, @JsonKey(name: 'recurrence_day_of_month')  int? recurrenceDayOfMonth, @JsonKey(name: 'is_recurrence_active')  bool isRecurrenceActive, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'updated_at')  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _TransactionModel() when $default != null:
return $default(_that.id,_that.name,_that.amount,_that.date,_that.categoryId,_that.type,_that.recurrence,_that.imageUrl,_that.notes,_that.userId,_that.pocketId,_that.recurrenceGroupId,_that.recurrenceStartDate,_that.recurrenceEndDate,_that.recurrenceDayOfMonth,_that.isRecurrenceActive,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TransactionModel extends TransactionModel {
  const _TransactionModel({this.id, required this.name, required this.amount, required this.date, @JsonKey(name: 'category_id') required this.categoryId, required this.type, this.recurrence = RecurrenceType.none, @JsonKey(name: 'image_url') this.imageUrl, this.notes, @JsonKey(name: 'user_id') required this.userId, @JsonKey(name: 'pocket_id') this.pocketId, @JsonKey(name: 'recurrence_group_id') this.recurrenceGroupId, @JsonKey(name: 'recurrence_start_date') this.recurrenceStartDate, @JsonKey(name: 'recurrence_end_date') this.recurrenceEndDate, @JsonKey(name: 'recurrence_day_of_month') this.recurrenceDayOfMonth, @JsonKey(name: 'is_recurrence_active') this.isRecurrenceActive = false, @JsonKey(name: 'created_at') this.createdAt, @JsonKey(name: 'updated_at') this.updatedAt}): super._();
  factory _TransactionModel.fromJson(Map<String, dynamic> json) => _$TransactionModelFromJson(json);

@override final  String? id;
@override final  String name;
@override final  double amount;
@override final  DateTime date;
@override@JsonKey(name: 'category_id') final  String categoryId;
@override final  TransactionType type;
@override@JsonKey() final  RecurrenceType recurrence;
@override@JsonKey(name: 'image_url') final  String? imageUrl;
@override final  String? notes;
@override@JsonKey(name: 'user_id') final  String userId;
@override@JsonKey(name: 'pocket_id') final  String? pocketId;
@override@JsonKey(name: 'recurrence_group_id') final  int? recurrenceGroupId;
@override@JsonKey(name: 'recurrence_start_date') final  DateTime? recurrenceStartDate;
@override@JsonKey(name: 'recurrence_end_date') final  DateTime? recurrenceEndDate;
@override@JsonKey(name: 'recurrence_day_of_month') final  int? recurrenceDayOfMonth;
@override@JsonKey(name: 'is_recurrence_active') final  bool isRecurrenceActive;
@override@JsonKey(name: 'created_at') final  DateTime? createdAt;
@override@JsonKey(name: 'updated_at') final  DateTime? updatedAt;

/// Create a copy of TransactionModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TransactionModelCopyWith<_TransactionModel> get copyWith => __$TransactionModelCopyWithImpl<_TransactionModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TransactionModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TransactionModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.date, date) || other.date == date)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.type, type) || other.type == type)&&(identical(other.recurrence, recurrence) || other.recurrence == recurrence)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.pocketId, pocketId) || other.pocketId == pocketId)&&(identical(other.recurrenceGroupId, recurrenceGroupId) || other.recurrenceGroupId == recurrenceGroupId)&&(identical(other.recurrenceStartDate, recurrenceStartDate) || other.recurrenceStartDate == recurrenceStartDate)&&(identical(other.recurrenceEndDate, recurrenceEndDate) || other.recurrenceEndDate == recurrenceEndDate)&&(identical(other.recurrenceDayOfMonth, recurrenceDayOfMonth) || other.recurrenceDayOfMonth == recurrenceDayOfMonth)&&(identical(other.isRecurrenceActive, isRecurrenceActive) || other.isRecurrenceActive == isRecurrenceActive)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,amount,date,categoryId,type,recurrence,imageUrl,notes,userId,pocketId,recurrenceGroupId,recurrenceStartDate,recurrenceEndDate,recurrenceDayOfMonth,isRecurrenceActive,createdAt,updatedAt);

@override
String toString() {
  return 'TransactionModel(id: $id, name: $name, amount: $amount, date: $date, categoryId: $categoryId, type: $type, recurrence: $recurrence, imageUrl: $imageUrl, notes: $notes, userId: $userId, pocketId: $pocketId, recurrenceGroupId: $recurrenceGroupId, recurrenceStartDate: $recurrenceStartDate, recurrenceEndDate: $recurrenceEndDate, recurrenceDayOfMonth: $recurrenceDayOfMonth, isRecurrenceActive: $isRecurrenceActive, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$TransactionModelCopyWith<$Res> implements $TransactionModelCopyWith<$Res> {
  factory _$TransactionModelCopyWith(_TransactionModel value, $Res Function(_TransactionModel) _then) = __$TransactionModelCopyWithImpl;
@override @useResult
$Res call({
 String? id, String name, double amount, DateTime date,@JsonKey(name: 'category_id') String categoryId, TransactionType type, RecurrenceType recurrence,@JsonKey(name: 'image_url') String? imageUrl, String? notes,@JsonKey(name: 'user_id') String userId,@JsonKey(name: 'pocket_id') String? pocketId,@JsonKey(name: 'recurrence_group_id') int? recurrenceGroupId,@JsonKey(name: 'recurrence_start_date') DateTime? recurrenceStartDate,@JsonKey(name: 'recurrence_end_date') DateTime? recurrenceEndDate,@JsonKey(name: 'recurrence_day_of_month') int? recurrenceDayOfMonth,@JsonKey(name: 'is_recurrence_active') bool isRecurrenceActive,@JsonKey(name: 'created_at') DateTime? createdAt,@JsonKey(name: 'updated_at') DateTime? updatedAt
});




}
/// @nodoc
class __$TransactionModelCopyWithImpl<$Res>
    implements _$TransactionModelCopyWith<$Res> {
  __$TransactionModelCopyWithImpl(this._self, this._then);

  final _TransactionModel _self;
  final $Res Function(_TransactionModel) _then;

/// Create a copy of TransactionModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? name = null,Object? amount = null,Object? date = null,Object? categoryId = null,Object? type = null,Object? recurrence = null,Object? imageUrl = freezed,Object? notes = freezed,Object? userId = null,Object? pocketId = freezed,Object? recurrenceGroupId = freezed,Object? recurrenceStartDate = freezed,Object? recurrenceEndDate = freezed,Object? recurrenceDayOfMonth = freezed,Object? isRecurrenceActive = null,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_TransactionModel(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as TransactionType,recurrence: null == recurrence ? _self.recurrence : recurrence // ignore: cast_nullable_to_non_nullable
as RecurrenceType,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,pocketId: freezed == pocketId ? _self.pocketId : pocketId // ignore: cast_nullable_to_non_nullable
as String?,recurrenceGroupId: freezed == recurrenceGroupId ? _self.recurrenceGroupId : recurrenceGroupId // ignore: cast_nullable_to_non_nullable
as int?,recurrenceStartDate: freezed == recurrenceStartDate ? _self.recurrenceStartDate : recurrenceStartDate // ignore: cast_nullable_to_non_nullable
as DateTime?,recurrenceEndDate: freezed == recurrenceEndDate ? _self.recurrenceEndDate : recurrenceEndDate // ignore: cast_nullable_to_non_nullable
as DateTime?,recurrenceDayOfMonth: freezed == recurrenceDayOfMonth ? _self.recurrenceDayOfMonth : recurrenceDayOfMonth // ignore: cast_nullable_to_non_nullable
as int?,isRecurrenceActive: null == isRecurrenceActive ? _self.isRecurrenceActive : isRecurrenceActive // ignore: cast_nullable_to_non_nullable
as bool,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on

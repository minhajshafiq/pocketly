// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'daily_expense_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DailyExpenseEntity {

 DateTime get date; int get dayOfWeek; double get income; double get expense; int get transactionCount;
/// Create a copy of DailyExpenseEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DailyExpenseEntityCopyWith<DailyExpenseEntity> get copyWith => _$DailyExpenseEntityCopyWithImpl<DailyExpenseEntity>(this as DailyExpenseEntity, _$identity);

  /// Serializes this DailyExpenseEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DailyExpenseEntity&&(identical(other.date, date) || other.date == date)&&(identical(other.dayOfWeek, dayOfWeek) || other.dayOfWeek == dayOfWeek)&&(identical(other.income, income) || other.income == income)&&(identical(other.expense, expense) || other.expense == expense)&&(identical(other.transactionCount, transactionCount) || other.transactionCount == transactionCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,date,dayOfWeek,income,expense,transactionCount);

@override
String toString() {
  return 'DailyExpenseEntity(date: $date, dayOfWeek: $dayOfWeek, income: $income, expense: $expense, transactionCount: $transactionCount)';
}


}

/// @nodoc
abstract mixin class $DailyExpenseEntityCopyWith<$Res>  {
  factory $DailyExpenseEntityCopyWith(DailyExpenseEntity value, $Res Function(DailyExpenseEntity) _then) = _$DailyExpenseEntityCopyWithImpl;
@useResult
$Res call({
 DateTime date, int dayOfWeek, double income, double expense, int transactionCount
});




}
/// @nodoc
class _$DailyExpenseEntityCopyWithImpl<$Res>
    implements $DailyExpenseEntityCopyWith<$Res> {
  _$DailyExpenseEntityCopyWithImpl(this._self, this._then);

  final DailyExpenseEntity _self;
  final $Res Function(DailyExpenseEntity) _then;

/// Create a copy of DailyExpenseEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? dayOfWeek = null,Object? income = null,Object? expense = null,Object? transactionCount = null,}) {
  return _then(_self.copyWith(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,dayOfWeek: null == dayOfWeek ? _self.dayOfWeek : dayOfWeek // ignore: cast_nullable_to_non_nullable
as int,income: null == income ? _self.income : income // ignore: cast_nullable_to_non_nullable
as double,expense: null == expense ? _self.expense : expense // ignore: cast_nullable_to_non_nullable
as double,transactionCount: null == transactionCount ? _self.transactionCount : transactionCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [DailyExpenseEntity].
extension DailyExpenseEntityPatterns on DailyExpenseEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DailyExpenseEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DailyExpenseEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DailyExpenseEntity value)  $default,){
final _that = this;
switch (_that) {
case _DailyExpenseEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DailyExpenseEntity value)?  $default,){
final _that = this;
switch (_that) {
case _DailyExpenseEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime date,  int dayOfWeek,  double income,  double expense,  int transactionCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DailyExpenseEntity() when $default != null:
return $default(_that.date,_that.dayOfWeek,_that.income,_that.expense,_that.transactionCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime date,  int dayOfWeek,  double income,  double expense,  int transactionCount)  $default,) {final _that = this;
switch (_that) {
case _DailyExpenseEntity():
return $default(_that.date,_that.dayOfWeek,_that.income,_that.expense,_that.transactionCount);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime date,  int dayOfWeek,  double income,  double expense,  int transactionCount)?  $default,) {final _that = this;
switch (_that) {
case _DailyExpenseEntity() when $default != null:
return $default(_that.date,_that.dayOfWeek,_that.income,_that.expense,_that.transactionCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DailyExpenseEntity implements DailyExpenseEntity {
  const _DailyExpenseEntity({required this.date, required this.dayOfWeek, required this.income, required this.expense, required this.transactionCount});
  factory _DailyExpenseEntity.fromJson(Map<String, dynamic> json) => _$DailyExpenseEntityFromJson(json);

@override final  DateTime date;
@override final  int dayOfWeek;
@override final  double income;
@override final  double expense;
@override final  int transactionCount;

/// Create a copy of DailyExpenseEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DailyExpenseEntityCopyWith<_DailyExpenseEntity> get copyWith => __$DailyExpenseEntityCopyWithImpl<_DailyExpenseEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DailyExpenseEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DailyExpenseEntity&&(identical(other.date, date) || other.date == date)&&(identical(other.dayOfWeek, dayOfWeek) || other.dayOfWeek == dayOfWeek)&&(identical(other.income, income) || other.income == income)&&(identical(other.expense, expense) || other.expense == expense)&&(identical(other.transactionCount, transactionCount) || other.transactionCount == transactionCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,date,dayOfWeek,income,expense,transactionCount);

@override
String toString() {
  return 'DailyExpenseEntity(date: $date, dayOfWeek: $dayOfWeek, income: $income, expense: $expense, transactionCount: $transactionCount)';
}


}

/// @nodoc
abstract mixin class _$DailyExpenseEntityCopyWith<$Res> implements $DailyExpenseEntityCopyWith<$Res> {
  factory _$DailyExpenseEntityCopyWith(_DailyExpenseEntity value, $Res Function(_DailyExpenseEntity) _then) = __$DailyExpenseEntityCopyWithImpl;
@override @useResult
$Res call({
 DateTime date, int dayOfWeek, double income, double expense, int transactionCount
});




}
/// @nodoc
class __$DailyExpenseEntityCopyWithImpl<$Res>
    implements _$DailyExpenseEntityCopyWith<$Res> {
  __$DailyExpenseEntityCopyWithImpl(this._self, this._then);

  final _DailyExpenseEntity _self;
  final $Res Function(_DailyExpenseEntity) _then;

/// Create a copy of DailyExpenseEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? dayOfWeek = null,Object? income = null,Object? expense = null,Object? transactionCount = null,}) {
  return _then(_DailyExpenseEntity(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,dayOfWeek: null == dayOfWeek ? _self.dayOfWeek : dayOfWeek // ignore: cast_nullable_to_non_nullable
as int,income: null == income ? _self.income : income // ignore: cast_nullable_to_non_nullable
as double,expense: null == expense ? _self.expense : expense // ignore: cast_nullable_to_non_nullable
as double,transactionCount: null == transactionCount ? _self.transactionCount : transactionCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on

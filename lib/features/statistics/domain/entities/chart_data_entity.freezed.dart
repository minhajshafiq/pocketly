// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chart_data_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ChartDataEntity {

 List<DailyExpenseEntity> get dailyExpenses; TimePeriod get period; DateTime get startDate; DateTime get endDate; double get maxExpense; double get totalExpense; double get totalIncome;
/// Create a copy of ChartDataEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChartDataEntityCopyWith<ChartDataEntity> get copyWith => _$ChartDataEntityCopyWithImpl<ChartDataEntity>(this as ChartDataEntity, _$identity);

  /// Serializes this ChartDataEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChartDataEntity&&const DeepCollectionEquality().equals(other.dailyExpenses, dailyExpenses)&&(identical(other.period, period) || other.period == period)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.maxExpense, maxExpense) || other.maxExpense == maxExpense)&&(identical(other.totalExpense, totalExpense) || other.totalExpense == totalExpense)&&(identical(other.totalIncome, totalIncome) || other.totalIncome == totalIncome));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(dailyExpenses),period,startDate,endDate,maxExpense,totalExpense,totalIncome);

@override
String toString() {
  return 'ChartDataEntity(dailyExpenses: $dailyExpenses, period: $period, startDate: $startDate, endDate: $endDate, maxExpense: $maxExpense, totalExpense: $totalExpense, totalIncome: $totalIncome)';
}


}

/// @nodoc
abstract mixin class $ChartDataEntityCopyWith<$Res>  {
  factory $ChartDataEntityCopyWith(ChartDataEntity value, $Res Function(ChartDataEntity) _then) = _$ChartDataEntityCopyWithImpl;
@useResult
$Res call({
 List<DailyExpenseEntity> dailyExpenses, TimePeriod period, DateTime startDate, DateTime endDate, double maxExpense, double totalExpense, double totalIncome
});




}
/// @nodoc
class _$ChartDataEntityCopyWithImpl<$Res>
    implements $ChartDataEntityCopyWith<$Res> {
  _$ChartDataEntityCopyWithImpl(this._self, this._then);

  final ChartDataEntity _self;
  final $Res Function(ChartDataEntity) _then;

/// Create a copy of ChartDataEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? dailyExpenses = null,Object? period = null,Object? startDate = null,Object? endDate = null,Object? maxExpense = null,Object? totalExpense = null,Object? totalIncome = null,}) {
  return _then(_self.copyWith(
dailyExpenses: null == dailyExpenses ? _self.dailyExpenses : dailyExpenses // ignore: cast_nullable_to_non_nullable
as List<DailyExpenseEntity>,period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as TimePeriod,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,endDate: null == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime,maxExpense: null == maxExpense ? _self.maxExpense : maxExpense // ignore: cast_nullable_to_non_nullable
as double,totalExpense: null == totalExpense ? _self.totalExpense : totalExpense // ignore: cast_nullable_to_non_nullable
as double,totalIncome: null == totalIncome ? _self.totalIncome : totalIncome // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [ChartDataEntity].
extension ChartDataEntityPatterns on ChartDataEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChartDataEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChartDataEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChartDataEntity value)  $default,){
final _that = this;
switch (_that) {
case _ChartDataEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChartDataEntity value)?  $default,){
final _that = this;
switch (_that) {
case _ChartDataEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<DailyExpenseEntity> dailyExpenses,  TimePeriod period,  DateTime startDate,  DateTime endDate,  double maxExpense,  double totalExpense,  double totalIncome)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChartDataEntity() when $default != null:
return $default(_that.dailyExpenses,_that.period,_that.startDate,_that.endDate,_that.maxExpense,_that.totalExpense,_that.totalIncome);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<DailyExpenseEntity> dailyExpenses,  TimePeriod period,  DateTime startDate,  DateTime endDate,  double maxExpense,  double totalExpense,  double totalIncome)  $default,) {final _that = this;
switch (_that) {
case _ChartDataEntity():
return $default(_that.dailyExpenses,_that.period,_that.startDate,_that.endDate,_that.maxExpense,_that.totalExpense,_that.totalIncome);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<DailyExpenseEntity> dailyExpenses,  TimePeriod period,  DateTime startDate,  DateTime endDate,  double maxExpense,  double totalExpense,  double totalIncome)?  $default,) {final _that = this;
switch (_that) {
case _ChartDataEntity() when $default != null:
return $default(_that.dailyExpenses,_that.period,_that.startDate,_that.endDate,_that.maxExpense,_that.totalExpense,_that.totalIncome);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChartDataEntity implements ChartDataEntity {
  const _ChartDataEntity({required final  List<DailyExpenseEntity> dailyExpenses, required this.period, required this.startDate, required this.endDate, required this.maxExpense, required this.totalExpense, required this.totalIncome}): _dailyExpenses = dailyExpenses;
  factory _ChartDataEntity.fromJson(Map<String, dynamic> json) => _$ChartDataEntityFromJson(json);

 final  List<DailyExpenseEntity> _dailyExpenses;
@override List<DailyExpenseEntity> get dailyExpenses {
  if (_dailyExpenses is EqualUnmodifiableListView) return _dailyExpenses;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_dailyExpenses);
}

@override final  TimePeriod period;
@override final  DateTime startDate;
@override final  DateTime endDate;
@override final  double maxExpense;
@override final  double totalExpense;
@override final  double totalIncome;

/// Create a copy of ChartDataEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChartDataEntityCopyWith<_ChartDataEntity> get copyWith => __$ChartDataEntityCopyWithImpl<_ChartDataEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChartDataEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChartDataEntity&&const DeepCollectionEquality().equals(other._dailyExpenses, _dailyExpenses)&&(identical(other.period, period) || other.period == period)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.maxExpense, maxExpense) || other.maxExpense == maxExpense)&&(identical(other.totalExpense, totalExpense) || other.totalExpense == totalExpense)&&(identical(other.totalIncome, totalIncome) || other.totalIncome == totalIncome));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_dailyExpenses),period,startDate,endDate,maxExpense,totalExpense,totalIncome);

@override
String toString() {
  return 'ChartDataEntity(dailyExpenses: $dailyExpenses, period: $period, startDate: $startDate, endDate: $endDate, maxExpense: $maxExpense, totalExpense: $totalExpense, totalIncome: $totalIncome)';
}


}

/// @nodoc
abstract mixin class _$ChartDataEntityCopyWith<$Res> implements $ChartDataEntityCopyWith<$Res> {
  factory _$ChartDataEntityCopyWith(_ChartDataEntity value, $Res Function(_ChartDataEntity) _then) = __$ChartDataEntityCopyWithImpl;
@override @useResult
$Res call({
 List<DailyExpenseEntity> dailyExpenses, TimePeriod period, DateTime startDate, DateTime endDate, double maxExpense, double totalExpense, double totalIncome
});




}
/// @nodoc
class __$ChartDataEntityCopyWithImpl<$Res>
    implements _$ChartDataEntityCopyWith<$Res> {
  __$ChartDataEntityCopyWithImpl(this._self, this._then);

  final _ChartDataEntity _self;
  final $Res Function(_ChartDataEntity) _then;

/// Create a copy of ChartDataEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? dailyExpenses = null,Object? period = null,Object? startDate = null,Object? endDate = null,Object? maxExpense = null,Object? totalExpense = null,Object? totalIncome = null,}) {
  return _then(_ChartDataEntity(
dailyExpenses: null == dailyExpenses ? _self._dailyExpenses : dailyExpenses // ignore: cast_nullable_to_non_nullable
as List<DailyExpenseEntity>,period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as TimePeriod,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,endDate: null == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime,maxExpense: null == maxExpense ? _self.maxExpense : maxExpense // ignore: cast_nullable_to_non_nullable
as double,totalExpense: null == totalExpense ? _self.totalExpense : totalExpense // ignore: cast_nullable_to_non_nullable
as double,totalIncome: null == totalIncome ? _self.totalIncome : totalIncome // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on

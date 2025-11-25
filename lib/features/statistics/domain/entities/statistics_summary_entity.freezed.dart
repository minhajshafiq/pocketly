// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'statistics_summary_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$StatisticsSummaryEntity {

 double get totalIncome; double get totalExpense; double get balance; int get transactionCount; DateTime get startDate; DateTime get endDate;
/// Create a copy of StatisticsSummaryEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StatisticsSummaryEntityCopyWith<StatisticsSummaryEntity> get copyWith => _$StatisticsSummaryEntityCopyWithImpl<StatisticsSummaryEntity>(this as StatisticsSummaryEntity, _$identity);

  /// Serializes this StatisticsSummaryEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StatisticsSummaryEntity&&(identical(other.totalIncome, totalIncome) || other.totalIncome == totalIncome)&&(identical(other.totalExpense, totalExpense) || other.totalExpense == totalExpense)&&(identical(other.balance, balance) || other.balance == balance)&&(identical(other.transactionCount, transactionCount) || other.transactionCount == transactionCount)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalIncome,totalExpense,balance,transactionCount,startDate,endDate);

@override
String toString() {
  return 'StatisticsSummaryEntity(totalIncome: $totalIncome, totalExpense: $totalExpense, balance: $balance, transactionCount: $transactionCount, startDate: $startDate, endDate: $endDate)';
}


}

/// @nodoc
abstract mixin class $StatisticsSummaryEntityCopyWith<$Res>  {
  factory $StatisticsSummaryEntityCopyWith(StatisticsSummaryEntity value, $Res Function(StatisticsSummaryEntity) _then) = _$StatisticsSummaryEntityCopyWithImpl;
@useResult
$Res call({
 double totalIncome, double totalExpense, double balance, int transactionCount, DateTime startDate, DateTime endDate
});




}
/// @nodoc
class _$StatisticsSummaryEntityCopyWithImpl<$Res>
    implements $StatisticsSummaryEntityCopyWith<$Res> {
  _$StatisticsSummaryEntityCopyWithImpl(this._self, this._then);

  final StatisticsSummaryEntity _self;
  final $Res Function(StatisticsSummaryEntity) _then;

/// Create a copy of StatisticsSummaryEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalIncome = null,Object? totalExpense = null,Object? balance = null,Object? transactionCount = null,Object? startDate = null,Object? endDate = null,}) {
  return _then(_self.copyWith(
totalIncome: null == totalIncome ? _self.totalIncome : totalIncome // ignore: cast_nullable_to_non_nullable
as double,totalExpense: null == totalExpense ? _self.totalExpense : totalExpense // ignore: cast_nullable_to_non_nullable
as double,balance: null == balance ? _self.balance : balance // ignore: cast_nullable_to_non_nullable
as double,transactionCount: null == transactionCount ? _self.transactionCount : transactionCount // ignore: cast_nullable_to_non_nullable
as int,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,endDate: null == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [StatisticsSummaryEntity].
extension StatisticsSummaryEntityPatterns on StatisticsSummaryEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StatisticsSummaryEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StatisticsSummaryEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StatisticsSummaryEntity value)  $default,){
final _that = this;
switch (_that) {
case _StatisticsSummaryEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StatisticsSummaryEntity value)?  $default,){
final _that = this;
switch (_that) {
case _StatisticsSummaryEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double totalIncome,  double totalExpense,  double balance,  int transactionCount,  DateTime startDate,  DateTime endDate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StatisticsSummaryEntity() when $default != null:
return $default(_that.totalIncome,_that.totalExpense,_that.balance,_that.transactionCount,_that.startDate,_that.endDate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double totalIncome,  double totalExpense,  double balance,  int transactionCount,  DateTime startDate,  DateTime endDate)  $default,) {final _that = this;
switch (_that) {
case _StatisticsSummaryEntity():
return $default(_that.totalIncome,_that.totalExpense,_that.balance,_that.transactionCount,_that.startDate,_that.endDate);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double totalIncome,  double totalExpense,  double balance,  int transactionCount,  DateTime startDate,  DateTime endDate)?  $default,) {final _that = this;
switch (_that) {
case _StatisticsSummaryEntity() when $default != null:
return $default(_that.totalIncome,_that.totalExpense,_that.balance,_that.transactionCount,_that.startDate,_that.endDate);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StatisticsSummaryEntity implements StatisticsSummaryEntity {
  const _StatisticsSummaryEntity({required this.totalIncome, required this.totalExpense, required this.balance, required this.transactionCount, required this.startDate, required this.endDate});
  factory _StatisticsSummaryEntity.fromJson(Map<String, dynamic> json) => _$StatisticsSummaryEntityFromJson(json);

@override final  double totalIncome;
@override final  double totalExpense;
@override final  double balance;
@override final  int transactionCount;
@override final  DateTime startDate;
@override final  DateTime endDate;

/// Create a copy of StatisticsSummaryEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StatisticsSummaryEntityCopyWith<_StatisticsSummaryEntity> get copyWith => __$StatisticsSummaryEntityCopyWithImpl<_StatisticsSummaryEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StatisticsSummaryEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StatisticsSummaryEntity&&(identical(other.totalIncome, totalIncome) || other.totalIncome == totalIncome)&&(identical(other.totalExpense, totalExpense) || other.totalExpense == totalExpense)&&(identical(other.balance, balance) || other.balance == balance)&&(identical(other.transactionCount, transactionCount) || other.transactionCount == transactionCount)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalIncome,totalExpense,balance,transactionCount,startDate,endDate);

@override
String toString() {
  return 'StatisticsSummaryEntity(totalIncome: $totalIncome, totalExpense: $totalExpense, balance: $balance, transactionCount: $transactionCount, startDate: $startDate, endDate: $endDate)';
}


}

/// @nodoc
abstract mixin class _$StatisticsSummaryEntityCopyWith<$Res> implements $StatisticsSummaryEntityCopyWith<$Res> {
  factory _$StatisticsSummaryEntityCopyWith(_StatisticsSummaryEntity value, $Res Function(_StatisticsSummaryEntity) _then) = __$StatisticsSummaryEntityCopyWithImpl;
@override @useResult
$Res call({
 double totalIncome, double totalExpense, double balance, int transactionCount, DateTime startDate, DateTime endDate
});




}
/// @nodoc
class __$StatisticsSummaryEntityCopyWithImpl<$Res>
    implements _$StatisticsSummaryEntityCopyWith<$Res> {
  __$StatisticsSummaryEntityCopyWithImpl(this._self, this._then);

  final _StatisticsSummaryEntity _self;
  final $Res Function(_StatisticsSummaryEntity) _then;

/// Create a copy of StatisticsSummaryEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalIncome = null,Object? totalExpense = null,Object? balance = null,Object? transactionCount = null,Object? startDate = null,Object? endDate = null,}) {
  return _then(_StatisticsSummaryEntity(
totalIncome: null == totalIncome ? _self.totalIncome : totalIncome // ignore: cast_nullable_to_non_nullable
as double,totalExpense: null == totalExpense ? _self.totalExpense : totalExpense // ignore: cast_nullable_to_non_nullable
as double,balance: null == balance ? _self.balance : balance // ignore: cast_nullable_to_non_nullable
as double,transactionCount: null == transactionCount ? _self.transactionCount : transactionCount // ignore: cast_nullable_to_non_nullable
as int,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,endDate: null == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on

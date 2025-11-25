// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transaction_summary_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TransactionSummaryEntity {

/// Liste des transactions (non sérialisée car potentiellement volumineuse)
@JsonKey(includeFromJson: false, includeToJson: false) List<TransactionEntity> get transactions; DateTime get startDate; DateTime get endDate; double get totalExpense; double get totalIncome; int get expenseCount; int get incomeCount; String get periodLabel;
/// Create a copy of TransactionSummaryEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TransactionSummaryEntityCopyWith<TransactionSummaryEntity> get copyWith => _$TransactionSummaryEntityCopyWithImpl<TransactionSummaryEntity>(this as TransactionSummaryEntity, _$identity);

  /// Serializes this TransactionSummaryEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TransactionSummaryEntity&&const DeepCollectionEquality().equals(other.transactions, transactions)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.totalExpense, totalExpense) || other.totalExpense == totalExpense)&&(identical(other.totalIncome, totalIncome) || other.totalIncome == totalIncome)&&(identical(other.expenseCount, expenseCount) || other.expenseCount == expenseCount)&&(identical(other.incomeCount, incomeCount) || other.incomeCount == incomeCount)&&(identical(other.periodLabel, periodLabel) || other.periodLabel == periodLabel));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(transactions),startDate,endDate,totalExpense,totalIncome,expenseCount,incomeCount,periodLabel);

@override
String toString() {
  return 'TransactionSummaryEntity(transactions: $transactions, startDate: $startDate, endDate: $endDate, totalExpense: $totalExpense, totalIncome: $totalIncome, expenseCount: $expenseCount, incomeCount: $incomeCount, periodLabel: $periodLabel)';
}


}

/// @nodoc
abstract mixin class $TransactionSummaryEntityCopyWith<$Res>  {
  factory $TransactionSummaryEntityCopyWith(TransactionSummaryEntity value, $Res Function(TransactionSummaryEntity) _then) = _$TransactionSummaryEntityCopyWithImpl;
@useResult
$Res call({
@JsonKey(includeFromJson: false, includeToJson: false) List<TransactionEntity> transactions, DateTime startDate, DateTime endDate, double totalExpense, double totalIncome, int expenseCount, int incomeCount, String periodLabel
});




}
/// @nodoc
class _$TransactionSummaryEntityCopyWithImpl<$Res>
    implements $TransactionSummaryEntityCopyWith<$Res> {
  _$TransactionSummaryEntityCopyWithImpl(this._self, this._then);

  final TransactionSummaryEntity _self;
  final $Res Function(TransactionSummaryEntity) _then;

/// Create a copy of TransactionSummaryEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? transactions = null,Object? startDate = null,Object? endDate = null,Object? totalExpense = null,Object? totalIncome = null,Object? expenseCount = null,Object? incomeCount = null,Object? periodLabel = null,}) {
  return _then(_self.copyWith(
transactions: null == transactions ? _self.transactions : transactions // ignore: cast_nullable_to_non_nullable
as List<TransactionEntity>,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,endDate: null == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime,totalExpense: null == totalExpense ? _self.totalExpense : totalExpense // ignore: cast_nullable_to_non_nullable
as double,totalIncome: null == totalIncome ? _self.totalIncome : totalIncome // ignore: cast_nullable_to_non_nullable
as double,expenseCount: null == expenseCount ? _self.expenseCount : expenseCount // ignore: cast_nullable_to_non_nullable
as int,incomeCount: null == incomeCount ? _self.incomeCount : incomeCount // ignore: cast_nullable_to_non_nullable
as int,periodLabel: null == periodLabel ? _self.periodLabel : periodLabel // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [TransactionSummaryEntity].
extension TransactionSummaryEntityPatterns on TransactionSummaryEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TransactionSummaryEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TransactionSummaryEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TransactionSummaryEntity value)  $default,){
final _that = this;
switch (_that) {
case _TransactionSummaryEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TransactionSummaryEntity value)?  $default,){
final _that = this;
switch (_that) {
case _TransactionSummaryEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(includeFromJson: false, includeToJson: false)  List<TransactionEntity> transactions,  DateTime startDate,  DateTime endDate,  double totalExpense,  double totalIncome,  int expenseCount,  int incomeCount,  String periodLabel)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TransactionSummaryEntity() when $default != null:
return $default(_that.transactions,_that.startDate,_that.endDate,_that.totalExpense,_that.totalIncome,_that.expenseCount,_that.incomeCount,_that.periodLabel);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(includeFromJson: false, includeToJson: false)  List<TransactionEntity> transactions,  DateTime startDate,  DateTime endDate,  double totalExpense,  double totalIncome,  int expenseCount,  int incomeCount,  String periodLabel)  $default,) {final _that = this;
switch (_that) {
case _TransactionSummaryEntity():
return $default(_that.transactions,_that.startDate,_that.endDate,_that.totalExpense,_that.totalIncome,_that.expenseCount,_that.incomeCount,_that.periodLabel);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(includeFromJson: false, includeToJson: false)  List<TransactionEntity> transactions,  DateTime startDate,  DateTime endDate,  double totalExpense,  double totalIncome,  int expenseCount,  int incomeCount,  String periodLabel)?  $default,) {final _that = this;
switch (_that) {
case _TransactionSummaryEntity() when $default != null:
return $default(_that.transactions,_that.startDate,_that.endDate,_that.totalExpense,_that.totalIncome,_that.expenseCount,_that.incomeCount,_that.periodLabel);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TransactionSummaryEntity implements TransactionSummaryEntity {
  const _TransactionSummaryEntity({@JsonKey(includeFromJson: false, includeToJson: false) final  List<TransactionEntity> transactions = const [], required this.startDate, required this.endDate, required this.totalExpense, required this.totalIncome, required this.expenseCount, required this.incomeCount, this.periodLabel = ''}): _transactions = transactions;
  factory _TransactionSummaryEntity.fromJson(Map<String, dynamic> json) => _$TransactionSummaryEntityFromJson(json);

/// Liste des transactions (non sérialisée car potentiellement volumineuse)
 final  List<TransactionEntity> _transactions;
/// Liste des transactions (non sérialisée car potentiellement volumineuse)
@override@JsonKey(includeFromJson: false, includeToJson: false) List<TransactionEntity> get transactions {
  if (_transactions is EqualUnmodifiableListView) return _transactions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_transactions);
}

@override final  DateTime startDate;
@override final  DateTime endDate;
@override final  double totalExpense;
@override final  double totalIncome;
@override final  int expenseCount;
@override final  int incomeCount;
@override@JsonKey() final  String periodLabel;

/// Create a copy of TransactionSummaryEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TransactionSummaryEntityCopyWith<_TransactionSummaryEntity> get copyWith => __$TransactionSummaryEntityCopyWithImpl<_TransactionSummaryEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TransactionSummaryEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TransactionSummaryEntity&&const DeepCollectionEquality().equals(other._transactions, _transactions)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.totalExpense, totalExpense) || other.totalExpense == totalExpense)&&(identical(other.totalIncome, totalIncome) || other.totalIncome == totalIncome)&&(identical(other.expenseCount, expenseCount) || other.expenseCount == expenseCount)&&(identical(other.incomeCount, incomeCount) || other.incomeCount == incomeCount)&&(identical(other.periodLabel, periodLabel) || other.periodLabel == periodLabel));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_transactions),startDate,endDate,totalExpense,totalIncome,expenseCount,incomeCount,periodLabel);

@override
String toString() {
  return 'TransactionSummaryEntity(transactions: $transactions, startDate: $startDate, endDate: $endDate, totalExpense: $totalExpense, totalIncome: $totalIncome, expenseCount: $expenseCount, incomeCount: $incomeCount, periodLabel: $periodLabel)';
}


}

/// @nodoc
abstract mixin class _$TransactionSummaryEntityCopyWith<$Res> implements $TransactionSummaryEntityCopyWith<$Res> {
  factory _$TransactionSummaryEntityCopyWith(_TransactionSummaryEntity value, $Res Function(_TransactionSummaryEntity) _then) = __$TransactionSummaryEntityCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(includeFromJson: false, includeToJson: false) List<TransactionEntity> transactions, DateTime startDate, DateTime endDate, double totalExpense, double totalIncome, int expenseCount, int incomeCount, String periodLabel
});




}
/// @nodoc
class __$TransactionSummaryEntityCopyWithImpl<$Res>
    implements _$TransactionSummaryEntityCopyWith<$Res> {
  __$TransactionSummaryEntityCopyWithImpl(this._self, this._then);

  final _TransactionSummaryEntity _self;
  final $Res Function(_TransactionSummaryEntity) _then;

/// Create a copy of TransactionSummaryEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? transactions = null,Object? startDate = null,Object? endDate = null,Object? totalExpense = null,Object? totalIncome = null,Object? expenseCount = null,Object? incomeCount = null,Object? periodLabel = null,}) {
  return _then(_TransactionSummaryEntity(
transactions: null == transactions ? _self._transactions : transactions // ignore: cast_nullable_to_non_nullable
as List<TransactionEntity>,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,endDate: null == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime,totalExpense: null == totalExpense ? _self.totalExpense : totalExpense // ignore: cast_nullable_to_non_nullable
as double,totalIncome: null == totalIncome ? _self.totalIncome : totalIncome // ignore: cast_nullable_to_non_nullable
as double,expenseCount: null == expenseCount ? _self.expenseCount : expenseCount // ignore: cast_nullable_to_non_nullable
as int,incomeCount: null == incomeCount ? _self.incomeCount : incomeCount // ignore: cast_nullable_to_non_nullable
as int,periodLabel: null == periodLabel ? _self.periodLabel : periodLabel // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on

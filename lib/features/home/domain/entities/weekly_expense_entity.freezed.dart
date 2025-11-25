// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'weekly_expense_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WeeklyExpenseEntity {

/// Jour de la semaine (1 = Lundi, 7 = Dimanche)
 int get dayOfWeek;/// Date du jour
 DateTime get date;/// Montant total des dépenses du jour
 double get amount;/// Nombre de transactions du jour
 int get transactionCount;
/// Create a copy of WeeklyExpenseEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WeeklyExpenseEntityCopyWith<WeeklyExpenseEntity> get copyWith => _$WeeklyExpenseEntityCopyWithImpl<WeeklyExpenseEntity>(this as WeeklyExpenseEntity, _$identity);

  /// Serializes this WeeklyExpenseEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WeeklyExpenseEntity&&(identical(other.dayOfWeek, dayOfWeek) || other.dayOfWeek == dayOfWeek)&&(identical(other.date, date) || other.date == date)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.transactionCount, transactionCount) || other.transactionCount == transactionCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,dayOfWeek,date,amount,transactionCount);

@override
String toString() {
  return 'WeeklyExpenseEntity(dayOfWeek: $dayOfWeek, date: $date, amount: $amount, transactionCount: $transactionCount)';
}


}

/// @nodoc
abstract mixin class $WeeklyExpenseEntityCopyWith<$Res>  {
  factory $WeeklyExpenseEntityCopyWith(WeeklyExpenseEntity value, $Res Function(WeeklyExpenseEntity) _then) = _$WeeklyExpenseEntityCopyWithImpl;
@useResult
$Res call({
 int dayOfWeek, DateTime date, double amount, int transactionCount
});




}
/// @nodoc
class _$WeeklyExpenseEntityCopyWithImpl<$Res>
    implements $WeeklyExpenseEntityCopyWith<$Res> {
  _$WeeklyExpenseEntityCopyWithImpl(this._self, this._then);

  final WeeklyExpenseEntity _self;
  final $Res Function(WeeklyExpenseEntity) _then;

/// Create a copy of WeeklyExpenseEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? dayOfWeek = null,Object? date = null,Object? amount = null,Object? transactionCount = null,}) {
  return _then(_self.copyWith(
dayOfWeek: null == dayOfWeek ? _self.dayOfWeek : dayOfWeek // ignore: cast_nullable_to_non_nullable
as int,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,transactionCount: null == transactionCount ? _self.transactionCount : transactionCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [WeeklyExpenseEntity].
extension WeeklyExpenseEntityPatterns on WeeklyExpenseEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WeeklyExpenseEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WeeklyExpenseEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WeeklyExpenseEntity value)  $default,){
final _that = this;
switch (_that) {
case _WeeklyExpenseEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WeeklyExpenseEntity value)?  $default,){
final _that = this;
switch (_that) {
case _WeeklyExpenseEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int dayOfWeek,  DateTime date,  double amount,  int transactionCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WeeklyExpenseEntity() when $default != null:
return $default(_that.dayOfWeek,_that.date,_that.amount,_that.transactionCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int dayOfWeek,  DateTime date,  double amount,  int transactionCount)  $default,) {final _that = this;
switch (_that) {
case _WeeklyExpenseEntity():
return $default(_that.dayOfWeek,_that.date,_that.amount,_that.transactionCount);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int dayOfWeek,  DateTime date,  double amount,  int transactionCount)?  $default,) {final _that = this;
switch (_that) {
case _WeeklyExpenseEntity() when $default != null:
return $default(_that.dayOfWeek,_that.date,_that.amount,_that.transactionCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WeeklyExpenseEntity implements WeeklyExpenseEntity {
  const _WeeklyExpenseEntity({required this.dayOfWeek, required this.date, required this.amount, this.transactionCount = 0});
  factory _WeeklyExpenseEntity.fromJson(Map<String, dynamic> json) => _$WeeklyExpenseEntityFromJson(json);

/// Jour de la semaine (1 = Lundi, 7 = Dimanche)
@override final  int dayOfWeek;
/// Date du jour
@override final  DateTime date;
/// Montant total des dépenses du jour
@override final  double amount;
/// Nombre de transactions du jour
@override@JsonKey() final  int transactionCount;

/// Create a copy of WeeklyExpenseEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WeeklyExpenseEntityCopyWith<_WeeklyExpenseEntity> get copyWith => __$WeeklyExpenseEntityCopyWithImpl<_WeeklyExpenseEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WeeklyExpenseEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WeeklyExpenseEntity&&(identical(other.dayOfWeek, dayOfWeek) || other.dayOfWeek == dayOfWeek)&&(identical(other.date, date) || other.date == date)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.transactionCount, transactionCount) || other.transactionCount == transactionCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,dayOfWeek,date,amount,transactionCount);

@override
String toString() {
  return 'WeeklyExpenseEntity(dayOfWeek: $dayOfWeek, date: $date, amount: $amount, transactionCount: $transactionCount)';
}


}

/// @nodoc
abstract mixin class _$WeeklyExpenseEntityCopyWith<$Res> implements $WeeklyExpenseEntityCopyWith<$Res> {
  factory _$WeeklyExpenseEntityCopyWith(_WeeklyExpenseEntity value, $Res Function(_WeeklyExpenseEntity) _then) = __$WeeklyExpenseEntityCopyWithImpl;
@override @useResult
$Res call({
 int dayOfWeek, DateTime date, double amount, int transactionCount
});




}
/// @nodoc
class __$WeeklyExpenseEntityCopyWithImpl<$Res>
    implements _$WeeklyExpenseEntityCopyWith<$Res> {
  __$WeeklyExpenseEntityCopyWithImpl(this._self, this._then);

  final _WeeklyExpenseEntity _self;
  final $Res Function(_WeeklyExpenseEntity) _then;

/// Create a copy of WeeklyExpenseEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? dayOfWeek = null,Object? date = null,Object? amount = null,Object? transactionCount = null,}) {
  return _then(_WeeklyExpenseEntity(
dayOfWeek: null == dayOfWeek ? _self.dayOfWeek : dayOfWeek // ignore: cast_nullable_to_non_nullable
as int,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,transactionCount: null == transactionCount ? _self.transactionCount : transactionCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$WeeklyExpensesEntity {

/// Liste des dépenses par jour
 List<WeeklyExpenseEntity> get expenses;/// Total de la semaine
 double get totalWeekAmount;/// Date de début de la semaine
 DateTime get weekStartDate;/// Date de fin de la semaine
 DateTime get weekEndDate;
/// Create a copy of WeeklyExpensesEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WeeklyExpensesEntityCopyWith<WeeklyExpensesEntity> get copyWith => _$WeeklyExpensesEntityCopyWithImpl<WeeklyExpensesEntity>(this as WeeklyExpensesEntity, _$identity);

  /// Serializes this WeeklyExpensesEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WeeklyExpensesEntity&&const DeepCollectionEquality().equals(other.expenses, expenses)&&(identical(other.totalWeekAmount, totalWeekAmount) || other.totalWeekAmount == totalWeekAmount)&&(identical(other.weekStartDate, weekStartDate) || other.weekStartDate == weekStartDate)&&(identical(other.weekEndDate, weekEndDate) || other.weekEndDate == weekEndDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(expenses),totalWeekAmount,weekStartDate,weekEndDate);

@override
String toString() {
  return 'WeeklyExpensesEntity(expenses: $expenses, totalWeekAmount: $totalWeekAmount, weekStartDate: $weekStartDate, weekEndDate: $weekEndDate)';
}


}

/// @nodoc
abstract mixin class $WeeklyExpensesEntityCopyWith<$Res>  {
  factory $WeeklyExpensesEntityCopyWith(WeeklyExpensesEntity value, $Res Function(WeeklyExpensesEntity) _then) = _$WeeklyExpensesEntityCopyWithImpl;
@useResult
$Res call({
 List<WeeklyExpenseEntity> expenses, double totalWeekAmount, DateTime weekStartDate, DateTime weekEndDate
});




}
/// @nodoc
class _$WeeklyExpensesEntityCopyWithImpl<$Res>
    implements $WeeklyExpensesEntityCopyWith<$Res> {
  _$WeeklyExpensesEntityCopyWithImpl(this._self, this._then);

  final WeeklyExpensesEntity _self;
  final $Res Function(WeeklyExpensesEntity) _then;

/// Create a copy of WeeklyExpensesEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? expenses = null,Object? totalWeekAmount = null,Object? weekStartDate = null,Object? weekEndDate = null,}) {
  return _then(_self.copyWith(
expenses: null == expenses ? _self.expenses : expenses // ignore: cast_nullable_to_non_nullable
as List<WeeklyExpenseEntity>,totalWeekAmount: null == totalWeekAmount ? _self.totalWeekAmount : totalWeekAmount // ignore: cast_nullable_to_non_nullable
as double,weekStartDate: null == weekStartDate ? _self.weekStartDate : weekStartDate // ignore: cast_nullable_to_non_nullable
as DateTime,weekEndDate: null == weekEndDate ? _self.weekEndDate : weekEndDate // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [WeeklyExpensesEntity].
extension WeeklyExpensesEntityPatterns on WeeklyExpensesEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WeeklyExpensesEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WeeklyExpensesEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WeeklyExpensesEntity value)  $default,){
final _that = this;
switch (_that) {
case _WeeklyExpensesEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WeeklyExpensesEntity value)?  $default,){
final _that = this;
switch (_that) {
case _WeeklyExpensesEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<WeeklyExpenseEntity> expenses,  double totalWeekAmount,  DateTime weekStartDate,  DateTime weekEndDate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WeeklyExpensesEntity() when $default != null:
return $default(_that.expenses,_that.totalWeekAmount,_that.weekStartDate,_that.weekEndDate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<WeeklyExpenseEntity> expenses,  double totalWeekAmount,  DateTime weekStartDate,  DateTime weekEndDate)  $default,) {final _that = this;
switch (_that) {
case _WeeklyExpensesEntity():
return $default(_that.expenses,_that.totalWeekAmount,_that.weekStartDate,_that.weekEndDate);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<WeeklyExpenseEntity> expenses,  double totalWeekAmount,  DateTime weekStartDate,  DateTime weekEndDate)?  $default,) {final _that = this;
switch (_that) {
case _WeeklyExpensesEntity() when $default != null:
return $default(_that.expenses,_that.totalWeekAmount,_that.weekStartDate,_that.weekEndDate);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WeeklyExpensesEntity implements WeeklyExpensesEntity {
  const _WeeklyExpensesEntity({required final  List<WeeklyExpenseEntity> expenses, required this.totalWeekAmount, required this.weekStartDate, required this.weekEndDate}): _expenses = expenses;
  factory _WeeklyExpensesEntity.fromJson(Map<String, dynamic> json) => _$WeeklyExpensesEntityFromJson(json);

/// Liste des dépenses par jour
 final  List<WeeklyExpenseEntity> _expenses;
/// Liste des dépenses par jour
@override List<WeeklyExpenseEntity> get expenses {
  if (_expenses is EqualUnmodifiableListView) return _expenses;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_expenses);
}

/// Total de la semaine
@override final  double totalWeekAmount;
/// Date de début de la semaine
@override final  DateTime weekStartDate;
/// Date de fin de la semaine
@override final  DateTime weekEndDate;

/// Create a copy of WeeklyExpensesEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WeeklyExpensesEntityCopyWith<_WeeklyExpensesEntity> get copyWith => __$WeeklyExpensesEntityCopyWithImpl<_WeeklyExpensesEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WeeklyExpensesEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WeeklyExpensesEntity&&const DeepCollectionEquality().equals(other._expenses, _expenses)&&(identical(other.totalWeekAmount, totalWeekAmount) || other.totalWeekAmount == totalWeekAmount)&&(identical(other.weekStartDate, weekStartDate) || other.weekStartDate == weekStartDate)&&(identical(other.weekEndDate, weekEndDate) || other.weekEndDate == weekEndDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_expenses),totalWeekAmount,weekStartDate,weekEndDate);

@override
String toString() {
  return 'WeeklyExpensesEntity(expenses: $expenses, totalWeekAmount: $totalWeekAmount, weekStartDate: $weekStartDate, weekEndDate: $weekEndDate)';
}


}

/// @nodoc
abstract mixin class _$WeeklyExpensesEntityCopyWith<$Res> implements $WeeklyExpensesEntityCopyWith<$Res> {
  factory _$WeeklyExpensesEntityCopyWith(_WeeklyExpensesEntity value, $Res Function(_WeeklyExpensesEntity) _then) = __$WeeklyExpensesEntityCopyWithImpl;
@override @useResult
$Res call({
 List<WeeklyExpenseEntity> expenses, double totalWeekAmount, DateTime weekStartDate, DateTime weekEndDate
});




}
/// @nodoc
class __$WeeklyExpensesEntityCopyWithImpl<$Res>
    implements _$WeeklyExpensesEntityCopyWith<$Res> {
  __$WeeklyExpensesEntityCopyWithImpl(this._self, this._then);

  final _WeeklyExpensesEntity _self;
  final $Res Function(_WeeklyExpensesEntity) _then;

/// Create a copy of WeeklyExpensesEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? expenses = null,Object? totalWeekAmount = null,Object? weekStartDate = null,Object? weekEndDate = null,}) {
  return _then(_WeeklyExpensesEntity(
expenses: null == expenses ? _self._expenses : expenses // ignore: cast_nullable_to_non_nullable
as List<WeeklyExpenseEntity>,totalWeekAmount: null == totalWeekAmount ? _self.totalWeekAmount : totalWeekAmount // ignore: cast_nullable_to_non_nullable
as double,weekStartDate: null == weekStartDate ? _self.weekStartDate : weekStartDate // ignore: cast_nullable_to_non_nullable
as DateTime,weekEndDate: null == weekEndDate ? _self.weekEndDate : weekEndDate // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on

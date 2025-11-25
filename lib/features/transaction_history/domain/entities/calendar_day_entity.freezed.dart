// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'calendar_day_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CalendarTransactionItem {

 String? get imageUrl; String get type;
/// Create a copy of CalendarTransactionItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CalendarTransactionItemCopyWith<CalendarTransactionItem> get copyWith => _$CalendarTransactionItemCopyWithImpl<CalendarTransactionItem>(this as CalendarTransactionItem, _$identity);

  /// Serializes this CalendarTransactionItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CalendarTransactionItem&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,imageUrl,type);

@override
String toString() {
  return 'CalendarTransactionItem(imageUrl: $imageUrl, type: $type)';
}


}

/// @nodoc
abstract mixin class $CalendarTransactionItemCopyWith<$Res>  {
  factory $CalendarTransactionItemCopyWith(CalendarTransactionItem value, $Res Function(CalendarTransactionItem) _then) = _$CalendarTransactionItemCopyWithImpl;
@useResult
$Res call({
 String? imageUrl, String type
});




}
/// @nodoc
class _$CalendarTransactionItemCopyWithImpl<$Res>
    implements $CalendarTransactionItemCopyWith<$Res> {
  _$CalendarTransactionItemCopyWithImpl(this._self, this._then);

  final CalendarTransactionItem _self;
  final $Res Function(CalendarTransactionItem) _then;

/// Create a copy of CalendarTransactionItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? imageUrl = freezed,Object? type = null,}) {
  return _then(_self.copyWith(
imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [CalendarTransactionItem].
extension CalendarTransactionItemPatterns on CalendarTransactionItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CalendarTransactionItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CalendarTransactionItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CalendarTransactionItem value)  $default,){
final _that = this;
switch (_that) {
case _CalendarTransactionItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CalendarTransactionItem value)?  $default,){
final _that = this;
switch (_that) {
case _CalendarTransactionItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? imageUrl,  String type)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CalendarTransactionItem() when $default != null:
return $default(_that.imageUrl,_that.type);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? imageUrl,  String type)  $default,) {final _that = this;
switch (_that) {
case _CalendarTransactionItem():
return $default(_that.imageUrl,_that.type);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? imageUrl,  String type)?  $default,) {final _that = this;
switch (_that) {
case _CalendarTransactionItem() when $default != null:
return $default(_that.imageUrl,_that.type);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CalendarTransactionItem implements CalendarTransactionItem {
  const _CalendarTransactionItem({required this.imageUrl, required this.type});
  factory _CalendarTransactionItem.fromJson(Map<String, dynamic> json) => _$CalendarTransactionItemFromJson(json);

@override final  String? imageUrl;
@override final  String type;

/// Create a copy of CalendarTransactionItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CalendarTransactionItemCopyWith<_CalendarTransactionItem> get copyWith => __$CalendarTransactionItemCopyWithImpl<_CalendarTransactionItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CalendarTransactionItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CalendarTransactionItem&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,imageUrl,type);

@override
String toString() {
  return 'CalendarTransactionItem(imageUrl: $imageUrl, type: $type)';
}


}

/// @nodoc
abstract mixin class _$CalendarTransactionItemCopyWith<$Res> implements $CalendarTransactionItemCopyWith<$Res> {
  factory _$CalendarTransactionItemCopyWith(_CalendarTransactionItem value, $Res Function(_CalendarTransactionItem) _then) = __$CalendarTransactionItemCopyWithImpl;
@override @useResult
$Res call({
 String? imageUrl, String type
});




}
/// @nodoc
class __$CalendarTransactionItemCopyWithImpl<$Res>
    implements _$CalendarTransactionItemCopyWith<$Res> {
  __$CalendarTransactionItemCopyWithImpl(this._self, this._then);

  final _CalendarTransactionItem _self;
  final $Res Function(_CalendarTransactionItem) _then;

/// Create a copy of CalendarTransactionItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? imageUrl = freezed,Object? type = null,}) {
  return _then(_CalendarTransactionItem(
imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$CalendarDayEntity {

 DateTime get date; int get transactionCount; double get totalExpense; double get totalIncome; List<CalendarTransactionItem> get transactions; bool get hasTransactions; bool get isToday; bool get isSelected; bool get isCurrentMonth;
/// Create a copy of CalendarDayEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CalendarDayEntityCopyWith<CalendarDayEntity> get copyWith => _$CalendarDayEntityCopyWithImpl<CalendarDayEntity>(this as CalendarDayEntity, _$identity);

  /// Serializes this CalendarDayEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CalendarDayEntity&&(identical(other.date, date) || other.date == date)&&(identical(other.transactionCount, transactionCount) || other.transactionCount == transactionCount)&&(identical(other.totalExpense, totalExpense) || other.totalExpense == totalExpense)&&(identical(other.totalIncome, totalIncome) || other.totalIncome == totalIncome)&&const DeepCollectionEquality().equals(other.transactions, transactions)&&(identical(other.hasTransactions, hasTransactions) || other.hasTransactions == hasTransactions)&&(identical(other.isToday, isToday) || other.isToday == isToday)&&(identical(other.isSelected, isSelected) || other.isSelected == isSelected)&&(identical(other.isCurrentMonth, isCurrentMonth) || other.isCurrentMonth == isCurrentMonth));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,date,transactionCount,totalExpense,totalIncome,const DeepCollectionEquality().hash(transactions),hasTransactions,isToday,isSelected,isCurrentMonth);

@override
String toString() {
  return 'CalendarDayEntity(date: $date, transactionCount: $transactionCount, totalExpense: $totalExpense, totalIncome: $totalIncome, transactions: $transactions, hasTransactions: $hasTransactions, isToday: $isToday, isSelected: $isSelected, isCurrentMonth: $isCurrentMonth)';
}


}

/// @nodoc
abstract mixin class $CalendarDayEntityCopyWith<$Res>  {
  factory $CalendarDayEntityCopyWith(CalendarDayEntity value, $Res Function(CalendarDayEntity) _then) = _$CalendarDayEntityCopyWithImpl;
@useResult
$Res call({
 DateTime date, int transactionCount, double totalExpense, double totalIncome, List<CalendarTransactionItem> transactions, bool hasTransactions, bool isToday, bool isSelected, bool isCurrentMonth
});




}
/// @nodoc
class _$CalendarDayEntityCopyWithImpl<$Res>
    implements $CalendarDayEntityCopyWith<$Res> {
  _$CalendarDayEntityCopyWithImpl(this._self, this._then);

  final CalendarDayEntity _self;
  final $Res Function(CalendarDayEntity) _then;

/// Create a copy of CalendarDayEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? transactionCount = null,Object? totalExpense = null,Object? totalIncome = null,Object? transactions = null,Object? hasTransactions = null,Object? isToday = null,Object? isSelected = null,Object? isCurrentMonth = null,}) {
  return _then(_self.copyWith(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,transactionCount: null == transactionCount ? _self.transactionCount : transactionCount // ignore: cast_nullable_to_non_nullable
as int,totalExpense: null == totalExpense ? _self.totalExpense : totalExpense // ignore: cast_nullable_to_non_nullable
as double,totalIncome: null == totalIncome ? _self.totalIncome : totalIncome // ignore: cast_nullable_to_non_nullable
as double,transactions: null == transactions ? _self.transactions : transactions // ignore: cast_nullable_to_non_nullable
as List<CalendarTransactionItem>,hasTransactions: null == hasTransactions ? _self.hasTransactions : hasTransactions // ignore: cast_nullable_to_non_nullable
as bool,isToday: null == isToday ? _self.isToday : isToday // ignore: cast_nullable_to_non_nullable
as bool,isSelected: null == isSelected ? _self.isSelected : isSelected // ignore: cast_nullable_to_non_nullable
as bool,isCurrentMonth: null == isCurrentMonth ? _self.isCurrentMonth : isCurrentMonth // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [CalendarDayEntity].
extension CalendarDayEntityPatterns on CalendarDayEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CalendarDayEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CalendarDayEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CalendarDayEntity value)  $default,){
final _that = this;
switch (_that) {
case _CalendarDayEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CalendarDayEntity value)?  $default,){
final _that = this;
switch (_that) {
case _CalendarDayEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime date,  int transactionCount,  double totalExpense,  double totalIncome,  List<CalendarTransactionItem> transactions,  bool hasTransactions,  bool isToday,  bool isSelected,  bool isCurrentMonth)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CalendarDayEntity() when $default != null:
return $default(_that.date,_that.transactionCount,_that.totalExpense,_that.totalIncome,_that.transactions,_that.hasTransactions,_that.isToday,_that.isSelected,_that.isCurrentMonth);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime date,  int transactionCount,  double totalExpense,  double totalIncome,  List<CalendarTransactionItem> transactions,  bool hasTransactions,  bool isToday,  bool isSelected,  bool isCurrentMonth)  $default,) {final _that = this;
switch (_that) {
case _CalendarDayEntity():
return $default(_that.date,_that.transactionCount,_that.totalExpense,_that.totalIncome,_that.transactions,_that.hasTransactions,_that.isToday,_that.isSelected,_that.isCurrentMonth);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime date,  int transactionCount,  double totalExpense,  double totalIncome,  List<CalendarTransactionItem> transactions,  bool hasTransactions,  bool isToday,  bool isSelected,  bool isCurrentMonth)?  $default,) {final _that = this;
switch (_that) {
case _CalendarDayEntity() when $default != null:
return $default(_that.date,_that.transactionCount,_that.totalExpense,_that.totalIncome,_that.transactions,_that.hasTransactions,_that.isToday,_that.isSelected,_that.isCurrentMonth);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CalendarDayEntity implements CalendarDayEntity {
  const _CalendarDayEntity({required this.date, required this.transactionCount, required this.totalExpense, required this.totalIncome, final  List<CalendarTransactionItem> transactions = const [], this.hasTransactions = false, this.isToday = false, this.isSelected = false, this.isCurrentMonth = false}): _transactions = transactions;
  factory _CalendarDayEntity.fromJson(Map<String, dynamic> json) => _$CalendarDayEntityFromJson(json);

@override final  DateTime date;
@override final  int transactionCount;
@override final  double totalExpense;
@override final  double totalIncome;
 final  List<CalendarTransactionItem> _transactions;
@override@JsonKey() List<CalendarTransactionItem> get transactions {
  if (_transactions is EqualUnmodifiableListView) return _transactions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_transactions);
}

@override@JsonKey() final  bool hasTransactions;
@override@JsonKey() final  bool isToday;
@override@JsonKey() final  bool isSelected;
@override@JsonKey() final  bool isCurrentMonth;

/// Create a copy of CalendarDayEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CalendarDayEntityCopyWith<_CalendarDayEntity> get copyWith => __$CalendarDayEntityCopyWithImpl<_CalendarDayEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CalendarDayEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CalendarDayEntity&&(identical(other.date, date) || other.date == date)&&(identical(other.transactionCount, transactionCount) || other.transactionCount == transactionCount)&&(identical(other.totalExpense, totalExpense) || other.totalExpense == totalExpense)&&(identical(other.totalIncome, totalIncome) || other.totalIncome == totalIncome)&&const DeepCollectionEquality().equals(other._transactions, _transactions)&&(identical(other.hasTransactions, hasTransactions) || other.hasTransactions == hasTransactions)&&(identical(other.isToday, isToday) || other.isToday == isToday)&&(identical(other.isSelected, isSelected) || other.isSelected == isSelected)&&(identical(other.isCurrentMonth, isCurrentMonth) || other.isCurrentMonth == isCurrentMonth));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,date,transactionCount,totalExpense,totalIncome,const DeepCollectionEquality().hash(_transactions),hasTransactions,isToday,isSelected,isCurrentMonth);

@override
String toString() {
  return 'CalendarDayEntity(date: $date, transactionCount: $transactionCount, totalExpense: $totalExpense, totalIncome: $totalIncome, transactions: $transactions, hasTransactions: $hasTransactions, isToday: $isToday, isSelected: $isSelected, isCurrentMonth: $isCurrentMonth)';
}


}

/// @nodoc
abstract mixin class _$CalendarDayEntityCopyWith<$Res> implements $CalendarDayEntityCopyWith<$Res> {
  factory _$CalendarDayEntityCopyWith(_CalendarDayEntity value, $Res Function(_CalendarDayEntity) _then) = __$CalendarDayEntityCopyWithImpl;
@override @useResult
$Res call({
 DateTime date, int transactionCount, double totalExpense, double totalIncome, List<CalendarTransactionItem> transactions, bool hasTransactions, bool isToday, bool isSelected, bool isCurrentMonth
});




}
/// @nodoc
class __$CalendarDayEntityCopyWithImpl<$Res>
    implements _$CalendarDayEntityCopyWith<$Res> {
  __$CalendarDayEntityCopyWithImpl(this._self, this._then);

  final _CalendarDayEntity _self;
  final $Res Function(_CalendarDayEntity) _then;

/// Create a copy of CalendarDayEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? transactionCount = null,Object? totalExpense = null,Object? totalIncome = null,Object? transactions = null,Object? hasTransactions = null,Object? isToday = null,Object? isSelected = null,Object? isCurrentMonth = null,}) {
  return _then(_CalendarDayEntity(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,transactionCount: null == transactionCount ? _self.transactionCount : transactionCount // ignore: cast_nullable_to_non_nullable
as int,totalExpense: null == totalExpense ? _self.totalExpense : totalExpense // ignore: cast_nullable_to_non_nullable
as double,totalIncome: null == totalIncome ? _self.totalIncome : totalIncome // ignore: cast_nullable_to_non_nullable
as double,transactions: null == transactions ? _self._transactions : transactions // ignore: cast_nullable_to_non_nullable
as List<CalendarTransactionItem>,hasTransactions: null == hasTransactions ? _self.hasTransactions : hasTransactions // ignore: cast_nullable_to_non_nullable
as bool,isToday: null == isToday ? _self.isToday : isToday // ignore: cast_nullable_to_non_nullable
as bool,isSelected: null == isSelected ? _self.isSelected : isSelected // ignore: cast_nullable_to_non_nullable
as bool,isCurrentMonth: null == isCurrentMonth ? _self.isCurrentMonth : isCurrentMonth // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on

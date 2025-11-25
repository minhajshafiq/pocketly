// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transaction_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TransactionState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TransactionState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TransactionState()';
}


}

/// @nodoc
class $TransactionStateCopyWith<$Res>  {
$TransactionStateCopyWith(TransactionState _, $Res Function(TransactionState) __);
}


/// Adds pattern-matching-related methods to [TransactionState].
extension TransactionStatePatterns on TransactionState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TransactionState value)?  $default,{TResult Function( TransactionStateInitial value)?  initial,TResult Function( TransactionStateLoading value)?  loading,TResult Function( TransactionStateLoaded value)?  loaded,TResult Function( TransactionStateRefreshing value)?  refreshing,TResult Function( TransactionStateError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TransactionState() when $default != null:
return $default(_that);case TransactionStateInitial() when initial != null:
return initial(_that);case TransactionStateLoading() when loading != null:
return loading(_that);case TransactionStateLoaded() when loaded != null:
return loaded(_that);case TransactionStateRefreshing() when refreshing != null:
return refreshing(_that);case TransactionStateError() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TransactionState value)  $default,{required TResult Function( TransactionStateInitial value)  initial,required TResult Function( TransactionStateLoading value)  loading,required TResult Function( TransactionStateLoaded value)  loaded,required TResult Function( TransactionStateRefreshing value)  refreshing,required TResult Function( TransactionStateError value)  error,}){
final _that = this;
switch (_that) {
case _TransactionState():
return $default(_that);case TransactionStateInitial():
return initial(_that);case TransactionStateLoading():
return loading(_that);case TransactionStateLoaded():
return loaded(_that);case TransactionStateRefreshing():
return refreshing(_that);case TransactionStateError():
return error(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TransactionState value)?  $default,{TResult? Function( TransactionStateInitial value)?  initial,TResult? Function( TransactionStateLoading value)?  loading,TResult? Function( TransactionStateLoaded value)?  loaded,TResult? Function( TransactionStateRefreshing value)?  refreshing,TResult? Function( TransactionStateError value)?  error,}){
final _that = this;
switch (_that) {
case _TransactionState() when $default != null:
return $default(_that);case TransactionStateInitial() when initial != null:
return initial(_that);case TransactionStateLoading() when loading != null:
return loading(_that);case TransactionStateLoaded() when loaded != null:
return loaded(_that);case TransactionStateRefreshing() when refreshing != null:
return refreshing(_that);case TransactionStateError() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<TransactionEntity> transactions,  bool isLoading,  bool isRefreshing,  String? error)?  $default,{TResult Function()?  initial,TResult Function( List<TransactionEntity> transactions)?  loading,TResult Function( List<TransactionEntity> transactions)?  loaded,TResult Function( List<TransactionEntity> transactions)?  refreshing,TResult Function( String message,  List<TransactionEntity> transactions)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TransactionState() when $default != null:
return $default(_that.transactions,_that.isLoading,_that.isRefreshing,_that.error);case TransactionStateInitial() when initial != null:
return initial();case TransactionStateLoading() when loading != null:
return loading(_that.transactions);case TransactionStateLoaded() when loaded != null:
return loaded(_that.transactions);case TransactionStateRefreshing() when refreshing != null:
return refreshing(_that.transactions);case TransactionStateError() when error != null:
return error(_that.message,_that.transactions);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<TransactionEntity> transactions,  bool isLoading,  bool isRefreshing,  String? error)  $default,{required TResult Function()  initial,required TResult Function( List<TransactionEntity> transactions)  loading,required TResult Function( List<TransactionEntity> transactions)  loaded,required TResult Function( List<TransactionEntity> transactions)  refreshing,required TResult Function( String message,  List<TransactionEntity> transactions)  error,}) {final _that = this;
switch (_that) {
case _TransactionState():
return $default(_that.transactions,_that.isLoading,_that.isRefreshing,_that.error);case TransactionStateInitial():
return initial();case TransactionStateLoading():
return loading(_that.transactions);case TransactionStateLoaded():
return loaded(_that.transactions);case TransactionStateRefreshing():
return refreshing(_that.transactions);case TransactionStateError():
return error(_that.message,_that.transactions);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<TransactionEntity> transactions,  bool isLoading,  bool isRefreshing,  String? error)?  $default,{TResult? Function()?  initial,TResult? Function( List<TransactionEntity> transactions)?  loading,TResult? Function( List<TransactionEntity> transactions)?  loaded,TResult? Function( List<TransactionEntity> transactions)?  refreshing,TResult? Function( String message,  List<TransactionEntity> transactions)?  error,}) {final _that = this;
switch (_that) {
case _TransactionState() when $default != null:
return $default(_that.transactions,_that.isLoading,_that.isRefreshing,_that.error);case TransactionStateInitial() when initial != null:
return initial();case TransactionStateLoading() when loading != null:
return loading(_that.transactions);case TransactionStateLoaded() when loaded != null:
return loaded(_that.transactions);case TransactionStateRefreshing() when refreshing != null:
return refreshing(_that.transactions);case TransactionStateError() when error != null:
return error(_that.message,_that.transactions);case _:
  return null;

}
}

}

/// @nodoc


class _TransactionState extends TransactionState {
  const _TransactionState({final  List<TransactionEntity> transactions = const [], this.isLoading = false, this.isRefreshing = false, this.error}): _transactions = transactions,super._();
  

 final  List<TransactionEntity> _transactions;
@JsonKey() List<TransactionEntity> get transactions {
  if (_transactions is EqualUnmodifiableListView) return _transactions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_transactions);
}

@JsonKey() final  bool isLoading;
@JsonKey() final  bool isRefreshing;
 final  String? error;

/// Create a copy of TransactionState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TransactionStateCopyWith<_TransactionState> get copyWith => __$TransactionStateCopyWithImpl<_TransactionState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TransactionState&&const DeepCollectionEquality().equals(other._transactions, _transactions)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isRefreshing, isRefreshing) || other.isRefreshing == isRefreshing)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_transactions),isLoading,isRefreshing,error);

@override
String toString() {
  return 'TransactionState(transactions: $transactions, isLoading: $isLoading, isRefreshing: $isRefreshing, error: $error)';
}


}

/// @nodoc
abstract mixin class _$TransactionStateCopyWith<$Res> implements $TransactionStateCopyWith<$Res> {
  factory _$TransactionStateCopyWith(_TransactionState value, $Res Function(_TransactionState) _then) = __$TransactionStateCopyWithImpl;
@useResult
$Res call({
 List<TransactionEntity> transactions, bool isLoading, bool isRefreshing, String? error
});




}
/// @nodoc
class __$TransactionStateCopyWithImpl<$Res>
    implements _$TransactionStateCopyWith<$Res> {
  __$TransactionStateCopyWithImpl(this._self, this._then);

  final _TransactionState _self;
  final $Res Function(_TransactionState) _then;

/// Create a copy of TransactionState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? transactions = null,Object? isLoading = null,Object? isRefreshing = null,Object? error = freezed,}) {
  return _then(_TransactionState(
transactions: null == transactions ? _self._transactions : transactions // ignore: cast_nullable_to_non_nullable
as List<TransactionEntity>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isRefreshing: null == isRefreshing ? _self.isRefreshing : isRefreshing // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class TransactionStateInitial extends TransactionState {
  const TransactionStateInitial(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TransactionStateInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TransactionState.initial()';
}


}




/// @nodoc


class TransactionStateLoading extends TransactionState {
  const TransactionStateLoading({final  List<TransactionEntity> transactions = const []}): _transactions = transactions,super._();
  

 final  List<TransactionEntity> _transactions;
@JsonKey() List<TransactionEntity> get transactions {
  if (_transactions is EqualUnmodifiableListView) return _transactions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_transactions);
}


/// Create a copy of TransactionState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TransactionStateLoadingCopyWith<TransactionStateLoading> get copyWith => _$TransactionStateLoadingCopyWithImpl<TransactionStateLoading>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TransactionStateLoading&&const DeepCollectionEquality().equals(other._transactions, _transactions));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_transactions));

@override
String toString() {
  return 'TransactionState.loading(transactions: $transactions)';
}


}

/// @nodoc
abstract mixin class $TransactionStateLoadingCopyWith<$Res> implements $TransactionStateCopyWith<$Res> {
  factory $TransactionStateLoadingCopyWith(TransactionStateLoading value, $Res Function(TransactionStateLoading) _then) = _$TransactionStateLoadingCopyWithImpl;
@useResult
$Res call({
 List<TransactionEntity> transactions
});




}
/// @nodoc
class _$TransactionStateLoadingCopyWithImpl<$Res>
    implements $TransactionStateLoadingCopyWith<$Res> {
  _$TransactionStateLoadingCopyWithImpl(this._self, this._then);

  final TransactionStateLoading _self;
  final $Res Function(TransactionStateLoading) _then;

/// Create a copy of TransactionState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? transactions = null,}) {
  return _then(TransactionStateLoading(
transactions: null == transactions ? _self._transactions : transactions // ignore: cast_nullable_to_non_nullable
as List<TransactionEntity>,
  ));
}


}

/// @nodoc


class TransactionStateLoaded extends TransactionState {
  const TransactionStateLoaded({required final  List<TransactionEntity> transactions}): _transactions = transactions,super._();
  

 final  List<TransactionEntity> _transactions;
 List<TransactionEntity> get transactions {
  if (_transactions is EqualUnmodifiableListView) return _transactions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_transactions);
}


/// Create a copy of TransactionState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TransactionStateLoadedCopyWith<TransactionStateLoaded> get copyWith => _$TransactionStateLoadedCopyWithImpl<TransactionStateLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TransactionStateLoaded&&const DeepCollectionEquality().equals(other._transactions, _transactions));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_transactions));

@override
String toString() {
  return 'TransactionState.loaded(transactions: $transactions)';
}


}

/// @nodoc
abstract mixin class $TransactionStateLoadedCopyWith<$Res> implements $TransactionStateCopyWith<$Res> {
  factory $TransactionStateLoadedCopyWith(TransactionStateLoaded value, $Res Function(TransactionStateLoaded) _then) = _$TransactionStateLoadedCopyWithImpl;
@useResult
$Res call({
 List<TransactionEntity> transactions
});




}
/// @nodoc
class _$TransactionStateLoadedCopyWithImpl<$Res>
    implements $TransactionStateLoadedCopyWith<$Res> {
  _$TransactionStateLoadedCopyWithImpl(this._self, this._then);

  final TransactionStateLoaded _self;
  final $Res Function(TransactionStateLoaded) _then;

/// Create a copy of TransactionState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? transactions = null,}) {
  return _then(TransactionStateLoaded(
transactions: null == transactions ? _self._transactions : transactions // ignore: cast_nullable_to_non_nullable
as List<TransactionEntity>,
  ));
}


}

/// @nodoc


class TransactionStateRefreshing extends TransactionState {
  const TransactionStateRefreshing({required final  List<TransactionEntity> transactions}): _transactions = transactions,super._();
  

 final  List<TransactionEntity> _transactions;
 List<TransactionEntity> get transactions {
  if (_transactions is EqualUnmodifiableListView) return _transactions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_transactions);
}


/// Create a copy of TransactionState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TransactionStateRefreshingCopyWith<TransactionStateRefreshing> get copyWith => _$TransactionStateRefreshingCopyWithImpl<TransactionStateRefreshing>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TransactionStateRefreshing&&const DeepCollectionEquality().equals(other._transactions, _transactions));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_transactions));

@override
String toString() {
  return 'TransactionState.refreshing(transactions: $transactions)';
}


}

/// @nodoc
abstract mixin class $TransactionStateRefreshingCopyWith<$Res> implements $TransactionStateCopyWith<$Res> {
  factory $TransactionStateRefreshingCopyWith(TransactionStateRefreshing value, $Res Function(TransactionStateRefreshing) _then) = _$TransactionStateRefreshingCopyWithImpl;
@useResult
$Res call({
 List<TransactionEntity> transactions
});




}
/// @nodoc
class _$TransactionStateRefreshingCopyWithImpl<$Res>
    implements $TransactionStateRefreshingCopyWith<$Res> {
  _$TransactionStateRefreshingCopyWithImpl(this._self, this._then);

  final TransactionStateRefreshing _self;
  final $Res Function(TransactionStateRefreshing) _then;

/// Create a copy of TransactionState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? transactions = null,}) {
  return _then(TransactionStateRefreshing(
transactions: null == transactions ? _self._transactions : transactions // ignore: cast_nullable_to_non_nullable
as List<TransactionEntity>,
  ));
}


}

/// @nodoc


class TransactionStateError extends TransactionState {
  const TransactionStateError({required this.message, final  List<TransactionEntity> transactions = const []}): _transactions = transactions,super._();
  

 final  String message;
 final  List<TransactionEntity> _transactions;
@JsonKey() List<TransactionEntity> get transactions {
  if (_transactions is EqualUnmodifiableListView) return _transactions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_transactions);
}


/// Create a copy of TransactionState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TransactionStateErrorCopyWith<TransactionStateError> get copyWith => _$TransactionStateErrorCopyWithImpl<TransactionStateError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TransactionStateError&&(identical(other.message, message) || other.message == message)&&const DeepCollectionEquality().equals(other._transactions, _transactions));
}


@override
int get hashCode => Object.hash(runtimeType,message,const DeepCollectionEquality().hash(_transactions));

@override
String toString() {
  return 'TransactionState.error(message: $message, transactions: $transactions)';
}


}

/// @nodoc
abstract mixin class $TransactionStateErrorCopyWith<$Res> implements $TransactionStateCopyWith<$Res> {
  factory $TransactionStateErrorCopyWith(TransactionStateError value, $Res Function(TransactionStateError) _then) = _$TransactionStateErrorCopyWithImpl;
@useResult
$Res call({
 String message, List<TransactionEntity> transactions
});




}
/// @nodoc
class _$TransactionStateErrorCopyWithImpl<$Res>
    implements $TransactionStateErrorCopyWith<$Res> {
  _$TransactionStateErrorCopyWithImpl(this._self, this._then);

  final TransactionStateError _self;
  final $Res Function(TransactionStateError) _then;

/// Create a copy of TransactionState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,Object? transactions = null,}) {
  return _then(TransactionStateError(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,transactions: null == transactions ? _self._transactions : transactions // ignore: cast_nullable_to_non_nullable
as List<TransactionEntity>,
  ));
}


}

// dart format on

// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'onboarding_state_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$OnboardingStateModel {

 double? get monthlyIncome; String get incomeFrequency; double? get firstExpenseAmount; String? get firstExpenseCategory; String? get firstExpenseDescription; int get currentStep; bool get isCompleted;
/// Create a copy of OnboardingStateModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OnboardingStateModelCopyWith<OnboardingStateModel> get copyWith => _$OnboardingStateModelCopyWithImpl<OnboardingStateModel>(this as OnboardingStateModel, _$identity);

  /// Serializes this OnboardingStateModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnboardingStateModel&&(identical(other.monthlyIncome, monthlyIncome) || other.monthlyIncome == monthlyIncome)&&(identical(other.incomeFrequency, incomeFrequency) || other.incomeFrequency == incomeFrequency)&&(identical(other.firstExpenseAmount, firstExpenseAmount) || other.firstExpenseAmount == firstExpenseAmount)&&(identical(other.firstExpenseCategory, firstExpenseCategory) || other.firstExpenseCategory == firstExpenseCategory)&&(identical(other.firstExpenseDescription, firstExpenseDescription) || other.firstExpenseDescription == firstExpenseDescription)&&(identical(other.currentStep, currentStep) || other.currentStep == currentStep)&&(identical(other.isCompleted, isCompleted) || other.isCompleted == isCompleted));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,monthlyIncome,incomeFrequency,firstExpenseAmount,firstExpenseCategory,firstExpenseDescription,currentStep,isCompleted);

@override
String toString() {
  return 'OnboardingStateModel(monthlyIncome: $monthlyIncome, incomeFrequency: $incomeFrequency, firstExpenseAmount: $firstExpenseAmount, firstExpenseCategory: $firstExpenseCategory, firstExpenseDescription: $firstExpenseDescription, currentStep: $currentStep, isCompleted: $isCompleted)';
}


}

/// @nodoc
abstract mixin class $OnboardingStateModelCopyWith<$Res>  {
  factory $OnboardingStateModelCopyWith(OnboardingStateModel value, $Res Function(OnboardingStateModel) _then) = _$OnboardingStateModelCopyWithImpl;
@useResult
$Res call({
 double? monthlyIncome, String incomeFrequency, double? firstExpenseAmount, String? firstExpenseCategory, String? firstExpenseDescription, int currentStep, bool isCompleted
});




}
/// @nodoc
class _$OnboardingStateModelCopyWithImpl<$Res>
    implements $OnboardingStateModelCopyWith<$Res> {
  _$OnboardingStateModelCopyWithImpl(this._self, this._then);

  final OnboardingStateModel _self;
  final $Res Function(OnboardingStateModel) _then;

/// Create a copy of OnboardingStateModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? monthlyIncome = freezed,Object? incomeFrequency = null,Object? firstExpenseAmount = freezed,Object? firstExpenseCategory = freezed,Object? firstExpenseDescription = freezed,Object? currentStep = null,Object? isCompleted = null,}) {
  return _then(_self.copyWith(
monthlyIncome: freezed == monthlyIncome ? _self.monthlyIncome : monthlyIncome // ignore: cast_nullable_to_non_nullable
as double?,incomeFrequency: null == incomeFrequency ? _self.incomeFrequency : incomeFrequency // ignore: cast_nullable_to_non_nullable
as String,firstExpenseAmount: freezed == firstExpenseAmount ? _self.firstExpenseAmount : firstExpenseAmount // ignore: cast_nullable_to_non_nullable
as double?,firstExpenseCategory: freezed == firstExpenseCategory ? _self.firstExpenseCategory : firstExpenseCategory // ignore: cast_nullable_to_non_nullable
as String?,firstExpenseDescription: freezed == firstExpenseDescription ? _self.firstExpenseDescription : firstExpenseDescription // ignore: cast_nullable_to_non_nullable
as String?,currentStep: null == currentStep ? _self.currentStep : currentStep // ignore: cast_nullable_to_non_nullable
as int,isCompleted: null == isCompleted ? _self.isCompleted : isCompleted // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [OnboardingStateModel].
extension OnboardingStateModelPatterns on OnboardingStateModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OnboardingStateModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OnboardingStateModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OnboardingStateModel value)  $default,){
final _that = this;
switch (_that) {
case _OnboardingStateModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OnboardingStateModel value)?  $default,){
final _that = this;
switch (_that) {
case _OnboardingStateModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double? monthlyIncome,  String incomeFrequency,  double? firstExpenseAmount,  String? firstExpenseCategory,  String? firstExpenseDescription,  int currentStep,  bool isCompleted)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OnboardingStateModel() when $default != null:
return $default(_that.monthlyIncome,_that.incomeFrequency,_that.firstExpenseAmount,_that.firstExpenseCategory,_that.firstExpenseDescription,_that.currentStep,_that.isCompleted);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double? monthlyIncome,  String incomeFrequency,  double? firstExpenseAmount,  String? firstExpenseCategory,  String? firstExpenseDescription,  int currentStep,  bool isCompleted)  $default,) {final _that = this;
switch (_that) {
case _OnboardingStateModel():
return $default(_that.monthlyIncome,_that.incomeFrequency,_that.firstExpenseAmount,_that.firstExpenseCategory,_that.firstExpenseDescription,_that.currentStep,_that.isCompleted);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double? monthlyIncome,  String incomeFrequency,  double? firstExpenseAmount,  String? firstExpenseCategory,  String? firstExpenseDescription,  int currentStep,  bool isCompleted)?  $default,) {final _that = this;
switch (_that) {
case _OnboardingStateModel() when $default != null:
return $default(_that.monthlyIncome,_that.incomeFrequency,_that.firstExpenseAmount,_that.firstExpenseCategory,_that.firstExpenseDescription,_that.currentStep,_that.isCompleted);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OnboardingStateModel implements OnboardingStateModel {
  const _OnboardingStateModel({required this.monthlyIncome, required this.incomeFrequency, required this.firstExpenseAmount, required this.firstExpenseCategory, required this.firstExpenseDescription, required this.currentStep, required this.isCompleted});
  factory _OnboardingStateModel.fromJson(Map<String, dynamic> json) => _$OnboardingStateModelFromJson(json);

@override final  double? monthlyIncome;
@override final  String incomeFrequency;
@override final  double? firstExpenseAmount;
@override final  String? firstExpenseCategory;
@override final  String? firstExpenseDescription;
@override final  int currentStep;
@override final  bool isCompleted;

/// Create a copy of OnboardingStateModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OnboardingStateModelCopyWith<_OnboardingStateModel> get copyWith => __$OnboardingStateModelCopyWithImpl<_OnboardingStateModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OnboardingStateModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OnboardingStateModel&&(identical(other.monthlyIncome, monthlyIncome) || other.monthlyIncome == monthlyIncome)&&(identical(other.incomeFrequency, incomeFrequency) || other.incomeFrequency == incomeFrequency)&&(identical(other.firstExpenseAmount, firstExpenseAmount) || other.firstExpenseAmount == firstExpenseAmount)&&(identical(other.firstExpenseCategory, firstExpenseCategory) || other.firstExpenseCategory == firstExpenseCategory)&&(identical(other.firstExpenseDescription, firstExpenseDescription) || other.firstExpenseDescription == firstExpenseDescription)&&(identical(other.currentStep, currentStep) || other.currentStep == currentStep)&&(identical(other.isCompleted, isCompleted) || other.isCompleted == isCompleted));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,monthlyIncome,incomeFrequency,firstExpenseAmount,firstExpenseCategory,firstExpenseDescription,currentStep,isCompleted);

@override
String toString() {
  return 'OnboardingStateModel(monthlyIncome: $monthlyIncome, incomeFrequency: $incomeFrequency, firstExpenseAmount: $firstExpenseAmount, firstExpenseCategory: $firstExpenseCategory, firstExpenseDescription: $firstExpenseDescription, currentStep: $currentStep, isCompleted: $isCompleted)';
}


}

/// @nodoc
abstract mixin class _$OnboardingStateModelCopyWith<$Res> implements $OnboardingStateModelCopyWith<$Res> {
  factory _$OnboardingStateModelCopyWith(_OnboardingStateModel value, $Res Function(_OnboardingStateModel) _then) = __$OnboardingStateModelCopyWithImpl;
@override @useResult
$Res call({
 double? monthlyIncome, String incomeFrequency, double? firstExpenseAmount, String? firstExpenseCategory, String? firstExpenseDescription, int currentStep, bool isCompleted
});




}
/// @nodoc
class __$OnboardingStateModelCopyWithImpl<$Res>
    implements _$OnboardingStateModelCopyWith<$Res> {
  __$OnboardingStateModelCopyWithImpl(this._self, this._then);

  final _OnboardingStateModel _self;
  final $Res Function(_OnboardingStateModel) _then;

/// Create a copy of OnboardingStateModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? monthlyIncome = freezed,Object? incomeFrequency = null,Object? firstExpenseAmount = freezed,Object? firstExpenseCategory = freezed,Object? firstExpenseDescription = freezed,Object? currentStep = null,Object? isCompleted = null,}) {
  return _then(_OnboardingStateModel(
monthlyIncome: freezed == monthlyIncome ? _self.monthlyIncome : monthlyIncome // ignore: cast_nullable_to_non_nullable
as double?,incomeFrequency: null == incomeFrequency ? _self.incomeFrequency : incomeFrequency // ignore: cast_nullable_to_non_nullable
as String,firstExpenseAmount: freezed == firstExpenseAmount ? _self.firstExpenseAmount : firstExpenseAmount // ignore: cast_nullable_to_non_nullable
as double?,firstExpenseCategory: freezed == firstExpenseCategory ? _self.firstExpenseCategory : firstExpenseCategory // ignore: cast_nullable_to_non_nullable
as String?,firstExpenseDescription: freezed == firstExpenseDescription ? _self.firstExpenseDescription : firstExpenseDescription // ignore: cast_nullable_to_non_nullable
as String?,currentStep: null == currentStep ? _self.currentStep : currentStep // ignore: cast_nullable_to_non_nullable
as int,isCompleted: null == isCompleted ? _self.isCompleted : isCompleted // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on

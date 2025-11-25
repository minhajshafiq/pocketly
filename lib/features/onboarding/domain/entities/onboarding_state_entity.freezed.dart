// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'onboarding_state_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$OnboardingStateEntity {

/// Revenu mensuel saisi par l'utilisateur
 double? get monthlyIncome;/// Fréquence du revenu
 IncomeFrequency get incomeFrequency;/// Montant de la première dépense
 double? get firstExpenseAmount;/// Catégorie de la première dépense
 ExpenseCategory? get firstExpenseCategory;/// Description de la première dépense
 String? get firstExpenseDescription;/// Étape actuelle de l'onboarding (1-4)
 int get currentStep;/// Indique si l'onboarding est complété
 bool get isCompleted;
/// Create a copy of OnboardingStateEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OnboardingStateEntityCopyWith<OnboardingStateEntity> get copyWith => _$OnboardingStateEntityCopyWithImpl<OnboardingStateEntity>(this as OnboardingStateEntity, _$identity);

  /// Serializes this OnboardingStateEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnboardingStateEntity&&(identical(other.monthlyIncome, monthlyIncome) || other.monthlyIncome == monthlyIncome)&&(identical(other.incomeFrequency, incomeFrequency) || other.incomeFrequency == incomeFrequency)&&(identical(other.firstExpenseAmount, firstExpenseAmount) || other.firstExpenseAmount == firstExpenseAmount)&&(identical(other.firstExpenseCategory, firstExpenseCategory) || other.firstExpenseCategory == firstExpenseCategory)&&(identical(other.firstExpenseDescription, firstExpenseDescription) || other.firstExpenseDescription == firstExpenseDescription)&&(identical(other.currentStep, currentStep) || other.currentStep == currentStep)&&(identical(other.isCompleted, isCompleted) || other.isCompleted == isCompleted));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,monthlyIncome,incomeFrequency,firstExpenseAmount,firstExpenseCategory,firstExpenseDescription,currentStep,isCompleted);

@override
String toString() {
  return 'OnboardingStateEntity(monthlyIncome: $monthlyIncome, incomeFrequency: $incomeFrequency, firstExpenseAmount: $firstExpenseAmount, firstExpenseCategory: $firstExpenseCategory, firstExpenseDescription: $firstExpenseDescription, currentStep: $currentStep, isCompleted: $isCompleted)';
}


}

/// @nodoc
abstract mixin class $OnboardingStateEntityCopyWith<$Res>  {
  factory $OnboardingStateEntityCopyWith(OnboardingStateEntity value, $Res Function(OnboardingStateEntity) _then) = _$OnboardingStateEntityCopyWithImpl;
@useResult
$Res call({
 double? monthlyIncome, IncomeFrequency incomeFrequency, double? firstExpenseAmount, ExpenseCategory? firstExpenseCategory, String? firstExpenseDescription, int currentStep, bool isCompleted
});




}
/// @nodoc
class _$OnboardingStateEntityCopyWithImpl<$Res>
    implements $OnboardingStateEntityCopyWith<$Res> {
  _$OnboardingStateEntityCopyWithImpl(this._self, this._then);

  final OnboardingStateEntity _self;
  final $Res Function(OnboardingStateEntity) _then;

/// Create a copy of OnboardingStateEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? monthlyIncome = freezed,Object? incomeFrequency = null,Object? firstExpenseAmount = freezed,Object? firstExpenseCategory = freezed,Object? firstExpenseDescription = freezed,Object? currentStep = null,Object? isCompleted = null,}) {
  return _then(_self.copyWith(
monthlyIncome: freezed == monthlyIncome ? _self.monthlyIncome : monthlyIncome // ignore: cast_nullable_to_non_nullable
as double?,incomeFrequency: null == incomeFrequency ? _self.incomeFrequency : incomeFrequency // ignore: cast_nullable_to_non_nullable
as IncomeFrequency,firstExpenseAmount: freezed == firstExpenseAmount ? _self.firstExpenseAmount : firstExpenseAmount // ignore: cast_nullable_to_non_nullable
as double?,firstExpenseCategory: freezed == firstExpenseCategory ? _self.firstExpenseCategory : firstExpenseCategory // ignore: cast_nullable_to_non_nullable
as ExpenseCategory?,firstExpenseDescription: freezed == firstExpenseDescription ? _self.firstExpenseDescription : firstExpenseDescription // ignore: cast_nullable_to_non_nullable
as String?,currentStep: null == currentStep ? _self.currentStep : currentStep // ignore: cast_nullable_to_non_nullable
as int,isCompleted: null == isCompleted ? _self.isCompleted : isCompleted // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [OnboardingStateEntity].
extension OnboardingStateEntityPatterns on OnboardingStateEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OnboardingStateEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OnboardingStateEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OnboardingStateEntity value)  $default,){
final _that = this;
switch (_that) {
case _OnboardingStateEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OnboardingStateEntity value)?  $default,){
final _that = this;
switch (_that) {
case _OnboardingStateEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double? monthlyIncome,  IncomeFrequency incomeFrequency,  double? firstExpenseAmount,  ExpenseCategory? firstExpenseCategory,  String? firstExpenseDescription,  int currentStep,  bool isCompleted)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OnboardingStateEntity() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double? monthlyIncome,  IncomeFrequency incomeFrequency,  double? firstExpenseAmount,  ExpenseCategory? firstExpenseCategory,  String? firstExpenseDescription,  int currentStep,  bool isCompleted)  $default,) {final _that = this;
switch (_that) {
case _OnboardingStateEntity():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double? monthlyIncome,  IncomeFrequency incomeFrequency,  double? firstExpenseAmount,  ExpenseCategory? firstExpenseCategory,  String? firstExpenseDescription,  int currentStep,  bool isCompleted)?  $default,) {final _that = this;
switch (_that) {
case _OnboardingStateEntity() when $default != null:
return $default(_that.monthlyIncome,_that.incomeFrequency,_that.firstExpenseAmount,_that.firstExpenseCategory,_that.firstExpenseDescription,_that.currentStep,_that.isCompleted);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OnboardingStateEntity implements OnboardingStateEntity {
  const _OnboardingStateEntity({this.monthlyIncome = null, this.incomeFrequency = IncomeFrequency.monthly, this.firstExpenseAmount = null, this.firstExpenseCategory = null, this.firstExpenseDescription = null, this.currentStep = 1, this.isCompleted = false});
  factory _OnboardingStateEntity.fromJson(Map<String, dynamic> json) => _$OnboardingStateEntityFromJson(json);

/// Revenu mensuel saisi par l'utilisateur
@override@JsonKey() final  double? monthlyIncome;
/// Fréquence du revenu
@override@JsonKey() final  IncomeFrequency incomeFrequency;
/// Montant de la première dépense
@override@JsonKey() final  double? firstExpenseAmount;
/// Catégorie de la première dépense
@override@JsonKey() final  ExpenseCategory? firstExpenseCategory;
/// Description de la première dépense
@override@JsonKey() final  String? firstExpenseDescription;
/// Étape actuelle de l'onboarding (1-4)
@override@JsonKey() final  int currentStep;
/// Indique si l'onboarding est complété
@override@JsonKey() final  bool isCompleted;

/// Create a copy of OnboardingStateEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OnboardingStateEntityCopyWith<_OnboardingStateEntity> get copyWith => __$OnboardingStateEntityCopyWithImpl<_OnboardingStateEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OnboardingStateEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OnboardingStateEntity&&(identical(other.monthlyIncome, monthlyIncome) || other.monthlyIncome == monthlyIncome)&&(identical(other.incomeFrequency, incomeFrequency) || other.incomeFrequency == incomeFrequency)&&(identical(other.firstExpenseAmount, firstExpenseAmount) || other.firstExpenseAmount == firstExpenseAmount)&&(identical(other.firstExpenseCategory, firstExpenseCategory) || other.firstExpenseCategory == firstExpenseCategory)&&(identical(other.firstExpenseDescription, firstExpenseDescription) || other.firstExpenseDescription == firstExpenseDescription)&&(identical(other.currentStep, currentStep) || other.currentStep == currentStep)&&(identical(other.isCompleted, isCompleted) || other.isCompleted == isCompleted));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,monthlyIncome,incomeFrequency,firstExpenseAmount,firstExpenseCategory,firstExpenseDescription,currentStep,isCompleted);

@override
String toString() {
  return 'OnboardingStateEntity(monthlyIncome: $monthlyIncome, incomeFrequency: $incomeFrequency, firstExpenseAmount: $firstExpenseAmount, firstExpenseCategory: $firstExpenseCategory, firstExpenseDescription: $firstExpenseDescription, currentStep: $currentStep, isCompleted: $isCompleted)';
}


}

/// @nodoc
abstract mixin class _$OnboardingStateEntityCopyWith<$Res> implements $OnboardingStateEntityCopyWith<$Res> {
  factory _$OnboardingStateEntityCopyWith(_OnboardingStateEntity value, $Res Function(_OnboardingStateEntity) _then) = __$OnboardingStateEntityCopyWithImpl;
@override @useResult
$Res call({
 double? monthlyIncome, IncomeFrequency incomeFrequency, double? firstExpenseAmount, ExpenseCategory? firstExpenseCategory, String? firstExpenseDescription, int currentStep, bool isCompleted
});




}
/// @nodoc
class __$OnboardingStateEntityCopyWithImpl<$Res>
    implements _$OnboardingStateEntityCopyWith<$Res> {
  __$OnboardingStateEntityCopyWithImpl(this._self, this._then);

  final _OnboardingStateEntity _self;
  final $Res Function(_OnboardingStateEntity) _then;

/// Create a copy of OnboardingStateEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? monthlyIncome = freezed,Object? incomeFrequency = null,Object? firstExpenseAmount = freezed,Object? firstExpenseCategory = freezed,Object? firstExpenseDescription = freezed,Object? currentStep = null,Object? isCompleted = null,}) {
  return _then(_OnboardingStateEntity(
monthlyIncome: freezed == monthlyIncome ? _self.monthlyIncome : monthlyIncome // ignore: cast_nullable_to_non_nullable
as double?,incomeFrequency: null == incomeFrequency ? _self.incomeFrequency : incomeFrequency // ignore: cast_nullable_to_non_nullable
as IncomeFrequency,firstExpenseAmount: freezed == firstExpenseAmount ? _self.firstExpenseAmount : firstExpenseAmount // ignore: cast_nullable_to_non_nullable
as double?,firstExpenseCategory: freezed == firstExpenseCategory ? _self.firstExpenseCategory : firstExpenseCategory // ignore: cast_nullable_to_non_nullable
as ExpenseCategory?,firstExpenseDescription: freezed == firstExpenseDescription ? _self.firstExpenseDescription : firstExpenseDescription // ignore: cast_nullable_to_non_nullable
as String?,currentStep: null == currentStep ? _self.currentStep : currentStep // ignore: cast_nullable_to_non_nullable
as int,isCompleted: null == isCompleted ? _self.isCompleted : isCompleted // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on

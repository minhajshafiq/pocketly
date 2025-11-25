// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pocket_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PocketModel {

 String? get id; String get name; String get icon; String get color; String get category; double get budget; double get spent;@JsonKey(name: 'saved_amount') double get savedAmount;@JsonKey(name: 'monthly_savings_amount') double? get monthlySavingsAmount;@JsonKey(name: 'savings_goal_type') String get savingsGoalType;@JsonKey(name: 'target_amount') double? get targetAmount;@JsonKey(name: 'target_date') DateTime? get targetDate;@JsonKey(name: 'user_id') String get userId;@JsonKey(name: 'is_active') bool get isActive;@JsonKey(name: 'is_default') bool get isDefault;@JsonKey(name: 'created_at') DateTime? get createdAt;@JsonKey(name: 'updated_at') DateTime? get updatedAt;
/// Create a copy of PocketModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PocketModelCopyWith<PocketModel> get copyWith => _$PocketModelCopyWithImpl<PocketModel>(this as PocketModel, _$identity);

  /// Serializes this PocketModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PocketModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.color, color) || other.color == color)&&(identical(other.category, category) || other.category == category)&&(identical(other.budget, budget) || other.budget == budget)&&(identical(other.spent, spent) || other.spent == spent)&&(identical(other.savedAmount, savedAmount) || other.savedAmount == savedAmount)&&(identical(other.monthlySavingsAmount, monthlySavingsAmount) || other.monthlySavingsAmount == monthlySavingsAmount)&&(identical(other.savingsGoalType, savingsGoalType) || other.savingsGoalType == savingsGoalType)&&(identical(other.targetAmount, targetAmount) || other.targetAmount == targetAmount)&&(identical(other.targetDate, targetDate) || other.targetDate == targetDate)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.isDefault, isDefault) || other.isDefault == isDefault)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,icon,color,category,budget,spent,savedAmount,monthlySavingsAmount,savingsGoalType,targetAmount,targetDate,userId,isActive,isDefault,createdAt,updatedAt);

@override
String toString() {
  return 'PocketModel(id: $id, name: $name, icon: $icon, color: $color, category: $category, budget: $budget, spent: $spent, savedAmount: $savedAmount, monthlySavingsAmount: $monthlySavingsAmount, savingsGoalType: $savingsGoalType, targetAmount: $targetAmount, targetDate: $targetDate, userId: $userId, isActive: $isActive, isDefault: $isDefault, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $PocketModelCopyWith<$Res>  {
  factory $PocketModelCopyWith(PocketModel value, $Res Function(PocketModel) _then) = _$PocketModelCopyWithImpl;
@useResult
$Res call({
 String? id, String name, String icon, String color, String category, double budget, double spent,@JsonKey(name: 'saved_amount') double savedAmount,@JsonKey(name: 'monthly_savings_amount') double? monthlySavingsAmount,@JsonKey(name: 'savings_goal_type') String savingsGoalType,@JsonKey(name: 'target_amount') double? targetAmount,@JsonKey(name: 'target_date') DateTime? targetDate,@JsonKey(name: 'user_id') String userId,@JsonKey(name: 'is_active') bool isActive,@JsonKey(name: 'is_default') bool isDefault,@JsonKey(name: 'created_at') DateTime? createdAt,@JsonKey(name: 'updated_at') DateTime? updatedAt
});




}
/// @nodoc
class _$PocketModelCopyWithImpl<$Res>
    implements $PocketModelCopyWith<$Res> {
  _$PocketModelCopyWithImpl(this._self, this._then);

  final PocketModel _self;
  final $Res Function(PocketModel) _then;

/// Create a copy of PocketModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? name = null,Object? icon = null,Object? color = null,Object? category = null,Object? budget = null,Object? spent = null,Object? savedAmount = null,Object? monthlySavingsAmount = freezed,Object? savingsGoalType = null,Object? targetAmount = freezed,Object? targetDate = freezed,Object? userId = null,Object? isActive = null,Object? isDefault = null,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,budget: null == budget ? _self.budget : budget // ignore: cast_nullable_to_non_nullable
as double,spent: null == spent ? _self.spent : spent // ignore: cast_nullable_to_non_nullable
as double,savedAmount: null == savedAmount ? _self.savedAmount : savedAmount // ignore: cast_nullable_to_non_nullable
as double,monthlySavingsAmount: freezed == monthlySavingsAmount ? _self.monthlySavingsAmount : monthlySavingsAmount // ignore: cast_nullable_to_non_nullable
as double?,savingsGoalType: null == savingsGoalType ? _self.savingsGoalType : savingsGoalType // ignore: cast_nullable_to_non_nullable
as String,targetAmount: freezed == targetAmount ? _self.targetAmount : targetAmount // ignore: cast_nullable_to_non_nullable
as double?,targetDate: freezed == targetDate ? _self.targetDate : targetDate // ignore: cast_nullable_to_non_nullable
as DateTime?,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,isDefault: null == isDefault ? _self.isDefault : isDefault // ignore: cast_nullable_to_non_nullable
as bool,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [PocketModel].
extension PocketModelPatterns on PocketModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PocketModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PocketModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PocketModel value)  $default,){
final _that = this;
switch (_that) {
case _PocketModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PocketModel value)?  $default,){
final _that = this;
switch (_that) {
case _PocketModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  String name,  String icon,  String color,  String category,  double budget,  double spent, @JsonKey(name: 'saved_amount')  double savedAmount, @JsonKey(name: 'monthly_savings_amount')  double? monthlySavingsAmount, @JsonKey(name: 'savings_goal_type')  String savingsGoalType, @JsonKey(name: 'target_amount')  double? targetAmount, @JsonKey(name: 'target_date')  DateTime? targetDate, @JsonKey(name: 'user_id')  String userId, @JsonKey(name: 'is_active')  bool isActive, @JsonKey(name: 'is_default')  bool isDefault, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'updated_at')  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PocketModel() when $default != null:
return $default(_that.id,_that.name,_that.icon,_that.color,_that.category,_that.budget,_that.spent,_that.savedAmount,_that.monthlySavingsAmount,_that.savingsGoalType,_that.targetAmount,_that.targetDate,_that.userId,_that.isActive,_that.isDefault,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  String name,  String icon,  String color,  String category,  double budget,  double spent, @JsonKey(name: 'saved_amount')  double savedAmount, @JsonKey(name: 'monthly_savings_amount')  double? monthlySavingsAmount, @JsonKey(name: 'savings_goal_type')  String savingsGoalType, @JsonKey(name: 'target_amount')  double? targetAmount, @JsonKey(name: 'target_date')  DateTime? targetDate, @JsonKey(name: 'user_id')  String userId, @JsonKey(name: 'is_active')  bool isActive, @JsonKey(name: 'is_default')  bool isDefault, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'updated_at')  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _PocketModel():
return $default(_that.id,_that.name,_that.icon,_that.color,_that.category,_that.budget,_that.spent,_that.savedAmount,_that.monthlySavingsAmount,_that.savingsGoalType,_that.targetAmount,_that.targetDate,_that.userId,_that.isActive,_that.isDefault,_that.createdAt,_that.updatedAt);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  String name,  String icon,  String color,  String category,  double budget,  double spent, @JsonKey(name: 'saved_amount')  double savedAmount, @JsonKey(name: 'monthly_savings_amount')  double? monthlySavingsAmount, @JsonKey(name: 'savings_goal_type')  String savingsGoalType, @JsonKey(name: 'target_amount')  double? targetAmount, @JsonKey(name: 'target_date')  DateTime? targetDate, @JsonKey(name: 'user_id')  String userId, @JsonKey(name: 'is_active')  bool isActive, @JsonKey(name: 'is_default')  bool isDefault, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'updated_at')  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _PocketModel() when $default != null:
return $default(_that.id,_that.name,_that.icon,_that.color,_that.category,_that.budget,_that.spent,_that.savedAmount,_that.monthlySavingsAmount,_that.savingsGoalType,_that.targetAmount,_that.targetDate,_that.userId,_that.isActive,_that.isDefault,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PocketModel implements PocketModel {
  const _PocketModel({this.id, required this.name, required this.icon, required this.color, required this.category, this.budget = 0.0, this.spent = 0.0, @JsonKey(name: 'saved_amount') this.savedAmount = 0.0, @JsonKey(name: 'monthly_savings_amount') this.monthlySavingsAmount, @JsonKey(name: 'savings_goal_type') this.savingsGoalType = 'none', @JsonKey(name: 'target_amount') this.targetAmount, @JsonKey(name: 'target_date') this.targetDate, @JsonKey(name: 'user_id') required this.userId, @JsonKey(name: 'is_active') this.isActive = true, @JsonKey(name: 'is_default') this.isDefault = false, @JsonKey(name: 'created_at') this.createdAt, @JsonKey(name: 'updated_at') this.updatedAt});
  factory _PocketModel.fromJson(Map<String, dynamic> json) => _$PocketModelFromJson(json);

@override final  String? id;
@override final  String name;
@override final  String icon;
@override final  String color;
@override final  String category;
@override@JsonKey() final  double budget;
@override@JsonKey() final  double spent;
@override@JsonKey(name: 'saved_amount') final  double savedAmount;
@override@JsonKey(name: 'monthly_savings_amount') final  double? monthlySavingsAmount;
@override@JsonKey(name: 'savings_goal_type') final  String savingsGoalType;
@override@JsonKey(name: 'target_amount') final  double? targetAmount;
@override@JsonKey(name: 'target_date') final  DateTime? targetDate;
@override@JsonKey(name: 'user_id') final  String userId;
@override@JsonKey(name: 'is_active') final  bool isActive;
@override@JsonKey(name: 'is_default') final  bool isDefault;
@override@JsonKey(name: 'created_at') final  DateTime? createdAt;
@override@JsonKey(name: 'updated_at') final  DateTime? updatedAt;

/// Create a copy of PocketModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PocketModelCopyWith<_PocketModel> get copyWith => __$PocketModelCopyWithImpl<_PocketModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PocketModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PocketModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.color, color) || other.color == color)&&(identical(other.category, category) || other.category == category)&&(identical(other.budget, budget) || other.budget == budget)&&(identical(other.spent, spent) || other.spent == spent)&&(identical(other.savedAmount, savedAmount) || other.savedAmount == savedAmount)&&(identical(other.monthlySavingsAmount, monthlySavingsAmount) || other.monthlySavingsAmount == monthlySavingsAmount)&&(identical(other.savingsGoalType, savingsGoalType) || other.savingsGoalType == savingsGoalType)&&(identical(other.targetAmount, targetAmount) || other.targetAmount == targetAmount)&&(identical(other.targetDate, targetDate) || other.targetDate == targetDate)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.isDefault, isDefault) || other.isDefault == isDefault)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,icon,color,category,budget,spent,savedAmount,monthlySavingsAmount,savingsGoalType,targetAmount,targetDate,userId,isActive,isDefault,createdAt,updatedAt);

@override
String toString() {
  return 'PocketModel(id: $id, name: $name, icon: $icon, color: $color, category: $category, budget: $budget, spent: $spent, savedAmount: $savedAmount, monthlySavingsAmount: $monthlySavingsAmount, savingsGoalType: $savingsGoalType, targetAmount: $targetAmount, targetDate: $targetDate, userId: $userId, isActive: $isActive, isDefault: $isDefault, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$PocketModelCopyWith<$Res> implements $PocketModelCopyWith<$Res> {
  factory _$PocketModelCopyWith(_PocketModel value, $Res Function(_PocketModel) _then) = __$PocketModelCopyWithImpl;
@override @useResult
$Res call({
 String? id, String name, String icon, String color, String category, double budget, double spent,@JsonKey(name: 'saved_amount') double savedAmount,@JsonKey(name: 'monthly_savings_amount') double? monthlySavingsAmount,@JsonKey(name: 'savings_goal_type') String savingsGoalType,@JsonKey(name: 'target_amount') double? targetAmount,@JsonKey(name: 'target_date') DateTime? targetDate,@JsonKey(name: 'user_id') String userId,@JsonKey(name: 'is_active') bool isActive,@JsonKey(name: 'is_default') bool isDefault,@JsonKey(name: 'created_at') DateTime? createdAt,@JsonKey(name: 'updated_at') DateTime? updatedAt
});




}
/// @nodoc
class __$PocketModelCopyWithImpl<$Res>
    implements _$PocketModelCopyWith<$Res> {
  __$PocketModelCopyWithImpl(this._self, this._then);

  final _PocketModel _self;
  final $Res Function(_PocketModel) _then;

/// Create a copy of PocketModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? name = null,Object? icon = null,Object? color = null,Object? category = null,Object? budget = null,Object? spent = null,Object? savedAmount = null,Object? monthlySavingsAmount = freezed,Object? savingsGoalType = null,Object? targetAmount = freezed,Object? targetDate = freezed,Object? userId = null,Object? isActive = null,Object? isDefault = null,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_PocketModel(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,budget: null == budget ? _self.budget : budget // ignore: cast_nullable_to_non_nullable
as double,spent: null == spent ? _self.spent : spent // ignore: cast_nullable_to_non_nullable
as double,savedAmount: null == savedAmount ? _self.savedAmount : savedAmount // ignore: cast_nullable_to_non_nullable
as double,monthlySavingsAmount: freezed == monthlySavingsAmount ? _self.monthlySavingsAmount : monthlySavingsAmount // ignore: cast_nullable_to_non_nullable
as double?,savingsGoalType: null == savingsGoalType ? _self.savingsGoalType : savingsGoalType // ignore: cast_nullable_to_non_nullable
as String,targetAmount: freezed == targetAmount ? _self.targetAmount : targetAmount // ignore: cast_nullable_to_non_nullable
as double?,targetDate: freezed == targetDate ? _self.targetDate : targetDate // ignore: cast_nullable_to_non_nullable
as DateTime?,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,isDefault: null == isDefault ? _self.isDefault : isDefault // ignore: cast_nullable_to_non_nullable
as bool,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on

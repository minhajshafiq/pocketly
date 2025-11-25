// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pocket_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PocketEntity {

/// Identifiant unique
 String? get id;/// Nom du pocket
 String get name;/// Icône (nom Material Design)
 String get icon;/// Couleur hexadécimale
 String get color;/// Catégorie du pocket
 PocketCategory get category;// ==================== BUDGETS (needs & wants) ====================
/// Budget alloué (needs/wants uniquement)
 double get budget;/// Montant dépensé (needs/wants uniquement)
 double get spent;// ==================== ÉPARGNE (savings) ====================
/// Montant épargné actuel (savings uniquement)
 double get savedAmount;/// Montant d'épargne mensuelle automatique (savings uniquement)
 double? get monthlySavingsAmount;// ==================== OBJECTIFS D'ÉPARGNE ====================
/// Type d'objectif d'épargne
 SavingsGoalType get savingsGoalType;/// Montant cible de l'objectif
 double? get targetAmount;/// Date cible de l'objectif
 DateTime? get targetDate;// ==================== MÉTADONNÉES ====================
/// Identifiant de l'utilisateur
 String get userId;/// Le pocket est-il actif ?
 bool get isActive;/// Le pocket est-il par défaut ?
 bool get isDefault;/// Date de création
 DateTime? get createdAt;/// Date de dernière mise à jour
 DateTime? get updatedAt;
/// Create a copy of PocketEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PocketEntityCopyWith<PocketEntity> get copyWith => _$PocketEntityCopyWithImpl<PocketEntity>(this as PocketEntity, _$identity);

  /// Serializes this PocketEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PocketEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.color, color) || other.color == color)&&(identical(other.category, category) || other.category == category)&&(identical(other.budget, budget) || other.budget == budget)&&(identical(other.spent, spent) || other.spent == spent)&&(identical(other.savedAmount, savedAmount) || other.savedAmount == savedAmount)&&(identical(other.monthlySavingsAmount, monthlySavingsAmount) || other.monthlySavingsAmount == monthlySavingsAmount)&&(identical(other.savingsGoalType, savingsGoalType) || other.savingsGoalType == savingsGoalType)&&(identical(other.targetAmount, targetAmount) || other.targetAmount == targetAmount)&&(identical(other.targetDate, targetDate) || other.targetDate == targetDate)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.isDefault, isDefault) || other.isDefault == isDefault)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,icon,color,category,budget,spent,savedAmount,monthlySavingsAmount,savingsGoalType,targetAmount,targetDate,userId,isActive,isDefault,createdAt,updatedAt);

@override
String toString() {
  return 'PocketEntity(id: $id, name: $name, icon: $icon, color: $color, category: $category, budget: $budget, spent: $spent, savedAmount: $savedAmount, monthlySavingsAmount: $monthlySavingsAmount, savingsGoalType: $savingsGoalType, targetAmount: $targetAmount, targetDate: $targetDate, userId: $userId, isActive: $isActive, isDefault: $isDefault, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $PocketEntityCopyWith<$Res>  {
  factory $PocketEntityCopyWith(PocketEntity value, $Res Function(PocketEntity) _then) = _$PocketEntityCopyWithImpl;
@useResult
$Res call({
 String? id, String name, String icon, String color, PocketCategory category, double budget, double spent, double savedAmount, double? monthlySavingsAmount, SavingsGoalType savingsGoalType, double? targetAmount, DateTime? targetDate, String userId, bool isActive, bool isDefault, DateTime? createdAt, DateTime? updatedAt
});




}
/// @nodoc
class _$PocketEntityCopyWithImpl<$Res>
    implements $PocketEntityCopyWith<$Res> {
  _$PocketEntityCopyWithImpl(this._self, this._then);

  final PocketEntity _self;
  final $Res Function(PocketEntity) _then;

/// Create a copy of PocketEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? name = null,Object? icon = null,Object? color = null,Object? category = null,Object? budget = null,Object? spent = null,Object? savedAmount = null,Object? monthlySavingsAmount = freezed,Object? savingsGoalType = null,Object? targetAmount = freezed,Object? targetDate = freezed,Object? userId = null,Object? isActive = null,Object? isDefault = null,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as PocketCategory,budget: null == budget ? _self.budget : budget // ignore: cast_nullable_to_non_nullable
as double,spent: null == spent ? _self.spent : spent // ignore: cast_nullable_to_non_nullable
as double,savedAmount: null == savedAmount ? _self.savedAmount : savedAmount // ignore: cast_nullable_to_non_nullable
as double,monthlySavingsAmount: freezed == monthlySavingsAmount ? _self.monthlySavingsAmount : monthlySavingsAmount // ignore: cast_nullable_to_non_nullable
as double?,savingsGoalType: null == savingsGoalType ? _self.savingsGoalType : savingsGoalType // ignore: cast_nullable_to_non_nullable
as SavingsGoalType,targetAmount: freezed == targetAmount ? _self.targetAmount : targetAmount // ignore: cast_nullable_to_non_nullable
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


/// Adds pattern-matching-related methods to [PocketEntity].
extension PocketEntityPatterns on PocketEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PocketEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PocketEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PocketEntity value)  $default,){
final _that = this;
switch (_that) {
case _PocketEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PocketEntity value)?  $default,){
final _that = this;
switch (_that) {
case _PocketEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  String name,  String icon,  String color,  PocketCategory category,  double budget,  double spent,  double savedAmount,  double? monthlySavingsAmount,  SavingsGoalType savingsGoalType,  double? targetAmount,  DateTime? targetDate,  String userId,  bool isActive,  bool isDefault,  DateTime? createdAt,  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PocketEntity() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  String name,  String icon,  String color,  PocketCategory category,  double budget,  double spent,  double savedAmount,  double? monthlySavingsAmount,  SavingsGoalType savingsGoalType,  double? targetAmount,  DateTime? targetDate,  String userId,  bool isActive,  bool isDefault,  DateTime? createdAt,  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _PocketEntity():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  String name,  String icon,  String color,  PocketCategory category,  double budget,  double spent,  double savedAmount,  double? monthlySavingsAmount,  SavingsGoalType savingsGoalType,  double? targetAmount,  DateTime? targetDate,  String userId,  bool isActive,  bool isDefault,  DateTime? createdAt,  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _PocketEntity() when $default != null:
return $default(_that.id,_that.name,_that.icon,_that.color,_that.category,_that.budget,_that.spent,_that.savedAmount,_that.monthlySavingsAmount,_that.savingsGoalType,_that.targetAmount,_that.targetDate,_that.userId,_that.isActive,_that.isDefault,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PocketEntity extends PocketEntity {
  const _PocketEntity({this.id, required this.name, required this.icon, required this.color, required this.category, this.budget = 0.0, this.spent = 0.0, this.savedAmount = 0.0, this.monthlySavingsAmount, this.savingsGoalType = SavingsGoalType.none, this.targetAmount, this.targetDate, required this.userId, this.isActive = true, this.isDefault = false, this.createdAt, this.updatedAt}): super._();
  factory _PocketEntity.fromJson(Map<String, dynamic> json) => _$PocketEntityFromJson(json);

/// Identifiant unique
@override final  String? id;
/// Nom du pocket
@override final  String name;
/// Icône (nom Material Design)
@override final  String icon;
/// Couleur hexadécimale
@override final  String color;
/// Catégorie du pocket
@override final  PocketCategory category;
// ==================== BUDGETS (needs & wants) ====================
/// Budget alloué (needs/wants uniquement)
@override@JsonKey() final  double budget;
/// Montant dépensé (needs/wants uniquement)
@override@JsonKey() final  double spent;
// ==================== ÉPARGNE (savings) ====================
/// Montant épargné actuel (savings uniquement)
@override@JsonKey() final  double savedAmount;
/// Montant d'épargne mensuelle automatique (savings uniquement)
@override final  double? monthlySavingsAmount;
// ==================== OBJECTIFS D'ÉPARGNE ====================
/// Type d'objectif d'épargne
@override@JsonKey() final  SavingsGoalType savingsGoalType;
/// Montant cible de l'objectif
@override final  double? targetAmount;
/// Date cible de l'objectif
@override final  DateTime? targetDate;
// ==================== MÉTADONNÉES ====================
/// Identifiant de l'utilisateur
@override final  String userId;
/// Le pocket est-il actif ?
@override@JsonKey() final  bool isActive;
/// Le pocket est-il par défaut ?
@override@JsonKey() final  bool isDefault;
/// Date de création
@override final  DateTime? createdAt;
/// Date de dernière mise à jour
@override final  DateTime? updatedAt;

/// Create a copy of PocketEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PocketEntityCopyWith<_PocketEntity> get copyWith => __$PocketEntityCopyWithImpl<_PocketEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PocketEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PocketEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.color, color) || other.color == color)&&(identical(other.category, category) || other.category == category)&&(identical(other.budget, budget) || other.budget == budget)&&(identical(other.spent, spent) || other.spent == spent)&&(identical(other.savedAmount, savedAmount) || other.savedAmount == savedAmount)&&(identical(other.monthlySavingsAmount, monthlySavingsAmount) || other.monthlySavingsAmount == monthlySavingsAmount)&&(identical(other.savingsGoalType, savingsGoalType) || other.savingsGoalType == savingsGoalType)&&(identical(other.targetAmount, targetAmount) || other.targetAmount == targetAmount)&&(identical(other.targetDate, targetDate) || other.targetDate == targetDate)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.isDefault, isDefault) || other.isDefault == isDefault)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,icon,color,category,budget,spent,savedAmount,monthlySavingsAmount,savingsGoalType,targetAmount,targetDate,userId,isActive,isDefault,createdAt,updatedAt);

@override
String toString() {
  return 'PocketEntity(id: $id, name: $name, icon: $icon, color: $color, category: $category, budget: $budget, spent: $spent, savedAmount: $savedAmount, monthlySavingsAmount: $monthlySavingsAmount, savingsGoalType: $savingsGoalType, targetAmount: $targetAmount, targetDate: $targetDate, userId: $userId, isActive: $isActive, isDefault: $isDefault, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$PocketEntityCopyWith<$Res> implements $PocketEntityCopyWith<$Res> {
  factory _$PocketEntityCopyWith(_PocketEntity value, $Res Function(_PocketEntity) _then) = __$PocketEntityCopyWithImpl;
@override @useResult
$Res call({
 String? id, String name, String icon, String color, PocketCategory category, double budget, double spent, double savedAmount, double? monthlySavingsAmount, SavingsGoalType savingsGoalType, double? targetAmount, DateTime? targetDate, String userId, bool isActive, bool isDefault, DateTime? createdAt, DateTime? updatedAt
});




}
/// @nodoc
class __$PocketEntityCopyWithImpl<$Res>
    implements _$PocketEntityCopyWith<$Res> {
  __$PocketEntityCopyWithImpl(this._self, this._then);

  final _PocketEntity _self;
  final $Res Function(_PocketEntity) _then;

/// Create a copy of PocketEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? name = null,Object? icon = null,Object? color = null,Object? category = null,Object? budget = null,Object? spent = null,Object? savedAmount = null,Object? monthlySavingsAmount = freezed,Object? savingsGoalType = null,Object? targetAmount = freezed,Object? targetDate = freezed,Object? userId = null,Object? isActive = null,Object? isDefault = null,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_PocketEntity(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as PocketCategory,budget: null == budget ? _self.budget : budget // ignore: cast_nullable_to_non_nullable
as double,spent: null == spent ? _self.spent : spent // ignore: cast_nullable_to_non_nullable
as double,savedAmount: null == savedAmount ? _self.savedAmount : savedAmount // ignore: cast_nullable_to_non_nullable
as double,monthlySavingsAmount: freezed == monthlySavingsAmount ? _self.monthlySavingsAmount : monthlySavingsAmount // ignore: cast_nullable_to_non_nullable
as double?,savingsGoalType: null == savingsGoalType ? _self.savingsGoalType : savingsGoalType // ignore: cast_nullable_to_non_nullable
as SavingsGoalType,targetAmount: freezed == targetAmount ? _self.targetAmount : targetAmount // ignore: cast_nullable_to_non_nullable
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

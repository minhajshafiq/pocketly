// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserModel {

 String get id; String get email; String? get name;@JsonKey(name: 'avatar_url') String? get avatarUrl;@JsonKey(name: 'is_premium') bool get isPremium;@JsonKey(name: 'premium_expires_at') DateTime? get premiumExpiresAt;@JsonKey(name: 'premium_trial_start') DateTime? get premiumTrialStart;@JsonKey(name: 'premium_trial_end') DateTime? get premiumTrialEnd;@JsonKey(name: 'active_subscription_type') String? get activeSubscriptionType;@JsonKey(name: 'has_completed_onboarding') bool get hasCompletedOnboarding;@JsonKey(name: 'notifications_enabled') bool get notificationsEnabled;@JsonKey(name: 'push_token') String? get pushToken;@JsonKey(name: 'app_version') String? get appVersion;@JsonKey(name: 'marketing_consent') bool get marketingConsent;@JsonKey(name: 'budget_rule_needs') int get budgetRuleNeeds;@JsonKey(name: 'budget_rule_wants') int get budgetRuleWants;@JsonKey(name: 'budget_rule_savings') int get budgetRuleSavings;@JsonKey(name: 'created_at') DateTime? get createdAt;@JsonKey(name: 'updated_at') DateTime? get updatedAt; String get role;
/// Create a copy of UserModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserModelCopyWith<UserModel> get copyWith => _$UserModelCopyWithImpl<UserModel>(this as UserModel, _$identity);

  /// Serializes this UserModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserModel&&(identical(other.id, id) || other.id == id)&&(identical(other.email, email) || other.email == email)&&(identical(other.name, name) || other.name == name)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.isPremium, isPremium) || other.isPremium == isPremium)&&(identical(other.premiumExpiresAt, premiumExpiresAt) || other.premiumExpiresAt == premiumExpiresAt)&&(identical(other.premiumTrialStart, premiumTrialStart) || other.premiumTrialStart == premiumTrialStart)&&(identical(other.premiumTrialEnd, premiumTrialEnd) || other.premiumTrialEnd == premiumTrialEnd)&&(identical(other.activeSubscriptionType, activeSubscriptionType) || other.activeSubscriptionType == activeSubscriptionType)&&(identical(other.hasCompletedOnboarding, hasCompletedOnboarding) || other.hasCompletedOnboarding == hasCompletedOnboarding)&&(identical(other.notificationsEnabled, notificationsEnabled) || other.notificationsEnabled == notificationsEnabled)&&(identical(other.pushToken, pushToken) || other.pushToken == pushToken)&&(identical(other.appVersion, appVersion) || other.appVersion == appVersion)&&(identical(other.marketingConsent, marketingConsent) || other.marketingConsent == marketingConsent)&&(identical(other.budgetRuleNeeds, budgetRuleNeeds) || other.budgetRuleNeeds == budgetRuleNeeds)&&(identical(other.budgetRuleWants, budgetRuleWants) || other.budgetRuleWants == budgetRuleWants)&&(identical(other.budgetRuleSavings, budgetRuleSavings) || other.budgetRuleSavings == budgetRuleSavings)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.role, role) || other.role == role));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,email,name,avatarUrl,isPremium,premiumExpiresAt,premiumTrialStart,premiumTrialEnd,activeSubscriptionType,hasCompletedOnboarding,notificationsEnabled,pushToken,appVersion,marketingConsent,budgetRuleNeeds,budgetRuleWants,budgetRuleSavings,createdAt,updatedAt,role]);

@override
String toString() {
  return 'UserModel(id: $id, email: $email, name: $name, avatarUrl: $avatarUrl, isPremium: $isPremium, premiumExpiresAt: $premiumExpiresAt, premiumTrialStart: $premiumTrialStart, premiumTrialEnd: $premiumTrialEnd, activeSubscriptionType: $activeSubscriptionType, hasCompletedOnboarding: $hasCompletedOnboarding, notificationsEnabled: $notificationsEnabled, pushToken: $pushToken, appVersion: $appVersion, marketingConsent: $marketingConsent, budgetRuleNeeds: $budgetRuleNeeds, budgetRuleWants: $budgetRuleWants, budgetRuleSavings: $budgetRuleSavings, createdAt: $createdAt, updatedAt: $updatedAt, role: $role)';
}


}

/// @nodoc
abstract mixin class $UserModelCopyWith<$Res>  {
  factory $UserModelCopyWith(UserModel value, $Res Function(UserModel) _then) = _$UserModelCopyWithImpl;
@useResult
$Res call({
 String id, String email, String? name,@JsonKey(name: 'avatar_url') String? avatarUrl,@JsonKey(name: 'is_premium') bool isPremium,@JsonKey(name: 'premium_expires_at') DateTime? premiumExpiresAt,@JsonKey(name: 'premium_trial_start') DateTime? premiumTrialStart,@JsonKey(name: 'premium_trial_end') DateTime? premiumTrialEnd,@JsonKey(name: 'active_subscription_type') String? activeSubscriptionType,@JsonKey(name: 'has_completed_onboarding') bool hasCompletedOnboarding,@JsonKey(name: 'notifications_enabled') bool notificationsEnabled,@JsonKey(name: 'push_token') String? pushToken,@JsonKey(name: 'app_version') String? appVersion,@JsonKey(name: 'marketing_consent') bool marketingConsent,@JsonKey(name: 'budget_rule_needs') int budgetRuleNeeds,@JsonKey(name: 'budget_rule_wants') int budgetRuleWants,@JsonKey(name: 'budget_rule_savings') int budgetRuleSavings,@JsonKey(name: 'created_at') DateTime? createdAt,@JsonKey(name: 'updated_at') DateTime? updatedAt, String role
});




}
/// @nodoc
class _$UserModelCopyWithImpl<$Res>
    implements $UserModelCopyWith<$Res> {
  _$UserModelCopyWithImpl(this._self, this._then);

  final UserModel _self;
  final $Res Function(UserModel) _then;

/// Create a copy of UserModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? email = null,Object? name = freezed,Object? avatarUrl = freezed,Object? isPremium = null,Object? premiumExpiresAt = freezed,Object? premiumTrialStart = freezed,Object? premiumTrialEnd = freezed,Object? activeSubscriptionType = freezed,Object? hasCompletedOnboarding = null,Object? notificationsEnabled = null,Object? pushToken = freezed,Object? appVersion = freezed,Object? marketingConsent = null,Object? budgetRuleNeeds = null,Object? budgetRuleWants = null,Object? budgetRuleSavings = null,Object? createdAt = freezed,Object? updatedAt = freezed,Object? role = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,isPremium: null == isPremium ? _self.isPremium : isPremium // ignore: cast_nullable_to_non_nullable
as bool,premiumExpiresAt: freezed == premiumExpiresAt ? _self.premiumExpiresAt : premiumExpiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,premiumTrialStart: freezed == premiumTrialStart ? _self.premiumTrialStart : premiumTrialStart // ignore: cast_nullable_to_non_nullable
as DateTime?,premiumTrialEnd: freezed == premiumTrialEnd ? _self.premiumTrialEnd : premiumTrialEnd // ignore: cast_nullable_to_non_nullable
as DateTime?,activeSubscriptionType: freezed == activeSubscriptionType ? _self.activeSubscriptionType : activeSubscriptionType // ignore: cast_nullable_to_non_nullable
as String?,hasCompletedOnboarding: null == hasCompletedOnboarding ? _self.hasCompletedOnboarding : hasCompletedOnboarding // ignore: cast_nullable_to_non_nullable
as bool,notificationsEnabled: null == notificationsEnabled ? _self.notificationsEnabled : notificationsEnabled // ignore: cast_nullable_to_non_nullable
as bool,pushToken: freezed == pushToken ? _self.pushToken : pushToken // ignore: cast_nullable_to_non_nullable
as String?,appVersion: freezed == appVersion ? _self.appVersion : appVersion // ignore: cast_nullable_to_non_nullable
as String?,marketingConsent: null == marketingConsent ? _self.marketingConsent : marketingConsent // ignore: cast_nullable_to_non_nullable
as bool,budgetRuleNeeds: null == budgetRuleNeeds ? _self.budgetRuleNeeds : budgetRuleNeeds // ignore: cast_nullable_to_non_nullable
as int,budgetRuleWants: null == budgetRuleWants ? _self.budgetRuleWants : budgetRuleWants // ignore: cast_nullable_to_non_nullable
as int,budgetRuleSavings: null == budgetRuleSavings ? _self.budgetRuleSavings : budgetRuleSavings // ignore: cast_nullable_to_non_nullable
as int,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [UserModel].
extension UserModelPatterns on UserModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserModel value)  $default,){
final _that = this;
switch (_that) {
case _UserModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserModel value)?  $default,){
final _that = this;
switch (_that) {
case _UserModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String email,  String? name, @JsonKey(name: 'avatar_url')  String? avatarUrl, @JsonKey(name: 'is_premium')  bool isPremium, @JsonKey(name: 'premium_expires_at')  DateTime? premiumExpiresAt, @JsonKey(name: 'premium_trial_start')  DateTime? premiumTrialStart, @JsonKey(name: 'premium_trial_end')  DateTime? premiumTrialEnd, @JsonKey(name: 'active_subscription_type')  String? activeSubscriptionType, @JsonKey(name: 'has_completed_onboarding')  bool hasCompletedOnboarding, @JsonKey(name: 'notifications_enabled')  bool notificationsEnabled, @JsonKey(name: 'push_token')  String? pushToken, @JsonKey(name: 'app_version')  String? appVersion, @JsonKey(name: 'marketing_consent')  bool marketingConsent, @JsonKey(name: 'budget_rule_needs')  int budgetRuleNeeds, @JsonKey(name: 'budget_rule_wants')  int budgetRuleWants, @JsonKey(name: 'budget_rule_savings')  int budgetRuleSavings, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'updated_at')  DateTime? updatedAt,  String role)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserModel() when $default != null:
return $default(_that.id,_that.email,_that.name,_that.avatarUrl,_that.isPremium,_that.premiumExpiresAt,_that.premiumTrialStart,_that.premiumTrialEnd,_that.activeSubscriptionType,_that.hasCompletedOnboarding,_that.notificationsEnabled,_that.pushToken,_that.appVersion,_that.marketingConsent,_that.budgetRuleNeeds,_that.budgetRuleWants,_that.budgetRuleSavings,_that.createdAt,_that.updatedAt,_that.role);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String email,  String? name, @JsonKey(name: 'avatar_url')  String? avatarUrl, @JsonKey(name: 'is_premium')  bool isPremium, @JsonKey(name: 'premium_expires_at')  DateTime? premiumExpiresAt, @JsonKey(name: 'premium_trial_start')  DateTime? premiumTrialStart, @JsonKey(name: 'premium_trial_end')  DateTime? premiumTrialEnd, @JsonKey(name: 'active_subscription_type')  String? activeSubscriptionType, @JsonKey(name: 'has_completed_onboarding')  bool hasCompletedOnboarding, @JsonKey(name: 'notifications_enabled')  bool notificationsEnabled, @JsonKey(name: 'push_token')  String? pushToken, @JsonKey(name: 'app_version')  String? appVersion, @JsonKey(name: 'marketing_consent')  bool marketingConsent, @JsonKey(name: 'budget_rule_needs')  int budgetRuleNeeds, @JsonKey(name: 'budget_rule_wants')  int budgetRuleWants, @JsonKey(name: 'budget_rule_savings')  int budgetRuleSavings, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'updated_at')  DateTime? updatedAt,  String role)  $default,) {final _that = this;
switch (_that) {
case _UserModel():
return $default(_that.id,_that.email,_that.name,_that.avatarUrl,_that.isPremium,_that.premiumExpiresAt,_that.premiumTrialStart,_that.premiumTrialEnd,_that.activeSubscriptionType,_that.hasCompletedOnboarding,_that.notificationsEnabled,_that.pushToken,_that.appVersion,_that.marketingConsent,_that.budgetRuleNeeds,_that.budgetRuleWants,_that.budgetRuleSavings,_that.createdAt,_that.updatedAt,_that.role);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String email,  String? name, @JsonKey(name: 'avatar_url')  String? avatarUrl, @JsonKey(name: 'is_premium')  bool isPremium, @JsonKey(name: 'premium_expires_at')  DateTime? premiumExpiresAt, @JsonKey(name: 'premium_trial_start')  DateTime? premiumTrialStart, @JsonKey(name: 'premium_trial_end')  DateTime? premiumTrialEnd, @JsonKey(name: 'active_subscription_type')  String? activeSubscriptionType, @JsonKey(name: 'has_completed_onboarding')  bool hasCompletedOnboarding, @JsonKey(name: 'notifications_enabled')  bool notificationsEnabled, @JsonKey(name: 'push_token')  String? pushToken, @JsonKey(name: 'app_version')  String? appVersion, @JsonKey(name: 'marketing_consent')  bool marketingConsent, @JsonKey(name: 'budget_rule_needs')  int budgetRuleNeeds, @JsonKey(name: 'budget_rule_wants')  int budgetRuleWants, @JsonKey(name: 'budget_rule_savings')  int budgetRuleSavings, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'updated_at')  DateTime? updatedAt,  String role)?  $default,) {final _that = this;
switch (_that) {
case _UserModel() when $default != null:
return $default(_that.id,_that.email,_that.name,_that.avatarUrl,_that.isPremium,_that.premiumExpiresAt,_that.premiumTrialStart,_that.premiumTrialEnd,_that.activeSubscriptionType,_that.hasCompletedOnboarding,_that.notificationsEnabled,_that.pushToken,_that.appVersion,_that.marketingConsent,_that.budgetRuleNeeds,_that.budgetRuleWants,_that.budgetRuleSavings,_that.createdAt,_that.updatedAt,_that.role);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserModel implements UserModel {
  const _UserModel({required this.id, required this.email, this.name, @JsonKey(name: 'avatar_url') this.avatarUrl, @JsonKey(name: 'is_premium') this.isPremium = false, @JsonKey(name: 'premium_expires_at') this.premiumExpiresAt, @JsonKey(name: 'premium_trial_start') this.premiumTrialStart, @JsonKey(name: 'premium_trial_end') this.premiumTrialEnd, @JsonKey(name: 'active_subscription_type') this.activeSubscriptionType, @JsonKey(name: 'has_completed_onboarding') this.hasCompletedOnboarding = false, @JsonKey(name: 'notifications_enabled') this.notificationsEnabled = true, @JsonKey(name: 'push_token') this.pushToken, @JsonKey(name: 'app_version') this.appVersion, @JsonKey(name: 'marketing_consent') this.marketingConsent = false, @JsonKey(name: 'budget_rule_needs') this.budgetRuleNeeds = 50, @JsonKey(name: 'budget_rule_wants') this.budgetRuleWants = 30, @JsonKey(name: 'budget_rule_savings') this.budgetRuleSavings = 20, @JsonKey(name: 'created_at') this.createdAt, @JsonKey(name: 'updated_at') this.updatedAt, this.role = 'user'});
  factory _UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

@override final  String id;
@override final  String email;
@override final  String? name;
@override@JsonKey(name: 'avatar_url') final  String? avatarUrl;
@override@JsonKey(name: 'is_premium') final  bool isPremium;
@override@JsonKey(name: 'premium_expires_at') final  DateTime? premiumExpiresAt;
@override@JsonKey(name: 'premium_trial_start') final  DateTime? premiumTrialStart;
@override@JsonKey(name: 'premium_trial_end') final  DateTime? premiumTrialEnd;
@override@JsonKey(name: 'active_subscription_type') final  String? activeSubscriptionType;
@override@JsonKey(name: 'has_completed_onboarding') final  bool hasCompletedOnboarding;
@override@JsonKey(name: 'notifications_enabled') final  bool notificationsEnabled;
@override@JsonKey(name: 'push_token') final  String? pushToken;
@override@JsonKey(name: 'app_version') final  String? appVersion;
@override@JsonKey(name: 'marketing_consent') final  bool marketingConsent;
@override@JsonKey(name: 'budget_rule_needs') final  int budgetRuleNeeds;
@override@JsonKey(name: 'budget_rule_wants') final  int budgetRuleWants;
@override@JsonKey(name: 'budget_rule_savings') final  int budgetRuleSavings;
@override@JsonKey(name: 'created_at') final  DateTime? createdAt;
@override@JsonKey(name: 'updated_at') final  DateTime? updatedAt;
@override@JsonKey() final  String role;

/// Create a copy of UserModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserModelCopyWith<_UserModel> get copyWith => __$UserModelCopyWithImpl<_UserModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserModel&&(identical(other.id, id) || other.id == id)&&(identical(other.email, email) || other.email == email)&&(identical(other.name, name) || other.name == name)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.isPremium, isPremium) || other.isPremium == isPremium)&&(identical(other.premiumExpiresAt, premiumExpiresAt) || other.premiumExpiresAt == premiumExpiresAt)&&(identical(other.premiumTrialStart, premiumTrialStart) || other.premiumTrialStart == premiumTrialStart)&&(identical(other.premiumTrialEnd, premiumTrialEnd) || other.premiumTrialEnd == premiumTrialEnd)&&(identical(other.activeSubscriptionType, activeSubscriptionType) || other.activeSubscriptionType == activeSubscriptionType)&&(identical(other.hasCompletedOnboarding, hasCompletedOnboarding) || other.hasCompletedOnboarding == hasCompletedOnboarding)&&(identical(other.notificationsEnabled, notificationsEnabled) || other.notificationsEnabled == notificationsEnabled)&&(identical(other.pushToken, pushToken) || other.pushToken == pushToken)&&(identical(other.appVersion, appVersion) || other.appVersion == appVersion)&&(identical(other.marketingConsent, marketingConsent) || other.marketingConsent == marketingConsent)&&(identical(other.budgetRuleNeeds, budgetRuleNeeds) || other.budgetRuleNeeds == budgetRuleNeeds)&&(identical(other.budgetRuleWants, budgetRuleWants) || other.budgetRuleWants == budgetRuleWants)&&(identical(other.budgetRuleSavings, budgetRuleSavings) || other.budgetRuleSavings == budgetRuleSavings)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.role, role) || other.role == role));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,email,name,avatarUrl,isPremium,premiumExpiresAt,premiumTrialStart,premiumTrialEnd,activeSubscriptionType,hasCompletedOnboarding,notificationsEnabled,pushToken,appVersion,marketingConsent,budgetRuleNeeds,budgetRuleWants,budgetRuleSavings,createdAt,updatedAt,role]);

@override
String toString() {
  return 'UserModel(id: $id, email: $email, name: $name, avatarUrl: $avatarUrl, isPremium: $isPremium, premiumExpiresAt: $premiumExpiresAt, premiumTrialStart: $premiumTrialStart, premiumTrialEnd: $premiumTrialEnd, activeSubscriptionType: $activeSubscriptionType, hasCompletedOnboarding: $hasCompletedOnboarding, notificationsEnabled: $notificationsEnabled, pushToken: $pushToken, appVersion: $appVersion, marketingConsent: $marketingConsent, budgetRuleNeeds: $budgetRuleNeeds, budgetRuleWants: $budgetRuleWants, budgetRuleSavings: $budgetRuleSavings, createdAt: $createdAt, updatedAt: $updatedAt, role: $role)';
}


}

/// @nodoc
abstract mixin class _$UserModelCopyWith<$Res> implements $UserModelCopyWith<$Res> {
  factory _$UserModelCopyWith(_UserModel value, $Res Function(_UserModel) _then) = __$UserModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String email, String? name,@JsonKey(name: 'avatar_url') String? avatarUrl,@JsonKey(name: 'is_premium') bool isPremium,@JsonKey(name: 'premium_expires_at') DateTime? premiumExpiresAt,@JsonKey(name: 'premium_trial_start') DateTime? premiumTrialStart,@JsonKey(name: 'premium_trial_end') DateTime? premiumTrialEnd,@JsonKey(name: 'active_subscription_type') String? activeSubscriptionType,@JsonKey(name: 'has_completed_onboarding') bool hasCompletedOnboarding,@JsonKey(name: 'notifications_enabled') bool notificationsEnabled,@JsonKey(name: 'push_token') String? pushToken,@JsonKey(name: 'app_version') String? appVersion,@JsonKey(name: 'marketing_consent') bool marketingConsent,@JsonKey(name: 'budget_rule_needs') int budgetRuleNeeds,@JsonKey(name: 'budget_rule_wants') int budgetRuleWants,@JsonKey(name: 'budget_rule_savings') int budgetRuleSavings,@JsonKey(name: 'created_at') DateTime? createdAt,@JsonKey(name: 'updated_at') DateTime? updatedAt, String role
});




}
/// @nodoc
class __$UserModelCopyWithImpl<$Res>
    implements _$UserModelCopyWith<$Res> {
  __$UserModelCopyWithImpl(this._self, this._then);

  final _UserModel _self;
  final $Res Function(_UserModel) _then;

/// Create a copy of UserModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? email = null,Object? name = freezed,Object? avatarUrl = freezed,Object? isPremium = null,Object? premiumExpiresAt = freezed,Object? premiumTrialStart = freezed,Object? premiumTrialEnd = freezed,Object? activeSubscriptionType = freezed,Object? hasCompletedOnboarding = null,Object? notificationsEnabled = null,Object? pushToken = freezed,Object? appVersion = freezed,Object? marketingConsent = null,Object? budgetRuleNeeds = null,Object? budgetRuleWants = null,Object? budgetRuleSavings = null,Object? createdAt = freezed,Object? updatedAt = freezed,Object? role = null,}) {
  return _then(_UserModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,isPremium: null == isPremium ? _self.isPremium : isPremium // ignore: cast_nullable_to_non_nullable
as bool,premiumExpiresAt: freezed == premiumExpiresAt ? _self.premiumExpiresAt : premiumExpiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,premiumTrialStart: freezed == premiumTrialStart ? _self.premiumTrialStart : premiumTrialStart // ignore: cast_nullable_to_non_nullable
as DateTime?,premiumTrialEnd: freezed == premiumTrialEnd ? _self.premiumTrialEnd : premiumTrialEnd // ignore: cast_nullable_to_non_nullable
as DateTime?,activeSubscriptionType: freezed == activeSubscriptionType ? _self.activeSubscriptionType : activeSubscriptionType // ignore: cast_nullable_to_non_nullable
as String?,hasCompletedOnboarding: null == hasCompletedOnboarding ? _self.hasCompletedOnboarding : hasCompletedOnboarding // ignore: cast_nullable_to_non_nullable
as bool,notificationsEnabled: null == notificationsEnabled ? _self.notificationsEnabled : notificationsEnabled // ignore: cast_nullable_to_non_nullable
as bool,pushToken: freezed == pushToken ? _self.pushToken : pushToken // ignore: cast_nullable_to_non_nullable
as String?,appVersion: freezed == appVersion ? _self.appVersion : appVersion // ignore: cast_nullable_to_non_nullable
as String?,marketingConsent: null == marketingConsent ? _self.marketingConsent : marketingConsent // ignore: cast_nullable_to_non_nullable
as bool,budgetRuleNeeds: null == budgetRuleNeeds ? _self.budgetRuleNeeds : budgetRuleNeeds // ignore: cast_nullable_to_non_nullable
as int,budgetRuleWants: null == budgetRuleWants ? _self.budgetRuleWants : budgetRuleWants // ignore: cast_nullable_to_non_nullable
as int,budgetRuleSavings: null == budgetRuleSavings ? _self.budgetRuleSavings : budgetRuleSavings // ignore: cast_nullable_to_non_nullable
as int,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on

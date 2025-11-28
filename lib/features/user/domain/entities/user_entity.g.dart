// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserEntity _$UserEntityFromJson(Map<String, dynamic> json) => _UserEntity(
  id: json['id'] as String,
  email: json['email'] as String,
  name: json['name'] as String?,
  avatarUrl: json['avatar_url'] as String?,
  isPremium: json['is_premium'] as bool? ?? false,
  premiumExpiresAt: json['premium_expires_at'] == null
      ? null
      : DateTime.parse(json['premium_expires_at'] as String),
  premiumTrialStart: json['premium_trial_start'] == null
      ? null
      : DateTime.parse(json['premium_trial_start'] as String),
  premiumTrialEnd: json['premium_trial_end'] == null
      ? null
      : DateTime.parse(json['premium_trial_end'] as String),
  activeSubscriptionType: json['active_subscription_type'] as String?,
  hasCompletedOnboarding: json['has_completed_onboarding'] as bool? ?? false,
  notificationsEnabled: json['notifications_enabled'] as bool? ?? true,
  pushToken: json['push_token'] as String?,
  appVersion: json['app_version'] as String?,
  marketingConsent: json['marketing_consent'] as bool? ?? false,
  budgetRuleNeeds: (json['budget_rule_needs'] as num?)?.toInt() ?? 50,
  budgetRuleWants: (json['budget_rule_wants'] as num?)?.toInt() ?? 30,
  budgetRuleSavings: (json['budget_rule_savings'] as num?)?.toInt() ?? 20,
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
  updatedAt: json['updated_at'] == null
      ? null
      : DateTime.parse(json['updated_at'] as String),
  role: json['role'] as String? ?? 'user',
);

Map<String, dynamic> _$UserEntityToJson(_UserEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'name': instance.name,
      'avatar_url': instance.avatarUrl,
      'is_premium': instance.isPremium,
      'premium_expires_at': instance.premiumExpiresAt?.toIso8601String(),
      'premium_trial_start': instance.premiumTrialStart?.toIso8601String(),
      'premium_trial_end': instance.premiumTrialEnd?.toIso8601String(),
      'active_subscription_type': instance.activeSubscriptionType,
      'has_completed_onboarding': instance.hasCompletedOnboarding,
      'notifications_enabled': instance.notificationsEnabled,
      'push_token': instance.pushToken,
      'app_version': instance.appVersion,
      'marketing_consent': instance.marketingConsent,
      'budget_rule_needs': instance.budgetRuleNeeds,
      'budget_rule_wants': instance.budgetRuleWants,
      'budget_rule_savings': instance.budgetRuleSavings,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'role': instance.role,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserEntity _$UserEntityFromJson(Map<String, dynamic> json) => UserEntity(
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
  hasCompletedOnboarding: json['has_completed_onboarding'] as bool? ?? false,
  notificationsEnabled: json['notifications_enabled'] as bool? ?? true,
  pushToken: json['push_token'] as String?,
  appVersion: json['app_version'] as String?,
  marketingConsent: json['marketing_consent'] as bool? ?? false,
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
  updatedAt: json['updated_at'] == null
      ? null
      : DateTime.parse(json['updated_at'] as String),
  role: json['role'] as String? ?? 'user',
);

Map<String, dynamic> _$UserEntityToJson(UserEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'name': instance.name,
      'avatar_url': instance.avatarUrl,
      'is_premium': instance.isPremium,
      'premium_expires_at': instance.premiumExpiresAt?.toIso8601String(),
      'premium_trial_start': instance.premiumTrialStart?.toIso8601String(),
      'premium_trial_end': instance.premiumTrialEnd?.toIso8601String(),
      'has_completed_onboarding': instance.hasCompletedOnboarding,
      'notifications_enabled': instance.notificationsEnabled,
      'push_token': instance.pushToken,
      'app_version': instance.appVersion,
      'marketing_consent': instance.marketingConsent,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'role': instance.role,
    };

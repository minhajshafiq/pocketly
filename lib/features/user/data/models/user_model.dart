import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/user_entity.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

/// Modèle de données pour l'utilisateur.
///
/// Représente la structure des données utilisateur dans la couche data.
/// Utilise Freezed 3.0 pour l'immutabilité et la génération de code.
@freezed
sealed class UserModel with _$UserModel {
  const factory UserModel({
    required String id,
    required String email,
    String? name,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    @JsonKey(name: 'is_premium') @Default(false) bool isPremium,
    @JsonKey(name: 'premium_expires_at') DateTime? premiumExpiresAt,
    @JsonKey(name: 'premium_trial_start') DateTime? premiumTrialStart,
    @JsonKey(name: 'premium_trial_end') DateTime? premiumTrialEnd,
    @JsonKey(name: 'has_completed_onboarding')
    @Default(false)
    bool hasCompletedOnboarding,
    @JsonKey(name: 'notifications_enabled')
    @Default(true)
    bool notificationsEnabled,
    @JsonKey(name: 'push_token') String? pushToken,
    @JsonKey(name: 'app_version') String? appVersion,
    @JsonKey(name: 'marketing_consent') @Default(false) bool marketingConsent,
    @JsonKey(name: 'budget_rule_needs') @Default(50) int budgetRuleNeeds,
    @JsonKey(name: 'budget_rule_wants') @Default(30) int budgetRuleWants,
    @JsonKey(name: 'budget_rule_savings') @Default(20) int budgetRuleSavings,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
    @Default('user') String role,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}

/// Extension pour la conversion entre UserModel et UserEntity.
extension UserModelX on UserModel {
  /// Convertit le modèle en entité du domaine.
  UserEntity toEntity() {
    return UserEntity(
      id: id,
      email: email,
      name: name,
      avatarUrl: avatarUrl,
      isPremium: isPremium,
      premiumExpiresAt: premiumExpiresAt,
      premiumTrialStart: premiumTrialStart,
      premiumTrialEnd: premiumTrialEnd,
      hasCompletedOnboarding: hasCompletedOnboarding,
      notificationsEnabled: notificationsEnabled,
      pushToken: pushToken,
      appVersion: appVersion,
      marketingConsent: marketingConsent,
      budgetRuleNeeds: budgetRuleNeeds,
      budgetRuleWants: budgetRuleWants,
      budgetRuleSavings: budgetRuleSavings,
      createdAt: createdAt,
      updatedAt: updatedAt,
      role: role,
    );
  }
}

/// Extension pour la conversion depuis UserEntity vers UserModel.
extension UserEntityToModelX on UserEntity {
  /// Convertit l'entité en modèle de données.
  UserModel toModel() {
    return UserModel(
      id: id,
      email: email,
      name: name,
      avatarUrl: avatarUrl,
      isPremium: isPremium,
      premiumExpiresAt: premiumExpiresAt,
      premiumTrialStart: premiumTrialStart,
      premiumTrialEnd: premiumTrialEnd,
      hasCompletedOnboarding: hasCompletedOnboarding,
      notificationsEnabled: notificationsEnabled,
      pushToken: pushToken,
      appVersion: appVersion,
      marketingConsent: marketingConsent,
      budgetRuleNeeds: budgetRuleNeeds,
      budgetRuleWants: budgetRuleWants,
      budgetRuleSavings: budgetRuleSavings,
      createdAt: createdAt,
      updatedAt: updatedAt,
      role: role,
    );
  }
}

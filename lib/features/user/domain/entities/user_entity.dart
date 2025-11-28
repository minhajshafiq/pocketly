import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_entity.freezed.dart';
part 'user_entity.g.dart';

/// Entité utilisateur principale pour Pocketly.
///
/// Représente un utilisateur dans le domaine métier avec toutes ses propriétés.
/// Utilise Freezed 3.0 pour l'immutabilité et la génération de code.
@freezed
sealed class UserEntity with _$UserEntity {
  const factory UserEntity({
    required String id,
    required String email,
    String? name,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    @JsonKey(name: 'is_premium') @Default(false) bool isPremium,
    @JsonKey(name: 'premium_expires_at') DateTime? premiumExpiresAt,
    @JsonKey(name: 'premium_trial_start') DateTime? premiumTrialStart,
    @JsonKey(name: 'premium_trial_end') DateTime? premiumTrialEnd,
    @JsonKey(name: 'active_subscription_type') String? activeSubscriptionType,
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
  }) = _UserEntity;

  factory UserEntity.fromJson(Map<String, dynamic> json) =>
      _$UserEntityFromJson(json);
}

/// Extension pour la logique métier de l'utilisateur
extension UserEntityX on UserEntity {
  /// Vérifie si l'utilisateur a accès aux fonctionnalités premium
  ///
  /// IMPORTANT: Vérifie TOUJOURS les dates d'expiration pour éviter que
  /// les utilisateurs gardent l'accès premium après expiration
  bool get canAccessPremium {
    // Si l'utilisateur a isPremium = true, vérifier la date d'expiration
    if (isPremium) {
      // Si premium_expires_at existe, vérifier qu'il n'est pas expiré
      if (premiumExpiresAt != null) {
        return !_isPremiumExpired;
      }
      // Si pas de premium_expires_at mais isPremium = true,
      // c'est probablement un utilisateur en trial
      // Vérifier que le trial n'est pas expiré
      return _isTrialActive;
    }

    // Si isPremium = false, vérifier le trial
    return _isTrialActive;
  }

  /// Vérifie si l'utilisateur est en période d'essai
  bool get _isTrialActive {
    if (premiumTrialStart == null || premiumTrialEnd == null) {
      return false;
    }
    // Utiliser UTC pour comparer car les dates sont stockées en UTC
    final now = DateTime.now().toUtc();
    final trialStart = premiumTrialStart!.toUtc();
    final trialEnd = premiumTrialEnd!.toUtc();

    // Utiliser >= pour le début et < pour la fin (inclut le moment exact de création)
    return !now.isBefore(trialStart) && now.isBefore(trialEnd);
  }

  /// Obtient le statut de l'utilisateur (free/trial/premium)
  String get status {
    if (isPremium && !_isPremiumExpired && premiumExpiresAt != null) {
      return 'premium';
    }
    if (_isTrialActive) {
      return 'trial';
    }
    return 'free';
  }

  /// Vérifie si l'abonnement premium est expiré
  bool get _isPremiumExpired {
    final now = DateTime.now().toUtc();

    if (premiumExpiresAt == null) {
      // Si pas de date d'expiration mais isPremium = true,
      // vérifier le trial
      if (isPremium && premiumTrialEnd != null) {
        return now.isAfter(premiumTrialEnd!.toUtc());
      }
      return false;
    }
    return now.isAfter(premiumExpiresAt!.toUtc());
  }

  /// Calcule le nombre de jours restants du trial
  int get trialDaysLeft {
    if (premiumTrialEnd == null) {
      return 0;
    }
    final now = DateTime.now().toUtc();
    return premiumTrialEnd!.toUtc().difference(now).inDays.clamp(0, 14);
  }

  /// Vérifie si l'utilisateur est actif (créé récemment)
  bool get isActive {
    if (createdAt == null) return false;
    final now = DateTime.now().toUtc();
    return now.difference(createdAt!.toUtc()).inDays < 30;
  }

  /// Obtient le nom d'affichage de l'utilisateur
  String get displayName =>
      name?.trim().isEmpty == true ? email : (name ?? email);

  /// Vérifie si l'utilisateur peut recevoir des notifications
  bool get canReceiveNotifications => notificationsEnabled && pushToken != null;

  /// Vérifie si l'utilisateur est en période d'essai (public)
  bool get isTrialActive => _isTrialActive;

  /// Vérifie si le profil est complet
  bool get hasCompleteProfile => name != null && name!.trim().isNotEmpty;

  /// Vérifie si l'utilisateur est administrateur
  bool get isAdmin => role == 'admin';

  /// Vérifie si l'utilisateur est un utilisateur normal
  bool get isUser => role == 'user';

  /// Obtient le pourcentage des besoins dans la règle budgétaire
  double get budgetRuleNeedsPercentage => budgetRuleNeeds / 100.0;

  /// Obtient le pourcentage des envies dans la règle budgétaire
  double get budgetRuleWantsPercentage => budgetRuleWants / 100.0;

  /// Obtient le pourcentage de l'épargne dans la règle budgétaire
  double get budgetRuleSavingsPercentage => budgetRuleSavings / 100.0;

  /// Vérifie si la règle budgétaire est valide (somme = 100%)
  bool get isBudgetRuleValid =>
      budgetRuleNeeds + budgetRuleWants + budgetRuleSavings == 100;

  /// Vérifie si la règle budgétaire est la règle par défaut (50/30/20)
  bool get isDefaultBudgetRule =>
      budgetRuleNeeds == 50 && budgetRuleWants == 30 && budgetRuleSavings == 20;
}

/// Factories pour créer des UserEntity avec des configurations prédéfinies
class UserEntityFactories {
  UserEntityFactories._();

  /// Crée un utilisateur avec des valeurs par défaut
  static UserEntity create({
    required String id,
    required String email,
    String? name,
    String? avatarUrl,
    bool isPremium = false,
    DateTime? premiumExpiresAt,
    DateTime? premiumTrialStart,
    DateTime? premiumTrialEnd,
    bool hasCompletedOnboarding = false,
    bool notificationsEnabled = true,
    String? pushToken,
    String? appVersion,
    bool marketingConsent = false,
    String role = 'user',
  }) {
    final now = DateTime.now();
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
      role: role,
      createdAt: now,
      updatedAt: now,
    );
  }

  /// Crée un utilisateur avec un trial actif
  static UserEntity withTrial({
    required String id,
    required String email,
    String? name,
    String? avatarUrl,
    bool hasCompletedOnboarding = false,
    bool notificationsEnabled = true,
    String? pushToken,
    String? appVersion,
    bool marketingConsent = false,
    String role = 'user',
  }) {
    final now = DateTime.now();
    final trialEnd = now.add(const Duration(days: 14));

    return UserEntity(
      id: id,
      email: email,
      name: name,
      avatarUrl: avatarUrl,
      isPremium: false,
      premiumTrialStart: now,
      premiumTrialEnd: trialEnd,
      hasCompletedOnboarding: hasCompletedOnboarding,
      notificationsEnabled: notificationsEnabled,
      pushToken: pushToken,
      appVersion: appVersion,
      marketingConsent: marketingConsent,
      role: role,
      createdAt: now,
      updatedAt: now,
    );
  }
}

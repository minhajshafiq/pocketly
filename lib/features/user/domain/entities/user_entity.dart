import 'package:json_annotation/json_annotation.dart';

part 'user_entity.g.dart';

/// Entité utilisateur principale pour Pocketly.
@JsonSerializable()
class UserEntity {
  final String id;
  final String email;
  final String? name;
  
  @JsonKey(name: 'avatar_url')
  final String? avatarUrl;
  
  @JsonKey(name: 'is_premium')
  final bool isPremium;
  
  @JsonKey(name: 'premium_expires_at')
  final DateTime? premiumExpiresAt;
  
  @JsonKey(name: 'premium_trial_start')
  final DateTime? premiumTrialStart;
  
  @JsonKey(name: 'premium_trial_end')
  final DateTime? premiumTrialEnd;
  
  @JsonKey(name: 'has_completed_onboarding')
  final bool hasCompletedOnboarding;
  
  @JsonKey(name: 'notifications_enabled')
  final bool notificationsEnabled;
  
  @JsonKey(name: 'push_token')
  final String? pushToken;
  
  @JsonKey(name: 'app_version')
  final String? appVersion;
  
  @JsonKey(name: 'marketing_consent')
  final bool marketingConsent;
  
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;
  
  final String role;

  const UserEntity({
    required this.id,
    required this.email,
    this.name,
    this.avatarUrl,
    this.isPremium = false,
    this.premiumExpiresAt,
    this.premiumTrialStart,
    this.premiumTrialEnd,
    this.hasCompletedOnboarding = false,
    this.notificationsEnabled = true,
    this.pushToken,
    this.appVersion,
    this.marketingConsent = false,
    this.createdAt,
    this.updatedAt,
    this.role = 'user',
  });

  factory UserEntity.fromJson(Map<String, dynamic> json) =>
      _$UserEntityFromJson(json);

  Map<String, dynamic> toJson() => _$UserEntityToJson(this);

  UserEntity copyWith({
    String? id,
    String? email,
    String? name,
    String? avatarUrl,
    bool? isPremium,
    DateTime? premiumExpiresAt,
    DateTime? premiumTrialStart,
    DateTime? premiumTrialEnd,
    bool? hasCompletedOnboarding,
    bool? notificationsEnabled,
    String? pushToken,
    String? appVersion,
    bool? marketingConsent,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? role,
  }) {
    return UserEntity(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      isPremium: isPremium ?? this.isPremium,
      premiumExpiresAt: premiumExpiresAt ?? this.premiumExpiresAt,
      premiumTrialStart: premiumTrialStart ?? this.premiumTrialStart,
      premiumTrialEnd: premiumTrialEnd ?? this.premiumTrialEnd,
      hasCompletedOnboarding: hasCompletedOnboarding ?? this.hasCompletedOnboarding,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      pushToken: pushToken ?? this.pushToken,
      appVersion: appVersion ?? this.appVersion,
      marketingConsent: marketingConsent ?? this.marketingConsent,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      role: role ?? this.role,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is UserEntity &&
        other.id == id &&
        other.email == email &&
        other.name == name &&
        other.avatarUrl == avatarUrl &&
        other.isPremium == isPremium &&
        other.premiumExpiresAt == premiumExpiresAt &&
        other.premiumTrialStart == premiumTrialStart &&
        other.premiumTrialEnd == premiumTrialEnd &&
        other.hasCompletedOnboarding == hasCompletedOnboarding &&
        other.notificationsEnabled == notificationsEnabled &&
        other.pushToken == pushToken &&
        other.appVersion == appVersion &&
        other.marketingConsent == marketingConsent &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.role == role;
  }

  @override
  int get hashCode {
    return Object.hash(
      id,
      email,
      name,
      avatarUrl,
      isPremium,
      premiumExpiresAt,
      premiumTrialStart,
      premiumTrialEnd,
      hasCompletedOnboarding,
      notificationsEnabled,
      pushToken,
      appVersion,
      marketingConsent,
      createdAt,
      updatedAt,
      role,
    );
  }

  @override
  String toString() {
    return 'UserEntity(id: $id, email: $email, name: $name, avatarUrl: $avatarUrl, isPremium: $isPremium, premiumExpiresAt: $premiumExpiresAt, premiumTrialStart: $premiumTrialStart, premiumTrialEnd: $premiumTrialEnd, hasCompletedOnboarding: $hasCompletedOnboarding, notificationsEnabled: $notificationsEnabled, pushToken: $pushToken, appVersion: $appVersion, marketingConsent: $marketingConsent, createdAt: $createdAt, updatedAt: $updatedAt, role: $role)';
  }
}

// ================================
// 🔍 Extensions pour logique métier
// ================================

extension UserEntityX on UserEntity {
  /// Indique si l'utilisateur est actuellement dans sa période d'essai.
  bool get isTrialActive {
    if (premiumTrialStart == null || premiumTrialEnd == null) return false;
    final now = DateTime.now();
    return now.isAfter(premiumTrialStart!) && now.isBefore(premiumTrialEnd!);
  }

  /// Indique si l'utilisateur a accès aux fonctionnalités premium.
  bool get canAccessPremium => isPremium || isTrialActive;

  /// Nombre de jours restants avant la fin du trial.
  int get trialDaysLeft {
    if (premiumTrialEnd == null) return 0;
    return premiumTrialEnd!.difference(DateTime.now()).inDays.clamp(0, 14);
  }

  /// Vérifie si l'utilisateur peut commencer un essai.
  bool get canStartTrial {
    return !isPremium && premiumTrialStart == null && premiumTrialEnd == null;
  }

  /// Vérifie si l'abonnement premium est expiré.
  bool get isPremiumExpired {
    if (!isPremium || premiumExpiresAt == null) return false;
    return DateTime.now().isAfter(premiumExpiresAt!);
  }

  /// Statut global de l'utilisateur (premium, trial, free).
  String get status {
    if (isPremium && !isPremiumExpired) return 'premium';
    if (isTrialActive) return 'trial';
    return 'free';
  }

  /// Vérifie si le profil est complet.
  bool get hasCompleteProfile {
    return name != null && name!.isNotEmpty;
  }

  /// Vérifie si l'utilisateur est administrateur.
  bool get isAdmin => role == 'admin';

  /// Vérifie si l'utilisateur est un utilisateur normal.
  bool get isUser => role == 'user';
}

// ================================
// 🏭 Factory methods
// ================================

class UserEntityFactories {
  /// Crée un utilisateur avec des valeurs par défaut sécurisées.
  static UserEntity create({
    required String id,
    required String email,
    String? name,
    String? avatarUrl,
    String role = 'user',
  }) {
    final now = DateTime.now();
    return UserEntity(
      id: id,
      email: email,
      name: name,
      avatarUrl: avatarUrl,
      createdAt: now,
      updatedAt: now,
      isPremium: false,
      hasCompletedOnboarding: false,
      notificationsEnabled: true,
      marketingConsent: false,
      role: role,
    );
  }

  /// Crée un utilisateur avec un trial actif de 14 jours.
  static UserEntity withTrial({
    required String id,
    required String email,
    String? name,
    String? avatarUrl,
    String role = 'user',
  }) {
    final now = DateTime.now();
    final trialEnd = now.add(const Duration(days: 14));
    
    return UserEntity(
      id: id,
      email: email,
      name: name,
      avatarUrl: avatarUrl,
      createdAt: now,
      updatedAt: now,
      premiumTrialStart: now,
      premiumTrialEnd: trialEnd,
      isPremium: false,
      hasCompletedOnboarding: false,
      notificationsEnabled: true,
      marketingConsent: false,
      role: role,
    );
  }
}
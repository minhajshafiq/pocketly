import 'package:freezed_annotation/freezed_annotation.dart';

part 'subscription_status_entity.freezed.dart';
part 'subscription_status_entity.g.dart';

/// Statut de l'abonnement
enum SubscriptionStatus {
  /// Utilisateur sans abonnement actif
  free,

  /// Période d'essai active
  trial,

  /// Abonnement premium actif
  premium,

  /// Abonnement expiré
  expired,
}

/// Entité représentant le statut d'abonnement d'un utilisateur
///
/// Contient toutes les informations sur l'abonnement actif
@freezed
sealed class SubscriptionStatusEntity with _$SubscriptionStatusEntity {
  const factory SubscriptionStatusEntity({
    /// Statut de l'abonnement
    required SubscriptionStatus status,

    /// L'utilisateur a-t-il accès aux fonctionnalités premium
    required bool isPremium,

    /// Date d'expiration de l'abonnement
    DateTime? expirationDate,

    /// Date de renouvellement automatique
    DateTime? renewalDate,

    /// Type d'abonnement actif
    String? activeSubscriptionType,

    /// L'abonnement se renouvelle-t-il automatiquement
    @Default(false) bool willRenew,

    /// L'utilisateur est-il en période d'essai
    @Default(false) bool isInTrial,

    /// Nombre de jours restants avant expiration
    int? daysRemaining,
  }) = _SubscriptionStatusEntity;

  factory SubscriptionStatusEntity.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionStatusEntityFromJson(json);

  /// Statut gratuit par défaut
  factory SubscriptionStatusEntity.free() => const SubscriptionStatusEntity(
        status: SubscriptionStatus.free,
        isPremium: false,
      );
}

/// Extension pour calculs sur le statut
extension SubscriptionStatusEntityX on SubscriptionStatusEntity {
  /// Calcule le nombre de jours restants avant expiration
  int? get remainingDays {
    if (expirationDate == null) return null;
    final now = DateTime.now();
    final difference = expirationDate!.difference(now);
    return difference.inDays;
  }

  /// L'abonnement expire-t-il bientôt (< 7 jours)
  bool get isExpiringSoon {
    final days = remainingDays;
    return days != null && days > 0 && days < 7;
  }

  /// L'abonnement est-il expiré
  bool get isExpired {
    if (expirationDate == null) return false;
    return DateTime.now().isAfter(expirationDate!);
  }
}

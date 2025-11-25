import 'package:pocketly/features/subscription/domain/entities/subscription_status_entity.dart';

/// Modèle de données pour le statut d'abonnement
///
/// Conversion entre données RevenueCat et SubscriptionStatusEntity
class SubscriptionStatusModel {
  final SubscriptionStatus status;
  final bool isPremium;
  final DateTime? expirationDate;
  final DateTime? renewalDate;
  final String? activeSubscriptionType;
  final bool willRenew;
  final bool isInTrial;
  final int? daysRemaining;

  SubscriptionStatusModel({
    required this.status,
    required this.isPremium,
    this.expirationDate,
    this.renewalDate,
    this.activeSubscriptionType,
    this.willRenew = false,
    this.isInTrial = false,
    this.daysRemaining,
  });

  /// Crée un statut gratuit
  factory SubscriptionStatusModel.free() {
    return SubscriptionStatusModel(
      status: SubscriptionStatus.free,
      isPremium: false,
    );
  }

  /// Crée un statut premium
  factory SubscriptionStatusModel.premium({
    DateTime? expirationDate,
    String? activeSubscriptionType,
    bool willRenew = false,
    bool isInTrial = false,
  }) {
    int? daysRemaining;
    if (expirationDate != null) {
      final difference = expirationDate.difference(DateTime.now());
      daysRemaining = difference.inDays;
    }

    SubscriptionStatus status;
    if (isInTrial) {
      status = SubscriptionStatus.trial;
    } else if (expirationDate != null && DateTime.now().isAfter(expirationDate)) {
      status = SubscriptionStatus.expired;
    } else {
      status = SubscriptionStatus.premium;
    }

    return SubscriptionStatusModel(
      status: status,
      isPremium: status == SubscriptionStatus.trial || status == SubscriptionStatus.premium,
      expirationDate: expirationDate,
      renewalDate: willRenew ? expirationDate : null,
      activeSubscriptionType: activeSubscriptionType,
      willRenew: willRenew,
      isInTrial: isInTrial,
      daysRemaining: daysRemaining,
    );
  }

  /// Convertit le modèle en entité domain
  SubscriptionStatusEntity toEntity() {
    return SubscriptionStatusEntity(
      status: status,
      isPremium: isPremium,
      expirationDate: expirationDate,
      renewalDate: renewalDate,
      activeSubscriptionType: activeSubscriptionType,
      willRenew: willRenew,
      isInTrial: isInTrial,
      daysRemaining: daysRemaining,
    );
  }

  /// Convertit une entité domain en modèle
  factory SubscriptionStatusModel.fromEntity(SubscriptionStatusEntity entity) {
    return SubscriptionStatusModel(
      status: entity.status,
      isPremium: entity.isPremium,
      expirationDate: entity.expirationDate,
      renewalDate: entity.renewalDate,
      activeSubscriptionType: entity.activeSubscriptionType,
      willRenew: entity.willRenew,
      isInTrial: entity.isInTrial,
      daysRemaining: entity.daysRemaining,
    );
  }
}

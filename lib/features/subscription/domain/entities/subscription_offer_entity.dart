import 'package:freezed_annotation/freezed_annotation.dart';

part 'subscription_offer_entity.freezed.dart';
part 'subscription_offer_entity.g.dart';

/// Type d'offre d'abonnement
enum SubscriptionOfferType {
  /// Abonnement mensuel
  monthly,

  /// Abonnement annuel
  yearly,
}

/// Entité représentant une offre d'abonnement
///
/// Contient les informations d'une offre (monthly ou yearly)
@freezed
sealed class SubscriptionOfferEntity with _$SubscriptionOfferEntity {
  const factory SubscriptionOfferEntity({
    /// Identifiant de l'offre
    required String id,

    /// Type d'offre (monthly/yearly)
    required SubscriptionOfferType type,

    /// Titre de l'offre (ex: "Premium Monthly")
    required String title,

    /// Description de l'offre
    required String description,

    /// Prix formaté (ex: "5,99€")
    required String priceString,

    /// Prix en nombre (ex: 5.99)
    required double price,

    /// Devise (ex: "EUR")
    required String currencyCode,

    /// Période d'abonnement (ex: "mois", "an")
    required String period,

    /// Indicateur "Meilleure valeur"
    @Default(false) bool isBestValue,

    /// Prix mensuel équivalent pour les offres annuelles
    String? monthlyEquivalentPrice,

    /// Pourcentage d'économie par rapport au mensuel
    int? savingsPercentage,

    /// Indique si cette offre a un essai gratuit
    @Default(false) bool hasFreeTrial,

    /// Durée de l'essai gratuit (ex: 7, 14, 30)
    int? freeTrialDuration,

    /// Unité de la période d'essai (ex: "jour", "jours", "day", "days")
    String? freeTrialPeriodUnit,

    /// Prix formaté de l'essai (généralement "0€" ou "Gratuit")
    String? freeTrialPriceString,
  }) = _SubscriptionOfferEntity;

  factory SubscriptionOfferEntity.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionOfferEntityFromJson(json);
}

/// Extension pour calculer le prix mensuel équivalent
extension SubscriptionOfferEntityX on SubscriptionOfferEntity {
  /// Calcule le prix mensuel équivalent pour une offre annuelle
  double get monthlyEquivalent {
    if (type == SubscriptionOfferType.yearly) {
      return price / 12;
    }
    return price;
  }

  /// Calcule le pourcentage d'économie par rapport à une offre de référence
  int calculateSavings(double monthlyPrice) {
    if (type == SubscriptionOfferType.yearly) {
      final yearlyAsMonthly = monthlyEquivalent;
      final savings = ((monthlyPrice - yearlyAsMonthly) / monthlyPrice) * 100;
      return savings.round();
    }
    return 0;
  }
}

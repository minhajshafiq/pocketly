import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:pocketly/features/subscription/domain/entities/subscription_offer_entity.dart';

/// Modèle de données pour une offre d'abonnement
///
/// Conversion entre Package RevenueCat et SubscriptionOfferEntity
class SubscriptionOfferModel {
  final String id;
  final SubscriptionOfferType type;
  final String title;
  final String description;
  final String priceString;
  final double price;
  final String currencyCode;
  final String period;
  final bool isBestValue;
  final String? monthlyEquivalentPrice;
  final int? savingsPercentage;
  final bool hasFreeTrial;
  final int? freeTrialDuration;
  final String? freeTrialPeriodUnit;
  final String? freeTrialPriceString;

  SubscriptionOfferModel({
    required this.id,
    required this.type,
    required this.title,
    required this.description,
    required this.priceString,
    required this.price,
    required this.currencyCode,
    required this.period,
    this.isBestValue = false,
    this.monthlyEquivalentPrice,
    this.savingsPercentage,
    this.hasFreeTrial = false,
    this.freeTrialDuration,
    this.freeTrialPeriodUnit,
    this.freeTrialPriceString,
  });

  /// Crée un modèle depuis un Package RevenueCat
  factory SubscriptionOfferModel.fromPackage(
    Package package, {
    bool isBestValue = false,
    double? monthlyReferencePrice,
  }) {
    final product = package.storeProduct;
    final isMonthly = package.identifier.contains('monthly');
    final isYearly = package.identifier.contains('annual') || package.identifier.contains('yearly');

    // Déterminer le type
    SubscriptionOfferType type;
    String period;
    if (isMonthly) {
      type = SubscriptionOfferType.monthly;
      period = 'mois';
    } else if (isYearly) {
      type = SubscriptionOfferType.yearly;
      period = 'an';
    } else {
      type = SubscriptionOfferType.monthly;
      period = 'mois';
    }

    // Prix
    final price = product.price;
    final priceString = product.priceString;
    final currencyCode = product.currencyCode;

    // Calcul du prix mensuel équivalent et économies pour yearly
    String? monthlyEquivalent;
    int? savings;

    if (isYearly && monthlyReferencePrice != null) {
      final monthlyPrice = price / 12;
      monthlyEquivalent = '${monthlyPrice.toStringAsFixed(2)} $currencyCode';

      final savingsAmount = monthlyReferencePrice - monthlyPrice;
      final savingsPercent = (savingsAmount / monthlyReferencePrice) * 100;
      savings = savingsPercent.round();
    }

    // Vérifier si le produit a un free trial
    // Note: RevenueCat SDK versions récentes gèrent les trials différemment
    // Pour le moment, on laisse hasFreeTrial = false car le trial est géré par Supabase
    // Si vous configurez des trials dans RevenueCat, décommentez et adaptez ce code
    bool hasFreeTrial = false;
    int? freeTrialDuration;
    String? freeTrialPeriodUnit;
    String? freeTrialPriceString;

    // Exemple pour RevenueCat SDK avec trials configurés :
    // if (product.introductoryPrice != null && product.introductoryPrice!.price == 0) {
    //   hasFreeTrial = true;
    //   freeTrialPriceString = 'Gratuit';
    //   // Parser duration from product.introductoryPrice...
    // }

    return SubscriptionOfferModel(
      id: package.identifier,
      type: type,
      title: product.title,
      description: product.description,
      priceString: priceString,
      price: price,
      currencyCode: currencyCode,
      period: period,
      isBestValue: isBestValue,
      monthlyEquivalentPrice: monthlyEquivalent,
      savingsPercentage: savings,
      hasFreeTrial: hasFreeTrial,
      freeTrialDuration: freeTrialDuration,
      freeTrialPeriodUnit: freeTrialPeriodUnit,
      freeTrialPriceString: freeTrialPriceString,
    );
  }

  /// Convertit le modèle en entité domain
  SubscriptionOfferEntity toEntity() {
    return SubscriptionOfferEntity(
      id: id,
      type: type,
      title: title,
      description: description,
      priceString: priceString,
      price: price,
      currencyCode: currencyCode,
      period: period,
      isBestValue: isBestValue,
      monthlyEquivalentPrice: monthlyEquivalentPrice,
      savingsPercentage: savingsPercentage,
      hasFreeTrial: hasFreeTrial,
      freeTrialDuration: freeTrialDuration,
      freeTrialPeriodUnit: freeTrialPeriodUnit,
      freeTrialPriceString: freeTrialPriceString,
    );
  }
}

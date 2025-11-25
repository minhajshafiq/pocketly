import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:pocketly/features/subscription/domain/entities/subscription_offer_entity.dart';
import 'package:pocketly/features/subscription/domain/entities/subscription_package_entity.dart';

/// Modèle de données pour un package RevenueCat
///
/// Conversion entre Package RevenueCat et SubscriptionPackageEntity
class SubscriptionPackageModel {
  final String identifier;
  final SubscriptionOfferType offerType;
  final String productIdentifier;
  final String priceString;
  final double price;
  final String currencyCode;
  final String? introPrice;
  final String? introPeriod;
  final Package? package;

  SubscriptionPackageModel({
    required this.identifier,
    required this.offerType,
    required this.productIdentifier,
    required this.priceString,
    required this.price,
    required this.currencyCode,
    this.introPrice,
    this.introPeriod,
    this.package,
  });

  /// Crée un modèle depuis un Package RevenueCat
  factory SubscriptionPackageModel.fromRevenueCat(Package package) {
    final product = package.storeProduct;
    final isMonthly = package.identifier.contains('monthly');

    // Déterminer le type
    final offerType = isMonthly
        ? SubscriptionOfferType.monthly
        : SubscriptionOfferType.yearly;

    // Informations d'introduction (essai gratuit)
    // Note: Dans purchases_flutter 9.9.3, l'API pour accéder aux prix d'introduction
    // a changé. Pour l'instant, nous ne gérons pas les prix d'introduction.
    // Cette fonctionnalité peut être ajoutée plus tard si nécessaire.
    String? introPrice;
    String? introPeriod;

    return SubscriptionPackageModel(
      identifier: package.identifier,
      offerType: offerType,
      productIdentifier: product.identifier,
      priceString: product.priceString,
      price: product.price,
      currencyCode: product.currencyCode,
      introPrice: introPrice,
      introPeriod: introPeriod,
      package: package, // Gardé pour l'achat
    );
  }

  /// Convertit le modèle en entité domain
  SubscriptionPackageEntity toEntity() {
    return SubscriptionPackageEntity(
      identifier: identifier,
      offerType: offerType,
      productIdentifier: productIdentifier,
      priceString: priceString,
      price: price,
      currencyCode: currencyCode,
      introPrice: introPrice,
      introPeriod: introPeriod,
      package: package, // Passé pour l'achat
    );
  }

  /// Convertit une entité domain en modèle
  factory SubscriptionPackageModel.fromEntity(SubscriptionPackageEntity entity) {
    return SubscriptionPackageModel(
      identifier: entity.identifier,
      offerType: entity.offerType,
      productIdentifier: entity.productIdentifier,
      priceString: entity.priceString,
      price: entity.price,
      currencyCode: entity.currencyCode,
      introPrice: entity.introPrice,
      introPeriod: entity.introPeriod,
      package: entity.package as Package?,
    );
  }
}

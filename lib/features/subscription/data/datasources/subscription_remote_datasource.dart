import 'dart:async';
import 'dart:io';

import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:pocketly/core/services/logger_service.dart';
import 'package:pocketly/features/subscription/data/models/subscription_offer_model.dart';
import 'package:pocketly/features/subscription/data/models/subscription_package_model.dart';
import 'package:pocketly/features/subscription/data/models/subscription_status_model.dart';
import 'package:pocketly/core/config/revenuecat_config.dart';

/// DataSource distant pour gérer les abonnements via RevenueCat
///
/// Encapsule toutes les interactions avec le SDK RevenueCat
class SubscriptionRemoteDataSource {
  final logger = const LoggerService();

  /// Identifiants des packages RevenueCat
  static const String monthlyPackageId = '\$rc_monthly';
  static const String yearlyPackageId = '\$rc_annual';

  /// Controller pour le stream de statut
  final _statusStreamController =
      StreamController<SubscriptionStatusModel>.broadcast();

  /// Initialise le SDK RevenueCat
  ///
  /// [userId] L'identifiant utilisateur Supabase
  Future<void> initialize(String userId) async {
    try {
      // Configuration du SDK
      final configuration = PurchasesConfiguration(
        Platform.isIOS
            ? RevenueCatConfig.iosApiKey
            : RevenueCatConfig.androidApiKey,
      )..appUserID = userId;

      await Purchases.configure(configuration);

      // Activer le mode debug en développement
      await Purchases.setLogLevel(LogLevel.debug);

      // Écouter les changements de statut
      Purchases.addCustomerInfoUpdateListener((customerInfo) {
        final status = _parseCustomerInfo(customerInfo);
        _statusStreamController.add(status);
      });

      logger.i(
        '[SubscriptionRemoteDataSource] SDK RevenueCat initialisé pour user: $userId',
      );
    } catch (e) {
      logger.e(
        '[SubscriptionRemoteDataSource] Erreur initialisation: $e',
        error: e,
      );
      throw Exception('Échec de l\'initialisation du SDK RevenueCat: $e');
    }
  }

  /// Récupère les offres disponibles
  Future<List<SubscriptionOfferModel>> getAvailableOffers() async {
    try {
      final offerings = await Purchases.getOfferings();

      if (offerings.current == null) {
        logger.w('[SubscriptionRemoteDataSource] Aucune offre disponible');
        return [];
      }

      final packages = offerings.current!.availablePackages;
      final offers = <SubscriptionOfferModel>[];

      // Trouver les packages monthly et yearly
      final monthlyPackage = packages.firstWhere(
        (p) => p.identifier == monthlyPackageId,
        orElse: () => throw Exception('Package monthly introuvable'),
      );

      final yearlyPackage = packages.firstWhere(
        (p) => p.identifier == yearlyPackageId,
        orElse: () => throw Exception('Package yearly introuvable'),
      );

      // Créer l'offre mensuelle
      final monthlyOffer = SubscriptionOfferModel.fromPackage(
        monthlyPackage,
        isBestValue: false,
      );
      offers.add(monthlyOffer);

      // Créer l'offre annuelle avec calcul d'économie
      final yearlyOffer = SubscriptionOfferModel.fromPackage(
        yearlyPackage,
        isBestValue: true,
        monthlyReferencePrice: monthlyOffer.price,
      );
      offers.add(yearlyOffer);

      logger.d(
        '[SubscriptionRemoteDataSource] Récupéré ${offers.length} offres',
      );
      return offers;
    } catch (e) {
      logger.e(
        '[SubscriptionRemoteDataSource] Erreur récupération offres: $e',
        error: e,
      );
      throw Exception('Échec de la récupération des offres: $e');
    }
  }

  /// Récupère les packages disponibles
  Future<List<SubscriptionPackageModel>> getAvailablePackages() async {
    try {
      final offerings = await Purchases.getOfferings();

      if (offerings.current == null) {
        return [];
      }

      final packages = offerings.current!.availablePackages;
      return packages
          .map((p) => SubscriptionPackageModel.fromRevenueCat(p))
          .toList();
    } catch (e) {
      logger.e(
        '[SubscriptionRemoteDataSource] Erreur récupération packages: $e',
        error: e,
      );
      throw Exception('Échec de la récupération des packages: $e');
    }
  }

  /// Vérifie le statut d'abonnement actuel
  Future<SubscriptionStatusModel> checkSubscriptionStatus() async {
    try {
      final customerInfo = await Purchases.getCustomerInfo();
      return _parseCustomerInfo(customerInfo);
    } catch (e) {
      logger.e(
        '[SubscriptionRemoteDataSource] Erreur vérification statut: $e',
        error: e,
      );
      throw Exception('Échec de la vérification du statut: $e');
    }
  }

  /// Achète un abonnement
  Future<SubscriptionStatusModel> purchaseSubscription(Package package) async {
    try {
      logger.d(
        '[SubscriptionRemoteDataSource] Début achat: ${package.identifier}',
      );

      final purchaserInfo = await Purchases.purchasePackage(package);

      logger.i('[SubscriptionRemoteDataSource] Achat réussi');
      return _parseCustomerInfo(purchaserInfo.customerInfo);
    } on PurchasesError catch (e) {
      if (e.code == PurchasesErrorCode.purchaseCancelledError) {
        logger.w(
          '[SubscriptionRemoteDataSource] Achat annulé par l\'utilisateur',
        );
        throw Exception('Achat annulé');
      } else if (e.code == PurchasesErrorCode.paymentPendingError) {
        logger.w('[SubscriptionRemoteDataSource] Paiement en attente');
        throw Exception('Paiement en attente de confirmation');
      } else {
        logger.e(
          '[SubscriptionRemoteDataSource] Erreur achat: ${e.message}',
          error: e,
        );
        throw Exception('Erreur lors de l\'achat: ${e.message}');
      }
    } catch (e) {
      logger.e('[SubscriptionRemoteDataSource] Erreur achat: $e', error: e);
      throw Exception('Échec de l\'achat: $e');
    }
  }

  /// Restaure les achats précédents
  Future<SubscriptionStatusModel> restorePurchases() async {
    try {
      logger.d('[SubscriptionRemoteDataSource] Restauration des achats');

      final customerInfo = await Purchases.restorePurchases();

      logger.i('[SubscriptionRemoteDataSource] Achats restaurés');
      return _parseCustomerInfo(customerInfo);
    } catch (e) {
      logger.e(
        '[SubscriptionRemoteDataSource] Erreur restauration: $e',
        error: e,
      );
      throw Exception('Échec de la restauration des achats: $e');
    }
  }

  /// Parse les informations client RevenueCat
  SubscriptionStatusModel _parseCustomerInfo(CustomerInfo customerInfo) {
    // Vérifier si l'utilisateur a un abonnement actif
    final entitlements = customerInfo.entitlements.active;

    if (entitlements.isEmpty) {
      // Pas d'abonnement actif
      return SubscriptionStatusModel.free();
    }

    // Récupérer le premier entitlement actif (devrait être "premium")
    final premiumEntitlement = entitlements.values.first;

    // Déterminer le type d'abonnement
    final productId = premiumEntitlement.productIdentifier;
    final bool isMonthly = productId.contains('monthly');
    final bool isYearly =
        productId.contains('yearly') || productId.contains('annual');

    String subscriptionType = 'unknown';
    if (isMonthly) {
      subscriptionType = 'monthly';
    } else if (isYearly) {
      subscriptionType = 'yearly';
    }

    // Date d'expiration
    final expirationDate = premiumEntitlement.expirationDate;

    // Est-ce que ça se renouvelle automatiquement
    final willRenew = premiumEntitlement.willRenew;

    // Période d'essai
    final isInTrial = customerInfo.entitlements.active.values.any(
      (e) => e.periodType == PeriodType.trial,
    );

    return SubscriptionStatusModel.premium(
      expirationDate: expirationDate != null
          ? DateTime.parse(expirationDate)
          : null,
      activeSubscriptionType: subscriptionType,
      willRenew: willRenew,
      isInTrial: isInTrial,
    );
  }

  /// Stream des changements de statut
  Stream<SubscriptionStatusModel> get statusStream =>
      _statusStreamController.stream;

  /// Nettoie les ressources
  void dispose() {
    _statusStreamController.close();
  }
}

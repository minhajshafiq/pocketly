import 'package:pocketly/features/subscription/domain/entities/subscription_offer_entity.dart';
import 'package:pocketly/features/subscription/domain/entities/subscription_package_entity.dart';
import 'package:pocketly/features/subscription/domain/entities/subscription_status_entity.dart';

/// Interface du repository pour gérer les abonnements
///
/// Définit les opérations disponibles pour les abonnements RevenueCat
abstract class SubscriptionRepository {
  /// Initialise le SDK RevenueCat avec l'ID utilisateur
  Future<void> initialize(String userId);

  /// Récupère les offres d'abonnement disponibles
  Future<List<SubscriptionOfferEntity>> getAvailableOffers();

  /// Récupère les packages RevenueCat disponibles
  Future<List<SubscriptionPackageEntity>> getAvailablePackages();

  /// Vérifie le statut d'abonnement actuel
  Future<SubscriptionStatusEntity> checkSubscriptionStatus();

  /// Achète un abonnement
  ///
  /// [package] Le package à acheter
  /// Lance une exception en cas d'erreur
  Future<void> purchaseSubscription(SubscriptionPackageEntity package);

  /// Restaure les achats précédents
  ///
  /// Utile pour les utilisateurs qui changent de device
  Future<SubscriptionStatusEntity> restorePurchases();

  /// Synchronise le statut d'abonnement avec le backend Supabase
  ///
  /// Met à jour isPremium et premiumExpiresAt dans la table users
  Future<void> syncSubscriptionToBackend(SubscriptionStatusEntity status);

  /// Écoute les changements de statut d'abonnement
  ///
  /// Retourne un Stream qui émet les nouveaux statuts
  Stream<SubscriptionStatusEntity> subscriptionStatusStream();
}

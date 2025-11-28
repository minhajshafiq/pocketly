import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:pocketly/core/services/logger_service.dart';
import 'package:pocketly/features/subscription/data/datasources/subscription_remote_datasource.dart';
import 'package:pocketly/features/subscription/data/models/subscription_package_model.dart';
import 'package:pocketly/features/subscription/domain/entities/subscription_offer_entity.dart';
import 'package:pocketly/features/subscription/domain/entities/subscription_package_entity.dart';
import 'package:pocketly/features/subscription/domain/entities/subscription_status_entity.dart';
import 'package:pocketly/features/subscription/domain/repositories/subscription_repository.dart';

/// Implémentation du repository d'abonnement
///
/// Orchestre les datasources et gère la logique métier
class SubscriptionRepositoryImpl implements SubscriptionRepository {
  final SubscriptionRemoteDataSource _remoteDataSource;
  final SupabaseClient _supabase;
  final logger = const LoggerService();

  SubscriptionRepositoryImpl({
    required SubscriptionRemoteDataSource remoteDataSource,
    required SupabaseClient supabase,
  })  : _remoteDataSource = remoteDataSource,
        _supabase = supabase;

  @override
  Future<void> initialize(String userId) async {
    try {
      await _remoteDataSource.initialize(userId);
      logger.i('[SubscriptionRepository] Initialisé pour user: $userId');
    } catch (e) {
      logger.e('[SubscriptionRepository] Erreur initialisation: $e', error: e);
      rethrow;
    }
  }

  @override
  Future<List<SubscriptionOfferEntity>> getAvailableOffers() async {
    try {
      final models = await _remoteDataSource.getAvailableOffers();
      return models.map((m) => m.toEntity()).toList();
    } catch (e) {
      logger.e('[SubscriptionRepository] Erreur récupération offres: $e', error: e);
      rethrow;
    }
  }

  @override
  Future<List<SubscriptionPackageEntity>> getAvailablePackages() async {
    try {
      final models = await _remoteDataSource.getAvailablePackages();
      return models.map((m) => m.toEntity()).toList();
    } catch (e) {
      logger.e('[SubscriptionRepository] Erreur récupération packages: $e', error: e);
      rethrow;
    }
  }

  @override
  Future<SubscriptionStatusEntity> checkSubscriptionStatus() async {
    try {
      final model = await _remoteDataSource.checkSubscriptionStatus();
      return model.toEntity();
    } catch (e) {
      logger.e('[SubscriptionRepository] Erreur vérification statut: $e', error: e);
      rethrow;
    }
  }

  @override
  Future<void> purchaseSubscription(SubscriptionPackageEntity packageEntity) async {
    try {
      // Convertir l'entité en modèle pour récupérer le Package RevenueCat
      final model = SubscriptionPackageModel.fromEntity(packageEntity);

      if (model.package == null) {
        throw Exception('Package RevenueCat manquant');
      }

      // Effectuer l'achat
      final statusModel = await _remoteDataSource.purchaseSubscription(
        model.package as Package,
      );

      // Synchroniser avec Supabase
      await syncSubscriptionToBackend(statusModel.toEntity());

      logger.i('[SubscriptionRepository] Achat et synchronisation réussis');
    } catch (e) {
      logger.e('[SubscriptionRepository] Erreur achat: $e', error: e);
      rethrow;
    }
  }

  @override
  Future<SubscriptionStatusEntity> restorePurchases() async {
    try {
      final model = await _remoteDataSource.restorePurchases();

      // Synchroniser avec Supabase
      await syncSubscriptionToBackend(model.toEntity());

      return model.toEntity();
    } catch (e) {
      logger.e('[SubscriptionRepository] Erreur restauration: $e', error: e);
      rethrow;
    }
  }

  @override
  Future<void> syncSubscriptionToBackend(SubscriptionStatusEntity status) async {
    try {
      final userId = _supabase.auth.currentUser?.id;

      if (userId == null) {
        throw Exception('Utilisateur non authentifié');
      }

      logger.d('[SubscriptionRepository] Synchronisation avec Supabase pour user: $userId');

      // Mettre à jour les champs premium dans la table users
      await _supabase.from('users').update({
        'is_premium': status.isPremium,
        'premium_expires_at': status.expirationDate?.toIso8601String(),
        'active_subscription_type': status.activeSubscriptionType,
        'updated_at': DateTime.now().toIso8601String(),
      }).eq('id', userId);

      logger.i('[SubscriptionRepository] Synchronisation réussie (premium: ${status.isPremium}, type: ${status.activeSubscriptionType})');
    } catch (e) {
      logger.e('[SubscriptionRepository] Erreur synchronisation: $e', error: e);
      rethrow;
    }
  }

  @override
  Stream<SubscriptionStatusEntity> subscriptionStatusStream() {
    return _remoteDataSource.statusStream.map((model) => model.toEntity());
  }
}

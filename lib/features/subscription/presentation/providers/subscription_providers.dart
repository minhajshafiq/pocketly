import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:pocketly/core/config/supabase_config.dart';
import 'package:pocketly/core/services/auth_service.dart';
import 'package:pocketly/core/services/logger_service.dart';
import 'package:pocketly/features/user/user.dart';
import 'package:pocketly/features/subscription/data/datasources/subscription_remote_datasource.dart';
import 'package:pocketly/features/subscription/data/repositories/subscription_repository_impl.dart';
import 'package:pocketly/features/subscription/domain/entities/subscription_offer_entity.dart';
import 'package:pocketly/features/subscription/domain/entities/subscription_package_entity.dart';
import 'package:pocketly/features/subscription/domain/entities/subscription_status_entity.dart';
import 'package:pocketly/features/subscription/domain/repositories/subscription_repository.dart';
import 'package:pocketly/features/subscription/domain/usecases/check_subscription_status_usecase.dart';
import 'package:pocketly/features/subscription/domain/usecases/get_subscription_offers_usecase.dart';
import 'package:pocketly/features/subscription/domain/usecases/purchase_subscription_usecase.dart';
import 'package:pocketly/features/subscription/domain/usecases/restore_purchases_usecase.dart';
import 'package:pocketly/features/subscription/domain/usecases/sync_subscription_to_backend_usecase.dart';

part 'subscription_providers.g.dart';

// =====================================================
// 🏗️ INFRASTRUCTURE PROVIDERS
// =====================================================

/// Provider pour SubscriptionRemoteDataSource
@Riverpod(keepAlive: true)
SubscriptionRemoteDataSource subscriptionRemoteDataSource(Ref ref) {
  return SubscriptionRemoteDataSource();
}

/// Provider pour SupabaseClient
@Riverpod(keepAlive: true)
SupabaseClient supabaseClient(Ref ref) {
  return SupabaseConfig.client;
}

/// Provider pour SubscriptionRepository
@Riverpod(keepAlive: true)
SubscriptionRepository subscriptionRepository(Ref ref) {
  final remoteDataSource = ref.watch(subscriptionRemoteDataSourceProvider);
  final supabase = ref.watch(supabaseClientProvider);

  return SubscriptionRepositoryImpl(
    remoteDataSource: remoteDataSource,
    supabase: supabase,
  );
}

// =====================================================
// 🎯 USE CASE PROVIDERS
// =====================================================

@Riverpod(keepAlive: true)
GetSubscriptionOffersUseCase getSubscriptionOffersUseCase(Ref ref) {
  return GetSubscriptionOffersUseCase(ref.watch(subscriptionRepositoryProvider));
}

@Riverpod(keepAlive: true)
PurchaseSubscriptionUseCase purchaseSubscriptionUseCase(Ref ref) {
  return PurchaseSubscriptionUseCase(ref.watch(subscriptionRepositoryProvider));
}

@Riverpod(keepAlive: true)
RestorePurchasesUseCase restorePurchasesUseCase(Ref ref) {
  return RestorePurchasesUseCase(ref.watch(subscriptionRepositoryProvider));
}

@Riverpod(keepAlive: true)
CheckSubscriptionStatusUseCase checkSubscriptionStatusUseCase(Ref ref) {
  return CheckSubscriptionStatusUseCase(ref.watch(subscriptionRepositoryProvider));
}

@Riverpod(keepAlive: true)
SyncSubscriptionToBackendUseCase syncSubscriptionToBackendUseCase(Ref ref) {
  return SyncSubscriptionToBackendUseCase(ref.watch(subscriptionRepositoryProvider));
}

// =====================================================
// 📋 STATE PROVIDERS
// =====================================================

/// Provider pour les offres d'abonnement disponibles
@riverpod
Future<List<SubscriptionOfferEntity>> subscriptionOffers(Ref ref) async {
  final useCase = ref.watch(getSubscriptionOffersUseCaseProvider);
  return await useCase();
}

/// Provider pour le statut d'abonnement actuel
@riverpod
Future<SubscriptionStatusEntity> subscriptionStatus(Ref ref) async {
  final useCase = ref.watch(checkSubscriptionStatusUseCaseProvider);
  return await useCase();
}

/// Provider pour le stream de statut d'abonnement
@riverpod
Stream<SubscriptionStatusEntity> subscriptionStatusStream(Ref ref) {
  final repository = ref.watch(subscriptionRepositoryProvider);
  return repository.subscriptionStatusStream();
}

// =====================================================
// 🎛️ CONTROLLER PROVIDERS
// =====================================================

/// État du controller d'abonnement
class SubscriptionControllerState {
  final bool isPurchasing;
  final bool isRestoring;
  final bool isActivatingTrial;
  final String? error;

  const SubscriptionControllerState({
    this.isPurchasing = false,
    this.isRestoring = false,
    this.isActivatingTrial = false,
    this.error,
  });

  SubscriptionControllerState copyWith({
    bool? isPurchasing,
    bool? isRestoring,
    bool? isActivatingTrial,
    String? error,
  }) {
    return SubscriptionControllerState(
      isPurchasing: isPurchasing ?? this.isPurchasing,
      isRestoring: isRestoring ?? this.isRestoring,
      isActivatingTrial: isActivatingTrial ?? this.isActivatingTrial,
      error: error,
    );
  }
}

/// Contrôleur principal pour gérer les abonnements
@Riverpod(keepAlive: true)
class SubscriptionController extends _$SubscriptionController {
  @override
  SubscriptionControllerState build() {
    return const SubscriptionControllerState();
  }

  /// Initialise le SDK RevenueCat
  Future<void> initialize() async {
    try {
      final authService = AuthService();
      final user = authService.currentUser;

      if (user == null) {
        throw Exception('Utilisateur non authentifié');
      }

      final repository = ref.read(subscriptionRepositoryProvider);
      await repository.initialize(user.id);

      ref.read(loggerProvider).i('SubscriptionController initialisé');
    } catch (e) {
      ref.read(loggerProvider).e('Erreur lors de l\'initialisation', error: e);
      state = state.copyWith(error: e.toString());
      rethrow;
    }
  }

  /// Achète un abonnement
  Future<void> purchaseSubscription(SubscriptionPackageEntity package) async {
    state = state.copyWith(isPurchasing: true, error: null);

    try {
      ref.read(loggerProvider).i('Début de l\'achat');

      final useCase = ref.read(purchaseSubscriptionUseCaseProvider);
      await useCase(package);

      // Invalider les providers pour rafraîchir les données
      ref.invalidate(subscriptionStatusProvider);
      ref.invalidate(subscriptionOffersProvider);

      ref.read(loggerProvider).i('Achat réussi');
      state = state.copyWith(isPurchasing: false);
    } catch (e) {
      ref.read(loggerProvider).e('Erreur lors de l\'achat', error: e);
      state = state.copyWith(isPurchasing: false, error: e.toString());
      rethrow;
    }
  }

  /// Restaure les achats précédents
  Future<void> restorePurchases() async {
    state = state.copyWith(isRestoring: true, error: null);

    try {
      ref.read(loggerProvider).i('Début de la restauration');

      final useCase = ref.read(restorePurchasesUseCaseProvider);
      await useCase();

      // Invalider les providers
      ref.invalidate(subscriptionStatusProvider);

      ref.read(loggerProvider).i('Restauration réussie');
      state = state.copyWith(isRestoring: false);
    } catch (e) {
      ref.read(loggerProvider).e('Erreur lors de la restauration', error: e);
      state = state.copyWith(isRestoring: false, error: e.toString());
      rethrow;
    }
  }

  /// Active l'essai gratuit de 14 jours
  Future<void> activateFreeTrial() async {
    state = state.copyWith(isActivatingTrial: true, error: null);

    try {
      ref.read(loggerProvider).i('Début de l\'activation du trial');

      final authService = AuthService();
      final user = authService.currentUser;

      if (user == null) {
        throw Exception('Utilisateur non authentifié');
      }

      // Utiliser le use case du feature user pour activer le trial
      final activateTrialUseCase = await ref.read(activateTrialUseCaseProvider.future);
      await activateTrialUseCase(user.id);

      // Invalider les providers pour rafraîchir l'état utilisateur
      ref.invalidate(currentUserProvider);
      ref.invalidate(canAccessPremiumProvider);

      ref.read(loggerProvider).i('Trial activé avec succès');
      state = state.copyWith(isActivatingTrial: false);
    } catch (e) {
      ref.read(loggerProvider).e('Erreur lors de l\'activation du trial', error: e);
      state = state.copyWith(isActivatingTrial: false, error: e.toString());
      rethrow;
    }
  }
}

import 'package:pocketly/features/subscription/domain/entities/subscription_status_entity.dart';
import 'package:pocketly/features/subscription/domain/repositories/subscription_repository.dart';

/// Use case pour synchroniser le statut d'abonnement avec le backend Supabase
///
/// Met à jour isPremium et premiumExpiresAt dans la table users
class SyncSubscriptionToBackendUseCase {
  final SubscriptionRepository _repository;

  SyncSubscriptionToBackendUseCase(this._repository);

  /// Exécute le use case
  ///
  /// [status] Le statut d'abonnement à synchroniser
  Future<void> call(SubscriptionStatusEntity status) async {
    await _repository.syncSubscriptionToBackend(status);
  }
}

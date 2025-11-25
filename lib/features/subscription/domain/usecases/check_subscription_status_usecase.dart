import 'package:pocketly/features/subscription/domain/entities/subscription_status_entity.dart';
import 'package:pocketly/features/subscription/domain/repositories/subscription_repository.dart';

/// Use case pour vérifier le statut d'abonnement actuel
///
/// Vérifie si l'utilisateur a un abonnement actif
class CheckSubscriptionStatusUseCase {
  final SubscriptionRepository _repository;

  CheckSubscriptionStatusUseCase(this._repository);

  /// Exécute le use case
  ///
  /// Retourne le statut d'abonnement actuel
  Future<SubscriptionStatusEntity> call() async {
    return await _repository.checkSubscriptionStatus();
  }
}

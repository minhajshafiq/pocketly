import 'package:pocketly/features/subscription/domain/entities/subscription_status_entity.dart';
import 'package:pocketly/features/subscription/domain/repositories/subscription_repository.dart';

/// Use case pour restaurer les achats précédents
///
/// Permet à un utilisateur de récupérer ses abonnements sur un nouveau device
class RestorePurchasesUseCase {
  final SubscriptionRepository _repository;

  RestorePurchasesUseCase(this._repository);

  /// Exécute le use case
  ///
  /// Retourne le nouveau statut d'abonnement après restauration
  Future<SubscriptionStatusEntity> call() async {
    return await _repository.restorePurchases();
  }
}

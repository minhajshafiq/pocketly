import 'package:pocketly/features/subscription/domain/entities/subscription_offer_entity.dart';
import 'package:pocketly/features/subscription/domain/repositories/subscription_repository.dart';

/// Use case pour récupérer les offres d'abonnement disponibles
///
/// Récupère les offres (Monthly, Yearly) depuis RevenueCat
class GetSubscriptionOffersUseCase {
  final SubscriptionRepository _repository;

  GetSubscriptionOffersUseCase(this._repository);

  /// Exécute le use case
  ///
  /// Retourne la liste des offres disponibles
  Future<List<SubscriptionOfferEntity>> call() async {
    return await _repository.getAvailableOffers();
  }
}

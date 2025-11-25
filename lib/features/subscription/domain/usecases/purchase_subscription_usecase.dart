import 'package:pocketly/features/subscription/domain/entities/subscription_package_entity.dart';
import 'package:pocketly/features/subscription/domain/repositories/subscription_repository.dart';

/// Use case pour acheter un abonnement
///
/// Gère le flux d'achat complet via RevenueCat
class PurchaseSubscriptionUseCase {
  final SubscriptionRepository _repository;

  PurchaseSubscriptionUseCase(this._repository);

  /// Exécute le use case
  ///
  /// [package] Le package à acheter
  /// Lance une exception si l'achat échoue
  Future<void> call(SubscriptionPackageEntity package) async {
    await _repository.purchaseSubscription(package);
  }
}

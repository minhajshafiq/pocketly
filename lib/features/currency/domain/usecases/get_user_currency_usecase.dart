import 'package:pocketly/features/currency/domain/entities/currency_entity.dart';
import 'package:pocketly/features/currency/domain/repositories/currency_repository.dart';

/// Use case pour récupérer la devise de l'utilisateur.
///
/// Récupère la devise actuellement sélectionnée par l'utilisateur
/// depuis le repository. Si aucune devise n'est définie, retourne
/// la devise par défaut (EUR).
class GetUserCurrencyUseCase {
  final CurrencyRepository _repository;

  GetUserCurrencyUseCase(this._repository);

  /// Exécute le use case.
  ///
  /// Returns: La devise de l'utilisateur ou EUR par défaut.
  Future<CurrencyEntity> call() async {
    return await _repository.getUserCurrency();
  }
}

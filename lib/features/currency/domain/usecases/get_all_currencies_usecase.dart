import 'package:pocketly/features/currency/domain/entities/currency_entity.dart';
import 'package:pocketly/features/currency/domain/repositories/currency_repository.dart';

/// Use case pour récupérer toutes les devises supportées.
///
/// Retourne la liste de toutes les devises disponibles
/// dans l'application (EUR, USD, GBP, JPY).
class GetAllCurrenciesUseCase {
  final CurrencyRepository _repository;

  GetAllCurrenciesUseCase(this._repository);

  /// Exécute le use case.
  ///
  /// Returns: Liste de toutes les devises supportées.
  List<CurrencyEntity> call() {
    return _repository.getAllCurrencies();
  }
}

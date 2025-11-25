import 'package:pocketly/features/currency/domain/entities/currency_entity.dart';
import 'package:pocketly/features/currency/domain/repositories/currency_repository.dart';

/// Use case pour définir la devise de l'utilisateur.
///
/// Sauvegarde la devise sélectionnée par l'utilisateur dans
/// le repository pour une utilisation ultérieure.
class SetUserCurrencyUseCase {
  final CurrencyRepository _repository;

  SetUserCurrencyUseCase(this._repository);

  /// Exécute le use case.
  ///
  /// [currency] La devise à sauvegarder.
  /// Lance une exception si la sauvegarde échoue.
  Future<void> call(CurrencyEntity currency) async {
    return await _repository.setUserCurrency(currency);
  }
}

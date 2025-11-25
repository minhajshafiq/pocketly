import 'package:pocketly/features/currency/domain/entities/currency_entity.dart';
import 'package:pocketly/features/currency/domain/repositories/currency_repository.dart';
import 'package:pocketly/features/currency/data/datasources/currency_local_datasource.dart';

/// Implémentation du repository des devises.
///
/// Gère la persistance de la devise utilisateur via le datasource local.
class CurrencyRepositoryImpl implements CurrencyRepository {
  final CurrencyLocalDataSource _localDataSource;

  CurrencyRepositoryImpl(this._localDataSource);

  @override
  Future<CurrencyEntity> getUserCurrency() async {
    try {
      final currencyMap = await _localDataSource.getUserCurrency();

      if (currencyMap == null) {
        // Aucune devise sauvegardée, retourner la devise par défaut
        return SupportedCurrencies.defaultCurrency;
      }

      // Convertir le Map en CurrencyEntity
      return CurrencyEntity.fromJson(currencyMap);
    } catch (e) {
      // En cas d'erreur, retourner la devise par défaut
      return SupportedCurrencies.defaultCurrency;
    }
  }

  @override
  Future<void> setUserCurrency(CurrencyEntity currency) async {
    await _localDataSource.setUserCurrency(currency.toJson());
  }

  @override
  Future<void> resetToDefault() async {
    await _localDataSource.clearUserCurrency();
  }

  @override
  List<CurrencyEntity> getAllCurrencies() {
    return SupportedCurrencies.all;
  }
}

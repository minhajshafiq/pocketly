import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pocketly/core/core.dart';
import 'package:pocketly/features/currency/domain/entities/currency_entity.dart';
import 'package:pocketly/features/currency/domain/repositories/currency_repository.dart';
import 'package:pocketly/features/currency/domain/usecases/get_user_currency_usecase.dart';
import 'package:pocketly/features/currency/domain/usecases/set_user_currency_usecase.dart';
import 'package:pocketly/features/currency/domain/usecases/get_all_currencies_usecase.dart';
import 'package:pocketly/features/currency/data/datasources/currency_local_datasource.dart';
import 'package:pocketly/features/currency/data/repositories/currency_repository_impl.dart';

part 'currency_providers.g.dart';

/// Provider pour SharedPreferences
@riverpod
Future<SharedPreferences> currencySharedPreferences(Ref ref) async {
  return await SharedPreferences.getInstance();
}

/// Provider pour le datasource local des devises
@riverpod
Future<CurrencyLocalDataSource> currencyLocalDataSource(Ref ref) async {
  final prefs = await ref.watch(currencySharedPreferencesProvider.future);
  return CurrencyLocalDataSource(prefs);
}

/// Provider pour le repository des devises
@riverpod
Future<CurrencyRepository> currencyRepository(Ref ref) async {
  final localDataSource = await ref.watch(currencyLocalDataSourceProvider.future);
  return CurrencyRepositoryImpl(localDataSource);
}

/// Provider pour le use case GetUserCurrency
@riverpod
Future<GetUserCurrencyUseCase> getUserCurrencyUseCase(Ref ref) async {
  final repository = await ref.watch(currencyRepositoryProvider.future);
  return GetUserCurrencyUseCase(repository);
}

/// Provider pour le use case SetUserCurrency
@riverpod
Future<SetUserCurrencyUseCase> setUserCurrencyUseCase(Ref ref) async {
  final repository = await ref.watch(currencyRepositoryProvider.future);
  return SetUserCurrencyUseCase(repository);
}

/// Provider pour le use case GetAllCurrencies
@riverpod
Future<GetAllCurrenciesUseCase> getAllCurrenciesUseCase(Ref ref) async {
  final repository = await ref.watch(currencyRepositoryProvider.future);
  return GetAllCurrenciesUseCase(repository);
}

/// Provider pour les devises disponibles
@riverpod
Future<List<CurrencyEntity>> availableCurrencies(Ref ref) async {
  final getAllCurrenciesUseCase = await ref.watch(getAllCurrenciesUseCaseProvider.future);
  return getAllCurrenciesUseCase();
}

/// Notifier pour la gestion de la devise utilisateur
@riverpod
class CurrencyNotifier extends _$CurrencyNotifier {
  @override
  Future<CurrencyEntity> build() async {
    // Charger la devise initiale
    return await _loadCurrency();
  }

  /// Charge la devise de l'utilisateur
  Future<CurrencyEntity> _loadCurrency() async {
    try {
      final getUserCurrencyUseCase = await ref.read(getUserCurrencyUseCaseProvider.future);
      return await getUserCurrencyUseCase();
    } catch (e) {
      // Log l'erreur avec le logger centralisé
      ref.read(loggerProvider).e('Erreur lors du chargement de la devise', error: e);
      rethrow; // Re-throw l'erreur spécifique
    }
  }

  /// Rafraîchit la devise
  Future<void> refreshCurrency() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return await _loadCurrency();
    });
  }

  /// Change la devise de l'utilisateur
  Future<void> setCurrency(CurrencyEntity currency) async {
    try {
      state = const AsyncValue.loading();
      final setUserCurrencyUseCase = await ref.read(setUserCurrencyUseCaseProvider.future);
      await setUserCurrencyUseCase(currency);

      // Recharge la devise après mise à jour
      state = await AsyncValue.guard(() async {
        return await _loadCurrency();
      });
    } catch (e) {
      ref.read(loggerProvider).e('Erreur lors de la mise à jour de la devise', error: e);
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  /// Réinitialise à la devise par défaut (EUR)
  Future<void> resetToDefault() async {
    try {
      state = const AsyncValue.loading();
      final repository = await ref.read(currencyRepositoryProvider.future);
      await repository.resetToDefault();

      // Recharge la devise après réinitialisation
      state = await AsyncValue.guard(() async {
        return await _loadCurrency();
      });
    } catch (e) {
      ref.read(loggerProvider).e('Erreur lors de la réinitialisation de la devise', error: e);
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}

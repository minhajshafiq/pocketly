import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pocketly/features/locale/data/datasources/locale_local_datasource.dart';
import 'package:pocketly/features/locale/data/repositories/locale_repository_impl.dart';
import 'package:pocketly/features/locale/domain/entities/app_locale_entity.dart';
import 'package:pocketly/features/locale/domain/repositories/locale_repository.dart';

part 'locale_providers.g.dart';

/// Provider pour SharedPreferences
@riverpod
Future<SharedPreferences> localeSharedPreferences(Ref ref) async {
  return await SharedPreferences.getInstance();
}

/// Provider pour le datasource local
@riverpod
LocaleLocalDataSource localeLocalDataSource(Ref ref) {
  final prefs = ref.watch(localeSharedPreferencesProvider).requireValue;
  return LocaleLocalDataSource(prefs);
}

/// Provider pour le repository
@riverpod
LocaleRepository localeRepository(Ref ref) {
  final dataSource = ref.watch(localeLocalDataSourceProvider);
  return LocaleRepositoryImpl(dataSource);
}

/// Provider pour la locale courante
///
/// Gère la locale de l'application avec persistance locale.
/// Si aucune locale n'est sauvegardée, utilise la locale du système.
@riverpod
class CurrentLocale extends _$CurrentLocale {
  @override
  Future<Locale> build() async {
    // Attendre que SharedPreferences soit prêt
    await ref.watch(localeSharedPreferencesProvider.future);

    final repository = ref.watch(localeRepositoryProvider);

    // Récupérer la locale sauvegardée
    final savedLocale = await repository.getCurrentLocale();

    if (savedLocale != null) {
      // Utiliser la locale sauvegardée
      final appLocale = SupportedLocales.fromLanguageCode(savedLocale);
      return appLocale.toLocale();
    }

    // Sinon, utiliser la locale par défaut
    return SupportedLocales.defaultLocale.toLocale();
  }

  /// Change la locale de l'application
  Future<void> setLocale(AppLocaleEntity locale) async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      final repository = ref.read(localeRepositoryProvider);
      await repository.setLocale(locale.languageCode);
      return locale.toLocale();
    });
  }

  /// Change la locale par code de langue
  Future<void> setLocaleByCode(String languageCode) async {
    final locale = SupportedLocales.fromLanguageCode(languageCode);
    await setLocale(locale);
  }

  /// Réinitialise à la locale du système
  Future<void> resetToSystemLocale() async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      final repository = ref.read(localeRepositoryProvider);
      await repository.clearLocale();

      // Récupérer la locale du système
      final systemLocale = WidgetsBinding.instance.platformDispatcher.locale;
      final appLocale = SupportedLocales.getSystemLocale(systemLocale);
      return appLocale.toLocale();
    });
  }
}

/// Provider pour obtenir l'AppLocaleEntity actuelle
@riverpod
Future<AppLocaleEntity> currentAppLocale(Ref ref) async {
  final locale = await ref.watch(currentLocaleProvider.future);
  return locale.toAppLocale();
}

/// Provider pour la liste de toutes les locales supportées
@riverpod
List<AppLocaleEntity> supportedAppLocales(Ref ref) {
  return SupportedLocales.all;
}

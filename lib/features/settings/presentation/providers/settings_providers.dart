import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pocketly/core/core.dart';
import 'package:pocketly/features/settings/domain/entities/app_settings_entity.dart';
import 'package:pocketly/features/settings/domain/repositories/settings_repository.dart';
import 'package:pocketly/features/settings/domain/usecases/get_settings_usecase.dart';
import 'package:pocketly/features/settings/domain/usecases/update_theme_mode_usecase.dart';
import 'package:pocketly/features/settings/domain/usecases/reset_settings_usecase.dart';
import 'package:pocketly/features/settings/data/datasources/settings_local_datasource.dart';
import 'package:pocketly/features/settings/data/repositories/settings_repository_impl.dart';

part 'settings_providers.g.dart';

/// Provider pour SharedPreferences
@riverpod
Future<SharedPreferences> settingsSharedPreferences(Ref ref) async {
  return await SharedPreferences.getInstance();
}

/// Provider pour le datasource local des paramètres
@riverpod
Future<SettingsLocalDataSource> settingsLocalDataSource(Ref ref) async {
  final prefs = await ref.watch(settingsSharedPreferencesProvider.future);
  return SettingsLocalDataSource(prefs);
}

/// Provider pour le repository des paramètres
@riverpod
Future<SettingsRepository> settingsRepository(Ref ref) async {
  final localDataSource = await ref.watch(settingsLocalDataSourceProvider.future);
  return SettingsRepositoryImpl(localDataSource);
}

/// Provider pour le use case GetSettings
@riverpod
Future<GetSettingsUseCase> getSettingsUseCase(Ref ref) async {
  final repository = await ref.watch(settingsRepositoryProvider.future);
  return GetSettingsUseCase(repository);
}

/// Provider pour le use case UpdateThemeMode
@riverpod
Future<UpdateThemeModeUseCase> updateThemeModeUseCase(Ref ref) async {
  final repository = await ref.watch(settingsRepositoryProvider.future);
  return UpdateThemeModeUseCase(repository);
}

/// Provider pour le use case ResetSettings
@riverpod
Future<ResetSettingsUseCase> resetSettingsUseCase(Ref ref) async {
  final repository = await ref.watch(settingsRepositoryProvider.future);
  return ResetSettingsUseCase(repository);
}

/// Notifier pour la gestion des paramètres de l'application
@riverpod
class SettingsNotifier extends _$SettingsNotifier {
  @override
  Future<AppSettingsEntity> build() async {
    // Charger les paramètres initiaux
    return await _loadSettings();
  }

  /// Charge les paramètres
  Future<AppSettingsEntity> _loadSettings() async {
    try {
      final getSettingsUseCase = await ref.read(getSettingsUseCaseProvider.future);
      return await getSettingsUseCase();
    } catch (e) {
      // Log l'erreur avec le logger centralisé
      ref.read(loggerProvider).e('Erreur lors du chargement des paramètres', error: e);
      rethrow; // Re-throw l'erreur spécifique
    }
  }

  /// Rafraîchit les paramètres
  Future<void> refreshSettings() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return await _loadSettings();
    });
  }

  /// Met à jour le mode du thème
  Future<void> updateThemeMode(String themeMode) async {
    try {
      state = const AsyncValue.loading();
      final updateThemeModeUseCase = await ref.read(updateThemeModeUseCaseProvider.future);
      await updateThemeModeUseCase(themeMode);

      // Recharge les paramètres après mise à jour
      state = await AsyncValue.guard(() async {
        return await _loadSettings();
      });
    } catch (e) {
      ref.read(loggerProvider).e('Erreur lors de la mise à jour du mode du thème', error: e);
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  /// Réinitialise les paramètres
  Future<void> resetSettings() async {
    try {
      state = const AsyncValue.loading();
      final resetSettingsUseCase = await ref.read(resetSettingsUseCaseProvider.future);
      await resetSettingsUseCase();

      // Recharge les paramètres après réinitialisation
      state = await AsyncValue.guard(() async {
        return await _loadSettings();
      });
    } catch (e) {
      ref.read(loggerProvider).e('Erreur lors de la réinitialisation des paramètres', error: e);
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}

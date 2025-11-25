import 'package:pocketly/features/settings/domain/entities/app_settings_entity.dart';
import 'package:pocketly/features/settings/domain/repositories/settings_repository.dart';
import 'package:pocketly/features/settings/data/datasources/settings_local_datasource.dart';

/// Implémentation du repository des paramètres.
class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsLocalDataSource _localDataSource;

  SettingsRepositoryImpl(this._localDataSource);

  /// Paramètres par défaut
  static const AppSettingsEntity _defaultSettings = AppSettingsEntity(
    themeMode: 'system',
    notificationsEnabled: true,
    dateFormat: 'dd/MM/yyyy',
  );

  @override
  Future<AppSettingsEntity> getSettings() async {
    try {
      final settingsMap = await _localDataSource.getSettings();
      if (settingsMap == null) {
        // Sauvegarder les paramètres par défaut
        await saveSettings(_defaultSettings);
        return _defaultSettings;
      }
      return AppSettingsEntity.fromJson(settingsMap);
    } catch (e) {
      // En cas d'erreur, retourner les paramètres par défaut
      return _defaultSettings;
    }
  }

  @override
  Future<void> saveSettings(AppSettingsEntity settings) async {
    await _localDataSource.saveSettings(settings.toJson());
  }

  @override
  Future<void> updateThemeMode(String themeMode) async {
    final currentSettings = await getSettings();
    final updatedSettings = currentSettings.copyWith(themeMode: themeMode);
    await saveSettings(updatedSettings);
  }

  @override
  Future<void> updateNotificationsEnabled(bool enabled) async {
    final currentSettings = await getSettings();
    final updatedSettings = currentSettings.copyWith(notificationsEnabled: enabled);
    await saveSettings(updatedSettings);
  }

  @override
  Future<void> resetSettings() async {
    await saveSettings(_defaultSettings);
  }
}

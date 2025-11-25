import 'package:pocketly/features/settings/domain/entities/app_settings_entity.dart';

/// Interface pour le repository des paramètres de l'application.
abstract class SettingsRepository {
  /// Récupère les paramètres de l'application.
  Future<AppSettingsEntity> getSettings();

  /// Sauvegarde les paramètres de l'application.
  Future<void> saveSettings(AppSettingsEntity settings);

  /// Met à jour le mode du thème.
  Future<void> updateThemeMode(String themeMode);

  /// Met à jour l'activation des notifications.
  Future<void> updateNotificationsEnabled(bool enabled);

  /// Réinitialise les paramètres aux valeurs par défaut.
  Future<void> resetSettings();
}

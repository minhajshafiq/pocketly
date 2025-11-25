import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pocketly/core/errors/common_errors.dart';

/// DataSource local pour la gestion des paramètres de l'application.
class SettingsLocalDataSource {
  final SharedPreferences _prefs;

  static const String _settingsKey = 'app_settings';

  SettingsLocalDataSource(this._prefs);

  /// Récupère les paramètres stockés localement.
  Future<Map<String, dynamic>?> getSettings() async {
    try {
      final settingsJson = _prefs.getString(_settingsKey);
      if (settingsJson == null) {
        return null;
      }
      return jsonDecode(settingsJson) as Map<String, dynamic>;
    } catch (e, stackTrace) {
      throw CacheError(
        operation: 'get_settings',
        technicalMessage: 'Failed to get settings from cache: $e',
        stackTrace: stackTrace,
      );
    }
  }

  /// Sauvegarde les paramètres localement.
  Future<void> saveSettings(Map<String, dynamic> settings) async {
    try {
      final settingsJson = jsonEncode(settings);
      await _prefs.setString(_settingsKey, settingsJson);
    } catch (e, stackTrace) {
      throw CacheError(
        operation: 'save_settings',
        technicalMessage: 'Failed to save settings to cache: $e',
        stackTrace: stackTrace,
      );
    }
  }

  /// Supprime les paramètres stockés localement.
  Future<void> clearSettings() async {
    try {
      await _prefs.remove(_settingsKey);
    } catch (e, stackTrace) {
      throw CacheError(
        operation: 'clear_settings',
        technicalMessage: 'Failed to clear settings from cache: $e',
        stackTrace: stackTrace,
      );
    }
  }
}

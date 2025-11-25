import 'package:shared_preferences/shared_preferences.dart';

/// DataSource local pour la gestion de la locale
class LocaleLocalDataSource {
  LocaleLocalDataSource(this._prefs);

  final SharedPreferences _prefs;

  static const String _localeKey = 'app_locale';

  /// Récupère le code de langue sauvegardé
  Future<String?> getLocale() async {
    return _prefs.getString(_localeKey);
  }

  /// Sauvegarde le code de langue
  Future<void> saveLocale(String languageCode) async {
    await _prefs.setString(_localeKey, languageCode);
  }

  /// Supprime la locale sauvegardée (revient à la locale du système)
  Future<void> clearLocale() async {
    await _prefs.remove(_localeKey);
  }
}

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pocketly/core/errors/common_errors.dart';

/// DataSource local pour la gestion de la devise utilisateur.
///
/// Utilise SharedPreferences pour persister la devise sélectionnée.
class CurrencyLocalDataSource {
  final SharedPreferences _prefs;

  static const String _currencyKey = 'user_currency';

  CurrencyLocalDataSource(this._prefs);

  /// Récupère la devise sauvegardée localement.
  ///
  /// Returns: Les données JSON de la devise ou null si non trouvée.
  /// Throws: [CacheError] si une erreur survient lors de la lecture.
  Future<Map<String, dynamic>?> getUserCurrency() async {
    try {
      final currencyJson = _prefs.getString(_currencyKey);
      if (currencyJson == null) {
        return null;
      }
      return jsonDecode(currencyJson) as Map<String, dynamic>;
    } catch (e, stackTrace) {
      throw CacheError(
        operation: 'get_user_currency',
        technicalMessage: 'Failed to get user currency from cache: $e',
        stackTrace: stackTrace,
      );
    }
  }

  /// Sauvegarde la devise de l'utilisateur localement.
  ///
  /// [currency] Les données JSON de la devise à sauvegarder.
  /// Throws: [CacheError] si la sauvegarde échoue.
  Future<void> setUserCurrency(Map<String, dynamic> currency) async {
    try {
      final currencyJson = jsonEncode(currency);
      await _prefs.setString(_currencyKey, currencyJson);
    } catch (e, stackTrace) {
      throw CacheError(
        operation: 'set_user_currency',
        technicalMessage: 'Failed to save user currency to cache: $e',
        stackTrace: stackTrace,
      );
    }
  }

  /// Supprime la devise sauvegardée.
  ///
  /// Throws: [CacheError] si la suppression échoue.
  Future<void> clearUserCurrency() async {
    try {
      await _prefs.remove(_currencyKey);
    } catch (e, stackTrace) {
      throw CacheError(
        operation: 'clear_user_currency',
        technicalMessage: 'Failed to clear user currency from cache: $e',
        stackTrace: stackTrace,
      );
    }
  }
}

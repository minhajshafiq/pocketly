import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Configuration centralisée pour les clés RevenueCat.
///
/// Toutes les clés sont chargées via `flutter_dotenv` pour éviter toute fuite
/// dans le code source et faciliter la gestion multi-environnements.
class RevenueCatConfig {
  RevenueCatConfig._();

  /// Clé iOS (Publishable) RevenueCat
  static String get iosApiKey => _readRequired('REVENUECAT_IOS_API_KEY');

  /// Clé Android (Publishable) RevenueCat
  static String get androidApiKey =>
      _readRequired('REVENUECAT_ANDROID_API_KEY');

  static String _readRequired(String key) {
    final value = dotenv.env[key];
    if (value != null && value.isNotEmpty) {
      return value;
    }
    throw Exception(
      '$key n\'est pas défini dans votre fichier .env. '
      'Ajoutez $key=<valeur> dans .env ou utilisez --dart-define.',
    );
  }
}

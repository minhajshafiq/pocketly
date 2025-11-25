import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Configuration pour l'API logo.dev
///
/// Toutes les valeurs sensibles proviennent des variables d'environnement afin
/// d'éviter d'exposer des tokens dans le code source. Assurez-vous de charger
/// le fichier `.env` (cf. `main.dart`) avant d'accéder à ces valeurs.
class LogoDevConfig {
  LogoDevConfig._();

  /// Token d'authentification (recherche)
  static String get authToken => _readRequired('LOGO_DEV_AUTH_TOKEN');

  /// Token pour la récupération des images
  static String get imageToken => _readRequired('LOGO_DEV_IMAGE_TOKEN');

  /// Base URL pour l'API de recherche (valeur par défaut = api.logo.dev)
  static String get searchApiUrl =>
      _readOptional('LOGO_DEV_SEARCH_API_URL') ?? 'https://api.logo.dev';

  /// Base URL pour les images (valeur par défaut = img.logo.dev)
  static String get imageBaseUrl =>
      _readOptional('LOGO_DEV_IMAGE_BASE_URL') ?? 'https://img.logo.dev';

  /// Headers pour l'authentification API
  static Map<String, String> get authHeaders => {
    'Authorization': 'Bearer $authToken',
    'Content-Type': 'application/json',
  };

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

  static String? _readOptional(String key) {
    final value = dotenv.env[key];
    if (value == null || value.isEmpty) {
      return null;
    }
    return value;
  }
}

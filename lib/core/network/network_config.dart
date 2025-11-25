/// Configuration réseau pour Pocketly.
///
/// Contient les paramètres de configuration pour les appels réseau.
class NetworkConfig {
  NetworkConfig._();

  /// Timeout par défaut pour les requêtes HTTP (30 secondes)
  static const Duration defaultTimeout = Duration(seconds: 30);

  /// Timeout pour les requêtes de connexion (10 secondes)
  static const Duration connectionTimeout = Duration(seconds: 10);

  /// Timeout pour les requêtes de lecture (30 secondes)
  static const Duration readTimeout = Duration(seconds: 30);

  /// Timeout pour les requêtes d'écriture (30 secondes)
  static const Duration writeTimeout = Duration(seconds: 30);

  /// Nombre maximum de tentatives de reconnexion
  static const int maxRetries = 3;

  /// Délai entre les tentatives de reconnexion
  static const Duration retryDelay = Duration(seconds: 2);

  /// Taille maximale du cache (50 MB)
  static const int maxCacheSize = 50 * 1024 * 1024;

  /// Durée de vie du cache (24 heures)
  static const Duration cacheLifetime = Duration(hours: 24);

  /// Headers par défaut pour les requêtes HTTP
  static const Map<String, String> defaultHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'User-Agent': 'Pocketly/1.0.0',
  };

  /// Codes de statut HTTP considérés comme des erreurs
  static const List<int> errorStatusCodes = [
    400,
    401,
    403,
    404,
    405,
    408,
    409,
    410,
    422,
    429,
    500,
    502,
    503,
    504,
  ];

  /// Codes de statut HTTP pour les erreurs de client
  static const List<int> clientErrorStatusCodes = [
    400,
    401,
    403,
    404,
    405,
    408,
    409,
    410,
    422,
    429,
  ];

  /// Codes de statut HTTP pour les erreurs de serveur
  static const List<int> serverErrorStatusCodes = [500, 502, 503, 504];

  /// Vérifie si un code de statut est une erreur
  static bool isErrorStatusCode(int statusCode) {
    return errorStatusCodes.contains(statusCode);
  }

  /// Vérifie si un code de statut est une erreur de client
  static bool isClientErrorStatusCode(int statusCode) {
    return clientErrorStatusCodes.contains(statusCode);
  }

  /// Vérifie si un code de statut est une erreur de serveur
  static bool isServerErrorStatusCode(int statusCode) {
    return serverErrorStatusCodes.contains(statusCode);
  }

  /// Obtient le message d'erreur pour un code de statut
  static String getErrorMessage(int statusCode) {
    switch (statusCode) {
      case 400:
        return 'Requête invalide';
      case 401:
        return 'Non autorisé';
      case 403:
        return 'Accès interdit';
      case 404:
        return 'Ressource non trouvée';
      case 405:
        return 'Méthode non autorisée';
      case 408:
        return 'Délai d\'attente dépassé';
      case 409:
        return 'Conflit';
      case 410:
        return 'Ressource supprimée';
      case 422:
        return 'Données non traitable';
      case 429:
        return 'Trop de requêtes';
      case 500:
        return 'Erreur interne du serveur';
      case 502:
        return 'Passerelle invalide';
      case 503:
        return 'Service indisponible';
      case 504:
        return 'Délai d\'attente de la passerelle';
      default:
        return 'Erreur inconnue';
    }
  }
}

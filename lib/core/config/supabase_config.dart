import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Configuration pour Supabase
///
/// Suivant les recommandations de Supabase (https://github.com/orgs/supabase/discussions/29260)
/// pour les nouvelles clés API.
///
/// Les clés sont chargées depuis le fichier .env pour permettre la gestion
/// d'environnements multiples (dev/staging/prod).
class SupabaseConfig {
  /// URL de l'instance Supabase
  ///
  /// Chargée depuis la variable d'environnement SUPABASE_URL.
  /// Fallback vers une valeur par défaut si non définie (pour compatibilité).
  static String get supabaseUrl {
    final url = dotenv.env['SUPABASE_URL'];
    if (url != null && url.isNotEmpty) {
      return url;
    }
    // Fallback pour compatibilité (ne devrait pas arriver si .env est correctement configuré)
    throw Exception(
      'SUPABASE_URL n\'est pas défini dans le fichier .env. '
      'Vérifiez que le fichier .env existe et contient SUPABASE_URL=...',
    );
  }

  /// Clé publishable pour l'authentification anonyme
  ///
  /// Chargée depuis la variable d'environnement SUPABASE_ANON_KEY.
  /// Cette clé est sécuritaire pour une utilisation dans des applications mobiles
  /// selon les recommandations de Supabase (https://github.com/orgs/supabase/discussions/29260)
  static String get supabaseAnonKey {
    final key = dotenv.env['SUPABASE_ANON_KEY'];
    if (key != null && key.isNotEmpty) {
      return key;
    }
    // Fallback pour compatibilité (ne devrait pas arriver si .env est correctement configuré)
    throw Exception(
      'SUPABASE_ANON_KEY n\'est pas défini dans le fichier .env. '
      'Vérifiez que le fichier .env existe et contient SUPABASE_ANON_KEY=...',
    );
  }

  /// Initialise Supabase
  ///
  /// Doit être appelé après avoir chargé le fichier .env avec dotenv.load().
  static Future<void> initialize() async {
    await Supabase.initialize(
      url: supabaseUrl,
      anonKey: supabaseAnonKey,
      debug: kDebugMode, // Utilise kDebugMode au lieu de true
    );
  }

  /// Récupère l'instance Supabase
  static SupabaseClient get client => Supabase.instance.client;
}

import 'package:supabase_flutter/supabase_flutter.dart';

/// Configuration pour Supabase
/// 
/// Suivant les recommandations de Supabase (https://github.com/orgs/supabase/discussions/29260)
/// pour les nouvelles clés API.
class SupabaseConfig {
  /// URL de l'instance Supabase
  static const String supabaseUrl = 'https://bwdqbfromrqpcphcydoq.supabase.co';
  
  /// Clé publishable pour l'authentification anonyme
  /// 
  /// Cette clé est sécuritaire pour une utilisation dans des applications mobiles
  /// selon les recommandations de Supabase (https://github.com/orgs/supabase/discussions/29260)
  static const String supabaseAnonKey = 'sb_publishable_RdozNsZvoo_kWWdeEkCSug_ex7em3Th';

  /// Initialise Supabase
  static Future<void> initialize() async {
    await Supabase.initialize(
      url: supabaseUrl,
      anonKey: supabaseAnonKey,
      debug: false,
    );
  }

  /// Récupère l'instance Supabase
  static SupabaseClient get client => Supabase.instance.client;
}

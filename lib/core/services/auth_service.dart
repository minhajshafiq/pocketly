import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:pocketly/core/config/supabase_config.dart';

/// Service centralisé pour la gestion de l'authentification.
///
/// Ce service encapsule toute la logique d'authentification et peut être utilisé
/// par le router sans créer de dépendances circulaires avec les providers.
class AuthService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  /// Client Supabase
  SupabaseClient get _client => SupabaseConfig.client;

  /// Vérifie si l'utilisateur est actuellement authentifié
  bool get isAuthenticated => _client.auth.currentUser != null;

  /// Récupère l'utilisateur actuellement connecté
  User? get currentUser => _client.auth.currentUser;

  /// Récupère l'ID de l'utilisateur actuel
  String? get currentUserId => _client.auth.currentUser?.id;

  /// Vérifie si l'utilisateur est en cours de chargement
  bool get isLoading => _client.auth.currentSession == null;

  /// Stream des changements d'état d'authentification
  Stream<AuthState> get authStateChanges => _client.auth.onAuthStateChange;

  /// Vérifie si l'utilisateur peut accéder à une route protégée
  bool canAccessProtectedRoute() {
    return isAuthenticated;
  }

  /// Vérifie si l'utilisateur peut accéder à une route publique
  bool canAccessPublicRoute() {
    return true; // Les routes publiques sont toujours accessibles
  }

  /// Détermine la route de redirection selon l'état d'authentification
  String? getRedirectRoute(String currentRoute) {
    final publicRoutes = ['/welcome', '/signin', '/signup'];

    // Si l'utilisateur n'est pas authentifié
    if (!isAuthenticated) {
      // Si on est déjà sur une route publique, pas de redirection
      if (publicRoutes.contains(currentRoute)) {
        return null;
      }
      // Sinon, rediriger vers welcome
      return '/welcome';
    }

    // Si l'utilisateur est authentifié
    if (isAuthenticated) {
      // Si on est sur une route publique, rediriger vers home
      if (publicRoutes.contains(currentRoute)) {
        return '/home';
      }
    }

    // Sinon, pas de redirection
    return null;
  }

  /// Déconnecte l'utilisateur actuel
  Future<void> signOut() async {
    await _client.auth.signOut();
  }

  /// Supprime le compte utilisateur de Supabase Auth
  ///
  /// ⚠️ ATTENTION : Cette opération supprime uniquement l'utilisateur d'Auth.
  /// Les données associées doivent être supprimées AVANT d'appeler cette méthode.
  Future<void> deleteAuthUser() async {
    final user = currentUser;
    if (user == null) {
      // Si l'utilisateur n'est plus authentifié, considérer que c'est déjà fait
      return;
    }

    try {
      // Supprimer l'utilisateur d'Auth via RPC
      // Note: Cette fonction RPC doit exister dans Supabase
      await _client.rpc('delete_user').timeout(
        const Duration(seconds: 5),
        onTimeout: () {
          // Si timeout, considérer que c'est OK (l'utilisateur peut déjà être supprimé)
          return;
        },
      );
    } catch (e) {
      // Si la fonction RPC n'existe pas ou échoue, essayer de supprimer via l'admin API
      // Pour l'instant, on ignore l'erreur car les données sont déjà supprimées
      debugPrint('Erreur lors de la suppression Auth (ignorée): $e');
      // Ne pas rethrow - continuer quand même
    }
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pocketly/core/router/app_router.dart';

/// Provider pour le routeur de l'application.
/// 
/// Fournit une instance unique de GoRouter accessible via Riverpod
/// dans toute l'application.
final appRouterProvider = Provider<GoRouter>((ref) {
  return AppRouter.instance;
});

/// Provider pour vérifier si l'utilisateur est authentifié.
/// 
/// TODO: À implémenter avec la logique d'authentification réelle
/// Une fois le système d'authentification en place, ce provider
/// devrait écouter l'état de l'authentification et retourner true/false.
final isAuthenticatedProvider = Provider<bool>((ref) => false);

/// Provider pour obtenir l'utilisateur actuel.
/// 
/// TODO: À implémenter avec la logique d'authentification réelle
/// Devrait retourner les données de l'utilisateur connecté ou null.
final currentUserProvider = Provider<Map<String, dynamic>?>((ref) => null);

/// Guard de navigation pour les routes protégées.
/// 
/// Cette classe peut être utilisée pour implémenter un système
/// de redirection automatique vers la page de login si l'utilisateur
/// n'est pas authentifié.
/// 
/// Exemple d'utilisation future dans app_router.dart :
/// ```dart
/// redirect: (context, state) {
///   final isAuthenticated = ref.read(isAuthenticatedProvider);
///   final isLoginPage = state.uri.toString() == AppRoutePaths.login;
///   
///   if (!isAuthenticated && !isLoginPage) {
///     return AppRoutePaths.login;
///   }
///   
///   if (isAuthenticated && isLoginPage) {
///     return AppRoutePaths.home;
///   }
///   
///   return null; // Pas de redirection
/// }
/// ```
class AuthGuard {
  /// Vérifie si une route nécessite une authentification
  static bool requiresAuth(String path) {
    // Liste des routes publiques (ne nécessitant pas d'authentification)
    const publicRoutes = [
      '/',
      '/login',
      '/register',
      '/forgot-password',
      '/reset-password',
    ];
    
    return !publicRoutes.contains(path);
  }
  
  /// Obtient la route de redirection si l'utilisateur n'est pas authentifié
  static String? getRedirect({
    required bool isAuthenticated,
    required String currentPath,
  }) {
    final needsAuth = requiresAuth(currentPath);
    
    // Si la route nécessite une authentification et que l'utilisateur n'est pas connecté
    if (needsAuth && !isAuthenticated) {
      return '/login';
    }
    
    // Si l'utilisateur est connecté et essaie d'accéder à la page de login
    if (isAuthenticated && currentPath == '/login') {
      return '/home';
    }
    
    // Pas de redirection nécessaire
    return null;
  }
}

/// Extension pour faciliter l'accès au routeur via Riverpod
extension RouterRefExtension on WidgetRef {
  /// Obtient l'instance du routeur
  GoRouter get router => read(appRouterProvider);
  
  /// Vérifie si l'utilisateur est authentifié
  bool get isAuthenticated => watch(isAuthenticatedProvider);
  
  /// Obtient l'utilisateur actuel
  Map<String, dynamic>? get currentUser => watch(currentUserProvider);
}


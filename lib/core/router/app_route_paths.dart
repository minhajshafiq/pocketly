/// Constantes de chemins de navigation pour l'application Pocketly.
/// 
/// Centralise tous les chemins de routes pour faciliter la maintenance
/// et éviter les erreurs de typage.
class AppRoutePaths {
  // Private constructor pour empêcher l'instanciation
  AppRoutePaths._();

  // ==================== ROUTES PUBLIQUES ====================
  
  /// Route de l'écran d'accueil/bienvenue
  static const String welcome = '/';
  
  /// Route de l'écran de connexion
  static const String login = '/login';
  
  /// Route de l'écran d'accueil principal (après connexion)
  static const String home = '/home';
  
  /// Route de l'écran des paramètres
  static const String settings = '/settings';
  
  // ==================== ROUTES AUTHENTIFICATION ====================
  
  /// Route de l'écran d'inscription
  static const String register = '/register';
  
  /// Route de l'écran de récupération de mot de passe
  static const String forgotPassword = '/forgot-password';
  
  /// Route de l'écran de réinitialisation de mot de passe
  static const String resetPassword = '/reset-password';
  
  // ==================== ROUTES TRANSACTIONS ====================
  
  /// Route de l'écran de liste des transactions
  static const String transactions = '/transactions';
  
  /// Route de l'écran de détail d'une transaction
  /// Utiliser : `${AppRoutePaths.transactionDetail}/$id`
  static const String transactionDetail = '/transactions/:id';
  
  /// Route de l'écran d'ajout de transaction
  static const String addTransaction = '/transactions/add';
  
  /// Route de l'écran d'édition de transaction
  /// Utiliser : `${AppRoutePaths.editTransaction}/$id`
  static const String editTransaction = '/transactions/edit/:id';
  
  // ==================== ROUTES PROFIL ====================
  
  /// Route de l'écran de profil utilisateur
  static const String profile = '/profile';
  
  /// Route de l'écran d'édition de profil
  static const String editProfile = '/profile/edit';
  
  // ==================== ROUTES ERREUR ====================
  
  /// Route de l'écran d'erreur 404
  static const String notFound = '/404';
  
  /// Route de l'écran d'erreur générique
  static const String error = '/error';
  
  // ==================== HELPERS ====================
  
  /// Construit le chemin de détail d'une transaction
  static String transactionDetailPath(String id) {
    return '/transactions/$id';
  }
  
  /// Construit le chemin d'édition d'une transaction
  static String editTransactionPath(String id) {
    return '/transactions/edit/$id';
  }
  
  /// Vérifie si un chemin nécessite une authentification
  static bool requiresAuth(String path) {
    return path != welcome && 
           path != login && 
           path != register && 
           path != forgotPassword &&
           path != resetPassword;
  }
}


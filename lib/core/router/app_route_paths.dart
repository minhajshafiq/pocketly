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
  static const String signin = '/signin';

  /// Route de l'écran d'accueil principal (après connexion)
  static const String home = '/home';

  /// Route de l'écran des paramètres
  static const String settings = '/settings';

  /// Route des mentions légales
  static const String legalNotice = '/settings/legal-notice';

  /// Route de la politique de confidentialité
  static const String privacyPolicy = '/settings/privacy-policy';

  /// Route des conditions d'utilisation
  static const String termsOfUse = '/settings/terms-of-use';

  /// Route de l'écran des paramètres de notifications (ancienne version)
  static const String notificationSettings = '/settings/notifications';

  /// Route de l'écran des préférences de notifications (nouvelle version)
  static const String notificationPreferences =
      '/settings/notification-preferences';

  /// Route du centre de notifications
  static const String notificationsCenter = '/notifications';

  /// Route de la démonstration des notifications
  static const String notificationDemo = '/notifications/demo';

  /// Route de l'écran des statistiques
  static const String statistics = '/statistics';

  /// Route de l'écran des pockets
  static const String pockets = '/pockets';

  /// Route de l'écran de détail d'un pocket
  /// Utiliser : `${AppRoutePaths.pocketDetail}/$id`
  static const String pocketDetail = '/pockets/:id';

  /// Route de l'écran de création d'un pocket
  static const String createPocket = '/pockets/create';

  /// Route de l'écran d'édition d'un pocket
  /// Utiliser : `${AppRoutePaths.editPocket}/$id`
  static const String editPocket = '/pockets/edit/:id';

  // ==================== ROUTES AUTHENTIFICATION ====================

  /// Route de l'écran d'inscription
  static const String signup = '/signup';

  /// Route de l'écran de récupération de mot de passe
  static const String forgotPassword = '/forgot-password';

  /// Route de l'écran de réinitialisation de mot de passe
  static const String resetPassword = '/reset-password';

  // ==================== ROUTES ONBOARDING ====================

  /// Route de l'étape 1 de l'onboarding
  static const String step1 = '/onboarding/step1';

  /// Route de l'étape 2 de l'onboarding
  static const String step2 = '/onboarding/step2';

  /// Route de l'étape 3 de l'onboarding
  static const String step3 = '/onboarding/step3';

  /// Route de l'étape 4 de l'onboarding
  static const String step4 = '/onboarding/step4';

  // ==================== ROUTES TRANSACTIONS ====================

  /// Route de l'écran de liste des transactions
  static const String transactions = '/transactions';

  /// Route de l'écran de détail d'une transaction
  /// Utiliser : `${AppRoutePaths.transactionDetail}/$id`
  static const String transactionDetail = '/transactions/:id';

  /// Route de l'écran d'ajout de transaction (ancienne version - une seule page)
  static const String addTransaction = '/transactions/add';

  /// Route de l'écran d'ajout de transaction - Étape 1 : Montant
  static const String addTransactionAmount = '/transactions/add/amount';

  /// Route de l'écran d'ajout de transaction - Étape 2 : Détails
  static const String addTransactionDetails = '/transactions/add/details';

  /// Route de l'écran d'édition de transaction
  /// Utiliser : `${AppRoutePaths.editTransaction}/$id`
  static const String editTransaction = '/transactions/edit/:id';

  /// Route de l'écran d'historique des transactions
  static const String transactionHistory = '/history';

  // ==================== ROUTES CATÉGORIES ====================

  /// Route de l'écran de liste des catégories
  static const String categories = '/categories';

  /// Route de l'écran de création de catégorie
  static const String createCategory = '/categories/create';

  /// Route de l'écran d'édition de catégorie
  /// Utiliser : `${AppRoutePaths.editCategory}/$id`
  static const String editCategory = '/categories/edit/:id';

  // ==================== ROUTES TRANSACTIONS ====================

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

  /// Construit le chemin de détail d'un pocket
  static String pocketDetailPath(String id) {
    return '/pockets/$id';
  }

  /// Construit le chemin d'édition d'un pocket
  static String editPocketPath(String id) {
    return '/pockets/edit/$id';
  }

  /// Construit le chemin d'édition d'une catégorie
  static String editCategoryPath(String id) {
    return '/categories/edit/$id';
  }

  /// Vérifie si un chemin nécessite une authentification
  static bool requiresAuth(String path) {
    return path != welcome &&
        path != signin &&
        path != signup &&
        path != forgotPassword &&
        path != resetPassword;
  }
}

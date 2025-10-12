import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pocketly/core/router/app_page.dart';
import 'package:pocketly/core/router/app_route_paths.dart';
import 'package:pocketly/features/onboarding/presentation/screens/welcome_screen.dart';
import 'package:pocketly/features/auth/presentation/screens/login_screen.dart';
import 'package:pocketly/features/themes/presentation/widgets/theme_selector.dart';
import 'package:pocketly/core/constants/app_constants.dart';

/// Configuration du routeur de l'application avec GoRouter.
/// 
/// Gère la navigation de manière centralisée avec :
/// - Transitions adaptatives iOS/Android
/// - Gestes de retour natifs (swipe back iOS, back button Android)
/// - Support des routes paramétrées
/// - Gestion des erreurs 404
/// - Architecture extensible pour ajouter de nouvelles routes
class AppRouter {
  // Private constructor pour pattern singleton
  AppRouter._();

  /// Instance unique du routeur
  static GoRouter? _router;

  /// Obtient l'instance du routeur
  static GoRouter get instance {
    _router ??= _createRouter();
    return _router!;
  }

  /// Crée la configuration du routeur
  static GoRouter _createRouter() {
    return GoRouter(
      // Configuration initiale
      initialLocation: AppRoutePaths.welcome,
      
      // Mode debug pour voir les logs de navigation
      debugLogDiagnostics: true,
      
      // Gestion des erreurs de navigation
      errorBuilder: (context, state) => _buildErrorPage(context, state),
      
      // Routes de l'application
      routes: [
        // ==================== ROUTE D'ACCUEIL ====================
        GoRoute(
          path: AppRoutePaths.welcome,
          name: 'welcome',
          pageBuilder: (context, state) => AppPage.adaptive(
            key: state.pageKey,
            name: state.name,
            child: const WelcomeScreen(),
          ),
        ),

        // ==================== ROUTES D'AUTHENTIFICATION ====================
        GoRoute(
          path: AppRoutePaths.login,
          name: 'login',
          pageBuilder: (context, state) => AppPage.adaptive(
            key: state.pageKey,
            name: state.name,
            child: const LoginScreen(),
          ),
        ),

        GoRoute(
          path: AppRoutePaths.register,
          name: 'register',
          pageBuilder: (context, state) => AppPage.adaptive(
            key: state.pageKey,
            name: state.name,
            child: const Scaffold(
              body: Center(
                child: Text(
                  'Register Screen\n(À implémenter)',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ),
          ),
        ),

        GoRoute(
          path: AppRoutePaths.forgotPassword,
          name: 'forgotPassword',
          pageBuilder: (context, state) => AppPage.adaptive(
            key: state.pageKey,
            name: state.name,
            child: const Scaffold(
              body: Center(
                child: Text(
                  'Forgot Password Screen\n(À implémenter)',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ),
          ),
        ),

        // ==================== ROUTE HOME ====================
        GoRoute(
          path: AppRoutePaths.home,
          name: 'home',
          pageBuilder: (context, state) => AppPage.adaptive(
            key: state.pageKey,
            name: state.name,
            child: Scaffold(
              appBar: AppBar(
                title: const Text('Home'),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.settings),
                    onPressed: () => context.push(AppRoutePaths.settings),
                  ),
                ],
              ),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Home Screen',
                      style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () => context.push(AppRoutePaths.transactions),
                      child: const Text('Voir les transactions'),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () => context.push(AppRoutePaths.profile),
                      child: const Text('Voir le profil'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

        // ==================== ROUTE SETTINGS ====================
        GoRoute(
          path: AppRoutePaths.settings,
          name: 'settings',
          pageBuilder: (context, state) => AppPage.adaptive(
            key: state.pageKey,
            name: state.name,
            child: Scaffold(
              appBar: AppBar(
                title: const Text('Settings'),
              ),
              body: SingleChildScrollView(
                padding: EdgeInsets.all(AppDimensions.paddingL),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Section Thème
                    Text(
                      'Apparence',
                      style: AppTypography.title.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: AppDimensions.paddingM),
                    
                    // Theme Selector
                    ThemeSelector(
                      style: ThemeSelectorStyle.card,
                      size: ThemeSelectorSize.medium,
                      showDescriptions: true,
                      showIcons: true,
                    ),
                    
                    SizedBox(height: AppDimensions.paddingXL),
                    
                    // Section Autres paramètres
                    Text(
                      'Autres paramètres',
                      style: AppTypography.title.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: AppDimensions.paddingM),
                    
                    // Placeholder pour d'autres paramètres
                    Container(
                      padding: EdgeInsets.all(AppDimensions.paddingL),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                        border: Border.all(
                          color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
                        ),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.settings_outlined,
                            size: 48,
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                          SizedBox(height: AppDimensions.paddingM),
                          Text(
                            'Autres paramètres',
                            style: AppTypography.title,
                          ),
                          SizedBox(height: AppDimensions.paddingS),
                          Text(
                            'À implémenter',
                            style: AppTypography.body.copyWith(
                              color: Theme.of(context).colorScheme.onSurfaceVariant,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

        // ==================== ROUTES TRANSACTIONS ====================
        GoRoute(
          path: AppRoutePaths.transactions,
          name: 'transactions',
          pageBuilder: (context, state) => AppPage.adaptive(
            key: state.pageKey,
            name: state.name,
            child: Scaffold(
              appBar: AppBar(
                title: const Text('Transactions'),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () => context.push(AppRoutePaths.addTransaction),
                  ),
                ],
              ),
              body: const Center(
                child: Text(
                  'Transactions List\n(À implémenter)',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ),
          ),
        ),

        GoRoute(
          path: AppRoutePaths.transactionDetail,
          name: 'transactionDetail',
          pageBuilder: (context, state) {
            final id = state.pathParameters['id'] ?? '';
            return AppPage.adaptive(
              key: state.pageKey,
              name: state.name,
              child: Scaffold(
                appBar: AppBar(
                  title: Text('Transaction #$id'),
                ),
                body: Center(
                  child: Text(
                    'Transaction Detail\nID: $id\n(À implémenter)',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 24),
                  ),
                ),
              ),
            );
          },
        ),

        GoRoute(
          path: AppRoutePaths.addTransaction,
          name: 'addTransaction',
          pageBuilder: (context, state) => AppPage.adaptive(
            key: state.pageKey,
            name: state.name,
            child: Scaffold(
              appBar: AppBar(
                title: const Text('Add Transaction'),
              ),
              body: const Center(
                child: Text(
                  'Add Transaction Screen\n(À implémenter)',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ),
          ),
        ),

        // ==================== ROUTES PROFIL ====================
        GoRoute(
          path: AppRoutePaths.profile,
          name: 'profile',
          pageBuilder: (context, state) => AppPage.adaptive(
            key: state.pageKey,
            name: state.name,
            child: Scaffold(
              appBar: AppBar(
                title: const Text('Profile'),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () => context.push(AppRoutePaths.editProfile),
                  ),
                ],
              ),
              body: const Center(
                child: Text(
                  'Profile Screen\n(À implémenter)',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ),
          ),
        ),

        GoRoute(
          path: AppRoutePaths.editProfile,
          name: 'editProfile',
          pageBuilder: (context, state) => AppPage.adaptive(
            key: state.pageKey,
            name: state.name,
            child: Scaffold(
              appBar: AppBar(
                title: const Text('Edit Profile'),
              ),
              body: const Center(
                child: Text(
                  'Edit Profile Screen\n(À implémenter)',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// Construit la page d'erreur 404
  static Widget _buildErrorPage(BuildContext context, GoRouterState state) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Erreur'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                size: 80,
                color: Colors.red,
              ),
              const SizedBox(height: 24),
              const Text(
                '404 - Page non trouvée',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                'La page "${state.uri}" n\'existe pas.',
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              ElevatedButton.icon(
                onPressed: () => context.go(AppRoutePaths.welcome),
                icon: const Icon(Icons.home),
                label: const Text('Retour à l\'accueil'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Reset le routeur (utile pour les tests)
  static void reset() {
    _router = null;
  }
}

/// Extension pour faciliter la navigation
extension GoRouterExtension on BuildContext {
  /// Navigation avec remplacement de la route actuelle
  void goNamed(String name, {Map<String, String>? pathParameters, Map<String, dynamic>? queryParameters}) {
    GoRouter.of(this).goNamed(
      name, 
      pathParameters: pathParameters ?? {}, 
      queryParameters: queryParameters ?? {},
    );
  }

  /// Navigation avec ajout à la pile
  void pushNamed(String name, {Map<String, String>? pathParameters, Map<String, dynamic>? queryParameters}) {
    GoRouter.of(this).pushNamed(
      name, 
      pathParameters: pathParameters ?? {}, 
      queryParameters: queryParameters ?? {},
    );
  }

  /// Retour en arrière
  void pop<T extends Object?>([T? result]) {
    GoRouter.of(this).pop(result);
  }

  /// Vérifie si on peut revenir en arrière
  bool canPop() {
    return GoRouter.of(this).canPop();
  }
}


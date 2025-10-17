import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocketly/core/router/app_route_paths.dart';
import 'package:pocketly/core/router/app_page.dart';
import 'package:pocketly/core/constants/app_constants.dart';
import 'package:pocketly/features/auth/presentation/providers/auth_state_provider.dart';
import 'package:pocketly/features/auth/presentation/screens/signin_screen.dart';
import 'package:pocketly/features/auth/presentation/screens/signup_screen.dart';
import 'package:pocketly/features/notifications/presentation/screens/notification_settings_screen.dart';
import 'package:pocketly/features/notifications/presentation/widgets/notification_demo.dart';
import 'package:pocketly/features/onboarding/presentation/screens/welcome_screen.dart';
import 'package:pocketly/features/themes/presentation/widgets/theme_selector.dart';

/// Fournit la configuration du routeur pour l'application
final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);
  
  return GoRouter(
    initialLocation: AppRoutePaths.welcome,
    debugLogDiagnostics: true,
    redirect: (context, state) {
      // Si l'état d'authentification est en chargement, pas de redirection
      if (authState.isLoading) {
        return null;
      }
      
      // Routes publiques accessibles sans authentification
      final publicRoutes = [
        AppRoutePaths.welcome,
        AppRoutePaths.signin,
        AppRoutePaths.signup,
      ];
      
      // Si l'utilisateur n'est pas authentifié
      if (authState.value == null) {
        // Si on est déjà sur une route publique, pas de redirection
        if (publicRoutes.contains(state.matchedLocation)) {
          return null;
        }
        // Sinon, rediriger vers welcome
        return AppRoutePaths.welcome;
      }
      
      // Si l'utilisateur est authentifié
      final user = authState.value;
      if (user != null) {
        // Si on est sur une route publique, rediriger vers home
        if (publicRoutes.contains(state.matchedLocation)) {
          return AppRoutePaths.home;
        }
      }
      
      // Sinon, pas de redirection
      return null;
    },
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
        path: AppRoutePaths.signin,
        name: 'signin',
        pageBuilder: (context, state) => AppPage.adaptive(
          key: state.pageKey,
          name: state.name,
          child: const SigninScreen(),
        ),
      ),

      GoRoute(
        path: AppRoutePaths.signup,
        name: 'signup',
        pageBuilder: (context, state) => AppPage.adaptive(
          key: state.pageKey,
          name: state.name,
          child: const SignupScreen(),
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

      // ==================== ROUTES ONBOARDING ====================
      GoRoute(
        path: AppRoutePaths.step1,
        name: 'step1',
        pageBuilder: (context, state) => AppPage.adaptive(
          key: state.pageKey,
          name: state.name,
          child: const Scaffold(
            body: Center(child: Text('Onboarding - Étape 1')),
          ),
        ),
      ),
      
      GoRoute(
        path: AppRoutePaths.step2,
        name: 'step2',
        pageBuilder: (context, state) => AppPage.adaptive(
          key: state.pageKey,
          name: state.name,
          child: const Scaffold(
            body: Center(child: Text('Onboarding - Étape 2')),
          ),
        ),
      ),
      
      GoRoute(
        path: AppRoutePaths.step3,
        name: 'step3',
        pageBuilder: (context, state) => AppPage.adaptive(
          key: state.pageKey,
          name: state.name,
          child: const Scaffold(
            body: Center(child: Text('Onboarding - Étape 3')),
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
                  icon: Icon(AppIcons.settings),
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
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () => context.push(AppRoutePaths.notificationDemo),
                    child: const Text('Démonstration Notifications'),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      // Déconnexion
                      final container = ProviderScope.containerOf(context);
                      await container.read(authActionsProvider).signOut();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Se déconnecter'),
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
                  
                  // Notification Settings Button
                  Container(
                    padding: EdgeInsets.all(AppDimensions.paddingL),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                      border: Border.all(
                        color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
                      ),
                    ),
                    child: InkWell(
                      onTap: () => context.push(AppRoutePaths.notificationSettings),
                      borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                      child: Column(
                        children: [
                          Icon(
                            Icons.notifications_outlined,
                            size: 48,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          SizedBox(height: AppDimensions.paddingM),
                          Text(
                            'Notifications',
                            style: AppTypography.title,
                          ),
                          SizedBox(height: AppDimensions.paddingS),
                          Text(
                            'Gérer les paramètres de notifications',
                            style: AppTypography.body.copyWith(
                              color: Theme.of(context).colorScheme.onSurfaceVariant,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),

      // ==================== ROUTE NOTIFICATION SETTINGS ====================
      GoRoute(
        path: AppRoutePaths.notificationSettings,
        name: 'notificationSettings',
        pageBuilder: (context, state) => AppPage.adaptive(
          key: state.pageKey,
          name: state.name,
          child: const NotificationSettingsScreen(),
        ),
      ),

      GoRoute(
        path: AppRoutePaths.notificationDemo,
        name: 'notificationDemo',
        pageBuilder: (context, state) => AppPage.adaptive(
          key: state.pageKey,
          name: state.name,
          child: const NotificationDemo(),
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
                  icon: Icon(AppIcons.add),
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
                  icon: Icon(AppIcons.edit),
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
    
    // Gestion des erreurs de navigation
    errorBuilder: (context, state) => Scaffold(
      appBar: AppBar(
        title: const Text('Erreur'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                AppIcons.error,
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
                icon: Icon(AppIcons.home),
                label: const Text('Retour à l\'accueil'),
              ),
            ],
          ),
        ),
      ),
    ),
  );
});

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

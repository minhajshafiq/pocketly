import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocketly/core/core.dart';
import 'package:pocketly/features/auth/presentation/providers/auth_providers.dart';
import 'package:pocketly/features/auth/presentation/screens/signin_screen.dart';
import 'package:pocketly/features/auth/presentation/screens/signup_screen.dart';
import 'package:pocketly/features/auth/presentation/screens/reset_password_screen.dart';
import 'package:pocketly/features/auth/presentation/screens/forgot_password_screen.dart';
import 'package:pocketly/features/notifications/presentation/screens/notification_settings_screen.dart';
import 'package:pocketly/features/notifications/presentation/widgets/notification_demo.dart';
import 'package:pocketly/features/onboarding/presentation/screens/welcome_screen.dart';
import 'package:pocketly/features/onboarding/presentation/screens/onboarding_step1_screen.dart';
import 'package:pocketly/features/onboarding/presentation/screens/onboarding_step2_screen.dart';
import 'package:pocketly/features/onboarding/presentation/screens/onboarding_step3_screen.dart';
import 'package:pocketly/features/onboarding/presentation/screens/onboarding_step4_screen.dart';
import 'package:pocketly/features/category/presentation/screens/categories_list_screen.dart';
import 'package:pocketly/features/category/presentation/screens/add_edit_category_screen.dart';
import 'package:pocketly/features/category/domain/entities/category_entity.dart';
import 'package:pocketly/features/transactions/presentation/screens/add_transaction_screen.dart';
import 'package:pocketly/features/transactions/presentation/screens/add_transaction_amount_screen.dart';
import 'package:pocketly/features/transactions/presentation/screens/add_transaction_details_screen.dart';
import 'package:pocketly/features/transactions/domain/entities/transaction_entity.dart';
import 'package:pocketly/features/transaction_history/presentation/screens/transaction_history_screen.dart';
import 'package:pocketly/features/settings/settings.dart';
import 'package:pocketly/features/home/home.dart';
import 'package:pocketly/features/statistics/statistics.dart';
import 'package:pocketly/features/pockets/pockets.dart';
import 'package:pocketly/features/subscription/subscription.dart';
import 'package:pocketly/features/user/presentation/screens/profile_edit_screen.dart';
import 'package:pocketly/features/notifications/presentation/screens/notifications_center_screen.dart';
import 'package:pocketly/features/notifications/presentation/screens/notification_preferences_screen.dart';
import 'package:pocketly/features/settings/presentation/screens/legal_notice_screen.dart';
import 'package:pocketly/features/settings/presentation/screens/privacy_policy_screen.dart';
import 'package:pocketly/features/settings/presentation/screens/terms_of_use_screen.dart';

/// Helper function pour déterminer la route de redirection
String? _getRedirectRoute(String currentRoute, bool isAuthenticated) {
  final publicRoutes = [
    AppRoutePaths.welcome,
    AppRoutePaths.signin,
    AppRoutePaths.signup,
    AppRoutePaths.forgotPassword,
    AppRoutePaths.resetPassword,
  ];

  // Si l'utilisateur n'est pas authentifié
  if (!isAuthenticated) {
    // Si on est déjà sur une route publique, pas de redirection
    if (publicRoutes.contains(currentRoute)) {
      return null;
    }
    // Sinon, rediriger vers signin
    return AppRoutePaths.signin;
  }

  // Si l'utilisateur est authentifié
  if (isAuthenticated) {
    // Si on est sur une route publique, rediriger vers home
    if (publicRoutes.contains(currentRoute)) {
      return AppRoutePaths.home;
    }
  }

  // Sinon, pas de redirection
  return null;
}

/// Fournit la configuration du routeur pour l'application
final routerProvider = Provider<GoRouter>((ref) {
  // Créer un notifier pour surveiller les changements d'auth
  final authState = ValueNotifier<bool>(false);

  // Écouter les changements d'état d'authentification
  ref.listen(isAuthenticatedProvider, (previous, next) {
    authState.value = next;
  });

  return GoRouter(
    initialLocation: AppRoutePaths.welcome,
    debugLogDiagnostics: true,
    refreshListenable: authState,
    redirect: (context, state) {
      final isAuthenticated = authState.value;

      // Utiliser la fonction helper pour déterminer la redirection
      return _getRedirectRoute(state.matchedLocation, isAuthenticated);
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
          child: const ForgotPasswordScreen(),
        ),
      ),

      GoRoute(
        path: AppRoutePaths.resetPassword,
        name: 'resetPassword',
        pageBuilder: (context, state) {
          // Récupérer le token depuis les query parameters (optionnel)
          final token = state.uri.queryParameters['token'];

          return AppPage.adaptive(
            key: state.pageKey,
            name: state.name,
            child: ResetPasswordScreen(token: token),
          );
        },
      ),

      // ==================== ROUTES ONBOARDING ====================
      GoRoute(
        path: AppRoutePaths.step1,
        name: 'step1',
        pageBuilder: (context, state) => AppPage.adaptive(
          key: state.pageKey,
          name: state.name,
          child: const OnboardingStep1Screen(),
        ),
      ),

      GoRoute(
        path: AppRoutePaths.step2,
        name: 'step2',
        pageBuilder: (context, state) => AppPage.adaptive(
          key: state.pageKey,
          name: state.name,
          child: const OnboardingStep2Screen(),
        ),
      ),

      GoRoute(
        path: AppRoutePaths.step3,
        name: 'step3',
        pageBuilder: (context, state) => AppPage.adaptive(
          key: state.pageKey,
          name: state.name,
          child: const OnboardingStep3Screen(),
        ),
      ),

      GoRoute(
        path: AppRoutePaths.step4,
        name: 'step4',
        pageBuilder: (context, state) => AppPage.adaptive(
          key: state.pageKey,
          name: state.name,
          child: const OnboardingStep4Screen(),
        ),
      ),

      // ==================== SHELL ROUTE AVEC BOTTOM NAV ====================
      ShellRoute(
        builder: (context, state, child) {
          return MainNavigationScreen(child: child);
        },
        routes: [
          // Route Home
          GoRoute(
            path: AppRoutePaths.home,
            name: 'home',
            pageBuilder: (context, state) => AppPage.adaptive(
              key: state.pageKey,
              name: state.name,
              child: const HomeScreen(),
            ),
          ),

          // Route Transactions (Transaction History)
          GoRoute(
            path: AppRoutePaths.transactions,
            name: 'transactions',
            pageBuilder: (context, state) => AppPage.adaptive(
              key: state.pageKey,
              name: state.name,
              child: const TransactionHistoryScreen(),
            ),
          ),

          // Route Paywall (abonnement Premium)
          GoRoute(
            path: AppRoutePaths.paywall,
            name: 'paywall',
            pageBuilder: (context, state) => AppPage.adaptive(
              key: state.pageKey,
              name: state.name,
              child: const PaywallScreen(),
            ),
          ),

          // Route Settings (dans la bottom nav)
          GoRoute(
            path: AppRoutePaths.settings,
            name: 'settings',
            pageBuilder: (context, state) => AppPage.adaptive(
              key: state.pageKey,
              name: state.name,
              child: const SettingsScreen(),
            ),
          ),

          // Route Pockets (dans la bottom nav)
          GoRoute(
            path: AppRoutePaths.pockets,
            name: 'pockets',
            pageBuilder: (context, state) => AppPage.adaptive(
              key: state.pageKey,
              name: state.name,
              child: const PocketsListScreen(),
            ),
          ),
        ],
      ),

      // ==================== ROUTES INDÉPENDANTES (SANS BOTTOM NAV) ====================

      // Statistics (sans bottom nav - accès depuis home)
      GoRoute(
        path: AppRoutePaths.statistics,
        name: 'statistics',
        pageBuilder: (context, state) => AppPage.adaptive(
          key: state.pageKey,
          name: state.name,
          child: const StatisticsScreen(),
        ),
      ),

      // Transaction History (sans bottom nav)
      GoRoute(
        path: AppRoutePaths.transactionHistory,
        name: 'transactionHistory',
        pageBuilder: (context, state) => AppPage.adaptive(
          key: state.pageKey,
          name: state.name,
          child: const TransactionHistoryScreen(),
        ),
      ),

      // Profile (sans bottom nav)
      GoRoute(
        path: AppRoutePaths.profile,
        name: 'profile',
        pageBuilder: (context, state) => AppPage.adaptive(
          key: state.pageKey,
          name: state.name,
          child: Scaffold(
            appBar: AdaptiveAppBar(
              title: 'Profile',
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

      // Centre de notifications moderne
      GoRoute(
        path: AppRoutePaths.notificationsCenter,
        name: 'notificationsCenter',
        pageBuilder: (context, state) => AppPage.adaptive(
          key: state.pageKey,
          name: state.name,
          child: const NotificationsCenterScreen(),
        ),
      ),

      // Préférences de notifications
      GoRoute(
        path: AppRoutePaths.notificationPreferences,
        name: 'notificationPreferences',
        pageBuilder: (context, state) => AppPage.adaptive(
          key: state.pageKey,
          name: state.name,
          child: const NotificationPreferencesScreen(),
        ),
      ),

      // ==================== ROUTES LÉGALES ====================

      // Mentions légales
      GoRoute(
        path: AppRoutePaths.legalNotice,
        name: 'legalNotice',
        pageBuilder: (context, state) => AppPage.adaptive(
          key: state.pageKey,
          name: state.name,
          child: const LegalNoticeScreen(),
        ),
      ),

      // Politique de confidentialité
      GoRoute(
        path: AppRoutePaths.privacyPolicy,
        name: 'privacyPolicy',
        pageBuilder: (context, state) => AppPage.adaptive(
          key: state.pageKey,
          name: state.name,
          child: const PrivacyPolicyScreen(),
        ),
      ),

      // Conditions générales d'utilisation
      GoRoute(
        path: AppRoutePaths.termsOfUse,
        name: 'termsOfUse',
        pageBuilder: (context, state) => AppPage.adaptive(
          key: state.pageKey,
          name: state.name,
          child: const TermsOfUseScreen(),
        ),
      ),

      // IMPORTANT: Routes spécifiques AVANT routes générales pour GoRouter
      // Les routes /add/amount et /add/details DOIVENT être avant /add

      // NOUVELLE: Ajouter transaction - Étape 1 : Montant
      GoRoute(
        path: AppRoutePaths.addTransactionAmount,
        name: 'addTransactionAmount',
        pageBuilder: (context, state) {
          // Récupérer le type de transaction depuis les query parameters
          final typeParam = state.uri.queryParameters['type'];
          final transactionType = typeParam == 'income'
              ? TransactionType.income
              : TransactionType.expense;

          return AppPage.adaptive(
            key: state.pageKey,
            name: state.name,
            child: AddTransactionAmountScreen(transactionType: transactionType),
          );
        },
      ),

      // NOUVELLE: Ajouter transaction - Étape 2 : Détails
      GoRoute(
        path: AppRoutePaths.addTransactionDetails,
        name: 'addTransactionDetails',
        pageBuilder: (context, state) {
          // Récupérer le type et le montant depuis les query parameters
          final typeParam = state.uri.queryParameters['type'];
          final amountParam = state.uri.queryParameters['amount'];

          final transactionType = typeParam == 'income'
              ? TransactionType.income
              : TransactionType.expense;

          final amount = double.tryParse(amountParam ?? '0') ?? 0.0;

          return AppPage.adaptive(
            key: state.pageKey,
            name: state.name,
            child: AddTransactionDetailsScreen(
              transactionType: transactionType,
              amount: amount,
            ),
          );
        },
      ),

      // ANCIENNE ROUTE (gardée pour compatibilité si besoin)
      // Ajouter une transaction - Version une seule page
      GoRoute(
        path: AppRoutePaths.addTransaction,
        name: 'addTransaction',
        pageBuilder: (context, state) {
          // Récupérer le type de transaction depuis les query parameters
          final typeParam = state.uri.queryParameters['type'];
          final transactionType = typeParam == 'income'
              ? TransactionType.income
              : TransactionType.expense;

          return AppPage.adaptive(
            key: state.pageKey,
            name: state.name,
            child: AddTransactionScreen(transactionType: transactionType),
          );
        },
      ),

      // Note: Transaction detail modal est désormais appelée directement
      // via showTransactionDetailModal() depuis les widgets
      // Si vous avez besoin d'une URL pour les deep links, utilisez:
      // showTransactionDetailModal(context, transactionId);

      // IMPORTANT: Create Pocket - DOIT être AVANT pocketDetail
      // pour éviter que "create" soit interprété comme un ID
      GoRoute(
        path: AppRoutePaths.createPocket,
        name: 'createPocket',
        pageBuilder: (context, state) => AppPage.adaptive(
          key: state.pageKey,
          name: state.name,
          child: const CreatePocketScreen(),
        ),
      ),

      // Edit Pocket (sans bottom nav)
      GoRoute(
        path: AppRoutePaths.editPocket,
        name: 'editPocket',
        pageBuilder: (context, state) {
          final pocketId = state.pathParameters['id'];
          if (pocketId == null) {
            return AppPage.adaptive(
              key: state.pageKey,
              name: state.name,
              child: const Scaffold(
                body: Center(child: Text('ID du pocket manquant')),
              ),
            );
          }

          return AppPage.adaptive(
            key: state.pageKey,
            name: state.name,
            child: EditPocketScreen(pocketId: pocketId),
          );
        },
      ),

      // Pocket Details (sans bottom nav)
      GoRoute(
        path: AppRoutePaths.pocketDetail,
        name: 'pocketDetail',
        pageBuilder: (context, state) {
          final pocketId = state.pathParameters['id'];
          if (pocketId == null) {
            return AppPage.adaptive(
              key: state.pageKey,
              name: state.name,
              child: const Scaffold(
                body: Center(child: Text('ID du pocket manquant')),
              ),
            );
          }

          return AppPage.adaptive(
            key: state.pageKey,
            name: state.name,
            child: PocketDetailsScreen(pocketId: pocketId),
          );
        },
      ),

      // ==================== ROUTES CATEGORIES ====================

      // Categories List (sans bottom nav)
      GoRoute(
        path: AppRoutePaths.categories,
        name: 'categories',
        pageBuilder: (context, state) => AppPage.adaptive(
          key: state.pageKey,
          name: state.name,
          child: const CategoriesListScreen(),
        ),
      ),

      // Create Category - DOIT être AVANT editCategory
      // pour éviter que "create" soit interprété comme un ID
      GoRoute(
        path: AppRoutePaths.createCategory,
        name: 'createCategory',
        pageBuilder: (context, state) {
          // Récupérer le type passé via extra
          final defaultType = state.extra as CategoryType?;

          return AppPage.adaptive(
            key: state.pageKey,
            name: state.name,
            child: AddEditCategoryScreen(defaultType: defaultType),
          );
        },
      ),

      // Edit Category (sans bottom nav)
      GoRoute(
        path: AppRoutePaths.editCategory,
        name: 'editCategory',
        pageBuilder: (context, state) {
          final categoryId = state.pathParameters['id'];
          final category = state.extra as CategoryEntity?;

          if (categoryId == null) {
            return AppPage.adaptive(
              key: state.pageKey,
              name: state.name,
              child: const Scaffold(
                body: Center(child: Text('ID de la catégorie manquant')),
              ),
            );
          }

          return AppPage.adaptive(
            key: state.pageKey,
            name: state.name,
            child: AddEditCategoryScreen(category: category),
          );
        },
      ),

      // Éditer le profil
      GoRoute(
        path: AppRoutePaths.editProfile,
        name: 'editProfile',
        pageBuilder: (context, state) => AppPage.adaptive(
          key: state.pageKey,
          name: state.name,
          child: const ProfileEditScreen(),
        ),
      ),
    ],

    // Gestion des erreurs de navigation
    errorBuilder: (context, state) => Scaffold(
      appBar: AppBar(
        title: const Text('Page non trouvée'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(AppIcons.error, size: 80, color: Colors.red),
              const SizedBox(height: 24),
              const Text(
                '404 - Page non trouvée',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                'La page "${state.uri}" n\'existe pas.',
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              // Bouton principal pour retourner à l'accueil
              AppButton(
                text: 'Retour à l\'accueil',
                onPressed: () => context.go(AppRoutePaths.welcome),
                style: AppButtonStyle.gradient,
                size: AppButtonSize.large,
                isFullWidth: true,
                icon: AppIcons.home,
                iconPosition: IconPosition.left,
              ),
              const SizedBox(height: 16),
              // Bouton secondaire pour essayer de se connecter
              AppButton(
                text: 'Se connecter',
                onPressed: () => context.go(AppRoutePaths.signin),
                style: AppButtonStyle.outline,
                size: AppButtonSize.medium,
                isFullWidth: true,
                icon: AppIcons.login,
                iconPosition: IconPosition.left,
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
  void goNamed(
    String name, {
    Map<String, String>? pathParameters,
    Map<String, dynamic>? queryParameters,
  }) {
    GoRouter.of(this).goNamed(
      name,
      pathParameters: pathParameters ?? {},
      queryParameters: queryParameters ?? {},
    );
  }

  /// Navigation avec ajout à la pile
  void pushNamed(
    String name, {
    Map<String, String>? pathParameters,
    Map<String, dynamic>? queryParameters,
  }) {
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

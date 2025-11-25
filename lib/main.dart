import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:app_links/app_links.dart';
import 'package:supabase_flutter/supabase_flutter.dart' show AuthChangeEvent;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pocketly/core/config/supabase_config.dart';
import 'package:pocketly/core/constants/app_colors.dart';
import 'package:pocketly/core/router/app_router_config.dart';
import 'package:pocketly/core/widgets/error_boundary.dart';
import 'package:pocketly/core/services/logger_service.dart';
import 'package:pocketly/features/notifications/presentation/providers/notification_providers.dart';
import 'package:pocketly/features/notifications/presentation/providers/notification_services_provider.dart';
import 'package:pocketly/features/themes/presentation/providers/theme_providers.dart';
import 'package:pocketly/features/locale/locale.dart';
import 'package:pocketly/features/user/user.dart';
import 'package:pocketly/features/subscription/subscription.dart';
import 'package:pocketly/generated/l10n/app_localizations.dart';

/// Instance globale de SharedPreferences initialisée au démarrage
late final SharedPreferences sharedPreferencesInstance;

/// Instance du logger service
const _logger = LoggerService();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables from .env file
  try {
    await dotenv.load(fileName: '.env');
    _logger.i('✅ Variables d\'environnement chargées depuis .env');
  } catch (e) {
    _logger.e(
      '⚠️ Erreur lors du chargement du fichier .env. '
      'Assurez-vous que le fichier .env existe à la racine du projet.',
      error: e,
    );
    // L'application peut continuer, mais SupabaseConfig.initialize() échouera
    // si les variables ne sont pas définies
  }

  // Initialize timezone for recurring notifications
  tz.initializeTimeZones();

  // Initialize SharedPreferences
  sharedPreferencesInstance = await SharedPreferences.getInstance();

  // Initialize Supabase (doit être appelé après dotenv.load())
  await SupabaseConfig.initialize();

  // Create a container for providers that need to be initialized before the app starts
  final container = ProviderContainer();

  // Initialize notification service (basic local notifications)
  await container.read(notificationServiceControllerProvider.future);

  // Initialize recurring notifications (month-end reminders, weekly summaries, monthly reports)
  try {
    await container.read(initializeRecurringNotificationsProvider.future);
    _logger.i('✅ Notifications récurrentes initialisées');
  } catch (e) {
    _logger.e('⚠️ Erreur initialisation notifications récurrentes', error: e);
    // Continue app launch even if notification initialization fails
  }

  // Initialize notification preferences listener
  try {
    await container.read(notificationPreferencesListenerProvider.future);
    _logger.i('✅ Listener de préférences initialisé');
  } catch (e) {
    _logger.e('⚠️ Erreur initialisation listener', error: e);
  }

  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  late AppLinks _appLinks;

  @override
  void initState() {
    super.initState();
    _initDeepLinks();
  }

  /// Initialise les deep links pour la réinitialisation de mot de passe
  Future<void> _initDeepLinks() async {
    _appLinks = AppLinks();

    // Écouter les changements d'état d'authentification pour password recovery
    SupabaseConfig.client.auth.onAuthStateChange.listen((data) {
      final event = data.event;
      if (event == AuthChangeEvent.passwordRecovery) {
        _logger.i('🔐 Password recovery event détecté');
        // Naviguer vers l'écran de réinitialisation
        final router = ref.read(routerProvider);
        router.go('/reset-password');
      }
    });

    // Gérer le deep link au lancement de l'app
    final initialUri = await _appLinks.getInitialLink();
    if (initialUri != null) {
      await _handleDeepLink(initialUri);
    }

    // Écouter les deep links pendant que l'app est ouverte
    _appLinks.uriLinkStream.listen((uri) async {
      await _handleDeepLink(uri);
    }, onError: (err) {
      _logger.e('🔴 Erreur deep link', error: err);
    });
  }

  /// Gère la redirection depuis un deep link
  Future<void> _handleDeepLink(Uri uri) async {
    _logger.i('📱 Deep link reçu: $uri');

    // Vérifier si c'est un callback Supabase (contient les tokens)
    if (uri.path.contains('/callback') || uri.fragment.isNotEmpty) {
      _logger.i('🔄 Traitement du callback Supabase...');

      try {
        // Récupérer la session depuis l'URL (tokens dans le fragment)
        await SupabaseConfig.client.auth.getSessionFromUrl(uri);
        _logger.i('✅ Session récupérée avec succès');
      } catch (e) {
        _logger.e('⚠️ Erreur récupération session', error: e);
      }
    }
    // Le listener onAuthStateChange ci-dessus gérera la navigation
  }

  @override
  Widget build(BuildContext context) {
    final router = ref.watch(routerProvider);
    final currentTheme = ref.watch(themeProvider);
    final localeAsync = ref.watch(currentLocaleProvider);

    // Initialiser RevenueCat quand l'utilisateur se connecte
    ref.listen(currentUserProvider, (previous, next) {
      next.whenData((user) {
        if (user != null) {
          // Initialiser RevenueCat avec l'ID utilisateur
          ref.read(subscriptionControllerProvider.notifier).initialize().catchError((error) {
            _logger.e('🔴 [Main] Erreur initialisation RevenueCat', error: error);
          });
        }
      });
    });

    // Utiliser ScreenUtilInit pour initialiser ScreenUtil
    return ErrorBoundary(
      child: ScreenUtilInit(
        // Design size basé sur iPhone 14 Pro (393x852)
        designSize: const Size(393, 852),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return localeAsync.when(
            data: (locale) => MaterialApp.router(
              title: 'Pocketly',

              // Configuration des localisations
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              locale: locale,

              // Thème dynamique
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
                useMaterial3: true,
              ),
              darkTheme: ThemeData(
                colorScheme: ColorScheme.fromSeed(
                  seedColor: AppColors.primary,
                  brightness: Brightness.dark,
                ),
                useMaterial3: true,
              ),
              themeMode: currentTheme.isSystem
                ? ThemeMode.system
                : currentTheme.isDark
                  ? ThemeMode.dark
                  : ThemeMode.light,

              // Router
              routerConfig: router,
            ),
            loading: () => const MaterialApp(
              home: Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
            error: (_, __) => MaterialApp.router(
              title: 'Pocketly',
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              routerConfig: router,
            ),
          );
        },
      ),
    );
  }
}
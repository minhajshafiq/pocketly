import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pocketly/core/config/supabase_config.dart';
import 'package:pocketly/core/router/app_router_config.dart';
import 'package:pocketly/core/widgets/error_boundary.dart';
import 'package:pocketly/features/notifications/presentation/providers/notification_providers.dart';
import 'package:pocketly/features/themes/presentation/providers/theme_providers.dart';
import 'package:pocketly/generated/l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Supabase
  await SupabaseConfig.initialize();
  
  // Create a container for providers that need to be initialized before the app starts
  final container = ProviderContainer();
  
  // Initialize notification service
  await container.read(notificationServiceInitProvider.future);
  
  runApp(
    ProviderScope(
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final currentTheme = ref.watch(themeNotifierProvider);
    
    // Utiliser ScreenUtilInit pour initialiser ScreenUtil
    return ErrorBoundary(
      child: ScreenUtilInit(
        // Design size basé sur iPhone 14 Pro (393x852)
        designSize: const Size(393, 852),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp.router(
            title: 'Pocketly',
            
            // Configuration des localisations
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            
            // Thème dynamique
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
              useMaterial3: true,
            ),
            darkTheme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.blue,
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
          );
        },
      ),
    );
  }
}
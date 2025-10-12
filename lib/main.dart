import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pocketly/generated/l10n/app_localizations.dart';
import 'package:pocketly/core/di/service_locator.dart';
import 'package:pocketly/features/themes/presentation/providers/theme_providers.dart';
import 'package:pocketly/features/themes/infrastructure/theme_service.dart';
import 'package:pocketly/core/router/app_route_providers.dart';

void main() async {
  // Preserve the splash screen until the app is ready
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  
  // Initialize dependencies with GetIt
  await initializeDependencies();
  
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(themeNotifierProvider);
    final router = ref.watch(appRouterProvider);
    
    return ScreenUtilInit(
      // Design size based on iPhone 12/13/14 (390x844)
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          title: 'Pocketly',
          debugShowCheckedModeBanner: false,
          // Router configuration avec GoRouter
          routerConfig: router,
          // Localization configuration
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''), // English
            Locale('fr', ''), // French
          ],
          theme: ThemeService.getThemeDataForMode(ThemeMode.light, context),
          darkTheme: ThemeService.getThemeDataForMode(ThemeMode.dark, context),
          themeMode: currentTheme.mode,
        );
      },
    );
  }
}
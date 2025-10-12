import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:pocketly/generated/l10n/app_localizations.dart';
import 'package:pocketly/core/constants/app_constants.dart';
import 'package:pocketly/core/providers/theme_provider.dart';
import 'package:pocketly/core/widgets/app_card.dart';
import 'package:pocketly/core/widgets/app_button.dart';
import 'package:pocketly/core/widgets/theme_selector.dart';
import 'package:pocketly/features/onboarding/presentation/screens/welcome_screen.dart';

void main() {
  // Preserve the splash screen until the app is ready
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  
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
    return ScreenUtilInit(
      // Design size based on iPhone 12/13/14 (390x844)
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return AnimatedTheme(
          data: ref.watch(themeModeProvider) == ThemeMode.dark 
            ? ref.watch(darkThemeProvider)
            : ref.watch(lightThemeProvider),
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: MaterialApp(
            title: 'Pocketly',
            debugShowCheckedModeBanner: false,
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
            theme: ref.watch(lightThemeProvider),
            darkTheme: ref.watch(darkThemeProvider),
            themeMode: ref.watch(themeModeProvider),
            home: const WelcomeScreen(),
          ),
        );
      },
    );
  }
}

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({super.key});

  @override
  ConsumerState<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    // Remove the splash screen once the app is ready
    FlutterNativeSplash.remove();
  }

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.background,
      appBar: AppBar(
        backgroundColor: isDark ? AppColors.surfaceDark : AppColors.primary,
        title: Text(
          l10n.appTitle,
          style: AppTypography.title.copyWith(
            color: isDark ? AppColors.textOnDark : Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(AppDimensions.pageHorizontalPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Welcome section
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(AppDimensions.paddingL),
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(AppDimensions.radiusL),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.account_balance_wallet,
                      size: AppDimensions.iconXL,
                      color: Colors.white,
                    ),
                    SizedBox(height: AppDimensions.paddingM),
                    Text(
                      l10n.welcome,
                      style: AppTypography.heading.copyWith(
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              )
                .animate()
                .fadeIn(duration: 600.ms, delay: 100.ms)
                .slideY(begin: 0.2, end: 0.0, curve: Curves.easeOutCubic),
              
              SizedBox(height: AppDimensions.paddingXL),
              
              // Counter section
              AppCardWithTitle(
                title: 'Counter',
                subtitle: 'Tap to increment',
                child: Column(
                  children: [
                    Text(
                      '$_counter',
                      style: AppTypography.moneyLarge.copyWith(
                        color: AppColors.primary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: AppDimensions.paddingS),
                    Text(
                      'clicks',
                      style: AppTypography.caption.copyWith(
                        color: AppColors.textSecondary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              )
                .animate()
                .fadeIn(duration: 600.ms, delay: 200.ms)
                .slideX(begin: -0.1, end: 0.0, curve: Curves.easeOutCubic),
              
              SizedBox(height: AppDimensions.paddingXL),
              
              // Statistics section
              Row(
                children: [
                  Expanded(
                    child: AppStatsCard(
                      title: 'Total Clicks',
                      value: '$_counter',
                      icon: Icons.touch_app,
                      isPositive: true,
                    )
                      .animate()
                      .fadeIn(duration: 600.ms, delay: 300.ms)
                      .slideX(begin: -0.1, end: 0.0, curve: Curves.easeOutCubic),
                  ),
                  SizedBox(width: AppDimensions.paddingM),
                  Expanded(
                    child: AppStatsCard(
                      title: 'Session',
                      value: '1',
                      icon: Icons.timer,
                      isPositive: true,
                    )
                      .animate()
                      .fadeIn(duration: 600.ms, delay: 400.ms)
                      .slideX(begin: 0.1, end: 0.0, curve: Curves.easeOutCubic),
                  ),
                ],
              ),
              
              SizedBox(height: AppDimensions.paddingXL),
              
              // Theme selector section
              AppCardWithTitle(
                title: 'Theme Settings',
                subtitle: 'Choose your preferred theme',
                child: Column(
                  children: [
                    ThemeSelector(
                      style: ThemeSelectorStyle.card,
                      size: ThemeSelectorSize.medium,
                      showDescriptions: true,
                      showIcons: true,
                    ),
                    SizedBox(height: AppDimensions.paddingM),
                    // Quick toggle button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Quick Toggle:',
                          style: AppTypography.caption.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                        ThemeToggleButton(
                          size: ThemeToggleSize.medium,
                          showLabel: false,
                          showIcon: true,
                        ),
                      ],
                    ),
                  ],
                ),
              )
                .animate()
                .fadeIn(duration: 600.ms, delay: 500.ms)
                .slideY(begin: 0.1, end: 0.0, curve: Curves.easeOutCubic),
              
              SizedBox(height: AppDimensions.paddingXL),
              
              // Action buttons
              Row(
                children: [
                  Expanded(
                    child: AppButton(
                      text: l10n.add,
                      icon: Icons.add,
                      onPressed: _incrementCounter,
                      style: AppButtonStyle.primary,
                      size: AppButtonSize.medium,
                    )
                      .animate()
                      .fadeIn(duration: 600.ms, delay: 600.ms)
                      .slideX(begin: -0.1, end: 0.0, curve: Curves.easeOutCubic),
                  ),
                  SizedBox(width: AppDimensions.paddingM),
                  AppButton(
                    text: 'Reset',
                    icon: Icons.refresh,
                    onPressed: () {
                      setState(() {
                        _counter = 0;
                      });
                    },
                    style: AppButtonStyle.secondary,
                    tooltip: 'Reset',
                  )
                    .animate()
                    .fadeIn(duration: 600.ms, delay: 700.ms)
                    .slideX(begin: 0.1, end: 0.0, curve: Curves.easeOutCubic),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

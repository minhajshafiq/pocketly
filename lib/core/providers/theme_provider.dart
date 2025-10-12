import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pocketly/core/constants/app_constants.dart';

/// Provider pour gérer le mode de thème de l'application.
/// 
/// Supporte les modes : Light, Dark, System
final themeModeProvider = NotifierProvider<ThemeModeNotifier, ThemeMode>(
  () => ThemeModeNotifier(),
);

/// Notifier pour gérer les changements de thème.
class ThemeModeNotifier extends Notifier<ThemeMode> {
  @override
  ThemeMode build() => ThemeMode.system;

  /// Change le mode de thème
  void setThemeMode(ThemeMode mode) {
    state = mode;
  }

  /// Bascule entre Light et Dark (ignore System)
  void toggleTheme() {
    state = state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
  }
}

/// Provider pour obtenir le thème clair
final lightThemeProvider = Provider<ThemeData>((ref) {
  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.light,
    ).copyWith(
      surface: AppColors.background,
      surfaceContainerHighest: AppColors.surface,
      surfaceContainer: AppColors.surfaceVariant,
      onSurface: AppColors.textPrimary,
      onSurfaceVariant: AppColors.textSecondary,
    ),
    textTheme: GoogleFonts.interTextTheme(
      ThemeData.light().textTheme,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: AppTypography.title.copyWith(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    ),
    cardTheme: CardThemeData(
      color: AppColors.surface,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        ),
      ),
    ),
    cupertinoOverrideTheme: CupertinoThemeData(
      textTheme: CupertinoTextThemeData(
        textStyle: GoogleFonts.inter(),
      ),
    ),
  );
});

/// Provider pour obtenir le thème sombre
final darkThemeProvider = Provider<ThemeData>((ref) {
  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.dark,
    ).copyWith(
      surface: AppColors.backgroundDark,
      surfaceContainerHighest: AppColors.surfaceDark,
      surfaceContainer: AppColors.surfaceDark,
      onSurface: AppColors.textOnDark,
      onSurfaceVariant: AppColors.textSecondaryOnDark,
    ),
    textTheme: GoogleFonts.interTextTheme(
      ThemeData.dark().textTheme,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.surfaceDark,
      foregroundColor: AppColors.textOnDark,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: AppTypography.title.copyWith(
        color: AppColors.textOnDark,
        fontWeight: FontWeight.bold,
      ),
    ),
    cardTheme: CardThemeData(
      color: AppColors.surfaceDark,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        ),
      ),
    ),
    cupertinoOverrideTheme: CupertinoThemeData(
      textTheme: CupertinoTextThemeData(
        textStyle: GoogleFonts.inter(),
      ),
    ),
  );
});

/// Provider pour obtenir les informations du thème actuel
final themeInfoProvider = Provider<ThemeInfo>((ref) {
  final themeMode = ref.watch(themeModeProvider);
  
  return ThemeInfo(
    mode: themeMode,
    isLight: themeMode == ThemeMode.light,
    isDark: themeMode == ThemeMode.dark,
    isSystem: themeMode == ThemeMode.system,
    displayName: _getThemeDisplayName(themeMode),
    icon: _getThemeIcon(themeMode),
  );
});

/// Classe pour les informations du thème
class ThemeInfo {
  final ThemeMode mode;
  final bool isLight;
  final bool isDark;
  final bool isSystem;
  final String displayName;
  final IconData icon;

  const ThemeInfo({
    required this.mode,
    required this.isLight,
    required this.isDark,
    required this.isSystem,
    required this.displayName,
    required this.icon,
  });
}

/// Helper pour obtenir le nom d'affichage du thème
String _getThemeDisplayName(ThemeMode mode) {
  switch (mode) {
    case ThemeMode.light:
      return 'Light';
    case ThemeMode.dark:
      return 'Dark';
    case ThemeMode.system:
      return 'System';
  }
}

/// Helper pour obtenir l'icône du thème
IconData _getThemeIcon(ThemeMode mode) {
  switch (mode) {
    case ThemeMode.light:
      return Icons.light_mode;
    case ThemeMode.dark:
      return Icons.dark_mode;
    case ThemeMode.system:
      return Icons.brightness_auto;
  }
}

import 'package:flutter/material.dart';
import 'package:pocketly/features/themes/domain/entities/theme_entity.dart';
import 'package:pocketly/features/themes/infrastructure/theme_factory.dart';

/// Service pour la gestion des thèmes Material Design.
/// 
/// Connecte les entités de domaine avec les thèmes Flutter
/// en respectant la Clean Architecture.
class ThemeService {
  /// Obtient le ThemeData correspondant à une entité de thème
  static ThemeData getThemeData(ThemeEntity entity, BuildContext context) {
    if (entity.isDark) {
      return ThemeFactory.createDarkTheme();
    } else if (entity.isLight) {
      return ThemeFactory.createLightTheme();
    } else if (entity.isSystem) {
      return ThemeFactory.createSystemTheme(context);
    } else {
      // Fallback vers le thème système
      return ThemeFactory.createSystemTheme(context);
    }
  }

  /// Obtient le ThemeData pour un mode spécifique
  static ThemeData getThemeDataForMode(ThemeMode mode, BuildContext context) {
    switch (mode) {
      case ThemeMode.light:
        return ThemeFactory.createLightTheme();
      case ThemeMode.dark:
        return ThemeFactory.createDarkTheme();
      case ThemeMode.system:
        return ThemeFactory.createSystemTheme(context);
    }
  }

  /// Vérifie si un thème est sombre
  static bool isDarkTheme(ThemeEntity entity, BuildContext context) {
    if (entity.isSystem) {
      return MediaQuery.of(context).platformBrightness == Brightness.dark;
    }
    return entity.isDark;
  }

  /// Obtient la couleur appropriée selon le thème
  static Color getAdaptiveColor(
    ThemeEntity entity,
    BuildContext context, {
    required Color lightColor,
    required Color darkColor,
  }) {
    return isDarkTheme(entity, context) ? darkColor : lightColor;
  }
}

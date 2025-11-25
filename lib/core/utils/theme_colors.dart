import 'package:flutter/material.dart';
import 'package:pocketly/core/constants/app_colors.dart';

/// Classe utilitaire pour les couleurs du thème
///
/// Centralise la logique de récupération des couleurs selon le mode clair/sombre
class ThemeColors {
  final Color primary;
  final Color secondary;
  final Color surface;
  final Color background;
  final Color onSurface;
  final Color onBackground;
  final Color textPrimary;
  final Color textSecondary;
  final Color border;
  final bool isDark;

  const ThemeColors({
    required this.primary,
    required this.secondary,
    required this.surface,
    required this.background,
    required this.onSurface,
    required this.onBackground,
    required this.textPrimary,
    required this.textSecondary,
    required this.border,
    required this.isDark,
  });

  /// Factory method pour créer ThemeColors depuis un BuildContext
  factory ThemeColors.fromContext(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return ThemeColors(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      surface: isDark ? AppColors.surfaceDark : AppColors.surface,
      background: isDark ? AppColors.backgroundDark : AppColors.background,
      onSurface: isDark ? AppColors.textOnDark : AppColors.textPrimary,
      onBackground: isDark ? AppColors.textOnDark : AppColors.textPrimary,
      textPrimary: isDark ? AppColors.textOnDark : AppColors.textPrimary,
      textSecondary: isDark
          ? AppColors.textSecondaryOnDark
          : AppColors.textSecondary,
      border: isDark ? AppColors.borderDark : AppColors.borderLight,
      isDark: isDark,
    );
  }
}

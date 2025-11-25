import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pocketly/core/constants/app_colors.dart';
import 'package:pocketly/core/constants/app_dimensions.dart';
import 'package:pocketly/core/constants/app_typography.dart';

/// Widget de carte personnalisé utilisant les constantes de l'application.
///
/// Ce widget démontre l'utilisation des constantes AppDimensions,
/// AppColors et AppTypography pour créer des composants cohérents.
class AppCard extends StatelessWidget {
  /// Contenu de la carte
  final Widget child;

  /// Padding interne de la carte
  final EdgeInsetsGeometry? padding;

  /// Couleur de fond de la carte
  final Color? backgroundColor;

  /// Couleur de bordure de la carte
  final Color? borderColor;

  /// Élévation de la carte
  final double? elevation;

  /// Callback appelé lors du tap sur la carte
  final VoidCallback? onTap;

  /// Indique si la carte est sélectionnée
  final bool isSelected;

  const AppCard({
    super.key,
    required this.child,
    this.padding,
    this.backgroundColor,
    this.borderColor,
    this.elevation,
    this.onTap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: padding ?? EdgeInsets.all(AppDimensions.paddingM),
        decoration: BoxDecoration(
          color:
              backgroundColor ??
              (isDark ? AppColors.surfaceDark : AppColors.surface),
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
          border: Border.all(
            color: isSelected
                ? AppColors.primary
                : (borderColor ??
                      (isDark ? AppColors.borderDark : AppColors.borderLight)),
            width: isSelected ? 2.0 : 1.0,
          ),
          boxShadow: [
            BoxShadow(
              color: isDark
                  ? Colors.black.withValues(alpha: 0.4)
                  : AppColors.grey300.withValues(alpha: 0.3),
              blurRadius: elevation ?? 8.0,
              offset: Offset(0, 4.h),
            ),
          ],
        ),
        child: child,
      ),
    );
  }
}

/// Widget de carte avec titre et contenu.
class AppCardWithTitle extends StatelessWidget {
  /// Titre de la carte
  final String title;

  /// Sous-titre optionnel
  final String? subtitle;

  /// Contenu de la carte
  final Widget child;

  /// Action optionnelle (bouton, icône, etc.)
  final Widget? action;

  /// Indique si la carte est sélectionnée
  final bool isSelected;

  /// Callback appelé lors du tap sur la carte
  final VoidCallback? onTap;

  const AppCardWithTitle({
    super.key,
    required this.title,
    this.subtitle,
    required this.child,
    this.action,
    this.isSelected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return AppCard(
      isSelected: isSelected,
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // En-tête avec titre et action
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTypography.title.copyWith(
                        color: isSelected
                            ? AppColors.primary
                            : (isDark
                                  ? AppColors.textOnDark
                                  : AppColors.textPrimary),
                      ),
                    ),
                    if (subtitle != null) ...[
                      SizedBox(height: AppDimensions.paddingXS),
                      Text(
                        subtitle!,
                        style: AppTypography.caption.copyWith(
                          color: isDark
                              ? AppColors.textSecondaryOnDark
                              : AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              if (action != null) ...[
                SizedBox(width: AppDimensions.paddingS),
                action!,
              ],
            ],
          ),

          SizedBox(height: AppDimensions.paddingM),

          // Contenu
          child,
        ],
      ),
    );
  }
}

/// Widget de carte pour les statistiques.
class AppStatsCard extends StatelessWidget {
  /// Titre de la statistique
  final String title;

  /// Valeur de la statistique
  final String value;

  /// Unité de la statistique
  final String? unit;

  /// Couleur de la valeur
  final Color? valueColor;

  /// Icône optionnelle
  final IconData? icon;

  /// Indique si c'est une valeur positive (pour les couleurs)
  final bool isPositive;

  const AppStatsCard({
    super.key,
    required this.title,
    required this.value,
    this.unit,
    this.valueColor,
    this.icon,
    this.isPositive = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final Color effectiveValueColor =
        valueColor ?? (isPositive ? AppColors.success : AppColors.error);

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // En-tête avec icône et titre
          Row(
            children: [
              if (icon != null) ...[
                Icon(
                  icon,
                  size: AppDimensions.iconM,
                  color: isDark
                      ? AppColors.textSecondaryOnDark
                      : AppColors.textSecondary,
                ),
                SizedBox(width: AppDimensions.paddingS),
              ],
              Expanded(
                child: Text(
                  title,
                  style: AppTypography.caption.copyWith(
                    color: isDark
                        ? AppColors.textSecondaryOnDark
                        : AppColors.textSecondary,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: AppDimensions.paddingM),

          // Valeur
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Text(
                  value,
                  style: AppTypography.moneyLarge.copyWith(
                    color: effectiveValueColor,
                  ),
                ),
              ),
              if (unit != null) ...[
                SizedBox(width: AppDimensions.paddingXS),
                Text(
                  unit!,
                  style: AppTypography.caption.copyWith(
                    color: isDark
                        ? AppColors.textSecondaryOnDark
                        : AppColors.textSecondary,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pocketly/core/core.dart';
import 'package:pocketly/core/constants/app_icons.dart';

/// Widget réutilisable pour les boutons de settings avec le style moderne
///
/// Style: fond gris foncé, icône carrée avec fond violet, texte blanc, chevron
class SettingsButtonTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback? onTap;
  final Color? iconBackgroundColor;
  final Color? textColor;
  final bool showChevron;

  const SettingsButtonTile({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.onTap,
    this.iconBackgroundColor,
    this.textColor,
    this.showChevron = true,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final iconBg = iconBackgroundColor ?? AppColors.secondary;
    final titleColor =
        textColor ?? (isDark ? AppColors.textOnDark : AppColors.textPrimary);
    final chevronColor = isDark
        ? AppColors.textSecondaryOnDark
        : AppColors.textSecondary;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap != null
            ? () {
                HapticFeedback.lightImpact();
                onTap!();
              }
            : null,
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: AppDimensions.paddingM,
            horizontal: AppDimensions.paddingM,
          ),
          child: Row(
            children: [
              // Icône carrée avec fond violet
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: iconBg,
                  borderRadius: BorderRadius.circular(AppDimensions.radiusS),
                ),
                child: Icon(icon, color: Colors.white, size: 20),
              ),
              SizedBox(width: AppDimensions.paddingM),
              // Texte
              Expanded(
                child: Text(
                  title,
                  style: AppTypography.body.copyWith(
                    color: titleColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              // Subtitle à côté de la flèche
              if (subtitle != null && subtitle!.isNotEmpty) ...[
                Text(
                  subtitle!,
                  style: AppTypography.small.copyWith(
                    color: isDark
                        ? AppColors.textSecondaryOnDark
                        : AppColors.textSecondary,
                  ),
                ),
                SizedBox(width: AppDimensions.paddingS),
              ],
              // Chevron
              if (showChevron && onTap != null) ...[
                Icon(
                  AppIcons.chevronRightRounded,
                  color: chevronColor,
                  size: 20,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

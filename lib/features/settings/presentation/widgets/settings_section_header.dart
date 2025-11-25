import 'package:flutter/material.dart';
import 'package:pocketly/core/constants/app_colors.dart';
import 'package:pocketly/core/constants/app_typography.dart';

/// Widget d'en-tête de section pour les paramètres
class SettingsSectionHeader extends StatelessWidget {
  final String title;

  const SettingsSectionHeader({
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Text(
      title.toUpperCase(),
      style: AppTypography.caption.copyWith(
        color: isDark ? AppColors.textSecondaryOnDark : AppColors.textSecondary,
        fontWeight: FontWeight.w600,
        letterSpacing: 1.2,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocketly/core/constants/app_colors.dart';
import 'package:pocketly/core/constants/app_dimensions.dart';
import 'package:pocketly/core/constants/app_typography.dart';
import 'package:pocketly/core/widgets/app_card.dart';
import 'package:pocketly/generated/l10n/app_localizations.dart';
import 'package:pocketly/features/themes/themes.dart';

/// Widget pour la carte de sélection d'apparence (thème)
class SettingsAppearanceCard extends ConsumerWidget {
  const SettingsAppearanceCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(AppDimensions.paddingM),
            child: Text(
              l10n.theme,
              style: AppTypography.bodyBold.copyWith(
                color: isDark ? AppColors.textOnDark : AppColors.textPrimary,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppDimensions.paddingM),
            child: const ThemeSelector(
              style: ThemeSelectorStyle.card,
              size: ThemeSelectorSize.medium,
              showDescriptions: true,
            ),
          ),
          SizedBox(height: AppDimensions.paddingM),
        ],
      ),
    );
  }
}

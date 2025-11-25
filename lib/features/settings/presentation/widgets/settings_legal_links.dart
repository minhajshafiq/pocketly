import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pocketly/core/core.dart';
import 'package:pocketly/generated/l10n/app_localizations.dart';
import 'package:pocketly/features/settings/presentation/widgets/settings_button_tile.dart';

/// Widget pour afficher les liens légaux dans les paramètres
class SettingsLegalLinks extends StatelessWidget {
  const SettingsLegalLinks({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AppCard(
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          // Mentions Légales
          SettingsButtonTile(
            icon: AppIcons.document,
            title: l10n.legalNotice,
            onTap: () => context.push('/settings/legal-notice'),
            iconBackgroundColor: AppColors.secondary,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppDimensions.paddingM),
            child: Divider(
            height: 1,
              thickness: 0.5,
            color: isDark 
                ? AppColors.borderDark.withValues(alpha: 0.3)
                : AppColors.borderLight.withValues(alpha: 0.3),
            ),
          ),
          // Politique de Confidentialité
          SettingsButtonTile(
            icon: AppIcons.info,
            title: l10n.privacyPolicy,
            onTap: () => context.push('/settings/privacy-policy'),
            iconBackgroundColor: AppColors.secondary,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppDimensions.paddingM),
            child: Divider(
            height: 1,
              thickness: 0.5,
            color: isDark 
                ? AppColors.borderDark.withValues(alpha: 0.3)
                : AppColors.borderLight.withValues(alpha: 0.3),
            ),
          ),
          // Conditions Générales d'Utilisation
          SettingsButtonTile(
            icon: AppIcons.document,
            title: l10n.termsOfUse,
            onTap: () => context.push('/settings/terms-of-use'),
            iconBackgroundColor: AppColors.secondary,
          ),
        ],
      ),
    );
  }
}

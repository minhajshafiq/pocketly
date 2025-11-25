import 'package:flutter/material.dart';
import 'package:pocketly/core/core.dart';
import 'package:pocketly/generated/l10n/app_localizations.dart';
import 'package:pocketly/features/settings/presentation/widgets/about_app_modal.dart';
import 'package:pocketly/features/settings/presentation/widgets/settings_button_tile.dart';

/// Widget pour afficher le bouton "À propos de l'app" dans les paramètres
class SettingsAboutButton extends StatelessWidget {
  const SettingsAboutButton({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return AppCard(
      padding: EdgeInsets.zero,
      child: SettingsButtonTile(
        icon: AppIcons.info,
        title: l10n.aboutApp,
        onTap: () => AboutAppModal.show(context),
        iconBackgroundColor: AppColors.secondary,
      ),
    );
  }
}

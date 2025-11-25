import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pocketly/core/constants/app_colors.dart';
import 'package:pocketly/core/constants/app_dimensions.dart';
import 'package:pocketly/core/constants/app_icons.dart';
import 'package:pocketly/core/constants/app_typography.dart';
import 'package:pocketly/core/router/app_route_paths.dart';
import 'package:pocketly/generated/l10n/app_localizations.dart';
import 'package:pocketly/features/settings/presentation/widgets/settings_button_tile.dart';
import 'package:pocketly/core/widgets/app_card.dart';
import 'package:pocketly/features/auth/auth.dart';
import 'package:pocketly/features/notifications/notifications.dart';
import 'package:pocketly/features/user/user.dart';

/// Widget pour le bouton de déconnexion
class SettingsLogoutButton extends ConsumerWidget {
  const SettingsLogoutButton({super.key});

  bool get _isIOS => !kIsWeb && Platform.isIOS;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppCard(
      padding: EdgeInsets.zero,
      child: _buildLogoutTile(
        context: context,
        isDark: Theme.of(context).brightness == Brightness.dark,
        onTap: () => _handleLogout(context, ref),
      ),
    );
  }

  Widget _buildLogoutTile({
    required BuildContext context,
    required bool isDark,
    required VoidCallback onTap,
  }) {
    final l10n = AppLocalizations.of(context)!;

    return SettingsButtonTile(
      icon: AppIcons.logout,
      title: l10n.logout,
      onTap: onTap,
      iconBackgroundColor: AppColors.error,
      textColor: AppColors.error,
    );
  }

  Future<void> _handleLogout(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context)!;
    
    // Afficher la modal de confirmation
    final confirmed = await _showLogoutConfirmation(context, l10n);
    if (confirmed != true) {
      return; // L'utilisateur a annulé
    }

    try {
      // Utiliser le provider pour que l'état d'authentification soit correctement mis à jour
      await ref.read(authProvider.notifier).signOut();
      ref.invalidate(currentUserProvider);
      // La redirection sera gérée automatiquement par le routeur
      // grâce à la fonction _getRedirectRoute qui détecte le changement d'état
    } catch (e) {
      if (context.mounted) {
        final l10n = AppLocalizations.of(context);
        if (l10n != null) {
          InAppNotificationService.showError(
            context,
            message: l10n.logoutError,
          );
        }
      }
    }
  }

  /// Affiche la modal de confirmation de déconnexion
  Future<bool?> _showLogoutConfirmation(
    BuildContext context,
    AppLocalizations l10n,
  ) async {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (_isIOS) {
      return showCupertinoDialog<bool>(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: Text(
            l10n.logout,
            style: AppTypography.title.copyWith(
              color: isDark ? AppColors.textOnDark : AppColors.textPrimary,
            ),
          ),
          content: Text(
            l10n.logoutConfirmation,
            style: AppTypography.body.copyWith(
              color: isDark ? AppColors.textSecondaryOnDark : AppColors.textSecondary,
            ),
          ),
          actions: [
            CupertinoDialogAction(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(
                l10n.cancel,
                style: AppTypography.body.copyWith(
                  color: isDark ? AppColors.textOnDark : AppColors.textPrimary,
                ),
              ),
            ),
            CupertinoDialogAction(
              onPressed: () => Navigator.of(context).pop(true),
              isDestructiveAction: true,
              child: Text(
                l10n.logout,
                style: AppTypography.body.copyWith(
                  color: AppColors.error,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return showDialog<bool>(
      context: context,
      useRootNavigator: true, // Passe au-dessus de la bottom nav
      builder: (context) => AlertDialog(
        backgroundColor: isDark ? AppColors.surfaceDark : AppColors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusL),
        ),
        title: Text(
          l10n.logout,
          style: AppTypography.title.copyWith(
            color: isDark ? AppColors.textOnDark : AppColors.textPrimary,
          ),
        ),
        content: Text(
          l10n.logoutConfirmation,
          style: AppTypography.body.copyWith(
            color: isDark ? AppColors.textSecondaryOnDark : AppColors.textSecondary,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(
              l10n.cancel,
              style: AppTypography.body.copyWith(
                color: isDark ? AppColors.textSecondaryOnDark : AppColors.textSecondary,
              ),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(
              l10n.logout,
              style: AppTypography.body.copyWith(
                color: AppColors.error,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

}

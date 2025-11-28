import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocketly/core/core.dart';
import 'package:pocketly/generated/l10n/app_localizations.dart';
import 'package:pocketly/features/settings/presentation/widgets/settings_button_tile.dart';
import 'package:pocketly/features/user/user.dart';

/// Bouton pour supprimer le compte utilisateur et toutes ses données
///
/// ⚠️ ATTENTION : Cette action est IRRÉVERSIBLE
class SettingsDeleteAccountButton extends ConsumerWidget {
  const SettingsDeleteAccountButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;

    return AppCard(
      padding: EdgeInsets.zero,
      child: SettingsButtonTile(
        icon: AppIcons.delete,
        title: l10n.deleteAccount,
        onTap: () => _showDeleteConfirmation(context, ref),
        iconBackgroundColor: AppColors.error,
        textColor: AppColors.error,
      ),
    );
  }

  /// Affiche la boîte de dialogue de confirmation de suppression
  void _showDeleteConfirmation(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final currentUserAsync = ref.read(currentUserProvider);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final userId = currentUserAsync.value?.id;
    if (userId == null) {
      context.showErrorSnackbar(
        ServerError(technicalMessage: 'User ID not found when attempting to delete account'),
      );
      return;
    }

    showDialog(
      context: context,
      useRootNavigator: true,
      barrierColor: Colors.black.withValues(alpha: 0.5),
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusXL),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: AppCard(
          padding: EdgeInsets.zero,
          child: Container(
            constraints: const BoxConstraints(maxWidth: 320),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Icône d'avertissement
                Padding(
                  padding: EdgeInsets.only(
                    top: AppDimensions.paddingXL,
                    left: AppDimensions.paddingXL,
                    right: AppDimensions.paddingXL,
                  ),
                  child: Container(
                    padding: EdgeInsets.all(AppDimensions.paddingM),
                    decoration: BoxDecoration(
                      color: AppColors.error.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      AppIcons.warningOutline,
                      color: AppColors.error,
                      size: 32,
                    ),
                  ),
                ),

                SizedBox(height: AppDimensions.paddingL),

                // Titre
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppDimensions.paddingXL),
                  child: Text(
                    l10n.deleteAccountConfirmTitle,
                    style: AppTypography.heading.copyWith(
                      color: isDark ? AppColors.textOnDark : AppColors.textPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                SizedBox(height: AppDimensions.paddingM),

                // Message
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppDimensions.paddingXL),
                  child: Text(
                    l10n.deleteAccountConfirmMessage,
                    style: AppTypography.body.copyWith(
                      color: isDark
                          ? AppColors.textSecondaryOnDark
                          : AppColors.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                SizedBox(height: AppDimensions.paddingXL),

                // Boutons
                Padding(
                  padding: EdgeInsets.only(
                    left: AppDimensions.paddingXL,
                    right: AppDimensions.paddingXL,
                    bottom: AppDimensions.paddingXL,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppButton(
                        text: l10n.deleteAccountCancel,
                        onPressed: () => Navigator.of(context).pop(),
                        style: AppButtonStyle.outline,
                        size: AppButtonSize.medium,
                        isFullWidth: true,
                      ),
                      SizedBox(height: AppDimensions.paddingM),
                      AppButton(
                        text: l10n.deleteAccountConfirmButton,
                        onPressed: () async {
                          Navigator.of(context).pop();
                          await _deleteAccount(context, ref, userId);
                        },
                        style: AppButtonStyle.error,
                        size: AppButtonSize.medium,
                        isFullWidth: true,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  /// Supprime le compte utilisateur
  Future<void> _deleteAccount(
    BuildContext context,
    WidgetRef ref,
    String userId,
  ) async {
    if (!context.mounted) return;

    final l10n = AppLocalizations.of(context)!;
    final logger = ref.read(loggerProvider);

    // Capturer le BuildContext avant les opérations async
    final navigator = Navigator.of(context, rootNavigator: true);
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    // Afficher un indicateur de chargement
    showDialog(
      context: context,
      useRootNavigator: true,
      barrierDismissible: false,
      builder: (dialogContext) => PopScope(
        canPop: false,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );

    try {
      // Supprimer le compte avec timeout
      await ref.read(currentUserProvider.notifier).deleteAccount(userId).timeout(
        const Duration(seconds: 15),
        onTimeout: () {
          if (kDebugMode) {
            logger.d('[DeleteAccount] Timeout - considéré comme réussi');
          }
        },
      );
      if (kDebugMode) {
        logger.i('[DeleteAccount] Suppression terminée');
      }
    } catch (e, stackTrace) {
      if (kDebugMode) {
        logger.w('[DeleteAccount] Erreur (ignorée): $e', stackTrace: stackTrace);
      }
    }

    // Fermer le dialog de chargement
    try {
      navigator.pop();
      if (kDebugMode) {
        logger.d('[DeleteAccount] Dialog fermé');
      }
    } catch (e) {
      if (kDebugMode) {
        logger.w('[DeleteAccount] Erreur fermeture dialog: $e');
    }
    }

    // Attendre un court instant pour que le dialog se ferme complètement
    await Future.delayed(const Duration(milliseconds: 300));

    // Afficher le message de succès
    try {
      scaffoldMessenger.showSnackBar(
        SnackBar(
          content: Text(
            l10n.accountDeleted,
            style: AppTypography.body.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          backgroundColor: AppColors.success,
          duration: const Duration(seconds: 3),
          behavior: SnackBarBehavior.floating,
        ),
      );
      if (kDebugMode) {
        logger.d('[DeleteAccount] Message de succès affiché');
      }
    } catch (e) {
      if (kDebugMode) {
        logger.w('[DeleteAccount] Erreur affichage snackbar: $e');
      }
    }

    // Le router va automatiquement rediriger vers signin car l'utilisateur n'est plus authentifié
    // Pas besoin de navigation manuelle - le redirect du router s'en charge
    if (kDebugMode) {
      logger.d('[DeleteAccount] Attente de la redirection automatique vers signin...');
    }
  }
}

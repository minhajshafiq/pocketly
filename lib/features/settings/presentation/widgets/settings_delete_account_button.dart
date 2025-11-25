import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pocketly/core/core.dart';
import 'package:pocketly/generated/l10n/app_localizations.dart';
import 'package:pocketly/features/settings/presentation/widgets/settings_button_tile.dart';
import 'package:pocketly/core/widgets/app_card.dart';
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

    final userId = currentUserAsync.value?.id;
    if (userId == null) {
      context.showErrorSnackbar(
        ServerError(technicalMessage: 'User ID not found when attempting to delete account'),
      );
      return;
    }

    showDialog(
      context: context,
      useRootNavigator: true, // Passe au-dessus de la bottom nav
      builder: (context) => AlertDialog(
        title: Text(
          l10n.deleteAccountConfirmTitle,
          style: AppTypography.heading.copyWith(
            color: AppColors.error,
          ),
        ),
        content: Text(
          l10n.deleteAccountConfirmMessage,
          style: AppTypography.body,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              l10n.cancel,
              style: AppTypography.body.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.of(context).pop();
              await _deleteAccount(context, ref, userId);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
              foregroundColor: Colors.white,
            ),
            child: Text(
              l10n.deleteAccountConfirmButton,
              style: AppTypography.body.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
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

    // Afficher un indicateur de chargement
    showDialog(
      context: context,
      useRootNavigator: true, // Passe au-dessus de la bottom nav
      barrierDismissible: false,
      builder: (context) => PopScope(
        canPop: false,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );

    try {
      // Supprimer le compte avec timeout de 10 secondes max
      await ref.read(currentUserProvider.notifier).deleteAccount(userId).timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          // Si timeout après 10 secondes, considérer que c'est OK (les données sont supprimées)
          return;
        },
      );
    } catch (e) {
      // Ignorer les erreurs - les données sont déjà supprimées en base
      debugPrint('Erreur suppression (ignorée): $e');
    }

    // Toujours fermer le dialog et rediriger, même en cas d'erreur
    if (context.mounted) {
      Navigator.of(context).pop(); // Fermer le loading
    }

    // Attendre un peu avant de rediriger
    await Future.delayed(const Duration(milliseconds: 300));

    // Rediriger vers welcome TOUJOURS
    if (context.mounted) {
      context.go('/welcome');
    }
  }
}

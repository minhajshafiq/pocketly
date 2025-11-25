import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:pocketly/core/constants/app_colors.dart';
import 'package:pocketly/core/constants/app_icons.dart';
import 'package:pocketly/features/transaction_history/presentation/providers/transaction_history_providers.dart';
import 'package:pocketly/features/transaction_history/presentation/widgets/transaction_card.dart';
import 'package:pocketly/features/notifications/notifications.dart';
import 'package:pocketly/features/transactions/transactions.dart';

/// Widget pour afficher une transaction avec actions de swipe
class SlidableTransactionCard extends ConsumerStatefulWidget {
  final TransactionEntity transaction;
  final VoidCallback? onTap;

  const SlidableTransactionCard({
    required this.transaction,
    this.onTap,
    super.key,
  });

  @override
  ConsumerState<SlidableTransactionCard> createState() =>
      _SlidableTransactionCardState();
}

class _SlidableTransactionCardState
    extends ConsumerState<SlidableTransactionCard> {
  @override
  Widget build(BuildContext context) {
    // Ne pas afficher le slidable si l'ID est null (transaction non sauvegardée)
    if (widget.transaction.id == null) {
      return TransactionCard(
        transaction: widget.transaction,
        onTap: widget.onTap,
      );
    }

    return Slidable(
      key: ValueKey(widget.transaction.id),

      // Actions de swipe à droite (Edit) - ouvre la modal au swipe complet
      startActionPane: ActionPane(
        motion: const BehindMotion(),
        extentRatio: 0.25,
        dismissible: DismissiblePane(
          onDismissed: () {
            // Ne rien faire car on ne veut pas dismisser la transaction
            // L'action est déclenchée dans confirmDismiss
          },
          confirmDismiss: () async {
            // Quand on swipe complètement vers la droite, ouvrir la modal d'édition
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _handleEdit(context, ref);
            });
            // Ne pas dismisser, juste déclencher l'action
            return false;
          },
        ),
        children: [
          SlidableAction(
            onPressed: (_) => _handleEdit(context, ref),
            backgroundColor: AppColors.info,
            foregroundColor: Colors.white,
            icon: AppIcons.edit,
            label: 'Modifier',
            borderRadius: BorderRadius.circular(12),
          ),
        ],
      ),

      // Actions de swipe à gauche (Delete)
      endActionPane: ActionPane(
        motion: const BehindMotion(),
        extentRatio: 0.25,
        children: [
          SlidableAction(
            onPressed: (_) => _handleDelete(context, ref),
            backgroundColor: AppColors.error,
            foregroundColor: Colors.white,
            icon: AppIcons.delete,
            label: 'Supprimer',
            borderRadius: BorderRadius.circular(12),
          ),
        ],
      ),

      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: TransactionCard(
          transaction: widget.transaction,
          onTap: widget.onTap,
        ),
      ),
    );
  }

  /// Gère l'édition d'une transaction
  void _handleEdit(BuildContext context, WidgetRef ref) {
    // Ne rien faire si l'ID est null
    if (widget.transaction.id == null) return;

    // Ouvrir la modal de modification
    showEditTransactionModal(context, widget.transaction);
  }

  /// Gère la suppression d'une transaction
  Future<void> _handleDelete(BuildContext context, WidgetRef ref) async {
    // Ne rien faire si l'ID est null
    if (widget.transaction.id == null) return;

    // Demander confirmation
    final confirmed = await _showDeleteConfirmation(context);
    if (confirmed != true) return;

    try {
      // Supprimer la transaction via le provider
      await ref
          .read(transactionProvider.notifier)
          .deleteTransaction(widget.transaction.id!);

      // Invalider les providers de transaction history pour rafraîchir la liste
      ref.invalidate(filteredTransactionsProvider);

      if (context.mounted) {
        InAppNotificationService.showSuccess(
          context,
          title: 'Supprimée',
          message: 'Transaction supprimée avec succès',
          duration: const Duration(seconds: 3),
        );
      }
    } catch (e) {
      if (context.mounted) {
        InAppNotificationService.showError(
          context,
          title: 'Erreur',
          message: 'Impossible de supprimer la transaction',
        );
      }
    }
  }

  /// Affiche une confirmation de suppression
  Future<bool?> _showDeleteConfirmation(BuildContext context) async {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (Platform.isIOS) {
      return showCupertinoDialog<bool>(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: const Text('Supprimer la transaction'),
          content: Text(
            'Êtes-vous sûr de vouloir supprimer "${widget.transaction.name}" ?',
          ),
          actions: [
            CupertinoDialogAction(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Annuler'),
            ),
            CupertinoDialogAction(
              onPressed: () => Navigator.of(context).pop(true),
              isDestructiveAction: true,
              child: const Text('Supprimer'),
            ),
          ],
        ),
      );
    }

    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: isDark ? AppColors.surfaceDark : AppColors.surface,
        title: const Text('Supprimer la transaction'),
        content: Text(
          'Êtes-vous sûr de vouloir supprimer "${widget.transaction.name}" ?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Annuler'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text('Supprimer', style: TextStyle(color: AppColors.error)),
          ),
        ],
      ),
    );
  }
}

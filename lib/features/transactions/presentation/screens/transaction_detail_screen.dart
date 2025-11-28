import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocketly/core/constants/app_colors.dart';
import 'package:pocketly/core/constants/app_dimensions.dart';
import 'package:pocketly/core/constants/app_icons.dart';
import 'package:pocketly/features/transactions/domain/entities/transaction_entity.dart';
import 'package:pocketly/features/transactions/presentation/providers/transaction_provider.dart';
import 'package:pocketly/features/transactions/presentation/widgets/transaction_detail_header.dart';
import 'package:pocketly/features/transactions/presentation/widgets/transaction_summary_card.dart';
import 'package:pocketly/features/transactions/presentation/widgets/transaction_occurrences_list.dart';
import 'package:pocketly/generated/l10n/app_localizations.dart';

/// Provider pour récupérer les occurrences d'une transaction
final transactionOccurrencesProvider = FutureProvider.autoDispose
    .family<List<TransactionEntity>, String>((ref, transactionId) async {
      // Récupérer toutes les transactions
      final transactionNotifier = ref.read(
        transactionProvider.notifier,
      );
      await transactionNotifier.loadTransactions();

      final allTransactions = ref
          .read(transactionProvider)
          .allTransactions;

      // Trouver la transaction par ID
      final transaction = allTransactions.firstWhere(
        (t) => t.id == transactionId,
      );

      if (!transaction.isRecurring) {
        // Si la transaction n'est pas récurrente, retourner seulement elle-même
        return [transaction];
      }

      // Si récurrente, récupérer toutes les transactions du même groupe de récurrence
      if (transaction.recurrenceGroupId != null) {
        final occurrences = allTransactions
            .where((t) => t.recurrenceGroupId == transaction.recurrenceGroupId)
            .toList();

        // Trier par date (du plus récent au plus ancien)
        occurrences.sort((a, b) => b.date.compareTo(a.date));

        return occurrences;
      }

      // Générer les occurrences entre la date de début et maintenant
      final now = DateTime.now();
      final startDate = transaction.recurrenceStartDate ?? transaction.date;

      return transaction.getOccurrencesBetween(start: startDate, end: now);
    });

/// Écran de détails d'une transaction
class TransactionDetailScreen extends ConsumerWidget {
  final String transactionId;

  const TransactionDetailScreen({required this.transactionId, super.key});

  bool get _isIOS => !kIsWeb && Platform.isIOS;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Récupérer la transaction et ses occurrences
    final occurrencesAsync = ref.watch(
      transactionOccurrencesProvider(transactionId),
    );

    return Column(
      children: [
        // Header avec titre
        _buildHeader(context, l10n, isDark),

        // Contenu scrollable
        Expanded(
          child: occurrencesAsync.when(
            data: (occurrences) {
              if (occurrences.isEmpty) {
                return _buildErrorContent(
                  l10n,
                  isDark,
                  'Transaction not found',
                );
              }

              final transaction = occurrences.first;
              return _buildContent(context, transaction, occurrences);
            },
            loading: () => _buildLoadingContent(),
            error: (error, stack) =>
                _buildErrorContent(l10n, isDark, error.toString()),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader(
    BuildContext context,
    AppLocalizations l10n,
    bool isDark,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingL,
        vertical: AppDimensions.paddingM,
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: isDark ? AppColors.borderDark : AppColors.borderLight,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              l10n.transactionDetails,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          IconButton(
            icon: Icon(_isIOS ? CupertinoIcons.xmark : AppIcons.close),
            onPressed: () => Navigator.of(context).pop(),
            color: isDark ? AppColors.textOnDark : AppColors.textPrimary,
          ),
        ],
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    TransactionEntity transaction,
    List<TransactionEntity> occurrences,
  ) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(AppDimensions.paddingL),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // En-tête avec icône, nom, montant, date
          TransactionDetailHeader(transaction: transaction),

          SizedBox(height: AppDimensions.paddingL),

          // Carte de résumé (total et nombre d'occurrences)
          TransactionSummaryCard(
            transaction: transaction,
            occurrences: occurrences,
          ),

          SizedBox(height: AppDimensions.paddingL),

          // Liste des occurrences
          TransactionOccurrencesList(occurrences: occurrences),

          SizedBox(height: AppDimensions.paddingXL),
        ],
      ),
    );
  }

  Widget _buildLoadingContent() {
    return Center(
      child: _isIOS
          ? const CupertinoActivityIndicator()
          : const CircularProgressIndicator(),
    );
  }

  Widget _buildErrorContent(AppLocalizations l10n, bool isDark, String error) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(AppDimensions.paddingXL),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _isIOS ? CupertinoIcons.exclamationmark_triangle : AppIcons.error,
              size: 64,
              color: AppColors.error,
            ),
            SizedBox(height: AppDimensions.paddingM),
            Text(
              l10n.error,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.error,
              ),
            ),
            SizedBox(height: AppDimensions.paddingS),
            Text(
              error,
              textAlign: TextAlign.center,
              style: const TextStyle(color: AppColors.error),
            ),
          ],
        ),
      ),
    );
  }
}

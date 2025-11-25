import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pocketly/core/constants/app_colors.dart';
import 'package:pocketly/core/constants/app_dimensions.dart';
import 'package:pocketly/core/constants/app_typography.dart';
import 'package:pocketly/features/transactions/domain/entities/transaction_entity.dart';
import 'package:pocketly/generated/l10n/app_localizations.dart';
import 'package:pocketly/features/currency/currency.dart';

/// Widget affichant la liste des occurrences d'une transaction
class TransactionOccurrencesList extends StatelessWidget {
  final List<TransactionEntity> occurrences;

  const TransactionOccurrencesList({
    required this.occurrences,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (occurrences.isEmpty) {
      return _buildEmptyState(context, l10n, isDark);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Titre
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppDimensions.paddingL),
          child: Text(
            l10n.occurrenceHistory,
            style: AppTypography.heading.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isDark ? AppColors.textOnDark : AppColors.textPrimary,
            ),
          ),
        ),

        SizedBox(height: AppDimensions.paddingM),

        // Liste des occurrences
        ...occurrences.asMap().entries.map((entry) {
          final index = entry.key;
          final occurrence = entry.value;

          return Padding(
            padding: EdgeInsets.only(
              bottom: index < occurrences.length - 1 ? AppDimensions.paddingS : 0,
            ),
            child: _buildOccurrenceItem(
              context: context,
              occurrence: occurrence,
              index: index + 1,
              total: occurrences.length,
              isDark: isDark,
            ),
          );
        }),
      ],
    );
  }

  Widget _buildOccurrenceItem({
    required BuildContext context,
    required TransactionEntity occurrence,
    required int index,
    required int total,
    required bool isDark,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: AppDimensions.paddingL),
      padding: EdgeInsets.all(AppDimensions.paddingM),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.surface,
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        border: Border.all(
          color: isDark ? AppColors.borderDark : AppColors.borderLight,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          // Numéro
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: occurrence.isExpense
                  ? AppColors.error.withValues(alpha: 0.1)
                  : AppColors.success.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '#$index',
                style: AppTypography.bodyBold.copyWith(
                  color: occurrence.isExpense ? AppColors.error : AppColors.success,
                  fontSize: 12,
                ),
              ),
            ),
          ),

          SizedBox(width: AppDimensions.paddingM),

          // Date
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  () {
                    final formatted = DateFormat('dd MMMM yyyy', 'fr_FR').format(occurrence.date);
                    // Capitaliser le mois en français
                    final parts = formatted.split(' ');
                    if (parts.length >= 3) {
                      // Format: "15 novembre 2024" - le mois est à l'index 1
                      parts[1] = parts[1][0].toUpperCase() + parts[1].substring(1);
                      return parts.join(' ');
                    }
                    return formatted;
                  }(),
                  style: AppTypography.body.copyWith(
                    fontWeight: FontWeight.w600,
                    color: isDark ? AppColors.textOnDark : AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: AppDimensions.paddingXS),
                Text(
                  DateFormat('HH:mm', 'fr_FR').format(occurrence.date),
                  style: AppTypography.small.copyWith(
                    color: isDark ? AppColors.textSecondaryOnDark : AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),

          // Montant
          CurrencyDisplayWidget(
            amount: occurrence.amount,
            style: AppTypography.bodyBold.copyWith(
              fontSize: 16,
              color: occurrence.isExpense ? AppColors.error : AppColors.success,
            ),
            decimals: 2,
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, AppLocalizations l10n, bool isDark) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(AppDimensions.paddingXL),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.inbox_outlined,
              size: 64,
              color: isDark ? AppColors.textSecondaryOnDark : AppColors.textSecondary,
            ),
            SizedBox(height: AppDimensions.paddingM),
            Text(
              l10n.noTransactionsYet,
              style: AppTypography.body.copyWith(
                color: isDark ? AppColors.textSecondaryOnDark : AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

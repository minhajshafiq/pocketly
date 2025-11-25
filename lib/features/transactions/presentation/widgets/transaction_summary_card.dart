import 'package:flutter/material.dart';
import 'package:pocketly/core/constants/app_colors.dart';
import 'package:pocketly/core/constants/app_dimensions.dart';
import 'package:pocketly/core/constants/app_typography.dart';
import 'package:pocketly/core/widgets/app_card.dart';
import 'package:pocketly/features/transactions/domain/entities/transaction_entity.dart';
import 'package:pocketly/generated/l10n/app_localizations.dart';
import 'package:pocketly/features/currency/currency.dart';

/// Widget affichant le résumé de la transaction
/// Affiche le total dépensé/reçu et le nombre d'occurrences
class TransactionSummaryCard extends StatelessWidget {
  final TransactionEntity transaction;
  final List<TransactionEntity> occurrences;

  const TransactionSummaryCard({
    required this.transaction,
    required this.occurrences,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Calculer le total
    final totalAmount = occurrences.fold<double>(
      0.0,
      (sum, t) => sum + t.amount,
    );

    return AppCard(
      padding: EdgeInsets.all(AppDimensions.paddingL),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Titre
          Text(
            l10n.sinceCreation,
            style: AppTypography.small.copyWith(
              color: isDark ? AppColors.textSecondaryOnDark : AppColors.textSecondary,
            ),
          ),

          SizedBox(height: AppDimensions.paddingL),

          // Total dépensé/reçu
          Row(
            children: [
              Expanded(
                child: _buildSummaryItem(
                  context: context,
                  label: transaction.isExpense ? l10n.totalSpent : l10n.totalReceived,
                  value: totalAmount,
                  icon: transaction.isExpense ? Icons.arrow_downward : Icons.arrow_upward,
                  color: transaction.isExpense ? AppColors.error : AppColors.success,
                  isDark: isDark,
                ),
              ),

              SizedBox(width: AppDimensions.paddingM),

              // Nombre d'occurrences
              Expanded(
                child: _buildSummaryItem(
                  context: context,
                  label: l10n.occurrences,
                  count: occurrences.length,
                  icon: Icons.repeat,
                  color: AppColors.info,
                  isDark: isDark,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem({
    required BuildContext context,
    required String label,
    double? value,
    int? count,
    required IconData icon,
    required Color color,
    required bool isDark,
  }) {
    return Container(
      padding: EdgeInsets.all(AppDimensions.paddingM),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        border: Border.all(
          color: color.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 16,
                color: color,
              ),
              SizedBox(width: AppDimensions.paddingXS),
              Expanded(
                child: Text(
                  label,
                  style: AppTypography.small.copyWith(
                    color: isDark ? AppColors.textSecondaryOnDark : AppColors.textSecondary,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: AppDimensions.paddingS),

          // Afficher le montant ou le compte
          if (value != null)
            CurrencyDisplayWidget(
              amount: value,
              style: AppTypography.heading.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: color,
              ),
              decimals: 2,
            )
          else if (count != null)
            Text(
              count.toString(),
              style: AppTypography.heading.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
        ],
      ),
    );
  }
}

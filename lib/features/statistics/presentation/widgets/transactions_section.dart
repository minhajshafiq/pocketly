import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocketly/core/constants/app_colors.dart';
import 'package:pocketly/core/constants/app_dimensions.dart';
import 'package:pocketly/core/constants/app_icons.dart';
import 'package:pocketly/core/constants/app_typography.dart';
import 'package:pocketly/core/widgets/app_card.dart';
import 'package:pocketly/features/statistics/presentation/providers/statistics_providers.dart';
import 'package:pocketly/generated/l10n/app_localizations.dart';
import 'package:pocketly/features/currency/currency.dart';
import 'package:pocketly/features/transactions/transactions.dart';

/// Section affichant les transactions de la période
class TransactionsSection extends ConsumerWidget {
  const TransactionsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactionState = ref.watch(transactionProvider);
    final transactions = ref.watch(periodTransactionsControllerProvider);
    final selectedDay = ref.watch(selectedDayProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context)!;

    // Filtrer par jour sélectionné si applicable
    final filteredTransactions = selectedDay == null
        ? transactions
        : transactions.where((transaction) {
            final transactionDate = transaction.date;
            return transactionDate.year == selectedDay.year &&
                transactionDate.month == selectedDay.month &&
                transactionDate.day == selectedDay.day;
          }).toList();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppDimensions.paddingM),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Titre avec indication du jour sélectionné
          Row(
            children: [
              Text(
                l10n.transactions,
                style: AppTypography.heading.copyWith(
                  fontWeight: FontWeight.bold,
                  color: isDark ? AppColors.textOnDark : AppColors.textPrimary,
                ),
              ),
              if (selectedDay != null) ...[
                SizedBox(width: AppDimensions.paddingS),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppDimensions.paddingS,
                    vertical: AppDimensions.paddingXS,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(AppDimensions.radiusS),
                  ),
                  child: Text(
                    _formatDate(selectedDay),
                    style: AppTypography.small.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ],
          ),

          SizedBox(height: AppDimensions.paddingM),

          // Afficher l'état de chargement si initial ou loading
          if (transactionState is TransactionStateInitial || transactionState.isLoadingState)
            _buildLoadingState(isDark)
          // Afficher l'erreur si présente
          else if (transactionState.hasError)
            _buildEmptyState(context, isDark, null)
          // Afficher les transactions ou l'état vide
          else if (filteredTransactions.isEmpty)
            _buildEmptyState(context, isDark, selectedDay)
          else
            Column(
                children: filteredTransactions
                    .take(10) // Limiter à 10 transactions
                    .map(
                      (transaction) =>
                          _buildTransactionItem(context, transaction, isDark),
                    )
                    .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(
    BuildContext context,
    bool isDark,
    DateTime? selectedDay,
  ) {
    final l10n = AppLocalizations.of(context)!;
    return AppCard(
      padding: EdgeInsets.all(AppDimensions.paddingXL),
      child: Center(
        child: Column(
          children: [
            Icon(
              AppIcons.description,
              size: 48,
              color: isDark
                  ? AppColors.textSecondaryOnDark
                  : AppColors.textSecondary,
            ),
            SizedBox(height: AppDimensions.paddingM),
            Text(
              l10n.noTransaction,
              style: AppTypography.body.copyWith(
                color: isDark
                    ? AppColors.textSecondaryOnDark
                    : AppColors.textSecondary,
              ),
            ),
            SizedBox(height: AppDimensions.paddingXS),
            Text(
              selectedDay != null ? l10n.forThisDay : l10n.available,
              style: AppTypography.body.copyWith(
                color: isDark
                    ? AppColors.textSecondaryOnDark
                    : AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingState(bool isDark) {
    return AppCard(
      padding: EdgeInsets.all(AppDimensions.paddingL),
      child: Column(
        children: List.generate(
          3,
          (index) => Container(
            margin: EdgeInsets.only(bottom: AppDimensions.paddingM),
            height: 60,
            decoration: BoxDecoration(
              color: isDark ? AppColors.surfaceDark : AppColors.surface,
              borderRadius: BorderRadius.circular(AppDimensions.radiusM),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTransactionItem(
    BuildContext context,
    TransactionEntity transaction,
    bool isDark,
  ) {
    final isIncome = transaction.isIncome;

    return Padding(
      padding: EdgeInsets.only(bottom: AppDimensions.paddingM),
      child: AppCard(
        padding: EdgeInsets.all(AppDimensions.paddingM),
        backgroundColor: isDark ? AppColors.surfaceDark : AppColors.surface,
        borderColor: Colors.transparent,
        elevation: 6,
        child: Row(
          children: [
            // Icône de type ou image de transaction
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: (isIncome ? AppColors.success : AppColors.error)
                    .withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: ClipOval(
                child:
                    transaction.imageUrl != null &&
                        transaction.imageUrl!.isNotEmpty
                    ? Image.network(
                        transaction.imageUrl!,
                        fit: BoxFit.cover,
                        width: 40,
                        height: 40,
                        errorBuilder: (context, error, stackTrace) {
                          return Center(
                            child: Icon(
                              isIncome ? AppIcons.arrowDown : AppIcons.arrowUp,
                              color: isIncome
                                  ? AppColors.success
                                  : AppColors.error,
                              size: 20,
                            ),
                          );
                        },
                      )
                    : Center(
                        child: Icon(
                          isIncome ? AppIcons.arrowDown : AppIcons.arrowUp,
                          color: isIncome ? AppColors.success : AppColors.error,
                          size: 20,
                        ),
                      ),
              ),
            ),

            SizedBox(width: AppDimensions.paddingM),

            // Nom et date
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    transaction.name,
                    style: AppTypography.body.copyWith(
                      fontWeight: FontWeight.w600,
                      color: isDark
                          ? AppColors.textOnDark
                          : AppColors.textPrimary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: AppDimensions.paddingXS),
                  Text(
                    _formatDate(transaction.date),
                    style: AppTypography.small.copyWith(
                      color: isDark
                          ? AppColors.textSecondaryOnDark
                          : AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),

            // Montant avec signe
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  isIncome ? '+' : '-',
                  style: AppTypography.body.copyWith(
                    color: isIncome ? AppColors.success : AppColors.error,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                CurrencyDisplayWidget(
                  amount: transaction.amount,
                  style: AppTypography.body.copyWith(
                    color: isIncome ? AppColors.success : AppColors.error,
                    fontWeight: FontWeight.bold,
                  ),
                  decimals: 2,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final year = date.year;
    return '$day/$month/$year';
  }
}

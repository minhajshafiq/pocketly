import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:pocketly/core/constants/app_colors.dart';
import 'package:pocketly/core/constants/app_dimensions.dart';
import 'package:pocketly/core/constants/app_icons.dart';
import 'package:pocketly/core/constants/app_typography.dart';
import 'package:pocketly/core/router/app_route_paths.dart';
import 'package:pocketly/core/widgets/app_button.dart';
import 'package:pocketly/core/widgets/app_card.dart';
import 'package:pocketly/features/home/presentation/providers/home_providers.dart';
import 'package:pocketly/generated/l10n/app_localizations.dart';
import 'package:pocketly/features/currency/currency.dart';
import 'package:pocketly/features/transactions/transactions.dart';

class RecentTransactionsWidget extends ConsumerWidget {
  const RecentTransactionsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactionState = ref.watch(transactionProvider);
    final transactions = ref.watch(recentTransactionsControllerProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AppCard(
      padding: EdgeInsets.fromLTRB(
        AppDimensions.paddingM,
        AppDimensions.paddingM,
        AppDimensions.paddingM,
        0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppLocalizations.of(context)!.recentTransactions,
                style: AppTypography.small.copyWith(
                  color: isDark
                      ? AppColors.textSecondaryOnDark
                      : AppColors.textSecondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextButton(
                onPressed: () => context.push(AppRoutePaths.transactionHistory),
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  AppLocalizations.of(context)!.seeAll,
                  style: AppTypography.small.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: AppDimensions.paddingS),
          // Afficher l'état de chargement si initial ou loading
          if (transactionState is TransactionStateInitial || transactionState.isLoadingState)
            _buildLoadingState(isDark)
          // Afficher l'erreur si présente
          else if (transactionState.hasError)
            _buildErrorState(context)
          // Afficher les transactions ou l'état vide
          else if (transactions.isEmpty)
            _buildEmptyState(context, isDark)
          else
            ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: transactions.length,
                itemBuilder: (context, index) =>
                    _buildTransactionItem(context, transactions[index], isDark),
                separatorBuilder: (context, index) => Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: AppDimensions.paddingXS / 3,
                    horizontal: AppDimensions
                        .paddingL, // Marges pour rendre le trait légèrement plus court (24px)
                  ),
                  child: Divider(
                    height: 0.3,
                    thickness: 0.3,
                    color: isDark
                        ? AppColors.borderDark.withValues(alpha: 0.35)
                        : AppColors.borderLight.withValues(alpha: 0.35),
                  ),
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionItem(
    BuildContext context,
    dynamic transaction,
    bool isDark,
  ) {
    final isExpense = transaction.type == TransactionType.expense;

    // Format: MOIS HEURE (ex: "03 oct. 15:16" ou "03 Oct 15:16")
    final formattedDate = DateFormat(
      'd MMM HH:mm',
      Localizations.localeOf(context).toLanguageTag(),
    ).format(transaction.date);

    return InkWell(
      onTap: () {
        // Ouvrir la modal de détails de transaction
        showTransactionDetailModal(context, transaction.id);
      },
      borderRadius: BorderRadius.circular(AppDimensions.radiusM),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: AppDimensions.paddingS),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Leading circular icon with subtle background or transaction image
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: (isExpense ? AppColors.error : AppColors.success)
                    .withValues(alpha: 0.12),
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
                          return Icon(
                            isExpense ? AppIcons.shopping : AppIcons.wallet,
                            size: 20,
                            color: (isExpense
                                ? AppColors.error
                                : AppColors.success),
                          );
                        },
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                value:
                                    loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            ),
                          );
                        },
                      )
                    : Icon(
                        isExpense ? AppIcons.shopping : AppIcons.wallet,
                        size: 20,
                        color: (isExpense
                            ? AppColors.error
                            : AppColors.success),
                      ),
              ),
            ),
            SizedBox(width: AppDimensions.paddingM),
            // Title and date
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    transaction.name,
                    style: AppTypography.small.copyWith(
                      fontWeight: FontWeight.w600,
                      color: isDark
                          ? AppColors.textOnDark
                          : AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: AppDimensions.paddingXS),
                  Text(
                    formattedDate,
                    style: AppTypography.small.copyWith(
                      color: isDark
                          ? AppColors.textSecondaryOnDark
                          : AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            // Amount with sign aligned right
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  isExpense ? '-' : '+',
                  style: AppTypography.small.copyWith(
                    color: isExpense ? AppColors.error : AppColors.success,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                CurrencyAmountText(
                  amount: transaction.amount,
                  style: AppTypography.small.copyWith(
                    color: isExpense ? AppColors.error : AppColors.success,
                    fontWeight: FontWeight.w600,
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

  Widget _buildEmptyState(BuildContext context, bool isDark) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(AppDimensions.paddingXL),
        child: Column(
          children: [
            Icon(
              AppIcons.transactions,
              size: 64,
              color: isDark ? AppColors.textOnDark : AppColors.textPrimary,
            ),
            SizedBox(height: AppDimensions.paddingM),
            Text(
              AppLocalizations.of(context)!.noTransactionsYet,
              style: AppTypography.small.copyWith(
                color: isDark
                    ? AppColors.textSecondaryOnDark
                    : AppColors.textSecondary,
              ),
            ),
            SizedBox(height: AppDimensions.paddingM),
            AppButton(
              text: AppLocalizations.of(context)!.addTransaction,
              onPressed: () => showTransactionTypeModal(context),
              style: AppButtonStyle.gradient,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingState(bool isDark) {
    return Column(
      children: List.generate(
        3,
        (index) => Padding(
          padding: EdgeInsets.symmetric(vertical: AppDimensions.paddingM),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: (isDark ? AppColors.surfaceDark : AppColors.surface)
                      .withValues(alpha: 0.8),
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: AppDimensions.paddingM),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 12,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: (isDark
                            ? AppColors.surfaceDark
                            : AppColors.surface),
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    SizedBox(height: AppDimensions.paddingS),
                    Container(
                      height: 10,
                      width: 120,
                      decoration: BoxDecoration(
                        color: (isDark
                            ? AppColors.surfaceDark
                            : AppColors.surface),
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: AppDimensions.paddingM),
              Container(
                height: 12,
                width: 80,
                decoration: BoxDecoration(
                  color: (isDark ? AppColors.surfaceDark : AppColors.surface),
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildErrorState(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(AppDimensions.paddingL),
        child: Text(
          AppLocalizations.of(context)!.failedToLoadTransactions,
          style: AppTypography.small.copyWith(color: AppColors.error),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocketly/core/core.dart';
import 'package:pocketly/core/utils/date_utils.dart' as pocketly_date_utils;
import 'package:pocketly/features/currency/currency.dart';
import 'package:pocketly/features/transactions/transactions.dart';

/// Widget de statistiques pour un pocket
///
/// Affiche:
/// - Le nombre de transactions
/// - Le coût moyen par transaction
/// - Les dépenses de cette semaine
class PocketStatisticsWidget extends ConsumerWidget {
  final String pocketId;

  const PocketStatisticsWidget({
    super.key,
    required this.pocketId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactionsAsync = ref.watch(transactionsByPocketProvider(pocketId));
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AppCard(
      padding: EdgeInsets.all(AppDimensions.paddingM),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header avec titre
            Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: AppColors.secondaryDark.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(AppDimensions.radiusS),
                  ),
                  child: Icon(
                    AppIcons.stats,
                    color: AppColors.secondaryDark,
                    size: AppDimensions.iconS + 2,
                  ),
                ),
                SizedBox(width: AppDimensions.paddingM),
                Text(
                  'Statistiques',
                  style: AppTypography.title.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(height: AppDimensions.paddingM),

            // Contenu
            transactionsAsync.when(
              data: (transactions) {
                final stats = _calculateStatistics(transactions);
                return _buildStatisticsContent(
                  context: context,
                  stats: stats,
                  isDark: isDark,
                );
              },
              loading: () => Center(
                child: Padding(
                  padding: EdgeInsets.all(AppDimensions.paddingL),
                  child: const CircularProgressIndicator(),
                ),
              ),
              error: (error, stack) => Center(
                child: Padding(
                  padding: EdgeInsets.all(AppDimensions.paddingM),
                  child: Text(
                    'Erreur lors du chargement des statistiques',
                    style: AppTypography.body.copyWith(
                      color: AppColors.error,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
    );
  }

  Widget _buildStatisticsContent({
    required BuildContext context,
    required _Statistics stats,
    required bool isDark,
  }) {
    // Section avec 3 colonnes (style similaire à la section budget)
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        // Nombre de transactions
        Expanded(
          child: _buildStatColumn(
            context: context,
            icon: AppIcons.bills,
            iconColor: AppColors.infoLight,
            label: 'Transactions',
            value: '${stats.transactionCount}',
            isDark: isDark,
          ),
        ),
        
        SizedBox(width: AppDimensions.paddingM),

        // Coût moyen par transaction
        Expanded(
          child: _buildStatColumnWithCurrency(
            context: context,
            icon: AppIcons.wallet,
            iconColor: AppColors.warningLight,
            label: 'Moyenne',
            amount: stats.averageAmount,
            isDark: isDark,
          ),
        ),
        
        SizedBox(width: AppDimensions.paddingM),
        
        // Dépenses de cette semaine
        Expanded(
          child: _buildStatColumnWithCurrency(
            context: context,
            icon: AppIcons.calendar,
            iconColor: AppColors.errorLight,
            label: 'Cette semaine',
            amount: stats.weeklyExpenses,
            isDark: isDark,
          ),
        ),
      ],
    );
  }

  Widget _buildStatColumn({
    required BuildContext context,
    required IconData icon,
    required Color iconColor,
    required String label,
    required String value,
    required bool isDark,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Icône
        Icon(
          icon,
          color: iconColor,
          size: AppDimensions.iconM,
        ),
        SizedBox(height: AppDimensions.paddingXS),
        
        // Label
        Text(
          label,
          style: AppTypography.caption.copyWith(
            color: isDark 
                ? AppColors.textSecondaryOnDark 
                : AppColors.textSecondary,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: AppDimensions.paddingXS),
        
        // Valeur
        Text(
          value,
          style: AppTypography.bodyBold.copyWith(
            color: isDark ? AppColors.textOnDark : AppColors.textPrimary,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildStatColumnWithCurrency({
    required BuildContext context,
    required IconData icon,
    required Color iconColor,
    required String label,
    required double amount,
    required bool isDark,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Icône
        Icon(
          icon,
          color: iconColor,
          size: AppDimensions.iconM,
        ),
        SizedBox(height: AppDimensions.paddingXS),
        
        // Label
        Text(
          label,
          style: AppTypography.caption.copyWith(
            color: isDark 
                ? AppColors.textSecondaryOnDark 
                : AppColors.textSecondary,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: AppDimensions.paddingXS),
        
        // Montant avec CurrencyAmountText
        Center(
          child: CurrencyAmountText(
            amount: amount,
            style: AppTypography.bodyBold.copyWith(
              color: isDark ? AppColors.textOnDark : AppColors.textPrimary,
            ),
          ),
        ),
      ],
    );
  }

  _Statistics _calculateStatistics(List<TransactionEntity> transactions) {
    // Filtrer uniquement les dépenses
    final expenses = transactions.where((t) => t.isExpense).toList();

    // Nombre de transactions
    final transactionCount = expenses.length;

    // Coût moyen par transaction
    double averageAmount = 0.0;
    if (transactionCount > 0) {
      final totalAmount = expenses.fold<double>(
        0.0,
        (sum, transaction) => sum + transaction.amount,
      );
      averageAmount = totalAmount / transactionCount;
    }

    // Dépenses de cette semaine
    final now = DateTime.now();
    final weekStart = pocketly_date_utils.DateUtils.startOfWeek(now);
    final weekEnd = pocketly_date_utils.DateUtils.endOfWeek(now);

    // Normaliser les dates pour la comparaison
    final weekStartNormalized = DateTime(
      weekStart.year,
      weekStart.month,
      weekStart.day,
    );
    final weekEndNormalized = DateTime(
      weekEnd.year,
      weekEnd.month,
      weekEnd.day,
      23,
      59,
      59,
    );

    final weeklyExpenses = expenses
        .where((transaction) {
          final transactionDate = DateTime(
            transaction.date.year,
            transaction.date.month,
            transaction.date.day,
          );
          return transactionDate.isAfter(
                weekStartNormalized.subtract(const Duration(seconds: 1)),
              ) &&
              transactionDate.isBefore(
                weekEndNormalized.add(const Duration(seconds: 1)),
              );
        })
        .fold<double>(
          0.0,
          (sum, transaction) => sum + transaction.amount,
        );

    return _Statistics(
      transactionCount: transactionCount,
      averageAmount: averageAmount,
      weeklyExpenses: weeklyExpenses,
    );
  }
}

/// Classe interne pour stocker les statistiques calculées
class _Statistics {
  final int transactionCount;
  final double averageAmount;
  final double weeklyExpenses;

  _Statistics({
    required this.transactionCount,
    required this.averageAmount,
    required this.weeklyExpenses,
  });
}


import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocketly/core/constants/app_colors.dart';
import 'package:pocketly/core/constants/app_dimensions.dart';
import 'package:pocketly/core/constants/app_icons.dart';
import 'package:pocketly/core/constants/app_typography.dart';
import 'package:pocketly/core/widgets/app_card.dart';
import 'package:pocketly/features/statistics/domain/entities/chart_data_entity.dart';
import 'package:pocketly/features/statistics/presentation/providers/statistics_providers.dart';
import 'package:pocketly/features/statistics/presentation/widgets/daily_expenses_chart.dart';
import 'package:pocketly/features/statistics/presentation/widgets/daily_expenses_line_chart.dart';
import 'package:pocketly/features/statistics/presentation/widgets/income_expense_cards.dart';
import 'package:pocketly/generated/l10n/app_localizations.dart';
import 'package:pocketly/features/currency/currency.dart';

/// Carte principale contenant le graphique et les statistiques
class StatisticsMainCard extends ConsumerWidget {
  const StatisticsMainCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chartDataAsync = ref.watch(chartDataControllerProvider);
    final period = ref.watch(timePeriodProvider);
    final chartType = ref.watch(chartTypeProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context)!;

    return AppCard(
      padding: EdgeInsets.all(AppDimensions.paddingM),
      child: chartDataAsync.when(
        data: (chartData) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header avec montant total et sélecteur de période
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Montant total dépensé
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.spent,
                      style: AppTypography.small.copyWith(
                        color: isDark
                            ? AppColors.textSecondaryOnDark
                            : AppColors.textSecondary,
                      ),
                    ),
                    SizedBox(height: AppDimensions.paddingXS),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '- ',
                          style: AppTypography.heading.copyWith(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: AppColors.error,
                          ),
                        ),
                        CurrencyDisplayWidget(
                          amount: chartData.totalExpense,
                          style: AppTypography.heading.copyWith(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: AppColors.error,
                          ),
                          decimals: 0,
                        ),
                      ],
                    ),
                  ],
                ),

                // Sélecteur de période
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppDimensions.paddingM,
                    vertical: AppDimensions.paddingS,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(AppDimensions.radiusL),
                    border: Border.all(
                      color:
                          (isDark
                                  ? AppColors.textSecondaryOnDark
                                  : AppColors.textSecondary)
                              .withValues(alpha: 0.2),
                      width: 1,
                    ),
                  ),
                  child: DropdownButton<TimePeriod>(
                    value: period,
                    underline: const SizedBox(),
                    isDense: true,
                    isExpanded: false,
                    alignment: Alignment.center,
                    style: AppTypography.body.copyWith(
                      color: isDark
                          ? AppColors.textOnDark
                          : AppColors.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                    dropdownColor: isDark
                        ? AppColors.surfaceDark
                        : AppColors.surface,
                    icon: Padding(
                      padding: EdgeInsets.only(left: 6, bottom: 1),
                      child: Icon(
                        AppIcons.keyboardArrowDown,
                        color: isDark
                            ? AppColors.textOnDark
                            : AppColors.textPrimary,
                        size: 16,
                      ),
                    ),
                    items: TimePeriod.values.map((p) {
                      return DropdownMenuItem(
                        value: p,
                        child: Text(p.getName(l10n), style: AppTypography.body),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        ref.read(timePeriodProvider.notifier).setPeriod(value);
                      }
                    },
                  ),
                ),
              ],
            ),

            SizedBox(height: AppDimensions.paddingL),

            // Message si pas de données
            if (!chartData.hasData)
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: AppDimensions.paddingXL,
                  ),
                  child: Column(
                    children: [
                      Icon(
                        AppIcons.checkCircleOutline,
                        size: 48,
                        color: isDark
                            ? AppColors.textSecondaryOnDark
                            : AppColors.textSecondary,
                      ),
                      SizedBox(height: AppDimensions.paddingM),
                      Text(
                        l10n.noData,
                        style: AppTypography.body.copyWith(
                          color: isDark
                              ? AppColors.textSecondaryOnDark
                              : AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            else ...[
              // Graphique des dépenses quotidiennes (bar ou line selon le type)
              chartType == ChartType.bar
                  ? const DailyExpensesChart()
                  : const DailyExpensesLineChart(),

              SizedBox(height: AppDimensions.paddingL),

              // Cartes revenus et dépenses
              IncomeExpenseCards(
                totalIncome: chartData.totalIncome,
                totalExpense: chartData.totalExpense,
              ),
            ],
          ],
        ),
        loading: () => _buildLoadingState(isDark),
        error: (error, stack) => _buildErrorState(isDark, l10n),
      ),
    );
  }

  Widget _buildLoadingState(bool isDark) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(AppDimensions.paddingXL),
        child: CircularProgressIndicator(color: AppColors.primary),
      ),
    );
  }

  Widget _buildErrorState(bool isDark, AppLocalizations l10n) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(AppDimensions.paddingL),
        child: Column(
          children: [
            Icon(AppIcons.errorOutline, size: 48, color: AppColors.error),
            SizedBox(height: AppDimensions.paddingM),
            Text(
              l10n.loadingError,
              style: AppTypography.body.copyWith(color: AppColors.error),
            ),
          ],
        ),
      ),
    );
  }
}

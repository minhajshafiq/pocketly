import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocketly/core/constants/app_colors.dart';
import 'package:pocketly/core/constants/app_dimensions.dart';
import 'package:pocketly/core/constants/app_typography.dart';
import 'package:pocketly/features/locale/locale.dart';
import 'package:pocketly/features/statistics/domain/entities/chart_data_entity.dart';
import 'package:pocketly/features/statistics/domain/entities/daily_expense_entity.dart';
import 'package:pocketly/features/statistics/presentation/providers/statistics_providers.dart';
import 'package:pocketly/generated/l10n/app_localizations.dart';
import 'package:pocketly/features/currency/currency.dart';

/// Widget affichant le graphique en barres des dépenses quotidiennes
class DailyExpensesChart extends ConsumerWidget {
  const DailyExpensesChart({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Écouter le changement de locale pour rebuild automatique
    ref.watch(currentLocaleProvider);

    final chartDataAsync = ref.watch(chartDataControllerProvider);
    final selectedDay = ref.watch(selectedDayProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context)!;

    return chartDataAsync.when(
      data: (chartData) {
        // Calculer la hauteur maximale des barres
        final maxExpense = chartData.maxExpense;
        
        // Déterminer le nombre d'éléments à afficher selon la période
        final itemCount = chartData.period == TimePeriod.week
            ? 7
            : chartData.period == TimePeriod.month
                ? 6
                : 7; // year

        return SizedBox(
          height: 140, // Même hauteur que weekly expenses
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: chartData.dailyExpenses.take(itemCount).map((dayExpense) {
              final isToday = dayExpense.isToday;
              final hasExpense = dayExpense.expense > 0;
              // Même logique de scaling que weekly expenses
              final scaled = maxExpense > 0
                  ? (dayExpense.expense / maxExpense * 85).clamp(8.0, 85.0)
                  : 8.0;
              final height = hasExpense ? scaled : 6.0;

              // Vérifier si ce jour est sélectionné
              final isSelected =
                  selectedDay != null &&
                  dayExpense.date.year == selectedDay.year &&
                  dayExpense.date.month == selectedDay.month &&
                  dayExpense.date.day == selectedDay.day;

              return Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppDimensions.paddingXS,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      // Si déjà sélectionné, désélectionner
                      if (isSelected) {
                        ref.read(selectedDayProvider.notifier).clearSelection();
                      } else {
                        // Sinon, sélectionner ce jour
                        ref
                            .read(selectedDayProvider.notifier)
                            .selectDay(dayExpense.date);
                      }
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // Montant (affiché seulement si > 0)
                        SizedBox(
                          height: 18, // Même hauteur que weekly expenses
                          child: hasExpense
                              ? Center(
                                  child: CurrencyDisplayWidget(
                                    amount: dayExpense.expense,
                                    style: AppTypography.small.copyWith(
                                      fontSize:
                                          12, // Même taille que weekly expenses
                                      fontWeight: isSelected || isToday
                                          ? FontWeight.bold
                                          : FontWeight.w600,
                                      color: isSelected
                                          ? AppColors.getDayColor(
                                              dayExpense.dayOfWeek,
                                            )
                                          : isToday
                                          ? AppColors.getDayColor(
                                              dayExpense.dayOfWeek,
                                            )
                                          : (isDark
                                                    ? AppColors
                                                          .textSecondaryOnDark
                                                    : AppColors.textSecondary)
                                                .withValues(alpha: 0.6),
                                    ),
                                    decimals: 0,
                                  ),
                                )
                              : const SizedBox.shrink(),
                        ),

                        SizedBox(
                          height: 3,
                        ), // Même espacement que weekly expenses
                        // Barre avec couleur spécifique au jour
                        Center(
                          child: Container(
                            width: 32, // Largeur fixe comme weekly expenses
                            height: height,
                            decoration: BoxDecoration(
                              color: hasExpense
                                  ? isSelected || isToday
                                        ? AppColors.getDayColor(
                                            dayExpense.dayOfWeek,
                                          )
                                        : (isDark
                                                  ? AppColors
                                                        .textSecondaryOnDark
                                                  : AppColors.textSecondary)
                                              .withValues(alpha: 0.35)
                                  : (isDark
                                            ? AppColors.textSecondaryOnDark
                                            : AppColors.textSecondary)
                                        .withValues(alpha: 0.18),
                              borderRadius: BorderRadius.circular(
                                16,
                              ), // Border radius fixe comme weekly expenses
                              border: isSelected || isToday
                                  ? Border.all(
                                      color: AppColors.getDayColor(
                                        dayExpense.dayOfWeek,
                                      ),
                                      width: isSelected
                                          ? 3.0
                                          : 2.0, // 2.0 pour today comme weekly expenses
                                    )
                                  : null,
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      (hasExpense
                                              ? isSelected || isToday
                                                    ? AppColors.getDayColor(
                                                        dayExpense.dayOfWeek,
                                                      )
                                                    : (isDark
                                                              ? AppColors
                                                                    .textSecondaryOnDark
                                                              : AppColors
                                                                    .textSecondary)
                                                          .withValues(
                                                            alpha: 0.35,
                                                          )
                                              : (isDark
                                                        ? AppColors
                                                              .textSecondaryOnDark
                                                        : AppColors
                                                              .textSecondary)
                                                    .withValues(alpha: 0.18))
                                          .withValues(alpha: 0.3),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                  spreadRadius: 0,
                                ),
                              ],
                            ),
                          ),
                        ),

                        SizedBox(
                          height: 3,
                        ), // Même espacement que weekly expenses
                        // Nom du jour/mois/année
                        Text(
                          _getPeriodLabel(
                            chartData.period,
                            dayExpense.date,
                            dayExpense.dayOfWeek,
                            l10n,
                          ),
                          style: AppTypography.small.copyWith(
                            fontSize: chartData.period == TimePeriod.year ? 10 : 12,
                            fontWeight: isSelected || isToday
                                ? FontWeight.bold
                                : FontWeight.normal,
                            color: isSelected
                                ? AppColors.getDayColor(dayExpense.dayOfWeek)
                                : isToday
                                ? AppColors.getDayColor(dayExpense.dayOfWeek)
                                : (isDark
                                          ? AppColors.textSecondaryOnDark
                                          : AppColors.textSecondary)
                                      .withValues(alpha: 0.6),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        );
      },
      loading: () => const SizedBox(height: 180),
      error: (error, stack) => const SizedBox(height: 180),
    );
  }

  /// Retourne le label approprié selon la période
  String _getPeriodLabel(
    TimePeriod period,
    DateTime date,
    int dayOfWeek,
    AppLocalizations l10n,
  ) {
    return switch (period) {
      TimePeriod.week => _getDayName(dayOfWeek, l10n),
      TimePeriod.month => _getMonthName(date.month, l10n),
      TimePeriod.year => date.year.toString(),
    };
  }
  
  /// Retourne le nom court du jour traduit
  String _getDayName(int dayOfWeek, AppLocalizations l10n) {
    switch (dayOfWeek) {
      case 1:
        return l10n.monday;
      case 2:
        return l10n.tuesday;
      case 3:
        return l10n.wednesday;
      case 4:
        return l10n.thursday;
      case 5:
        return l10n.friday;
      case 6:
        return l10n.saturday;
      case 7:
        return l10n.sunday;
      default:
        return '';
    }
  }
  
  /// Retourne le nom court du mois (3 lettres)
  String _getMonthName(int month, AppLocalizations l10n) {
    const monthNames = [
      'Jan', 'Fév', 'Mar', 'Avr', 'Mai', 'Juin',
      'Juil', 'Août', 'Sep', 'Oct', 'Nov', 'Déc'
    ];
    return monthNames[month - 1];
  }
}

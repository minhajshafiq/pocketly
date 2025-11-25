import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocketly/core/constants/app_colors.dart';
import 'package:pocketly/core/constants/app_dimensions.dart';
import 'package:pocketly/core/constants/app_typography.dart';
import 'package:pocketly/core/widgets/app_card.dart';
import 'package:pocketly/features/home/domain/entities/weekly_expense_entity.dart';
import 'package:pocketly/features/home/presentation/providers/home_providers.dart';
import 'package:pocketly/features/locale/locale.dart';
import 'package:pocketly/generated/l10n/app_localizations.dart';
import 'package:pocketly/features/currency/currency.dart';
import 'package:pocketly/features/transactions/transactions.dart';

class WeeklyExpensesWidget extends ConsumerWidget {
  const WeeklyExpensesWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Écouter le changement de locale pour rebuild automatique
    ref.watch(currentLocaleProvider);

    final weeklyExpenses = ref.watch(weeklyExpensesControllerProvider);
    final transactionState = ref.watch(transactionProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context)!;

    // Afficher l'état de chargement si initial ou loading
    if (transactionState is TransactionStateInitial || transactionState.isLoadingState) {
      return AppCard(
        padding: EdgeInsets.all(AppDimensions.paddingL),
        child: SizedBox(
          height: 150,
          child: Center(child: CircularProgressIndicator()),
        ),
      );
    }

    // Afficher l'erreur si présente
    if (transactionState.hasError) {
      return AppCard(
        padding: EdgeInsets.all(AppDimensions.paddingL),
        child: Center(
          child: Text(AppLocalizations.of(context)!.failedToLoadExpenses,
              style: TextStyle(color: AppColors.error)),
        ),
      );
    }

    // Afficher les dépenses
    return _buildExpensesContent(weeklyExpenses, isDark, l10n);
  }

  Widget _buildExpensesContent(WeeklyExpensesEntity weeklyExpenses, bool isDark, AppLocalizations l10n) {
        // Trouver le montant maximum
        double maxAmount = 1;
        for (final expense in weeklyExpenses.expenses) {
          if (expense.amount > maxAmount) {
            maxAmount = expense.amount;
          }
        }

        return AppCard(
          padding: EdgeInsets.all(AppDimensions.paddingM),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Titre + montant en colonne (label au-dessus, montant en gros en dessous)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.weeklyExpenses,
                    style: AppTypography.small.copyWith(
                      color: isDark
                          ? AppColors.textSecondaryOnDark
                          : AppColors.textSecondary,
                    ),
                  ),
                  SizedBox(height: AppDimensions.paddingXS),
                  Row(
                    children: [
                      Text(
                        '-',
                        style: AppTypography.title.copyWith(
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                      ),
                      CurrencyDisplayWidget(
                        amount: weeklyExpenses.totalWeekAmount,
                        style: AppTypography.title.copyWith(
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                        decimals: 0,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: AppDimensions.paddingM),
              SizedBox(
                height: 140, // Hauteur plus compacte, tout en évitant l'overflow
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: weeklyExpenses.expenses.map((expense) {
                    final isToday = _isToday(expense.date);
                    final hasExpense = expense.amount > 0;
                    // Always render a visible bar. If no expense, show a small
                    // subtle capsule while keeping today's bar highlighted.
                    final scaled = maxAmount > 0
                        ? (expense.amount / maxAmount * 85).clamp(8.0, 85.0)
                        : 8.0;
                    final height = hasExpense ? scaled : 6.0;

                    return Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: AppDimensions.paddingXS),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            // Prix au-dessus de la barre (seulement si > 0)
                            SizedBox(
                              height: 18, // Espace réservé pour le prix (plus compact)
                              child: hasExpense
                                  ? Center(
                                      child: CurrencyAmountText(
                                        amount: expense.amount,
                                        style: AppTypography.small.copyWith(
                                          color: isToday
                                              ? AppColors.getDayColor(expense.dayOfWeek)
                                              : (isDark
                                                      ? AppColors.textSecondaryOnDark
                                                      : AppColors.textSecondary)
                                                  .withValues(alpha: 0.6),
                                          fontWeight: isToday
                                              ? FontWeight.bold
                                              : FontWeight.w600,
                                          fontSize: 12,
                                        ),
                                        decimals: 0,
                                      ),
                                    )
                                  : const SizedBox.shrink(),
                            ),
                            SizedBox(height: 3),
                            // Barre
                            Center(
                              child: Container(
                                width: 32, // Largeur fixe pour la barre
                                height: height,
                                decoration: BoxDecoration(
                                  color: hasExpense
                                      ? isToday
                                          ? AppColors.getDayColor(expense.dayOfWeek)
                                          : (isDark
                                                  ? AppColors.textSecondaryOnDark
                                                  : AppColors.textSecondary)
                                              .withValues(alpha: 0.35)
                                      : (isDark
                                              ? AppColors.textSecondaryOnDark
                                              : AppColors.textSecondary)
                                          .withValues(alpha: 0.18),
                                  borderRadius: BorderRadius.circular(16),
                                  border: isToday
                                      ? Border.all(
                                          color: AppColors.getDayColor(expense.dayOfWeek),
                                          width: 2,
                                        )
                                      : null,
                                  boxShadow: [
                                    BoxShadow(
                                      color: (hasExpense
                                              ? isToday
                                                  ? AppColors.getDayColor(expense.dayOfWeek)
                                                  : (isDark
                                                          ? AppColors.textSecondaryOnDark
                                                          : AppColors.textSecondary)
                                                      .withValues(alpha: 0.35)
                                              : (isDark
                                                      ? AppColors.textSecondaryOnDark
                                                      : AppColors.textSecondary)
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
                            SizedBox(height: 3),
                            // Label du jour
                            Text(
                              _getDayName(expense.dayOfWeek, l10n),
                              style: AppTypography.small.copyWith(
                                color: isToday
                                    ? AppColors.getDayColor(expense.dayOfWeek)
                                    : (isDark
                                        ? AppColors.textSecondaryOnDark
                                            : AppColors.textSecondary)
                                        .withValues(alpha: 0.6),
                                fontWeight: isToday
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
      ),
    );
  }

  /// Vérifie si une date est aujourd'hui
  bool _isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  /// Retourne le nom court du jour
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
}

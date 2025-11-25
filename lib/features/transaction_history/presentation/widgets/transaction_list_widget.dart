import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:pocketly/core/constants/app_colors.dart';
import 'package:pocketly/core/constants/app_dimensions.dart';
import 'package:pocketly/core/constants/app_typography.dart';
import 'package:pocketly/features/transaction_history/domain/entities/transaction_period_entity.dart';
import 'package:pocketly/features/transaction_history/presentation/providers/transaction_history_providers.dart';
import 'package:pocketly/features/transaction_history/presentation/widgets/slidable_transaction_card.dart';
import 'package:pocketly/generated/l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:pocketly/features/transactions/transactions.dart';

/// Widget pour afficher la liste des transactions filtrées
class TransactionListWidget extends ConsumerWidget {
  const TransactionListWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedPeriod = ref.watch(periodFilterControllerProvider);
    final calendarState = ref.watch(calendarControllerProvider);
    final transactionState = ref.watch(transactionProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Utiliser les transactions filtrées par période ou par jour sélectionné
    final transactions = calendarState.selectedDate != null
        ? ref.watch(selectedDayTransactionsProvider)
        : ref.watch(filteredTransactionsProvider);

    // Titre adaptatif selon la période - utiliser les traductions
    final l10n = AppLocalizations.of(context)!;
    final title = _getPeriodTitle(context, selectedPeriod, l10n);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Titre adaptatif selon la période ou le jour sélectionné
        _buildTitle(context, title, isDark),

        SizedBox(height: AppDimensions.paddingM),

        // Afficher l'état de chargement si initial ou loading
        if (transactionState is TransactionStateInitial || transactionState.isLoadingState)
          _buildLoading()
        // Afficher l'erreur si présente
        else if (transactionState.hasError)
          Center(
            child: Padding(
              padding: EdgeInsets.all(AppDimensions.paddingL),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.error_outline, size: 48, color: AppColors.error),
                  SizedBox(height: AppDimensions.paddingM),
                  Text(
                    'Erreur de chargement',
                    style: AppTypography.body.copyWith(
                      color: AppColors.error,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: AppDimensions.paddingS),
                  Text(
                    transactionState.errorMessage ?? 'Erreur inconnue',
                    style: AppTypography.caption,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: AppDimensions.paddingM),
                  TextButton(
                    onPressed: () {
                      ref.read(transactionProvider.notifier).loadTransactions();
                    },
                    child: const Text('Réessayer'),
                  ),
                ],
              ),
            ),
          )
        // Afficher les transactions ou l'état vide
        else if (transactions.isEmpty)
          _buildEmptyState(isDark)
        else
            // Grouper par jour
          Builder(
            builder: (context) {
            final transactionsByDay = _groupByDay(transactions);

            return SlidableAutoCloseBehavior(
              child: Column(
                children: transactionsByDay.entries.map((entry) {
                final date = entry.key;
                final dayTransactions = entry.value;
                final index = transactionsByDay.keys.toList().indexOf(date);

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // En-tête du jour
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: AppDimensions.paddingS,
                      ),
                      child: Text(
                        _formatDayHeader(context, date),
                        style: AppTypography.small.copyWith(
                          color: isDark
                              ? AppColors.textSecondaryOnDark
                              : AppColors.textSecondary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                        .animate()
                        .fadeIn(delay: (index * 50).ms, duration: 300.ms)
                        .slideX(
                          begin: -0.2,
                          end: 0,
                          duration: 300.ms,
                          delay: (index * 50).ms,
                        ),

                    // Transactions du jour
                    ...dayTransactions.asMap().entries.map((txEntry) {
                      final txIndex = txEntry.key;
                      final transaction = txEntry.value;
                      final globalIndex = index * 10 + txIndex;

                      return Padding(
                        padding: EdgeInsets.only(
                          bottom: AppDimensions.paddingS,
                        ),
                        child: SlidableTransactionCard(
                          transaction: transaction,
                          onTap: () {
                            // TODO: Naviguer vers détails de transaction si implémenté
                          },
                        )
                            .animate()
                            .fadeIn(
                              delay: (globalIndex * 50).ms,
                              duration: 300.ms,
                            )
                            .slideY(
                              begin: 0.2,
                              end: 0,
                              duration: 300.ms,
                              delay: (globalIndex * 50).ms,
                            ),
                      );
                    }),

                    SizedBox(height: AppDimensions.paddingM),
                  ],
                );
              }).toList(),
              ),
            );
          },
        ),
      ],
    );
  }

  /// Construit le titre de la section
  Widget _buildTitle(BuildContext context, String title, bool isDark) {
    return Text(
      title,
      style: AppTypography.heading.copyWith(
        color: isDark ? AppColors.textOnDark : AppColors.textPrimary,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  /// Construit l'état vide
  Widget _buildEmptyState(bool isDark) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(AppDimensions.paddingXL),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.inbox_outlined,
              size: 64,
              color: isDark
                  ? AppColors.textSecondaryOnDark
                  : AppColors.textSecondary,
            ),
            SizedBox(height: AppDimensions.paddingM),
            Text(
              'Aucune transaction',
              style: AppTypography.body.copyWith(
                color: isDark
                    ? AppColors.textSecondaryOnDark
                    : AppColors.textSecondary,
              ),
            ),
            SizedBox(height: AppDimensions.paddingS),
            Text(
              'Commencez à enregistrer vos transactions',
              style: AppTypography.caption.copyWith(
                color: isDark
                    ? AppColors.textSecondaryOnDark.withValues(alpha: 0.7)
                    : AppColors.textSecondary.withValues(alpha: 0.7),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 500.ms);
  }

  /// Construit l'indicateur de chargement
  Widget _buildLoading() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(AppDimensions.paddingXL),
        child: const CircularProgressIndicator(),
      ),
    );
  }

  /// Groupe les transactions par jour
  Map<DateTime, List<TransactionEntity>> _groupByDay(
    List<TransactionEntity> transactions,
  ) {
    final Map<DateTime, List<TransactionEntity>> grouped = {};

    for (final transaction in transactions) {
      final date = DateTime(
        transaction.date.year,
        transaction.date.month,
        transaction.date.day,
      );

      if (!grouped.containsKey(date)) {
        grouped[date] = [];
      }
      grouped[date]!.add(transaction);
    }

    // Trier les jours par date décroissante
    final sortedEntries = grouped.entries.toList()
      ..sort((a, b) => b.key.compareTo(a.key));

    return Map.fromEntries(sortedEntries);
  }

  /// Formate l'en-tête du jour
  String _formatDayHeader(BuildContext context, DateTime date) {
    final l10n = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context);
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));

    if (date == today) {
      return l10n.today;
    } else if (date == yesterday) {
      return l10n.yesterday;
    } else {
      final formatted = DateFormat('EEEE dd MMMM yyyy', locale.toString()).format(date);
      // Capitaliser le mois en français
      if (locale.languageCode == 'fr' && formatted.isNotEmpty) {
        final parts = formatted.split(' ');
        if (parts.length >= 4) {
          // Format: "lundi 15 novembre 2024" - le mois est à l'index 2
          parts[2] = parts[2][0].toUpperCase() + parts[2].substring(1);
          return parts.join(' ');
        }
      }
      return formatted;
    }
  }

  /// Obtient le titre traduit selon la période
  String _getPeriodTitle(
    BuildContext context,
    TransactionPeriodEntity period,
    AppLocalizations l10n,
  ) {
    switch (period.type) {
      case PeriodType.today:
        return l10n.today;
      case PeriodType.week:
        return l10n.thisWeek;
      case PeriodType.month:
        return l10n.thisMonth;
      case PeriodType.year:
        return l10n.thisYear;
      case PeriodType.custom:
        // Pour les périodes personnalisées, utiliser le label s'il existe
        // ou formater les dates
        if (period.label != null && period.label!.isNotEmpty) {
          return period.label!;
        }
        final locale = Localizations.localeOf(context);
        final startDate = DateFormat('d MMM', locale.toString()).format(period.startDate);
        final endDate = DateFormat('d MMM yyyy', locale.toString()).format(period.endDate);
        return '$startDate - $endDate';
    }
  }
}

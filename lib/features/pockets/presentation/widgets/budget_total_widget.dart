import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocketly/core/core.dart';
import 'package:pocketly/features/currency/currency.dart';
import 'package:pocketly/features/pockets/domain/entities/pocket_entity.dart';
import 'package:pocketly/features/pockets/presentation/providers/pocket_providers.dart';
import 'package:pocketly/generated/l10n/app_localizations.dart';
import 'package:pocketly/features/transactions/transactions.dart';

/// Widget affichant le budget total, dépensé et restant
///
/// Calcule le budget total à partir de tous les revenus de l'utilisateur
/// et affiche les montants dépensés et restants basés sur les pockets.
class BudgetTotalWidget extends ConsumerWidget {
  const BudgetTotalWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // S'assurer que les transactions sont chargées
    _ensureTransactionsLoaded(ref);

    // Le budget total = somme de TOUTES les transactions de type income
    final totalIncome = ref.watch(totalIncomeProvider);
    final pocketsAsync = ref.watch(userPocketsProvider);

    return pocketsAsync.when(
      data: (pockets) => _buildContent(
        context: context,
        l10n: l10n,
        isDark: isDark,
        totalIncome: totalIncome,
        pockets: pockets,
      ),
      loading: () => _buildLoadingState(),
      error: (error, stack) => _buildErrorState(error),
    );
  }

  /// S'assure que les transactions sont chargées
  void _ensureTransactionsLoaded(WidgetRef ref) {
    final transactionState = ref.watch(transactionProvider);
    if (transactionState.allTransactions.isEmpty && !transactionState.isLoadingState) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(transactionProvider.notifier).loadTransactions();
      });
    }
  }

  /// Construit le contenu principal du widget
  Widget _buildContent({
    required BuildContext context,
    required AppLocalizations l10n,
    required bool isDark,
    required double totalIncome,
    required List<PocketEntity> pockets,
  }) {
    // Calculer le total dépensé (needs + wants uniquement)
    final totalSpent = pockets
        .where((p) => p.isExpensePocket)
        .fold(0.0, (sum, p) => sum + p.spent);
    final remaining = totalIncome - totalSpent;

    return AppCard(
      padding: EdgeInsets.all(AppDimensions.paddingM),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHeader(context, l10n, isDark),
          SizedBox(height: AppDimensions.paddingXS),
          _buildTotalAmount(totalIncome),
          SizedBox(height: AppDimensions.paddingXS),
          _buildSummaryRow(l10n, isDark, totalSpent, remaining),
        ],
      ),
    );
  }

  /// Construit le header avec titre
  Widget _buildHeader(
    BuildContext context,
    AppLocalizations l10n,
    bool isDark,
  ) {
    return Text(
      l10n.budgetTotal,
      style: AppTypography.small.copyWith(
        fontWeight: FontWeight.w600,
        color: isDark
            ? AppColors.textSecondaryOnDark
            : AppColors.textSecondary,
      ),
    );
  }

  /// Construit l'affichage du montant total
  Widget _buildTotalAmount(double totalIncome) {
    return CurrencyAmountText(
      amount: totalIncome,
      style: AppTypography.display.copyWith(
        fontWeight: FontWeight.w700,
      ),
      decimals: 0,
    );
  }

  /// Construit la ligne de résumé (dépensé et restant)
  Widget _buildSummaryRow(
    AppLocalizations l10n,
    bool isDark,
    double totalSpent,
    double remaining,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildSpentSection(l10n, isDark, totalSpent),
        _buildRemainingSection(l10n, remaining),
      ],
    );
  }

  /// Construit la section "Dépensé"
  Widget _buildSpentSection(
    AppLocalizations l10n,
    bool isDark,
    double totalSpent,
  ) {
    return Flexible(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '${l10n.totalSpent}: ',
            style: AppTypography.small.copyWith(
              color: isDark
                  ? AppColors.textSecondaryOnDark
                  : AppColors.textSecondary,
            ),
          ),
          CurrencyAmountText(
            amount: totalSpent,
            style: AppTypography.small.copyWith(
              fontWeight: FontWeight.w600,
            ),
            decimals: 0,
          ),
        ],
      ),
    );
  }

  /// Construit la section "Restant"
  Widget _buildRemainingSection(
    AppLocalizations l10n,
    double remaining,
  ) {
    return Flexible(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '${l10n.remaining}: ',
            style: AppTypography.small.copyWith(
              color: AppColors.success,
              fontWeight: FontWeight.w600,
            ),
          ),
          CurrencyAmountText(
            amount: remaining,
            style: AppTypography.small.copyWith(
              color: AppColors.success,
              fontWeight: FontWeight.w600,
            ),
            decimals: 0,
          ),
        ],
      ),
    );
  }

  /// Construit l'état de chargement
  Widget _buildLoadingState() {
    return AppCard(
      padding: EdgeInsets.all(AppDimensions.paddingM),
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  /// Construit l'état d'erreur
  Widget _buildErrorState(Object error) {
    return AppCard(
      padding: EdgeInsets.all(AppDimensions.paddingM),
      child: Center(
        child: Text(
          'Erreur: $error',
          style: AppTypography.body.copyWith(color: AppColors.error),
        ),
      ),
    );
  }
}


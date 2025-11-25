import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocketly/core/constants/app_dimensions.dart';
import 'package:pocketly/core/widgets/platform_safe_area.dart';
import 'package:pocketly/features/home/presentation/widgets/action_buttons_widget.dart';
import 'package:pocketly/features/home/presentation/widgets/balance_card.dart';
import 'package:pocketly/features/home/presentation/widgets/recent_transactions_widget.dart';
import 'package:pocketly/features/home/presentation/widgets/user_header_widget.dart';
import 'package:pocketly/features/home/presentation/widgets/weekly_expenses_widget.dart';
import 'package:pocketly/features/locale/locale.dart';
import 'package:pocketly/features/transactions/transactions.dart';

/// Écran principal de la page d'accueil.
///
/// Affiche le résumé du compte, les dépenses hebdomadaires,
/// les boutons d'action et les transactions récentes.
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Écouter le changement de locale pour rebuild automatique
    ref.watch(currentLocaleProvider);

    return Scaffold(
      body: PlatformSafeArea(
        top: true,
        bottom: false, // La bottom nav gère déjà le safe area
        padding: EdgeInsets.only(top: AppDimensions.paddingS),
        child: RefreshIndicator(
          onRefresh: () => _refreshAll(ref),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header avec utilisateur
                const UserHeaderWidget(),

                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppDimensions.paddingM,
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: AppDimensions.paddingM),
                      // Balance Card avec variation 24h
                      const BalanceCard(),

                      SizedBox(height: AppDimensions.paddingL),

                      // Dépenses hebdomadaires
                      const WeeklyExpensesWidget(),

                      SizedBox(height: AppDimensions.paddingL),

                      // Boutons d'action (4 boutons)
                      const ActionButtonsWidget(),

                      SizedBox(height: AppDimensions.paddingL),

                      // Transactions récentes
                      const RecentTransactionsWidget(),

                      SizedBox(height: AppDimensions.paddingL),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Rafraîchit toutes les données
  Future<void> _refreshAll(WidgetRef ref) async {
    await ref.read(transactionProvider.notifier).loadTransactions();
    // Les providers homeSummaryControllerProvider et weeklyExpensesControllerProvider
    // se mettront à jour automatiquement car ils watch transactionProvider
  }
}

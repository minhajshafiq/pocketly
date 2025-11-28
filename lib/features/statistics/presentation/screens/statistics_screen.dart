import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocketly/core/constants/app_colors.dart';
import 'package:pocketly/core/constants/app_dimensions.dart';
import 'package:pocketly/core/widgets/platform_safe_area.dart';
import 'package:pocketly/features/statistics/presentation/widgets/premium_locked_widget.dart';
import 'package:pocketly/features/statistics/presentation/widgets/statistics_header_widget.dart';
import 'package:pocketly/features/statistics/presentation/widgets/statistics_main_card.dart';
import 'package:pocketly/features/statistics/presentation/widgets/time_navigation_widget.dart';
import 'package:pocketly/features/statistics/presentation/widgets/transactions_section.dart';
import 'package:pocketly/features/locale/locale.dart';
import 'package:pocketly/features/transactions/transactions.dart';
import 'package:pocketly/features/user/user.dart';

/// Écran principal des statistiques
class StatisticsScreen extends ConsumerStatefulWidget {
  const StatisticsScreen({super.key});

  @override
  ConsumerState<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends ConsumerState<StatisticsScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    // Écouter le changement de locale pour rebuild automatique
    ref.watch(currentLocaleProvider);

    // Vérifier l'accès premium
    final canAccessPremium = ref.watch(canAccessPremiumProvider);

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.background,
      body: PlatformSafeArea(
        top: true,
        bottom: null, // Auto: true sur Android, false sur iOS
        padding: EdgeInsets.only(top: AppDimensions.paddingS),
        child: Stack(
          children: [
            _buildPremiumContent(),
            if (!canAccessPremium) PremiumLockedOverlay(),
          ],
        ),
      ),
    );
  }

  /// Construit le contenu pour les utilisateurs premium
  Widget _buildPremiumContent() {
    return Stack(
      children: [
        // Contenu scrollable
        RefreshIndicator(
          onRefresh: _refreshAll,
          child: SingleChildScrollView(
            controller: _scrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.only(
              bottom: Platform.isAndroid
                  ? AppDimensions.paddingXL *
                        2 // Plus d'espace pour les boutons Android
                  : AppDimensions.paddingXL,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Espace pour le header sticky
                const SizedBox(height: 80),

                SizedBox(height: AppDimensions.paddingL),

                // Carte principale avec graphique
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppDimensions.paddingM,
                  ),
                  child: const StatisticsMainCard(),
                ),

                SizedBox(height: AppDimensions.paddingL),

                // Navigation temporelle
                const TimeNavigationWidget(),

                SizedBox(height: AppDimensions.paddingL),

                // Section transactions
                const TransactionsSection(),

                SizedBox(height: AppDimensions.paddingXL),
              ],
            ),
          ),
        ),

        // Header sticky animé
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: StatisticsHeaderWidget(scrollController: _scrollController),
        ),
      ],
    );
  }

  /// Rafraîchit toutes les données
  Future<void> _refreshAll() async {
    await ref.read(transactionProvider.notifier).loadTransactions();
    // Les providers statisticsSummaryControllerProvider, chartDataControllerProvider
    // et periodTransactionsControllerProvider se mettront à jour automatiquement
    // car ils watch transactionProvider
  }
}

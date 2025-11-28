import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocketly/core/constants/app_colors.dart';
import 'package:pocketly/core/constants/app_dimensions.dart';
import 'package:pocketly/core/widgets/animated_page_header.dart';
import 'package:pocketly/core/widgets/platform_safe_area.dart';
import 'package:pocketly/features/transaction_history/presentation/widgets/interactive_calendar.dart';
import 'package:pocketly/features/transaction_history/presentation/widgets/period_filter_buttons.dart';
import 'package:pocketly/features/transaction_history/presentation/widgets/transaction_list_widget.dart';
import 'package:pocketly/generated/l10n/app_localizations.dart';
import 'package:pocketly/features/locale/locale.dart';

/// Écran principal pour l'historique des transactions
class TransactionHistoryScreen extends ConsumerStatefulWidget {
  const TransactionHistoryScreen({super.key});

  @override
  ConsumerState<TransactionHistoryScreen> createState() =>
      _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState
    extends ConsumerState<TransactionHistoryScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Écouter le changement de locale pour rebuild automatique
    ref.watch(currentLocaleProvider);
    final l10n = AppLocalizations.of(context)!;

    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.background,
      body: PlatformSafeArea(
        top: true,
        bottom: false,
        padding: EdgeInsets.only(top: AppDimensions.paddingS),
        child: Stack(
          children: [
            // Contenu scrollable
            SingleChildScrollView(
              controller: _scrollController,
              padding: EdgeInsets.only(
                top: 80, // Espace pour le header
                left: AppDimensions.paddingM,
                right: AppDimensions.paddingM,
                bottom: AppDimensions.paddingM,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Calendrier interactif avec navigation intégrée
                  const InteractiveCalendar(),

                  SizedBox(height: AppDimensions.paddingL),

                  // Boutons de filtrage rapide
                  const PeriodFilterButtons(),

                  SizedBox(height: AppDimensions.paddingL),

                  // Liste des transactions
                  const TransactionListWidget(),
                ],
              ),
            ),

            // Header sticky animé
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: AnimatedPageHeader(
                title: l10n.transactionHistory,
                scrollController: _scrollController,
                showBackButton: false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocketly/core/core.dart';
import 'package:pocketly/core/widgets/animated_page_header.dart';
import 'package:pocketly/features/pockets/domain/entities/pocket_entity.dart';
import 'package:pocketly/features/pockets/presentation/providers/pocket_providers.dart';
import 'package:pocketly/features/pockets/presentation/screens/edit_pocket_screen.dart';
import 'package:pocketly/features/pockets/presentation/screens/assign_transactions_screen.dart';
import 'package:pocketly/features/pockets/presentation/widgets/savings_operation_bottom_sheet.dart';
import 'package:pocketly/features/pockets/presentation/widgets/pocket_statistics_widget.dart';
import 'package:pocketly/features/currency/currency.dart';
import 'package:pocketly/generated/l10n/app_localizations.dart';
import 'package:pocketly/features/notifications/notifications.dart';
import 'package:pocketly/features/transactions/transactions.dart';

/// Écran de détails d'un pocket
///
/// Affiche toutes les informations détaillées d'un pocket :
/// - Informations générales (nom, catégorie, icône)
/// - Budget et dépenses (pour needs/wants)
/// - Épargne et objectifs (pour savings)
/// - Statistiques et recommandations
class PocketDetailsScreen extends ConsumerStatefulWidget {
  final String pocketId;

  const PocketDetailsScreen({
    super.key,
    required this.pocketId,
  });

  @override
  ConsumerState<PocketDetailsScreen> createState() => _PocketDetailsScreenState();
}

class _PocketDetailsScreenState extends ConsumerState<PocketDetailsScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pocketAsync = ref.watch(pocketByIdProvider(widget.pocketId));
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: PlatformSafeArea(
        top: true,
        bottom: false,
        padding: EdgeInsets.only(top: AppDimensions.paddingS),
        child: Stack(
          children: [
            // Contenu scrollable
            pocketAsync.when(
              data: (pocket) {
                if (pocket == null) {
                  return SingleChildScrollView(
                    controller: _scrollController,
                    padding: EdgeInsets.only(top: AppDimensions.appBarHeight + AppDimensions.paddingL),
                    child: _buildNotFound(context),
                  );
                }

                return _buildContent(context, pocket, isDark);
              },
              loading: () => SingleChildScrollView(
                controller: _scrollController,
                padding: EdgeInsets.only(top: AppDimensions.appBarHeight + AppDimensions.paddingL),
                child: const Center(child: CircularProgressIndicator()),
              ),
              error: (error, stack) => SingleChildScrollView(
                controller: _scrollController,
                padding: EdgeInsets.only(top: AppDimensions.appBarHeight + AppDimensions.paddingL),
                child: ErrorDisplay(
                  error: error is AppError
                      ? error
                      : UnknownError(
                          technicalMessage: error.toString(),
                          stackTrace: stack,
                        ),
                ),
              ),
            ),

            // Header sticky animé
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: AnimatedPageHeader(
                title: AppLocalizations.of(context)!.pocketDetails,
                scrollController: _scrollController,
                showBackButton: true,
                actionButton: _buildEditButton(pocket: pocketAsync.value, isDark: isDark),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: pocketAsync.maybeWhen(
        data: (pocket) {
          if (pocket == null) return null;

          final l10n = AppLocalizations.of(context)!;
          final pocketColor = Color(int.parse(pocket.color.replaceFirst('#', '0xFF')));

          // Fonction différente selon le type de pocket
          Future<void> onPressed() async {
            if (pocket.isSavingsPocket) {
              // Pour les savings pockets : ouvrir le bottom sheet d'opération
              final result = await SavingsOperationBottomSheet.show(context, pocket);

              // Rafraîchir si une opération a été effectuée
              if (result == true && context.mounted) {
                ref.invalidate(pocketByIdProvider(pocket.id!));
                ref.invalidate(userPocketsProvider);
              }
            } else {
              // Pour les expense pockets : ouvrir l'écran d'assignation de transactions
              final result = await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => AssignTransactionsScreen(
                    pocketId: pocket.id!,
                    pocketName: pocket.getName(l10n),
                  ),
                ),
              );

              // Rafraîchir si des transactions ont été assignées
              if (result == true && context.mounted) {
                ref.invalidate(transactionsByPocketProvider(pocket.id!));
                ref.invalidate(pocketByIdProvider(pocket.id!));
                ref.invalidate(userPocketsProvider);
              }
            }
          }

          // Label différent selon le type de pocket
          final String semanticLabel = pocket.isSavingsPocket
              ? 'Gérer l\'épargne'
              : AppLocalizations.of(context)!.assignTransactions;

          if (Platform.isIOS) {
            return Semantics(
              label: semanticLabel,
              button: true,
              child: CupertinoButton(
                padding: EdgeInsets.all(AppDimensions.paddingM),
                borderRadius: BorderRadius.circular(AppDimensions.radiusXL),
                color: pocketColor,
                onPressed: onPressed,
                child: const Icon(CupertinoIcons.add, color: AppColors.textOnDark),
              ),
            );
          }

          return Semantics(
            label: semanticLabel,
            button: true,
            child: FloatingActionButton(
              onPressed: onPressed,
              backgroundColor: pocketColor,
              elevation: AppDimensions.elevationButton,
              shape: const CircleBorder(),
              child: Icon(AppIcons.add, color: AppColors.textOnDark),
            ),
          );
        },
        orElse: () => null,
      ),
    );
  }

  Widget _buildEditButton({required PocketEntity? pocket, required bool isDark}) {
    if (pocket == null) {
      return SizedBox.shrink();
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 100),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.surface,
        shape: BoxShape.circle,
        border: Border.all(
          color: isDark
              ? AppColors.textSecondaryOnDark.withValues(alpha: 0.3)
              : AppColors.textSecondary.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: IconButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => EditPocketScreen(pocketId: widget.pocketId),
            ),
          );
        },
        icon: Icon(
          AppIcons.edit,
          color: AppColors.primary,
        ),
        padding: EdgeInsets.zero,
      ),
    );
  }

  Widget _buildNotFound(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            AppIcons.close,
            size: AppDimensions.iconXXL,
            color: isDark ? AppColors.textSecondaryOnDark : AppColors.textSecondary,
          ),
          SizedBox(height: AppDimensions.paddingM),
          Text(
            AppLocalizations.of(context)!.pocketNotFound,
            style: AppTypography.title,
          ),
          SizedBox(height: AppDimensions.paddingS),
          Text(
            AppLocalizations.of(context)!.pocketNotFoundMessage,
            style: AppTypography.body.copyWith(
              color: isDark ? AppColors.textSecondaryOnDark : AppColors.textSecondary,
            ),
          ),
          SizedBox(height: AppDimensions.paddingL),
          AppButton(
            text: AppLocalizations.of(context)!.back,
            onPressed: () => Navigator.of(context).pop(),
            style: AppButtonStyle.outline,
          ),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context, PocketEntity pocket, bool isDark) {
    final l10n = AppLocalizations.of(context)!;
    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(pocketByIdProvider(widget.pocketId));
        await ref.read(pocketByIdProvider(widget.pocketId).future);
      },
      child: SingleChildScrollView(
        controller: _scrollController,
        padding: EdgeInsets.only(
          top: AppDimensions.appBarHeight + AppDimensions.paddingL + AppDimensions.paddingM, // Header + padding
          left: AppDimensions.paddingM,
          right: AppDimensions.paddingM,
          bottom: AppDimensions.paddingM,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppCard(
              padding: EdgeInsets.all(AppDimensions.paddingM),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(context, pocket, l10n),
                  SizedBox(height: AppDimensions.paddingM),
                  _buildStatusBadges(context, pocket),
                ],
              ),
            ),
            SizedBox(height: AppDimensions.paddingL),

            // Section Budget ou Épargne selon la catégorie (sans header dupliqué)
            if (pocket.category == PocketCategory.savings)
              _buildSavingsSection(context, ref, pocket, l10n, showHeader: false)
            else
              _buildBudgetSection(context, ref, pocket, l10n, showHeader: false),

            // Section Statistiques (uniquement pour needs/wants, pas pour savings)
            if (pocket.isExpensePocket) ...[
              SizedBox(height: AppDimensions.paddingL),
              PocketStatisticsWidget(pocketId: pocket.id!),
            ],

            // Section Transactions (uniquement pour needs/wants, pas pour savings)
            if (pocket.isExpensePocket) ...[
              SizedBox(height: AppDimensions.paddingL),
              _buildTransactionsSection(context, ref, pocket),
            ],

            // Espace pour le FAB (pour tous les types de pockets)
            SizedBox(height: AppDimensions.paddingXXL * 2),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, PocketEntity pocket, AppLocalizations l10n) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final color = Color(int.parse(pocket.color.replaceFirst('#', '0xFF')));

    return Row(
      children: [
        // Icône
        Container(
          width: AppDimensions.iconXL,
          height: AppDimensions.iconXL,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(AppDimensions.radiusM),
          ),
          child: Icon(
            _getIconData(pocket.icon),
            color: color,
            size: AppDimensions.iconM,
          ),
        ),
        SizedBox(width: AppDimensions.paddingM),

        // Nom et catégorie
        Expanded(
          child: Stack(
            children: [
              Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                pocket.getName(l10n),
                style: AppTypography.heading.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: AppDimensions.paddingXS),
              Row(
                children: [
                  Icon(
                    _getCategoryIcon(pocket.category),
                    size: AppDimensions.iconS,
                    color: color,
                  ),
                  SizedBox(width: AppDimensions.paddingXS),
                  Text(
                    _getCategoryName(pocket.category, l10n),
                    style: AppTypography.label.copyWith(
                      color: color,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    ' (${pocket.category.recommendedPercentage}%)',
                    style: AppTypography.caption.copyWith(
                      color: isDark ? AppColors.textSecondaryOnDark : AppColors.textSecondary,
                    ),
                  ),
                ],
                  ),
                ],
              ),
              // Boutons d'action centrés verticalement
              Positioned(
                right: 0,
                top: 0,
                bottom: 0,
                child: Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildActionButton(
                        context: context,
                        icon: pocket.isActive ? AppIcons.passwordHidden : AppIcons.passwordVisible,
                        onTap: () => _handleToggleActive(context, ref, pocket, l10n),
                        isDark: isDark,
                      ),
                      SizedBox(width: AppDimensions.paddingXS),
                      _buildActionButton(
                        context: context,
                        icon: AppIcons.info,
                        onTap: () => _showInfoModal(context, pocket, l10n),
                        isDark: isDark,
                      ),
                      SizedBox(width: AppDimensions.paddingXS),
                      _buildActionButton(
                        context: context,
                        icon: AppIcons.delete,
                        onTap: () => _showDeleteDialog(context, ref, pocket, l10n),
                        isDark: isDark,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required BuildContext context,
    required IconData icon,
    required VoidCallback onTap,
    required bool isDark,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 100),
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.surface,
        shape: BoxShape.circle,
        border: Border.all(
          color: isDark
              ? AppColors.textSecondaryOnDark.withValues(alpha: 0.3)
              : AppColors.textSecondary.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            HapticFeedback.lightImpact();
            onTap();
          },
          borderRadius: BorderRadius.circular(16),
          child: Center(
            child: Icon(
              icon,
              color: AppColors.primary,
              size: AppDimensions.iconS + 2,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatusBadges(BuildContext context, PocketEntity pocket) {
    final badges = <Widget>[];

    final l10n = AppLocalizations.of(context)!;

    // Badge actif/inactif
    badges.add(_buildBadge(
      icon: pocket.isActive ? AppIcons.success : AppIcons.error,
      label: pocket.isActive ? l10n.active : l10n.inactive,
      color: pocket.isActive ? AppColors.success : AppColors.grey500,
    ));

    // Badge par défaut
    if (pocket.isDefault) {
      badges.add(_buildBadge(
        icon: AppIcons.premium,
        label: l10n.defaultLabel,
        color: AppColors.warning,
      ));
    }

    // Badge budget dépassé
    if (pocket.category != PocketCategory.savings && pocket.isBudgetExceeded) {
      badges.add(_buildBadge(
        icon: AppIcons.warning,
        label: l10n.badgeBudgetExceeded,
        color: AppColors.error,
      ));
    }

    // Badge objectif atteint
    if (pocket.category == PocketCategory.savings &&
        pocket.savingsGoalType != SavingsGoalType.none &&
        pocket.savedAmount >= (pocket.targetAmount ?? 0)) {
      badges.add(_buildBadge(
        icon: AppIcons.premium,
        label: l10n.badgeGoalReached,
        color: AppColors.success,
      ));
    }

    if (badges.isEmpty) {
      return const SizedBox.shrink();
    }

    return Wrap(
      spacing: AppDimensions.paddingS,
      runSpacing: AppDimensions.paddingS,
      children: badges,
    );
  }

  Widget _buildBadge({
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: AppDimensions.paddingS, vertical: AppDimensions.paddingXS),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppDimensions.radiusL + AppDimensions.radiusXS),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: AppDimensions.iconS, color: color),
          SizedBox(width: AppDimensions.paddingXS + 2),
          Text(
            label,
            style: AppTypography.caption.copyWith(
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBudgetSection(
    BuildContext context,
    WidgetRef ref,
    PocketEntity pocket,
    AppLocalizations l10n, {
    bool showHeader = true,
  }) {
    final usagePercent = pocket.budgetUsagePercentage;
    final remaining = pocket.remainingBudget;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final pocketColor = Color(int.parse(pocket.color.replaceFirst('#', '0xFF')));
    final accentColor = pocketColor.withValues(alpha: 0.8);

    return AppCard(
        padding: EdgeInsets.all(AppDimensions.paddingM),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            // Header avec titre "Budget"
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
                    AppIcons.wallet,
                    color: AppColors.secondaryDark,
                    size: AppDimensions.iconS + 2,
                  ),
                  ),
                  SizedBox(width: AppDimensions.paddingM),
                Text(
                  'Budget',
                  style: AppTypography.title.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  ),
                ],
              ),
            SizedBox(height: AppDimensions.paddingM),
            
            // Section du haut : 3 colonnes (Budget, Spent, Remaining)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Budget
                Expanded(
                  child: _buildBudgetColumn(
                    context: context,
                    icon: AppIcons.wallet,
                    iconColor: AppColors.infoLight,
                    label: l10n.budget,
                    amount: pocket.budget,
                  ),
                ),
                
                SizedBox(width: AppDimensions.paddingM),

                // Spent
                Expanded(
                  child: _buildBudgetColumn(
                    context: context,
                    icon: AppIcons.expense,
                    iconColor: AppColors.errorLight,
                    label: l10n.spent,
                    amount: pocket.spent,
                  ),
                ),
                
                SizedBox(width: AppDimensions.paddingM),
                
                // Remaining
                Expanded(
                  child: _buildBudgetColumn(
                    context: context,
                    icon: AppIcons.savings,
                    iconColor: AppColors.successLight,
                    label: l10n.remaining,
                    amount: remaining,
                  ),
                ),
              ],
            ),
            
            SizedBox(height: AppDimensions.paddingM),

            // Section du bas : Progression
            Container(
              padding: EdgeInsets.all(AppDimensions.paddingM),
              decoration: BoxDecoration(
                color: isDark
                    ? AppColors.surfaceDark.withValues(alpha: 0.5)
                    : AppColors.surface.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(AppDimensions.radiusM),
              ),
              child: Column(
                children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                  l10n.progress,
                  style: AppTypography.small.copyWith(
                    fontWeight: FontWeight.w600,
                    color: isDark ? AppColors.textOnDark : AppColors.textPrimary,
                      ),
                    ),
                    Text(
                  '${usagePercent.toStringAsFixed(0)}%',
                  style: AppTypography.small.copyWith(
                    fontWeight: FontWeight.w600,
                    color: accentColor,
                      ),
                    ),
                  ],
                ),
            SizedBox(height: AppDimensions.paddingS),
            // Barre de progression
                ClipRRect(
              borderRadius: BorderRadius.circular(AppDimensions.radiusXS),
                  child: LinearProgressIndicator(
                    value: (usagePercent / 100).clamp(0.0, 1.0),
                      minHeight: AppDimensions.paddingS + 2,
                backgroundColor: AppColors.getProgressBarBackground(isDark),
                      valueColor: AlwaysStoppedAnimation<Color>(accentColor),
                  ),
                ),
              ],
            ),
            ),
          ],
      ),
    );
  }

  Widget _buildBudgetColumn({
    required BuildContext context,
    required IconData icon,
    required Color iconColor,
    required String label,
    required double amount,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
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
        CurrencyAmountText(
          amount: amount,
          style: AppTypography.bodyBold.copyWith(
            color: isDark ? AppColors.textOnDark : AppColors.textPrimary,
                      ),
                    ),
                  ],
    );
  }

  Widget _buildSavingsSection(
    BuildContext context,
    WidgetRef ref,
    PocketEntity pocket,
    AppLocalizations l10n, {
    bool showHeader = true,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return AppCard(
        padding: EdgeInsets.all(AppDimensions.paddingM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  AppIcons.savings,
                  color: AppColors.successDark,
                  size: AppDimensions.iconS + AppDimensions.iconXS,
                ),
                SizedBox(width: AppDimensions.paddingS),
                Text(
                  l10n.savings,
                  style: AppTypography.title,
                ),
              ],
            ),
            SizedBox(height: AppDimensions.paddingM),

            // Montant épargné
            _buildStatRowWithCurrency(
              context: context,
              ref: ref,
              label: l10n.savedAmount,
              amount: pocket.savedAmount,
              valueColor: AppColors.successDark,
            ),

            // Objectif d'épargne
            if (pocket.savingsGoalType != SavingsGoalType.none) ...[
              SizedBox(height: AppDimensions.paddingS),
              _buildStatRowWithCurrency(
                context: context,
                ref: ref,
                label: l10n.goal,
                amount: pocket.targetAmount,
                valueColor: AppColors.infoDark,
              ),

              // Progression vers l'objectif
              if (pocket.targetAmount != null && pocket.targetAmount! > 0) ...[
                SizedBox(height: AppDimensions.paddingM),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          l10n.progression,
                          style: AppTypography.small.copyWith(
                            color: isDark ? AppColors.textSecondaryOnDark : AppColors.textSecondary,
                          ),
                        ),
                        Text(
                          '${((pocket.savedAmount / pocket.targetAmount!) * 100).toStringAsFixed(1)}%',
                          style: AppTypography.small.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColors.successDark,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: AppDimensions.paddingS),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(AppDimensions.radiusS),
                      child: LinearProgressIndicator(
                        value: (pocket.savedAmount / pocket.targetAmount!)
                            .clamp(0.0, 1.0),
                        minHeight: AppDimensions.paddingS + AppDimensions.paddingXS,
                        backgroundColor: AppColors.getProgressBarBackground(isDark),
                        valueColor: AlwaysStoppedAnimation<Color>(
                          AppColors.successDark,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ],

            // Date cible
            if (pocket.targetDate != null) ...[
              SizedBox(height: AppDimensions.paddingS),
              _buildStatRow(
                context: context,
                label: 'Date cible',
                value: _formatDate(pocket.targetDate!),
                valueColor: AppColors.warningDark,
              ),
            ],

            // Épargne mensuelle
            if (pocket.monthlySavingsAmount != null) ...[
              SizedBox(height: AppDimensions.paddingS),
              _buildStatRowWithCurrency(
                context: context,
                ref: ref,
                label: 'Épargne mensuelle',
                amount: pocket.monthlySavingsAmount,
                valueColor: AppColors.secondaryDark,
              ),
            ],

            // Recommandation
            if (pocket.targetAmount != null &&
                pocket.targetDate != null &&
                pocket.savedAmount < pocket.targetAmount!) ...[
              SizedBox(height: AppDimensions.paddingM),
              const Divider(),
              SizedBox(height: AppDimensions.paddingM),
              Container(
                padding: EdgeInsets.all(AppDimensions.paddingS),
                decoration: BoxDecoration(
                  color: AppColors.successLight.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppDimensions.radiusS),
                  border: Border.all(color: AppColors.successLight),
                ),
                child: Row(
                  children: [
                    Icon(AppIcons.info, color: AppColors.successDark, size: AppDimensions.iconS + AppDimensions.iconXS),
                    SizedBox(width: AppDimensions.paddingS),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Épargne mensuelle recommandée',
                            style: AppTypography.caption.copyWith(
                              color: AppColors.successDark,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: AppDimensions.paddingXS),
                          CurrencyAmountText(
                            amount: pocket.recommendedMonthlySavings ?? 0,
                            style: AppTypography.title.copyWith(
                              color: AppColors.successDark,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if ((pocket.recommendedDailySavings ?? 0) > 0) ...[
                            SizedBox(height: AppDimensions.paddingXS),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                            Text(
                                  'Soit ',
                              style: AppTypography.caption.copyWith(
                                    color: AppColors.successDark,
                                  ),
                                ),
                                CurrencyAmountText(
                                  amount: pocket.recommendedDailySavings ?? 0,
                                  style: AppTypography.caption.copyWith(
                                    color: AppColors.successDark,
                                  ),
                                ),
                                Text(
                                  '/jour',
                                  style: AppTypography.caption.copyWith(
                                    color: AppColors.successDark,
                                  ),
                              ),
                              ],
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
      ),
    );
  }

  Widget _buildStatRow({
    required BuildContext context,
    required String label,
    required String value,
    Color? valueColor,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTypography.body.copyWith(
            color: isDark ? AppColors.textSecondaryOnDark : AppColors.textSecondary,
          ),
        ),
        Text(
          value,
          style: AppTypography.title.copyWith(
            color: valueColor,
          ),
        ),
      ],
    );
  }

  Widget _buildStatRowWithCurrency({
    required BuildContext context,
    required WidgetRef ref,
    required String label,
    required double? amount,
    Color? valueColor,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    if (amount == null) {
      return _buildStatRow(
        context: context,
        label: label,
        value: 'Non défini',
        valueColor: valueColor,
      );
    }
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTypography.body.copyWith(
            color: isDark ? AppColors.textSecondaryOnDark : AppColors.textSecondary,
          ),
        ),
        CurrencyAmountText(
          amount: amount,
          style: AppTypography.title.copyWith(
            color: valueColor,
          ),
        ),
      ],
    );
  }

  /// Section des transactions assignées au pocket
  Widget _buildTransactionsSection(BuildContext context, WidgetRef ref, PocketEntity pocket) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final transactionsAsync = ref.watch(transactionsByPocketProvider(pocket.id!));

    return AppCard(
      padding: EdgeInsets.all(AppDimensions.paddingM),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
            children: [
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
                        AppIcons.bills,
                        color: AppColors.secondaryDark,
                        size: AppDimensions.iconS + 2,
                      ),
                    ),
                    SizedBox(width: AppDimensions.paddingM),
              Text(
                'Transactions',
                      style: AppTypography.title.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
              ),
              transactionsAsync.whenData((transactions) {
                  return Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppDimensions.paddingS,
                      vertical: AppDimensions.paddingXS,
                    ),
                    decoration: BoxDecoration(
                      color: isDark
                          ? AppColors.textSecondaryOnDark.withValues(alpha: 0.1)
                          : AppColors.textSecondary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(AppDimensions.radiusL),
                    ),
                    child: Text(
                      '${transactions.length}',
                  style: AppTypography.small.copyWith(
                    color: isDark ? AppColors.textSecondaryOnDark : AppColors.textSecondary,
                        fontWeight: FontWeight.w600,
                      ),
                  ),
                );
              }).value ?? const SizedBox.shrink(),
            ],
          ),
          SizedBox(height: AppDimensions.paddingM),

          transactionsAsync.when(
            data: (transactions) {
              if (transactions.isEmpty) {
                return Center(
                  child: Padding(
                    padding: EdgeInsets.all(AppDimensions.paddingXL),
                    child: Column(
                      children: [
                        Icon(
                          AppIcons.bills,
                          size: AppDimensions.iconXL,
                          color: isDark ? AppColors.textSecondaryOnDark : AppColors.textSecondary,
                        ),
                        SizedBox(height: AppDimensions.paddingS),
                        Text(
                          'Aucune transaction assignée',
                          style: AppTypography.body.copyWith(
                            color: isDark ? AppColors.textSecondaryOnDark : AppColors.textSecondary,
                          ),
                        ),
                        SizedBox(height: AppDimensions.paddingS),
                        Text(
                          'Utilisez le bouton ci-dessous pour assigner des transactions',
                          style: AppTypography.small.copyWith(
                            color: isDark ? AppColors.textSecondaryOnDark : AppColors.textSecondary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              }

              // Limiter à 5 transactions max dans l'aperçu
              final displayTransactions = transactions.take(5).toList();

              return Column(
                children: [
                  ...displayTransactions.asMap().entries.map((entry) {
                    final index = entry.key;
                    final transaction = entry.value;
                    final isLast = index == displayTransactions.length - 1;
                    
                    final backgroundColor = transaction.isExpense
                        ? AppColors.errorLight.withValues(alpha: 0.1)
                        : AppColors.successLight.withValues(alpha: 0.1);
                    final iconColor = transaction.isExpense ? AppColors.error : AppColors.success;

                    return Column(
                      children: [
                        ListTile(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: AppDimensions.paddingS,
                            vertical: AppDimensions.paddingXS,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                          ),
                          tileColor: isDark
                              ? AppColors.surfaceDark.withValues(alpha: 0.5)
                              : AppColors.surface.withValues(alpha: 0.5),
                      leading: CircleAvatar(
                        radius: 20,
                        backgroundColor: backgroundColor,
                        child: ClipOval(
                          child: transaction.imageUrl != null && transaction.imageUrl!.isNotEmpty
                              ? Image.network(
                                  transaction.imageUrl!,
                                  fit: BoxFit.cover,
                                  width: 40,
                                  height: 40,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Icon(
                                      transaction.isExpense ? AppIcons.expense : AppIcons.income,
                                      color: iconColor,
                                      size: 20,
                                    );
                                  },
                                  loadingBuilder: (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Center(
                                      child: SizedBox(
                                        width: AppDimensions.iconS,
                                        height: AppDimensions.iconS,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          value: loadingProgress.expectedTotalBytes != null
                                              ? loadingProgress.cumulativeBytesLoaded /
                                                  loadingProgress.expectedTotalBytes!
                                              : null,
                                        ),
                                      ),
                                    );
                                  },
                                )
                              : Icon(
                                  transaction.isExpense ? AppIcons.expense : AppIcons.income,
                                  color: iconColor,
                                  size: 20,
                                ),
                        ),
                      ),
                      title: Text(
                        transaction.name,
                        style: AppTypography.body.copyWith(fontWeight: FontWeight.w500),
                      ),
                      subtitle: Text(
                        '${transaction.date.day}/${transaction.date.month}/${transaction.date.year}',
                        style: AppTypography.small.copyWith(
                          color: isDark ? AppColors.textSecondaryOnDark : AppColors.textSecondary,
                        ),
                      ),
                      trailing: CurrencyAmountText(
                        amount: transaction.amount,
                        style: AppTypography.body.copyWith(
                          fontWeight: FontWeight.w600,
                          color: transaction.isExpense ? AppColors.error : AppColors.success,
                        ),
                      ),
                        ),
                        if (!isLast) ...[
                          SizedBox(height: AppDimensions.paddingXS),
                          Divider(
                            height: 1,
                            thickness: 1,
                            color: isDark
                                ? AppColors.textSecondaryOnDark.withValues(alpha: 0.2)
                                : AppColors.textSecondary.withValues(alpha: 0.2),
                          ),
                          SizedBox(height: AppDimensions.paddingXS),
                        ],
                      ],
                    );
                  }),

                  if (transactions.length > 5) ...[
                    SizedBox(height: AppDimensions.paddingM),
                    Container(
                      padding: EdgeInsets.all(AppDimensions.paddingM),
                      decoration: BoxDecoration(
                        color: isDark
                            ? AppColors.textSecondaryOnDark.withValues(alpha: 0.05)
                            : AppColors.textSecondary.withValues(alpha: 0.05),
                        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                      ),
                      child: Center(
                      child: Text(
                        '+ ${transactions.length - 5} autre${transactions.length - 5 > 1 ? 's' : ''} transaction${transactions.length - 5 > 1 ? 's' : ''}',
                        style: AppTypography.small.copyWith(
                          color: isDark ? AppColors.textSecondaryOnDark : AppColors.textSecondary,
                            fontWeight: FontWeight.w500,
                        ),
                        ),
                      ),
                    ),
                  ],
                ],
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
                padding: EdgeInsets.all(AppDimensions.paddingL),
                child: Text(
                  'Erreur lors du chargement des transactions',
                  style: AppTypography.body.copyWith(color: AppColors.error),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _handleToggleActive(
    BuildContext context,
    WidgetRef ref,
    PocketEntity pocket,
    AppLocalizations l10n,
  ) async {
    try {
      final controller = ref.read(pocketControllerProvider.notifier);
      if (pocket.isActive) {
        await controller.deactivatePocket(pocket.id!);
        if (context.mounted) {
          InAppNotificationService.showSuccess(
            context,
            message: 'Pocket désactivé avec succès',
          );
        }
      } else {
        await controller.activatePocket(pocket.id!);
        if (context.mounted) {
          InAppNotificationService.showSuccess(
            context,
            message: 'Pocket activé avec succès',
          );
        }
      }
      // Rafraîchir les données
      if (context.mounted) {
        ref.invalidate(pocketByIdProvider(pocket.id!));
        ref.invalidate(userPocketsProvider);
      }
    } catch (e) {
      if (context.mounted) {
        InAppNotificationService.showError(
          context,
          message: 'Erreur: ${e.toString()}',
        );
      }
    }
  }

  void _showInfoModal(
    BuildContext context,
    PocketEntity pocket,
    AppLocalizations l10n,
  ) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final color = Color(int.parse(pocket.color.replaceFirst('#', '0xFF')));

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Consumer(
        builder: (context, ref, child) => Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.7,
          ),
          decoration: BoxDecoration(
            color: isDark ? AppColors.surfaceDark : AppColors.surface,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(AppDimensions.radiusL),
            ),
          ),
          child: SafeArea(
            top: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Handle bar
                Center(
                  child: Container(
                    margin: EdgeInsets.only(top: AppDimensions.paddingS),
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: isDark
                          ? AppColors.textSecondaryOnDark.withValues(alpha: 0.3)
                          : AppColors.textSecondary.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                // Header
                Padding(
                  padding: EdgeInsets.fromLTRB(
                    AppDimensions.paddingL,
                    AppDimensions.paddingM,
                    AppDimensions.paddingL,
                    AppDimensions.paddingM,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Informations',
                        style: AppTypography.heading.copyWith(
                          color: isDark ? AppColors.textOnDark : AppColors.textPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Platform.isIOS
                          ? CupertinoButton(
                              padding: EdgeInsets.zero,
                              minSize: 0,
                              onPressed: () => Navigator.of(context).pop(),
                              child: Icon(
                                AppIcons.close,
                                color: isDark ? AppColors.textSecondaryOnDark : AppColors.textSecondary,
                                size: AppDimensions.iconM,
                              ),
                            )
                          : IconButton(
                              padding: EdgeInsets.zero,
                              constraints: BoxConstraints(),
                              onPressed: () => Navigator.of(context).pop(),
                              icon: Icon(
                                AppIcons.close,
                                color: isDark ? AppColors.textSecondaryOnDark : AppColors.textSecondary,
                                size: AppDimensions.iconM,
                              ),
                            ),
                    ],
                  ),
                ),
                // Content
                SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: AppDimensions.paddingL),
                  child: _buildInfoModalContent(context, ref, pocket, l10n, isDark, color),
                ),
                SizedBox(height: AppDimensions.paddingL),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoModalContent(
    BuildContext context,
    WidgetRef ref,
    PocketEntity pocket,
    AppLocalizations l10n,
    bool isDark,
    Color color,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInfoModalRow(
          context: context,
          icon: AppIcons.filter,
          label: 'Catégorie',
          value: _getCategoryName(pocket.category, l10n),
        ),
        _buildInfoModalRow(
          context: context,
          icon: AppIcons.info,
          label: 'Type',
          value: pocket.isDefault ? 'Pocket par défaut' : 'Pocket personnalisé',
        ),
        _buildInfoModalRow(
          context: context,
          icon: pocket.isActive ? AppIcons.success : AppIcons.error,
          label: 'Statut',
          value: pocket.isActive ? 'Actif' : 'Inactif',
        ),
        if (pocket.createdAt != null)
          _buildInfoModalRow(
            context: context,
            icon: AppIcons.calendar,
            label: 'Créé le',
            value: _formatDate(pocket.createdAt!),
          ),
        if (pocket.updatedAt != null)
          _buildInfoModalRow(
            context: context,
            icon: AppIcons.refresh,
            label: 'Modifié le',
            value: _formatDate(pocket.updatedAt!),
          ),
        if (pocket.category != PocketCategory.savings)
          _buildInfoModalRow(
            context: context,
            icon: AppIcons.wallet,
            label: 'Budget',
            value: CurrencyAmountText(
              amount: pocket.budget,
              style: AppTypography.bodyBold.copyWith(
                color: color,
              ),
            ),
          ),
        if (pocket.category == PocketCategory.savings && pocket.targetAmount != null)
          _buildInfoModalRow(
            context: context,
            icon: AppIcons.target,
            label: 'Objectif',
            value: CurrencyAmountText(
              amount: pocket.targetAmount!,
              style: AppTypography.bodyBold.copyWith(
                color: color,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildInfoModalRow({
    required BuildContext context,
    required IconData icon,
    required String label,
    required dynamic value,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppDimensions.paddingXS),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: (isDark ? AppColors.textSecondaryOnDark : AppColors.textSecondary)
                  .withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppDimensions.radiusS),
            ),
            child: Icon(
              icon,
              size: AppDimensions.iconS,
              color: isDark ? AppColors.textSecondaryOnDark : AppColors.textSecondary,
            ),
          ),
          SizedBox(width: AppDimensions.paddingM),
          Expanded(
            child: Text(
              label,
              style: AppTypography.body.copyWith(
                color: isDark ? AppColors.textSecondaryOnDark : AppColors.textSecondary,
              ),
            ),
          ),
          SizedBox(width: AppDimensions.paddingM),
          value is Widget
              ? value
              : Text(
                  value.toString(),
                  style: AppTypography.bodyBold.copyWith(
                    color: isDark ? AppColors.textOnDark : AppColors.textPrimary,
                  ),
                  textAlign: TextAlign.end,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  void _showDeleteDialog(
    BuildContext context,
    WidgetRef ref,
    PocketEntity pocket,
    AppLocalizations l10n,
  ) {
    if (Platform.isIOS) {
      showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: const Text('Supprimer le pocket'),
          content: Text(
            'Êtes-vous sûr de vouloir supprimer "${pocket.getName(l10n)}" ?\n\nCette action est irréversible.',
          ),
          actions: [
            CupertinoDialogAction(
              child: const Text('Annuler'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            CupertinoDialogAction(
              isDestructiveAction: true,
              onPressed: () async {
                Navigator.of(context).pop();
                try {
                final controller = ref.read(pocketControllerProvider.notifier);
                await controller.deletePocket(pocket.id!);
                if (context.mounted) {
                    final l10n = AppLocalizations.of(context)!;
                    InAppNotificationService.showSuccess(
                      context,
                      message: l10n.notificationSuccessMessage,
                    );
                  Navigator.of(context).pop();
                  }
                } catch (e) {
                  if (context.mounted) {
                    final l10n = AppLocalizations.of(context)!;
                    InAppNotificationService.showError(
                      context,
                      message: '${l10n.notificationErrorMessage}: ${e.toString()}',
                    );
                  }
                }
              },
              child: const Text('Supprimer'),
            ),
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Supprimer le pocket'),
          content: Text(
            'Êtes-vous sûr de vouloir supprimer "${pocket.getName(l10n)}" ?\n\nCette action est irréversible.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Annuler'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                try {
                final controller = ref.read(pocketControllerProvider.notifier);
                await controller.deletePocket(pocket.id!);
                if (context.mounted) {
                    final l10n = AppLocalizations.of(context)!;
                    InAppNotificationService.showSuccess(
                      context,
                      message: l10n.notificationSuccessMessage,
                    );
                  Navigator.of(context).pop();
                }
                } catch (e) {
                  if (context.mounted) {
                    final l10n = AppLocalizations.of(context)!;
                    InAppNotificationService.showError(
                      context,
                      message: '${l10n.notificationErrorMessage}: ${e.toString()}',
                    );
                  }
                }
              },
              style: TextButton.styleFrom(foregroundColor: AppColors.error),
              child: const Text('Supprimer'),
            ),
          ],
        ),
      );
    }
  }

  IconData _getIconData(String iconName) {
    // Utilise la méthode utilitaire centralisée pour convertir le code d'icône
    return AppIcons.getPocketIcon(iconName);
  }

  IconData _getCategoryIcon(PocketCategory category) {
    return switch (category) {
      PocketCategory.needs => AppIcons.housing,
      PocketCategory.wants => AppIcons.favorite,
      PocketCategory.savings => AppIcons.savings,
    };
  }

  String _getCategoryName(PocketCategory category, AppLocalizations l10n) {
    return category.getName(l10n);
  }

  String _formatDate(DateTime date) {
    final months = [
      'Janvier', 'Février', 'Mars', 'Avril', 'Mai', 'Juin',
      'Juillet', 'Août', 'Septembre', 'Octobre', 'Novembre', 'Décembre'
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }
}

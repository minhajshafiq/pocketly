import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:pocketly/core/core.dart';
import 'package:pocketly/core/widgets/animated_page_header.dart';
import 'package:pocketly/features/pockets/domain/entities/pocket_entity.dart';
import 'package:pocketly/features/pockets/presentation/providers/pocket_providers.dart';
import 'package:pocketly/features/pockets/presentation/widgets/pocket_card.dart';
import 'package:pocketly/features/pockets/presentation/widgets/pocket_category_section.dart';
import 'package:pocketly/features/pockets/presentation/widgets/budget_total_widget.dart';
import 'package:pocketly/features/pockets/presentation/widgets/rule_502030_widget.dart';
import 'package:pocketly/features/pockets/presentation/widgets/pocket_category_filter_buttons.dart';
import 'package:pocketly/features/statistics/presentation/widgets/premium_locked_widget.dart';
import 'package:pocketly/features/user/user.dart';
import 'package:pocketly/generated/l10n/app_localizations.dart';
import 'package:pocketly/features/notifications/notifications.dart';

/// Écran de liste des Pockets
///
/// Affiche la liste des pockets avec filtrage par catégorie.
class PocketsListScreen extends ConsumerStatefulWidget {
  const PocketsListScreen({super.key});

  @override
  ConsumerState<PocketsListScreen> createState() => _PocketsListScreenState();
}

class _PocketsListScreenState extends ConsumerState<PocketsListScreen> {
  final ScrollController _scrollController = ScrollController();
  PocketCategory? _selectedCategory;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _handleCategoryChange(PocketCategory? category) {
    setState(() {
      _selectedCategory = category;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Vérifier l'accès premium
    final canAccessPremium = ref.watch(canAccessPremiumProvider);

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.background,
      body: PlatformSafeArea(
        top: true,
        bottom: false,
        padding: EdgeInsets.only(top: AppDimensions.paddingS),
        child: Stack(
                children: [
                  // Contenu scrollable
                  RefreshIndicator(
                    onRefresh: () async {
                      ref.invalidate(userPocketsProvider);
                      await ref.read(userPocketsProvider.future);
                    },
                    child: _buildBody(),
                  ),

                  // Header sticky animé
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: AnimatedPageHeader(
                      title: l10n.pockets,
                      scrollController: _scrollController,
                      showBackButton: false,
                      actionButton: _buildRefreshButton(isDark),
                    ),
                  ),

            if (!canAccessPremium) PremiumLockedOverlay(),
                ],
        ),
      ),
    );
  }

  Widget _buildRefreshButton(bool isDark) {
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
          ref.invalidate(userPocketsProvider);
        },
        icon: Icon(AppIcons.refresh, color: AppColors.primary),
        padding: EdgeInsets.zero,
      ),
    );
  }

  Widget _buildBody() {
    final pocketsAsync = ref.watch(userPocketsProvider);

    return pocketsAsync.when(
      data: (allPockets) {
        if (allPockets.isEmpty) {
          return SingleChildScrollView(
            controller: _scrollController,
            padding: EdgeInsets.only(top: 80),
            child: _buildEmptyState(),
          );
        }

        return _buildPocketsList(allPockets);
      },
      loading: () => SingleChildScrollView(
        controller: _scrollController,
        padding: EdgeInsets.only(top: 80),
        child: const Center(child: CircularProgressIndicator()),
      ),
      error: (error, stack) => SingleChildScrollView(
        controller: _scrollController,
        padding: EdgeInsets.only(top: 80),
        child: ErrorDisplay(
          error: error is AppError
              ? error
              : UnknownError(
                  technicalMessage: error.toString(),
                  stackTrace: stack,
                ),
          onRetry: () {
            ref.invalidate(userPocketsProvider);
          },
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Center(
      child: Padding(
        padding: EdgeInsets.all(AppDimensions.paddingL),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              AppIcons.wallet,
              size: 80,
              color: isDark
                  ? AppColors.textSecondaryOnDark
                  : AppColors.textSecondary,
            ),
            SizedBox(height: AppDimensions.paddingM),
            Text(
              l10n.noPocketsYet,
              style: AppTypography.title.copyWith(fontWeight: FontWeight.w500),
            ),
            SizedBox(height: AppDimensions.paddingS),
            Text(
              l10n.createFirstPocket,
              style: AppTypography.body.copyWith(
                color: isDark
                    ? AppColors.textSecondaryOnDark
                    : AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: AppDimensions.paddingL),
            AppButton(
              text: l10n.createDefaultPockets,
              icon: AppIcons.target,
              iconPosition: IconPosition.left,
              onPressed: () async {
                // Créer les pockets par défaut
                final controller = ref.read(pocketControllerProvider.notifier);
                await controller.createDefaultPockets();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPocketsList(List<PocketEntity> allPockets) {
    return ListView(
      controller: _scrollController,
      padding: EdgeInsets.only(
        top: 80 + AppDimensions.paddingM, // Header + padding
        left: AppDimensions.paddingM,
        right: AppDimensions.paddingM,
        bottom: AppDimensions.paddingM,
      ),
      children: [
        // === Section d'en-tête ===
        const BudgetTotalWidget(),
        SizedBox(height: AppDimensions.paddingM),
        const Rule502030Widget(),
        SizedBox(height: AppDimensions.paddingM),

        // === Filtres ===
        PocketCategoryFilterButtons(
          selectedCategory: _selectedCategory,
          onCategoryChanged: _handleCategoryChange,
        ),
        SizedBox(height: AppDimensions.paddingM),

        // === Liste des pockets ===
        ..._buildPocketsContent(allPockets),
      ],
    );
  }

  /// Construit le contenu des pockets selon le filtre actif
  List<Widget> _buildPocketsContent(List<PocketEntity> allPockets) {
    if (_selectedCategory == null) {
      return _buildAllCategoriesSections(allPockets);
    }
    return _buildFilteredPockets(allPockets);
  }

  /// Construit les sections pour toutes les catégories
  List<Widget> _buildAllCategoriesSections(List<PocketEntity> allPockets) {
    return [
      if (allPockets.needs.isNotEmpty) ...[
        PocketCategorySection(
          category: PocketCategory.needs,
          pockets: allPockets.needs,
        ),
        SizedBox(height: AppDimensions.paddingL),
      ],
      if (allPockets.wants.isNotEmpty) ...[
        PocketCategorySection(
          category: PocketCategory.wants,
          pockets: allPockets.wants,
        ),
        SizedBox(height: AppDimensions.paddingL),
      ],
      if (allPockets.savings.isNotEmpty) ...[
        PocketCategorySection(
          category: PocketCategory.savings,
          pockets: allPockets.savings,
        ),
        SizedBox(height: AppDimensions.paddingL),
      ],
    ];
  }

  /// Construit la liste des pockets filtrés par catégorie
  List<Widget> _buildFilteredPockets(List<PocketEntity> allPockets) {
    final filteredPockets = allPockets
        .where((p) => p.category == _selectedCategory)
        .toList();

    if (filteredPockets.isEmpty) {
      return [_buildEmptyCategoryState()];
    }

    return filteredPockets.map((pocket) {
      final l10n = AppLocalizations.of(context)!;
      return Padding(
        padding: EdgeInsets.only(bottom: AppDimensions.paddingM),
        child: Slidable(
          key: ValueKey(pocket.id),
          endActionPane: ActionPane(
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                onPressed: (context) => _handleDelete(context, pocket, l10n),
                backgroundColor: AppColors.error,
                foregroundColor: Colors.white,
                icon: Platform.isIOS ? CupertinoIcons.delete : Icons.delete,
                label: l10n.delete,
                borderRadius: BorderRadius.circular(AppDimensions.radiusM),
              ),
            ],
          ),
          child: PocketCard(
            pocket: pocket,
            transactionCount: ref.watch(
              transactionCountByPocketProvider(pocket.id),
            ),
            onTap: () {
              if (pocket.id != null) {
                context.push(AppRoutePaths.pocketDetailPath(pocket.id!));
              }
            },
          ),
        ),
      );
    }).toList();
  }

  Future<void> _handleDelete(
    BuildContext context,
    PocketEntity pocket,
    AppLocalizations l10n,
  ) async {
    final confirmed = await _showDeleteConfirmation(context, l10n, pocket);
    if (confirmed == true && pocket.id != null) {
      final controller = ref.read(pocketControllerProvider.notifier);
      await controller.deletePocket(pocket.id!);

      // Afficher notification selon le résultat
      final state = ref.read(pocketControllerProvider);
      state.when(
        data: (_) {
          InAppNotificationService.showSuccess(
            context,
            title: l10n.success,
            message: l10n.pocketDeletedSuccess,
          );
        },
        loading: () {},
        error: (error, stack) {
          InAppNotificationService.showError(
            context,
            title: l10n.error,
            message: l10n.pocketDeleteError,
          );
        },
      );
    }
  }

  Future<bool?> _showDeleteConfirmation(
    BuildContext context,
    AppLocalizations l10n,
    PocketEntity pocket,
  ) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (Platform.isIOS) {
      return showCupertinoDialog<bool>(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: Text(l10n.deletePocketTitle),
          content: Text(l10n.deletePocketMessage),
          actions: [
            CupertinoDialogAction(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(l10n.cancel),
            ),
            CupertinoDialogAction(
              onPressed: () => Navigator.of(context).pop(true),
              isDestructiveAction: true,
              child: Text(l10n.delete),
            ),
          ],
        ),
      );
    }

    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: isDark ? AppColors.surfaceDark : AppColors.surface,
        title: Text(
          l10n.deletePocketTitle,
          style: AppTypography.heading.copyWith(fontWeight: FontWeight.bold),
        ),
        content: Text(l10n.deletePocketMessage, style: AppTypography.body),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: Text(l10n.delete),
          ),
        ],
      ),
    );
  }

  /// État vide pour une catégorie filtrée
  Widget _buildEmptyCategoryState() {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Center(
      child: Padding(
        padding: EdgeInsets.all(AppDimensions.paddingXL),
        child: Text(
          l10n.noPocketsInCategory,
          style: AppTypography.body.copyWith(
            color: isDark
                ? AppColors.textSecondaryOnDark
                : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }
}

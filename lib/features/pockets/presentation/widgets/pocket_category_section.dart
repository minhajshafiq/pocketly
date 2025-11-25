import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:pocketly/core/core.dart';
import 'package:pocketly/features/pockets/domain/entities/pocket_entity.dart';
import 'package:pocketly/features/pockets/presentation/providers/pocket_providers.dart';
import 'package:pocketly/features/pockets/presentation/widgets/pocket_card.dart';
import 'package:pocketly/generated/l10n/app_localizations.dart';
import 'package:pocketly/features/notifications/notifications.dart';

/// Section affichant une catégorie de pockets
///
/// Affiche un titre de section et la liste des pockets de cette catégorie.
class PocketCategorySection extends ConsumerWidget {
  final PocketCategory category;
  final List<PocketEntity> pockets;

  const PocketCategorySection({
    super.key,
    required this.category,
    required this.pockets,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(context, l10n, isDark),
        SizedBox(height: AppDimensions.paddingM),
        ...pockets.map((pocket) => Padding(
              padding: EdgeInsets.only(bottom: AppDimensions.paddingM),
              child: Slidable(
                key: ValueKey(pocket.id),
                endActionPane: ActionPane(
                  motion: const ScrollMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (context) => _handleDelete(context, ref, pocket, l10n),
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
                  transactionCount: ref.watch(transactionCountByPocketProvider(pocket.id)),
                  onTap: () {
                    if (pocket.id != null) {
                      context.push(AppRoutePaths.pocketDetailPath(pocket.id!));
                    }
                  },
                ),
              ),
            )),
      ],
    );
  }

  Future<void> _handleDelete(
    BuildContext context,
    WidgetRef ref,
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
        content: Text(
          l10n.deletePocketMessage,
          style: AppTypography.body,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(
              foregroundColor: AppColors.error,
            ),
            child: Text(l10n.delete),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, AppLocalizations l10n, bool isDark) {
    final categoryColor = Color(
      int.parse(
        category.primaryColor.replaceFirst('#', '0xFF'),
      ),
    );
    
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(AppDimensions.paddingS),
          decoration: BoxDecoration(
            color: categoryColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(AppDimensions.radiusS),
          ),
          child: Icon(
            _getCategoryIcon(),
            color: categoryColor,
            size: AppDimensions.iconM,
          ),
        ),
        SizedBox(width: AppDimensions.paddingM),
        Text(
          _getCategoryName(l10n),
          style: AppTypography.heading.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(width: AppDimensions.paddingS),
        Text(
          '(${category.recommendedPercentage}%)',
          style: AppTypography.label.copyWith(
            color: isDark
                ? AppColors.textSecondaryOnDark
                : AppColors.textSecondary,
          ),
        ),
        const Spacer(),
        Text(
          '${pockets.length}',
          style: AppTypography.large.copyWith(
            color: isDark
                ? AppColors.textSecondaryOnDark
                : AppColors.textSecondary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  IconData _getCategoryIcon() {
    return switch (category) {
      PocketCategory.needs => AppIcons.home,
      PocketCategory.wants => AppIcons.favorite,
      PocketCategory.savings => AppIcons.savings,
    };
  }

  String _getCategoryName(AppLocalizations l10n) {
    return category.getName(l10n);
  }
}

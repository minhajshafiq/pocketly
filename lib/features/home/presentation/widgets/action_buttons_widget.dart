import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:pocketly/core/constants/app_colors.dart';
import 'package:pocketly/core/constants/app_dimensions.dart';
import 'package:pocketly/core/constants/app_typography.dart';
import 'package:pocketly/core/constants/app_icons.dart';
import 'package:pocketly/core/router/app_route_paths.dart';
import 'package:pocketly/generated/l10n/app_localizations.dart';
import 'package:pocketly/features/transactions/transactions.dart';

class ActionButtonsWidget extends StatelessWidget {
  const ActionButtonsWidget({super.key});

  bool get _isIOS => !kIsWeb && Platform.isIOS;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildActionButton(
          context,
          icon: AppIcons.add,
          label: AppLocalizations.of(context)!.add,
          onTap: () => showTransactionTypeModal(context),
        ),
        _buildActionButton(
          context,
          icon: LucideIcons.tag,
          label: AppLocalizations.of(context)!.categories,
          onTap: () => context.push(AppRoutePaths.categories),
        ),
        _buildActionButton(
          context,
          icon: AppIcons.stats,
          label: AppLocalizations.of(context)!.statistics,
          onTap: () => context.push(AppRoutePaths.statistics),
        ),
        _buildMoreButton(context),
      ],
    );
  }

  Widget _buildActionButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (_isIOS) {
      return CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Bouton circulaire avec icône
            Container(
              width: 52,
              height: 52,
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
              child: Icon(
                icon,
                size: 20,
                color: isDark ? AppColors.textOnDark : AppColors.textPrimary,
              ),
            ),
            SizedBox(height: AppDimensions.paddingXS),
            // Label en dessous
            Text(
              label,
              style: AppTypography.small.copyWith(
                color: isDark
                    ? AppColors.textOnDark
                    : AppColors.textPrimary,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      );
    }

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Bouton circulaire avec icône
          Container(
            width: 52,
            height: 52,
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
            child: Icon(
              icon,
              size: 20,
              color: isDark ? AppColors.textOnDark : AppColors.textPrimary,
            ),
          ),
          SizedBox(height: AppDimensions.paddingXS),
          // Label en dessous
          Text(
            label,
            style: AppTypography.small.copyWith(
              color: isDark
                  ? AppColors.textOnDark
                  : AppColors.textPrimary,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  /// Construit le bouton "Plus" avec PopupMenuButton
  Widget _buildMoreButton(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return PopupMenuButton<String>(
      onSelected: (value) {
        if (value == 'categories') {
          context.push(AppRoutePaths.categories);
        }
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
      ),
      color: isDark ? AppColors.surfaceDark : AppColors.surface,
      elevation: 8,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Bouton circulaire avec icône
          Container(
            width: 52,
            height: 52,
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
            child: Icon(
              AppIcons.more,
              size: 20,
              color: isDark ? AppColors.textOnDark : AppColors.textPrimary,
            ),
          ),
          SizedBox(height: AppDimensions.paddingXS),
          // Label en dessous
          Text(
            l10n.more,
            style: AppTypography.small.copyWith(
              color: isDark
                  ? AppColors.textOnDark
                  : AppColors.textPrimary,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          value: 'categories',
          child: Row(
            children: [
              Icon(
                LucideIcons.tag,
                size: 20,
                color: AppColors.primary,
              ),
              SizedBox(width: AppDimensions.paddingM),
              Text(
                l10n.categories,
                style: AppTypography.body.copyWith(
                  color: isDark ? AppColors.textOnDark : AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

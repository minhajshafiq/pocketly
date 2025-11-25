import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:pocketly/core/constants/app_colors.dart';
import 'package:pocketly/core/constants/app_dimensions.dart';
import 'package:pocketly/core/constants/app_typography.dart';
import 'package:pocketly/core/router/app_route_paths.dart';
import 'package:pocketly/features/transactions/domain/entities/transaction_entity.dart';

/// Modal pour sélectionner le type de transaction (dépense ou revenu)
class TransactionTypeModal extends StatelessWidget {
  const TransactionTypeModal({super.key});

  bool get _isIOS => !kIsWeb && Platform.isIOS;

  @override
  Widget build(BuildContext context) {
    if (_isIOS) {
      return _buildCupertinoModal(context);
    }
    return _buildMaterialModal(context);
  }

  Widget _buildCupertinoModal(BuildContext context) {
    return CupertinoActionSheet(
      title: Text(
        'Nouvelle transaction',
        style: AppTypography.heading.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
      message: Text(
        'Sélectionnez le type de transaction',
        style: AppTypography.body,
      ),
      actions: [
        CupertinoActionSheetAction(
          onPressed: () {
            Navigator.of(context).pop();
            context.push(
              '${AppRoutePaths.addTransactionAmount}?type=expense',
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                CupertinoIcons.arrow_up_circle_fill,
                color: AppColors.error,
                size: 24,
              ),
              SizedBox(width: AppDimensions.paddingM),
              Text(
                'Dépense',
                style: AppTypography.title.copyWith(
                  color: AppColors.error,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        CupertinoActionSheetAction(
          onPressed: () {
            Navigator.of(context).pop();
            context.push(
              '${AppRoutePaths.addTransactionAmount}?type=income',
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                CupertinoIcons.arrow_down_circle_fill,
                color: AppColors.success,
                size: 24,
              ),
              SizedBox(width: AppDimensions.paddingM),
              Text(
                'Revenu',
                style: AppTypography.title.copyWith(
                  color: AppColors.success,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        onPressed: () => Navigator.of(context).pop(),
        isDefaultAction: true,
        child: Text(
          'Annuler',
          style: AppTypography.title,
        ),
      ),
    );
  }

  Widget _buildMaterialModal(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusL),
      ),
      child: Container(
        padding: EdgeInsets.all(AppDimensions.paddingM),
        decoration: BoxDecoration(
          color: isDark ? AppColors.surfaceDark : Colors.white,
          borderRadius: BorderRadius.circular(AppDimensions.radiusL),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Titre
            Text(
              'Nouvelle transaction',
              style: AppTypography.title.copyWith(
                fontWeight: FontWeight.bold,
                color: isDark ? AppColors.textOnDark : AppColors.textPrimary,
              ),
            ),
            SizedBox(height: AppDimensions.paddingXS / 2),
            Text(
              'Sélectionnez le type de transaction',
              style: AppTypography.small.copyWith(
                color: isDark
                    ? AppColors.textSecondaryOnDark
                    : AppColors.textSecondary,
              ),
            ),

            SizedBox(height: AppDimensions.paddingM),

            // Option Dépense
            _buildTransactionTypeCard(
              context: context,
              type: TransactionType.expense,
              icon: Icons.arrow_upward_rounded,
              label: 'Dépense',
              color: AppColors.error,
              isDark: isDark,
            ).animate().fadeIn(duration: 300.ms).slideY(
                  begin: 0.2,
                  end: 0,
                  curve: Curves.easeOutCubic,
                ),

            SizedBox(height: AppDimensions.paddingS),

            // Option Revenu
            _buildTransactionTypeCard(
              context: context,
              type: TransactionType.income,
              icon: Icons.arrow_downward_rounded,
              label: 'Revenu',
              color: AppColors.success,
              isDark: isDark,
            ).animate().fadeIn(duration: 300.ms, delay: 100.ms).slideY(
                  begin: 0.2,
                  end: 0,
                  curve: Curves.easeOutCubic,
                ),

            SizedBox(height: AppDimensions.paddingM),

            // Bouton Annuler
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Annuler',
                style: AppTypography.body.copyWith(
                  color: isDark
                      ? AppColors.textSecondaryOnDark
                      : AppColors.textSecondary,
                ),
              ),
            ),
          ],
        ),
      ),
    ).animate().scale(
          duration: 200.ms,
          curve: Curves.easeOutCubic,
        );
  }

  Widget _buildTransactionTypeCard({
    required BuildContext context,
    required TransactionType type,
    required IconData icon,
    required String label,
    required Color color,
    required bool isDark,
  }) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pop();
        context.push(
          '${AppRoutePaths.addTransactionAmount}?type=${type.name}',
        );
      },
      borderRadius: BorderRadius.circular(AppDimensions.radiusM),
      child: Container(
        padding: EdgeInsets.all(AppDimensions.paddingM),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
          border: Border.all(
            color: color.withValues(alpha: 0.3),
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            // Icône
            Container(
              padding: EdgeInsets.all(AppDimensions.paddingS),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: color,
                size: 24,
              ),
            ),

            SizedBox(width: AppDimensions.paddingM),

            // Label
            Expanded(
              child: Text(
                label,
                style: AppTypography.title.copyWith(
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // Flèche
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: color,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}

/// Fonction helper pour afficher le modal de sélection de type
void showTransactionTypeModal(BuildContext context) {
  if (!kIsWeb && Platform.isIOS) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => const TransactionTypeModal(),
    );
  } else {
    showDialog(
      context: context,
      builder: (context) => const TransactionTypeModal(),
    );
  }
}

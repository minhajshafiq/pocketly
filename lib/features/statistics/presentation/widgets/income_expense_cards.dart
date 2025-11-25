import 'package:flutter/material.dart';
import 'package:pocketly/core/constants/app_colors.dart';
import 'package:pocketly/core/constants/app_dimensions.dart';
import 'package:pocketly/core/constants/app_icons.dart';
import 'package:pocketly/core/constants/app_typography.dart';
import 'package:pocketly/generated/l10n/app_localizations.dart';
import 'package:pocketly/features/currency/currency.dart';

/// Widget affichant les cartes de revenus et dépenses
class IncomeExpenseCards extends StatelessWidget {
  final double totalIncome;
  final double totalExpense;

  const IncomeExpenseCards({
    super.key,
    required this.totalIncome,
    required this.totalExpense,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context)!;

    return Row(
      children: [
        // Carte Revenus
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: AppDimensions.paddingS,
              vertical: AppDimensions.paddingXS,
            ),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(999),
              border: Border.all(
                color:
                    (isDark
                            ? AppColors.textSecondaryOnDark
                            : AppColors.textSecondary)
                        .withValues(alpha: 0.2),
                width: 1,
              ),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Icône positionnée à gauche
                Positioned(
                  left: 0,
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: AppColors.success.withValues(alpha: 0.18),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      AppIcons.keyboardDoubleArrowDown,
                      color: AppColors.success,
                      size: 18,
                    ),
                  ),
                ),
                // Contenu centré
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      l10n.incomeLabel,
                      style: AppTypography.small.copyWith(
                        fontSize: 12,
                        color: isDark
                            ? AppColors.textSecondaryOnDark
                            : AppColors.textSecondary,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      softWrap: false,
                      overflow: TextOverflow.fade,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: AppDimensions.paddingXS),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '+ ',
                          style: AppTypography.body.copyWith(
                            fontSize: 16,
                            color: AppColors.success,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        CurrencyDisplayWidget(
                          amount: totalIncome,
                          style: AppTypography.body.copyWith(
                            fontSize: 16,
                            color: AppColors.success,
                            fontWeight: FontWeight.w700,
                          ),
                          decimals: 0,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        SizedBox(width: AppDimensions.paddingM),

        // Carte Dépenses
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: AppDimensions.paddingS,
              vertical: AppDimensions.paddingXS,
            ),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(999),
              border: Border.all(
                color:
                    (isDark
                            ? AppColors.textSecondaryOnDark
                            : AppColors.textSecondary)
                        .withValues(alpha: 0.2),
                width: 1,
              ),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Icône positionnée à gauche
                Positioned(
                  left: 0,
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: AppColors.error.withValues(alpha: 0.18),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      AppIcons.keyboardDoubleArrowUp,
                      color: AppColors.error,
                      size: 18,
                    ),
                  ),
                ),
                // Contenu centré
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      l10n.expensesLabel,
                      style: AppTypography.small.copyWith(
                        fontSize: 12,
                        color: isDark
                            ? AppColors.textSecondaryOnDark
                            : AppColors.textSecondary,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      softWrap: false,
                      overflow: TextOverflow.fade,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: AppDimensions.paddingXS),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '- ',
                          style: AppTypography.body.copyWith(
                            fontSize: 16,
                            color: AppColors.error,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        CurrencyDisplayWidget(
                          amount: totalExpense,
                          style: AppTypography.body.copyWith(
                            fontSize: 16,
                            color: AppColors.error,
                            fontWeight: FontWeight.w700,
                          ),
                          decimals: 0,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

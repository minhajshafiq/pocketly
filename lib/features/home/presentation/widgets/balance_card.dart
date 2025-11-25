import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocketly/core/constants/app_colors.dart';
import 'package:pocketly/core/constants/app_dimensions.dart';
import 'package:pocketly/core/constants/app_typography.dart';
import 'package:pocketly/core/constants/app_icons.dart';
import 'package:pocketly/core/widgets/app_card.dart';
import 'package:pocketly/features/home/presentation/providers/home_providers.dart';
import 'package:pocketly/generated/l10n/app_localizations.dart';
import 'package:pocketly/features/currency/currency.dart';

/// Widget affichant le solde et la variation 24h.
class BalanceCard extends ConsumerWidget {
  const BalanceCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summaryAsync = ref.watch(homeSummaryControllerProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return summaryAsync.when(
      data: (summary) {
        final isPositive = summary.variation24h >= 0;

        return AppCard(
          padding: EdgeInsets.all(AppDimensions.paddingM),
          child: Row(
            children: [
              // Contenu principal (solde disponible, épargne et variation)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Solde disponible
                    Text(
                      AppLocalizations.of(context)!.availableBalance,
                      style: AppTypography.small.copyWith(
                        color: isDark
                            ? AppColors.textSecondaryOnDark
                            : AppColors.textSecondary,
                      ),
                    ),
                    SizedBox(height: AppDimensions.paddingXS),
                    CurrencyDisplayWidget(
                      amount: summary.availableBalance,
                      style: AppTypography.heading.copyWith(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                      decimals: 2,
                    ),
                    SizedBox(height: AppDimensions.paddingS),
                    // Ligne avec "Dernière 24h" + variation à gauche et épargne à droite
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // À gauche : "Dernière 24h" + variation
                        Row(
                          children: [
                            Text(
                              AppLocalizations.of(context)!.last24Hours,
                              style: AppTypography.small.copyWith(
                                color: isDark
                                    ? AppColors.textSecondaryOnDark
                                    : AppColors.textSecondary,
                              ),
                            ),
                            SizedBox(width: AppDimensions.paddingS),
                            // Afficher icône ou trait selon la variation
                            if (summary.variation24h == 0)
                              Text(
                                '—',
                                style: AppTypography.small.copyWith(
                                  color: isDark
                                      ? AppColors.textSecondaryOnDark
                                      : AppColors.textSecondary,
                                ),
                              )
                            else
                              Icon(
                                isPositive
                                    ? AppIcons.trendingUp
                                    : AppIcons.trendingDown,
                                color: isPositive
                                    ? AppColors.success
                                    : AppColors.error,
                                size: 16,
                              ),
                            SizedBox(width: AppDimensions.paddingXS),
                            CurrencyDisplayWidget(
                              amount: summary.variation24h,
                              style: AppTypography.small.copyWith(
                                color: summary.variation24h == 0
                                    ? (isDark
                                          ? AppColors.textSecondaryOnDark
                                          : AppColors.textSecondary)
                                    : (isPositive
                                          ? AppColors.success
                                          : AppColors.error),
                                fontWeight: FontWeight.w600,
                              ),
                              decimals: 2,
                            ),
                          ],
                        ),
                        // À droite : Épargne avec icône cochon
                        Row(
                          children: [
                            Icon(
                              AppIcons.savings,
                              color: AppColors.success,
                              size: 16,
                            ),
                            SizedBox(width: 4),
                            CurrencyDisplayWidget(
                              amount: summary.totalSavings,
                              style: AppTypography.small.copyWith(
                                color: AppColors.success,
                                fontWeight: FontWeight.w600,
                              ),
                              decimals: 2,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
      loading: () => AppCard(
        padding: EdgeInsets.all(AppDimensions.paddingM),
        child: _buildLoadingSkeleton(isDark),
      ),
      error: (error, stack) => AppCard(
        padding: EdgeInsets.all(AppDimensions.paddingM),
        child: _buildErrorState(context),
      ),
    );
  }

  Widget _buildLoadingSkeleton(bool isDark) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Skeleton pour "Solde actuel"
              Container(
                width: 80,
                height: 12,
                decoration: BoxDecoration(
                  color: isDark ? AppColors.surfaceDark : AppColors.surface,
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              SizedBox(height: AppDimensions.paddingXS),
              // Skeleton pour le montant
              Container(
                width: 120,
                height: 28,
                decoration: BoxDecoration(
                  color: isDark ? AppColors.surfaceDark : AppColors.surface,
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              SizedBox(height: AppDimensions.paddingXS),
              // Skeleton pour "Dernière 24h"
              Row(
                children: [
                  Container(
                    width: 60,
                    height: 12,
                    decoration: BoxDecoration(
                      color: isDark ? AppColors.surfaceDark : AppColors.surface,
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  SizedBox(width: 4),
                  Container(
                    width: 16,
                    height: 12,
                    decoration: BoxDecoration(
                      color: isDark ? AppColors.surfaceDark : AppColors.surface,
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  SizedBox(width: 4),
                  Container(
                    width: 40,
                    height: 12,
                    decoration: BoxDecoration(
                      color: isDark ? AppColors.surfaceDark : AppColors.surface,
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildErrorState(BuildContext context) {
    return Column(
      children: [
        Icon(AppIcons.errorOutline, color: AppColors.error, size: 48),
        SizedBox(height: AppDimensions.paddingS),
        Text(
          AppLocalizations.of(context)!.failedToLoadBalance,
          style: AppTypography.body.copyWith(color: AppColors.error),
        ),
      ],
    );
  }
}

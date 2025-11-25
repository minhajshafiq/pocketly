import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocketly/core/constants/app_colors.dart';
import 'package:pocketly/core/constants/app_dimensions.dart';
import 'package:pocketly/core/constants/app_icons.dart';
import 'package:pocketly/core/constants/app_typography.dart';
import 'package:pocketly/features/statistics/domain/entities/chart_data_entity.dart';
import 'package:pocketly/features/statistics/presentation/providers/statistics_providers.dart';
import 'package:pocketly/generated/l10n/app_localizations.dart';

/// Widget de navigation temporelle
class TimeNavigationWidget extends ConsumerWidget {
  const TimeNavigationWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chartDataAsync = ref.watch(chartDataControllerProvider);
    final period = ref.watch(timePeriodProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppDimensions.paddingM),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Bouton précédent (capsule ronde avec bord)
          _NavCircleButton(
            icon: AppIcons.chevronLeft,
            isDark: isDark,
            onTap: () => ref
                .read(currentStartDateProvider.notifier)
                .goToPrevious(period),
          ),

          // Affichage de la période (pill avec bord)
          Expanded(
            child: Center(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: AppDimensions.paddingL,
                  vertical: AppDimensions.paddingS,
                ),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.surfaceDark : AppColors.surface,
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
                child: chartDataAsync.when(
                  data: (chartData) => Text(
                    chartData.periodDisplay,
                    style: AppTypography.body.copyWith(
                      fontWeight: FontWeight.w600,
                      color: isDark
                          ? AppColors.textOnDark
                          : AppColors.textPrimary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  loading: () => Text(
                    '…',
                    style: AppTypography.body.copyWith(
                      fontWeight: FontWeight.w600,
                      color: isDark
                          ? AppColors.textSecondaryOnDark
                          : AppColors.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  error: (error, stack) {
                    final l10n = AppLocalizations.of(context)!;
                    return Text(
                      l10n.error,
                      style: AppTypography.body.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.error,
                      ),
                      textAlign: TextAlign.center,
                    );
                  },
                ),
              ),
            ),
          ),

          // Bouton suivant (capsule ronde avec bord)
          _NavCircleButton(
            icon: AppIcons.chevronRight,
            isDark: isDark,
            onTap: () =>
                ref.read(currentStartDateProvider.notifier).goToNext(period),
          ),
        ],
      ),
    );
  }
}

class _NavCircleButton extends StatelessWidget {
  final IconData icon;
  final bool isDark;
  final VoidCallback onTap;

  const _NavCircleButton({
    required this.icon,
    required this.isDark,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: isDark ? AppColors.surfaceDark : AppColors.surface,
          shape: BoxShape.circle,
          border: Border.all(
            color:
                (isDark
                        ? AppColors.textSecondaryOnDark
                        : AppColors.textSecondary)
                    .withValues(alpha: 0.2),
            width: 1,
          ),
        ),
        child: Center(
          child: Icon(
            icon,
            size: 20,
            color: isDark
                ? AppColors.textSecondaryOnDark
                : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }
}

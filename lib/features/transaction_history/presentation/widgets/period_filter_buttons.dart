import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocketly/core/core.dart';
import 'package:pocketly/features/transaction_history/domain/entities/transaction_period_entity.dart';
import 'package:pocketly/features/transaction_history/presentation/providers/transaction_history_providers.dart';
import 'package:pocketly/generated/l10n/app_localizations.dart';

/// Widget pour les boutons de filtre de période rapide
/// Style harmonisé avec PocketCategoryFilterButtons
class PeriodFilterButtons extends ConsumerWidget {
  const PeriodFilterButtons({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedPeriod = ref.watch(periodFilterControllerProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context)!;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingS,
        vertical: AppDimensions.paddingS,
      ),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.surface,
        borderRadius: BorderRadius.circular(AppDimensions.radiusL),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withValues(alpha: 0.2)
                : Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: _PeriodButton(
              label: l10n.today,
              isSelected: selectedPeriod.type == PeriodType.today,
              onTap: () {
                HapticFeedback.lightImpact();
                ref.read(periodFilterControllerProvider.notifier).selectToday();
              },
            ),
          ),
          SizedBox(width: AppDimensions.paddingS),
          Expanded(
            child: _PeriodButton(
              label: l10n.week,
              isSelected: selectedPeriod.type == PeriodType.week,
              onTap: () {
                HapticFeedback.lightImpact();
                ref.read(periodFilterControllerProvider.notifier).selectThisWeek();
              },
            ),
          ),
          SizedBox(width: AppDimensions.paddingS),
          Expanded(
            child: _PeriodButton(
              label: l10n.month,
              isSelected: selectedPeriod.type == PeriodType.month,
              onTap: () {
                HapticFeedback.lightImpact();
                ref.read(periodFilterControllerProvider.notifier).selectThisMonth();
              },
            ),
          ),
          SizedBox(width: AppDimensions.paddingS),
          Expanded(
            child: _PeriodButton(
              label: l10n.year,
              isSelected: selectedPeriod.type == PeriodType.year,
              onTap: () {
                HapticFeedback.lightImpact();
                ref.read(periodFilterControllerProvider.notifier).selectThisYear();
              },
            ),
          ),
        ],
      ),
    );
  }
}

/// Bouton de filtre individuel avec animation fluide
/// Style harmonisé avec _FilterButton de PocketCategoryFilterButtons
class _PeriodButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _PeriodButton({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        padding: EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingM,
          vertical: AppDimensions.paddingS,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withValues(alpha: 0.15)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        ),
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          style: AppTypography.small.copyWith(
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            color: isSelected
                ? AppColors.primary
                : (isDark
                    ? AppColors.textSecondaryOnDark
                    : AppColors.textSecondary),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}

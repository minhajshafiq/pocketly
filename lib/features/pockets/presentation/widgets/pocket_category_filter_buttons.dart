import 'package:flutter/material.dart';
import 'package:pocketly/core/core.dart';
import 'package:pocketly/features/pockets/domain/entities/pocket_entity.dart';
import 'package:pocketly/generated/l10n/app_localizations.dart';

/// Widget moderne pour les boutons de filtre de catégories de pockets
class PocketCategoryFilterButtons extends StatelessWidget {
  final PocketCategory? selectedCategory;
  final ValueChanged<PocketCategory?> onCategoryChanged;

  const PocketCategoryFilterButtons({
    super.key,
    required this.selectedCategory,
    required this.onCategoryChanged,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;

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
      child: Wrap(
        spacing: AppDimensions.paddingS,
        runSpacing: AppDimensions.paddingS,
        alignment: WrapAlignment.center,
        children: [
          _FilterButton(
            label: l10n.all,
            isSelected: selectedCategory == null,
            onTap: () => onCategoryChanged(null),
          ),
          _FilterButton(
            label: l10n.pocketCategoryNeeds,
            isSelected: selectedCategory == PocketCategory.needs,
            onTap: () => onCategoryChanged(PocketCategory.needs),
          ),
          _FilterButton(
            label: l10n.pocketCategoryWants,
            isSelected: selectedCategory == PocketCategory.wants,
            onTap: () => onCategoryChanged(PocketCategory.wants),
          ),
          _FilterButton(
            label: l10n.pocketCategorySavings,
            isSelected: selectedCategory == PocketCategory.savings,
            onTap: () => onCategoryChanged(PocketCategory.savings),
          ),
        ],
      ),
    );
  }
}

/// Bouton de filtre individuel avec animation fluide
class _FilterButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterButton({
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

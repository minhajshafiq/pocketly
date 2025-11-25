import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pocketly/core/core.dart';
import 'package:pocketly/features/transactions/domain/entities/transaction_entity.dart';
import 'package:pocketly/generated/l10n/app_localizations.dart';

/// Widget pour sélectionner le type de récurrence d'une transaction.
///
/// Affiche un sélecteur adaptatif (iOS/Android) avec toutes les options
/// de récurrence disponibles.
class RecurrenceSelector extends StatelessWidget {
  final RecurrenceType selectedRecurrence;
  final ValueChanged<RecurrenceType> onRecurrenceChanged;

  const RecurrenceSelector({
    super.key,
    required this.selectedRecurrence,
    required this.onRecurrenceChanged,
  });

  bool get _isIOS => Platform.isIOS;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: () => _showRecurrencePicker(context),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingM,
          vertical: AppDimensions.paddingS,
        ),
        decoration: BoxDecoration(
          color: isDark ? AppColors.surfaceDark : AppColors.surface,
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
          border: Border.all(
            color: isDark
                ? AppColors.textSecondaryOnDark.withValues(alpha: 0.3)
                : AppColors.textSecondary.withValues(alpha: 0.3),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                  selectedRecurrence.getName(l10n),
                  style: AppTypography.body.copyWith(
                    color: isDark ? AppColors.textOnDark : AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
            ),
            SizedBox(width: AppDimensions.paddingS),
            Icon(
              _isIOS ? CupertinoIcons.chevron_down : Icons.keyboard_arrow_down,
              color: isDark
                  ? AppColors.textSecondaryOnDark
                  : AppColors.textSecondary,
            ),
          ],
        ),
      ),
    );
  }

  void _showRecurrencePicker(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    if (_isIOS) {
      showCupertinoModalPopup(
        context: context,
        builder: (context) => _buildIOSPicker(context, l10n),
      );
    } else {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) => _buildAndroidPicker(context, l10n),
      );
    }
  }

  Widget _buildIOSPicker(BuildContext context, AppLocalizations l10n) {
    return Container(
      height: 250,
      color: CupertinoColors.systemBackground.resolveFrom(context),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: AppDimensions.paddingM),
            height: 44,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  child: Text(l10n.cancel),
                  onPressed: () => Navigator.pop(context),
                ),
                Text(
                  'Récurrence',
                  style: AppTypography.body.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  child: Text(l10n.okButton),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
          Expanded(
            child: CupertinoPicker(
              itemExtent: 44,
              scrollController: FixedExtentScrollController(
                initialItem: RecurrenceType.values.indexOf(selectedRecurrence),
              ),
              onSelectedItemChanged: (index) {
                onRecurrenceChanged(RecurrenceType.values[index]);
              },
              children: RecurrenceType.values
                  .map((type) => Center(
                        child: Text(
                          type.getName(l10n),
                          style: AppTypography.body,
                        ),
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAndroidPicker(BuildContext context, AppLocalizations l10n) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final itemCount = RecurrenceType.values.length;
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    // Calculer la hauteur nécessaire : header + (nombre d'items * hauteur d'un ListTile) + padding + safe area bottom + marge supplémentaire
    // Ajout de 60px supplémentaires pour éviter tout débordement
    final estimatedHeight = 80.0 + (itemCount * 56.0) + AppDimensions.paddingM * 2 + bottomPadding + 60.0;
    final maxHeight = MediaQuery.of(context).size.height * 0.9;
    final modalHeight = estimatedHeight < maxHeight ? estimatedHeight : maxHeight;

    return Container(
      height: modalHeight,
      decoration: BoxDecoration(
        color: isDark ? AppColors.backgroundDark : AppColors.background,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      child: SafeArea(
        bottom: true,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.all(AppDimensions.paddingM),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Récurrence',
                    style: AppTypography.heading.copyWith(
                      color: isDark ? AppColors.textOnDark : AppColors.textPrimary,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(
                      Icons.close,
                      color: isDark ? AppColors.textOnDark : AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
            ...RecurrenceType.values.map((type) {
              final isSelected = type == selectedRecurrence;
              return ListTile(
                title: Text(
                  type.getName(l10n),
                  style: AppTypography.body.copyWith(
                    color: isSelected
                        ? AppColors.primary
                        : (isDark ? AppColors.textOnDark : AppColors.textPrimary),
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
                trailing: isSelected
                    ? Icon(
                        Icons.check,
                        color: AppColors.primary,
                      )
                    : null,
                onTap: () {
                  onRecurrenceChanged(type);
                  Navigator.pop(context);
                },
              );
            }),
            SizedBox(height: AppDimensions.paddingM + bottomPadding + 20.0),
          ],
        ),
      ),
    );
  }
}

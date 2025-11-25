import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:pocketly/core/constants/app_colors.dart';
import 'package:pocketly/core/constants/app_dimensions.dart';
import 'package:pocketly/core/constants/app_typography.dart';

/// Enum pour le choix de modification d'une transaction récurrente
enum RecurrenceEditChoice {
  thisOccurrence,  // Modifier uniquement cette occurrence
  allOccurrences,  // Modifier toutes les occurrences
}

/// Modal pour choisir comment modifier une transaction récurrente
///
/// Affiche deux options :
/// - Modifier uniquement cette occurrence
/// - Modifier toutes les occurrences
class EditRecurrenceChoiceModal extends StatelessWidget {
  const EditRecurrenceChoiceModal({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (Platform.isIOS) {
      return _buildIOSModal(context, isDark);
    }
    return _buildAndroidModal(context, isDark);
  }

  /// Modal iOS avec style Cupertino
  Widget _buildIOSModal(BuildContext context, bool isDark) {
    return CupertinoAlertDialog(
      title: const Text('Modifier la transaction récurrente'),
      content: const Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: Text(
          'Cette transaction se répète. Comment souhaitez-vous la modifier ?',
        ),
      ),
      actions: [
        CupertinoDialogAction(
          onPressed: () => Navigator.of(context).pop(RecurrenceEditChoice.thisOccurrence),
          child: const Text('Uniquement cette occurrence'),
        ),
        CupertinoDialogAction(
          onPressed: () => Navigator.of(context).pop(RecurrenceEditChoice.allOccurrences),
          isDefaultAction: true,
          child: const Text('Toutes les occurrences'),
        ),
        CupertinoDialogAction(
          onPressed: () => Navigator.of(context).pop(null),
          isDestructiveAction: true,
          child: const Text('Annuler'),
        ),
      ],
    );
  }

  /// Modal Android avec Material Design
  Widget _buildAndroidModal(BuildContext context, bool isDark) {
    return AlertDialog(
      backgroundColor: isDark ? AppColors.surfaceDark : AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusL),
      ),
      title: Text(
        'Modifier la transaction récurrente',
        style: AppTypography.title.copyWith(
          color: isDark ? AppColors.textOnDark : AppColors.textPrimary,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Cette transaction se répète. Comment souhaitez-vous la modifier ?',
            style: AppTypography.body.copyWith(
              color: isDark
                  ? AppColors.textSecondaryOnDark
                  : AppColors.textSecondary,
            ),
          ),
          SizedBox(height: AppDimensions.paddingL),

          // Option 1 : Cette occurrence uniquement
          _buildOption(
            context,
            isDark,
            icon: Icons.edit_outlined,
            title: 'Uniquement cette occurrence',
            description: 'Modifie seulement cette transaction',
            onTap: () => Navigator.of(context).pop(RecurrenceEditChoice.thisOccurrence),
          ),

          SizedBox(height: AppDimensions.paddingM),

          // Option 2 : Toutes les occurrences
          _buildOption(
            context,
            isDark,
            icon: Icons.edit_calendar_outlined,
            title: 'Toutes les occurrences',
            description: 'Modifie cette transaction et toutes les futures',
            onTap: () => Navigator.of(context).pop(RecurrenceEditChoice.allOccurrences),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(null),
          child: Text(
            'Annuler',
            style: TextStyle(
              color: isDark ? AppColors.textSecondaryOnDark : AppColors.textSecondary,
            ),
          ),
        ),
      ],
    );
  }

  /// Construit une option cliquable
  Widget _buildOption(
    BuildContext context,
    bool isDark, {
    required IconData icon,
    required String title,
    required String description,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppDimensions.radiusM),
      child: Container(
        padding: EdgeInsets.all(AppDimensions.paddingM),
        decoration: BoxDecoration(
          color: isDark
              ? AppColors.surfaceDark.withValues(alpha: 0.5)
              : AppColors.surface,
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
          border: Border.all(
            color: isDark ? AppColors.borderDark : AppColors.borderLight,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(AppDimensions.paddingS),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(AppDimensions.radiusS),
              ),
              child: Icon(
                icon,
                color: AppColors.primary,
                size: 24,
              ),
            ),
            SizedBox(width: AppDimensions.paddingM),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTypography.body.copyWith(
                      color: isDark ? AppColors.textOnDark : AppColors.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: AppDimensions.paddingXS),
                  Text(
                    description,
                    style: AppTypography.small.copyWith(
                      color: isDark
                          ? AppColors.textSecondaryOnDark
                          : AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: isDark
                  ? AppColors.textSecondaryOnDark
                  : AppColors.textSecondary,
            ),
          ],
        ),
      ),
    );
  }
}

/// Affiche la modal de choix et retourne le choix de l'utilisateur
Future<RecurrenceEditChoice?> showEditRecurrenceChoiceModal(
  BuildContext context,
) async {
  return showDialog<RecurrenceEditChoice>(
    context: context,
    builder: (context) => const EditRecurrenceChoiceModal(),
  );
}

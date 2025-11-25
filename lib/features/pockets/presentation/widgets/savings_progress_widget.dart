import 'package:flutter/material.dart';
import 'package:pocketly/core/core.dart';
import 'package:pocketly/features/pockets/domain/entities/pocket_entity.dart';

/// Widget de progression pour l'épargne d'un pocket
///
/// Affiche visuellement la progression vers l'objectif d'épargne.
class SavingsProgressWidget extends StatelessWidget {
  final PocketEntity pocket;
  final double height;
  final bool showPercentage;

  const SavingsProgressWidget({
    super.key,
    required this.pocket,
    this.height = 8.0,
    this.showPercentage = true,
  });

  @override
  Widget build(BuildContext context) {
    assert(
      pocket.isSavingsPocket,
      'SavingsProgressWidget can only be used with savings pockets',
    );

    if (!pocket.hasSavingsGoal) {
      return const SizedBox.shrink();
    }

    final percentage = pocket.savingsGoalPercentage;
    final color = _getColorForPercentage(percentage);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(height / 2),
          child: LinearProgressIndicator(
            value: (percentage / 100).clamp(0.0, 1.0),
            backgroundColor: AppColors.getProgressBarBackground(isDark),
            valueColor: AlwaysStoppedAnimation<Color>(color),
            minHeight: height,
          ),
        ),
        if (showPercentage) ...[
          const SizedBox(height: 4),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              '${percentage.toStringAsFixed(1)}%',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: color,
              ),
            ),
          ),
        ],
      ],
    );
  }

  Color _getColorForPercentage(double percentage) {
    if (percentage < 50) {
      return Colors.orange;
    } else if (percentage < 100) {
      return Colors.blue;
    } else {
      return Colors.green;
    }
  }
}

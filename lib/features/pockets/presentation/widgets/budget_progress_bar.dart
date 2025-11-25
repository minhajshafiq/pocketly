import 'package:flutter/material.dart';
import 'package:pocketly/core/core.dart';
import 'package:pocketly/features/pockets/domain/entities/pocket_entity.dart';

/// Barre de progression pour le budget d'un pocket
///
/// Affiche visuellement le pourcentage du budget utilisé
/// avec des couleurs adaptées (vert, orange, rouge).
class BudgetProgressBar extends StatelessWidget {
  final PocketEntity pocket;
  final double height;
  final bool showPercentage;

  const BudgetProgressBar({
    super.key,
    required this.pocket,
    this.height = 8.0,
    this.showPercentage = true,
  });

  @override
  Widget build(BuildContext context) {
    assert(
      pocket.isExpensePocket,
      'BudgetProgressBar can only be used with expense pockets',
    );

    final percentage = pocket.budgetUsagePercentage;
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
    if (percentage < 80) {
      return Colors.green;
    } else if (percentage < 100) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }
}

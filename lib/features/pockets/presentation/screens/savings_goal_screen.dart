import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocketly/core/core.dart';

/// Écran de configuration d'objectif d'épargne
///
/// TODO: Implémenter la configuration d'objectifs avec :
/// - 3 options : Aucun / Montant fixe / Montant + Date
/// - Calcul automatique des recommandations
/// - Affichage de la progression
class SavingsGoalScreen extends ConsumerStatefulWidget {
  final String pocketId;

  const SavingsGoalScreen({
    super.key,
    required this.pocketId,
  });

  @override
  ConsumerState<SavingsGoalScreen> createState() => _SavingsGoalScreenState();
}

class _SavingsGoalScreenState extends ConsumerState<SavingsGoalScreen> {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.background,
      appBar: AdaptiveAppBar(
        title: 'Objectif d\'Épargne',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // TODO: Implement savings goal configuration
            const Center(
              child: Text(
                'Configuration d\'objectif à implémenter',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

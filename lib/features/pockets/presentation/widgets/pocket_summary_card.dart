import 'package:flutter/material.dart';
import 'package:pocketly/core/core.dart';
import 'package:pocketly/features/pockets/domain/entities/pocket_entity.dart';
import 'package:pocketly/features/pockets/domain/repositories/pocket_repository.dart';

/// Carte résumé pour une catégorie de pockets
///
/// Affiche les statistiques agrégées d'une catégorie.
class PocketSummaryCard extends StatelessWidget {
  final PocketCategory category;
  final PocketSummary summary;

  const PocketSummaryCard({
    super.key,
    required this.category,
    required this.summary,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _getCategoryName(),
              style: AppTypography.heading,
            ),
            const SizedBox(height: 8),
            Text(
              '${summary.pocketCount} pockets (${summary.activeCount} actifs)',
              style: AppTypography.body,
            ),
            // TODO: Add more summary stats
          ],
        ),
      ),
    );
  }

  String _getCategoryName() {
    return switch (category) {
      PocketCategory.needs => 'Besoins',
      PocketCategory.wants => 'Envies',
      PocketCategory.savings => 'Épargne',
    };
  }
}

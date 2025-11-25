import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:pocketly/core/core.dart';

/// Liste des fonctionnalités Premium
///
/// Affiche les avantages avec des icônes et des animations
class SubscriptionFeaturesList extends StatelessWidget {
  const SubscriptionFeaturesList({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final features = [
      _Feature(
        icon: Icons.bar_chart,
        title: 'Statistiques avancées',
        description: 'Analysez vos dépenses en profondeur',
      ),
      _Feature(
        icon: Icons.account_balance_wallet,
        title: 'Pockets illimités',
        description: 'Créez autant de pockets que vous voulez',
      ),
      _Feature(
        icon: Icons.file_download,
        title: 'Export de données',
        description: 'Exportez vos données en CSV ou PDF',
      ),
      _Feature(
        icon: Icons.support_agent,
        title: 'Support prioritaire',
        description: 'Assistance rapide et personnalisée',
      ),
      _Feature(
        icon: Icons.sync,
        title: 'Synchronisation cloud',
        description: 'Accédez à vos données partout',
      ),
      _Feature(
        icon: Icons.notifications_active,
        title: 'Rappels intelligents',
        description: 'Ne dépassez plus jamais votre budget',
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tout ce que vous obtenez :',
          style: AppTypography.heading.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        ...features.asMap().entries.map((entry) {
          final index = entry.key;
          final feature = entry.value;

          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: _FeatureItem(
              feature: feature,
              isDark: isDark,
            ).animate().fadeIn(
                  delay: (100 * index).ms,
                  duration: 300.ms,
                ).slideX(
                  begin: -0.2,
                  end: 0,
                  delay: (100 * index).ms,
                  duration: 300.ms,
                  curve: Curves.easeOut,
                ),
          );
        }),
      ],
    );
  }
}

class _FeatureItem extends StatelessWidget {
  final _Feature feature;
  final bool isDark;

  const _FeatureItem({
    required this.feature,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Icône avec cercle
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            feature.icon,
            color: AppColors.primary,
            size: 20,
          ),
        ),
        const SizedBox(width: 16),

        // Texte
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                feature.title,
                style: AppTypography.body.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                feature.description,
                style: AppTypography.small.copyWith(
                  color: isDark ? Colors.grey[400] : Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Feature {
  final IconData icon;
  final String title;
  final String description;

  _Feature({
    required this.icon,
    required this.title,
    required this.description,
  });
}

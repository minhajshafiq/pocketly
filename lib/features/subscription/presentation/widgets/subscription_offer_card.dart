import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:pocketly/core/core.dart';
import 'package:pocketly/features/subscription/domain/entities/subscription_offer_entity.dart';

/// Card pour afficher une offre d'abonnement
///
/// Design moderne avec badge "Meilleure valeur" pour yearly
class SubscriptionOfferCard extends StatelessWidget {
  final SubscriptionOfferEntity offer;
  final bool isSelected;
  final VoidCallback onTap;

  const SubscriptionOfferCard({
    super.key,
    required this.offer,
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
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? AppColors.primary
                : isDark
                    ? Colors.grey[800]!
                    : Colors.grey[300]!,
            width: isSelected ? 2 : 1,
          ),
          color: isSelected
              ? AppColors.primary.withValues(alpha: 0.1)
              : isDark
                  ? Colors.grey[900]
                  : Colors.white,
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
        ),
        padding: const EdgeInsets.all(20),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Titre avec icône
                Row(
                  children: [
                    Icon(
                      offer.type == SubscriptionOfferType.monthly
                          ? Icons.calendar_month
                          : Icons.calendar_today,
                      color: isSelected ? AppColors.primary : Colors.grey[600],
                      size: 24,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        offer.type == SubscriptionOfferType.monthly
                            ? 'Mensuel'
                            : 'Annuel',
                        style: AppTypography.heading.copyWith(
                          fontWeight: FontWeight.bold,
                          color: isSelected ? AppColors.primary : null,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Prix principal
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      offer.priceString,
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: isSelected ? AppColors.primary : null,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Text(
                        '/ ${offer.period}',
                        style: AppTypography.body.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                  ],
                ),

                // Prix mensuel équivalent pour yearly
                if (offer.monthlyEquivalentPrice != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    'Soit ${offer.monthlyEquivalentPrice} / mois',
                    style: AppTypography.small.copyWith(
                      color: Colors.grey[600],
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],

                // Économies
                if (offer.savingsPercentage != null && offer.savingsPercentage! > 0) ...[
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Colors.green.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Text(
                      'Économisez ${offer.savingsPercentage}%',
                      style: AppTypography.small.copyWith(
                        color: Colors.green[700],
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ],
            ),

            // Badge "Meilleure valeur"
            if (offer.isBestValue)
              Positioned(
                top: -10,
                right: -10,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFFFD700), Color(0xFFFFA500)],
                    ),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.orange.withValues(alpha: 0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.star,
                        size: 14,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Meilleure valeur',
                        style: AppTypography.small.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ).animate().scale(
                      duration: 300.ms,
                      curve: Curves.elasticOut,
                    ),
              ),

            // Icône de sélection
            if (isSelected)
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 16,
                  ),
                ).animate().scale(
                      duration: 200.ms,
                      curve: Curves.easeOut,
                    ),
              ),
          ],
        ),
      ),
    );
  }
}

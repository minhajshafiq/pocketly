import 'package:flutter/material.dart';
import 'package:pocketly/core/core.dart';
import 'package:pocketly/features/pockets/domain/entities/pocket_entity.dart';
import 'package:pocketly/features/currency/currency.dart';
import 'package:pocketly/generated/l10n/app_localizations.dart';

/// Carte affichant un pocket
///
/// Affiche les informations principales du pocket avec
/// une barre de progression pour le budget ou l'épargne.
class PocketCard extends StatelessWidget {
  final PocketEntity pocket;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final int transactionCount; // Nombre de transactions (à intégrer plus tard)

  const PocketCard({
    super.key,
    required this.pocket,
    this.onTap,
    this.onLongPress,
    this.transactionCount = 0, // Par défaut 0, à remplacer par le vrai comptage
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final pocketColor = Color(int.parse(pocket.color.replaceFirst('#', '0xFF')));
    final accentColor = pocketColor.withValues(alpha: 0.8); // Bleu clair pour les montants
    final textColor = isDark ? AppColors.textOnDark : AppColors.textPrimary;
    final secondaryTextColor = isDark
        ? AppColors.textSecondaryOnDark
        : AppColors.textSecondary;

    return AppCard(
      onTap: onTap,
      padding: EdgeInsets.all(AppDimensions.paddingM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          // Header avec icône, titre et montants
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
      children: [
              // Icône dans un carré arrondi avec fond coloré
        Container(
                width: 48,
                height: 48,
          decoration: BoxDecoration(
                  color: accentColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            _getIconData(),
                  color: accentColor,
            size: 24,
          ),
        ),
              SizedBox(width: AppDimensions.paddingM),

              // Titre et sous-titre
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                      pocket.getName(l10n),
                      style: AppTypography.bodyBold.copyWith(
                        color: textColor,
                      ),
                      maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
                    SizedBox(height: 4),
                // Pour les pockets d'épargne, ne pas afficher le nombre de transactions
                if (pocket.isExpensePocket)
                Text(
                      transactionCount == 0 
                          ? '0 transaction' 
                          : '$transactionCount transaction${transactionCount > 1 ? 's' : ''}',
                      style: AppTypography.caption.copyWith(
                        color: secondaryTextColor,
                  ),
                ),
            ],
          ),
        ),

              // Montants à droite
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
      children: [
                  // Montant actuel avec icône d'avertissement si dépassé
        Row(
                    mainAxisSize: MainAxisSize.min,
          children: [
            CurrencyDisplayWidget(
                        amount: pocket.isExpensePocket ? pocket.spent : pocket.savedAmount,
                        style: AppTypography.bodyBold.copyWith(
                          color: pocket.isExpensePocket && pocket.isBudgetExceeded
                              ? AppColors.error
                              : accentColor,
                        ),
                      ),
                      // Icône d'avertissement si budget dépassé
                      if (pocket.isExpensePocket && pocket.isBudgetExceeded) ...[
                        SizedBox(width: 4),
                        Icon(
                          AppIcons.warning,
                          size: 16,
                          color: AppColors.error,
                        ),
                      ],
                    ],
                  ),
                  SizedBox(height: 4),
                  // "sur X €" en gris clair
                  // Pour les dépenses : "sur budget €"
                  // Pour l'épargne avec objectif : "sur objectif €"
                  // Pour l'épargne sans objectif : rien
            Text(
                    pocket.isExpensePocket 
                        ? 'sur ${pocket.budget.toStringAsFixed(0)} €'
                        : (pocket.targetAmount != null && pocket.targetAmount! > 0
                            ? 'sur ${pocket.targetAmount!.toStringAsFixed(0)} €'
                            : ''),
                    style: AppTypography.caption.copyWith(
                      color: secondaryTextColor,
              ),
            ),
          ],
            ),
          ],
        ),

          SizedBox(height: AppDimensions.paddingL),
          
          // Section Progression
          // Toujours affichée pour les pockets de dépenses
          // Toujours affichée pour les pockets d'épargne (même sans objectif)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Label "Progression"
              Text(
                'Progression',
                style: AppTypography.small.copyWith(
                  fontWeight: FontWeight.w600,
                  color: textColor,
                ),
              ),
              
                  // Pourcentage en bleu clair (affiché seulement si on a un objectif pour l'épargne)
                  if (pocket.isExpensePocket || (pocket.category == PocketCategory.savings && pocket.targetAmount != null && pocket.targetAmount! > 0))
              Text(
                '${_getProgressPercentage().toStringAsFixed(0)}%',
                style: AppTypography.small.copyWith(
                  color: accentColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          
          SizedBox(height: AppDimensions.paddingS),
          
          // Barre de progression
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: (_getProgressPercentage() / 100).clamp(0.0, 1.0),
              backgroundColor: AppColors.getProgressBarBackground(isDark),
              valueColor: AlwaysStoppedAnimation<Color>(accentColor),
              minHeight: 8,
            ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Calcule le pourcentage de progression
  double _getProgressPercentage() {
    if (pocket.isExpensePocket) {
      // Pour les dépenses : (dépensé / budget) * 100
      if (pocket.budget == 0) return 0.0;
      return ((pocket.spent / pocket.budget) * 100).clamp(0.0, 100.0);
    } else {
      // Pour l'épargne : (épargné / objectif) * 100
      if (pocket.targetAmount == null || pocket.targetAmount == 0) {
        return 0.0;
      }
      return ((pocket.savedAmount / pocket.targetAmount!) * 100).clamp(0.0, 100.0);
    }
  }

  IconData _getIconData() {
    // Utilise la méthode utilitaire centralisée pour convertir le code d'icône
    return AppIcons.getPocketIcon(pocket.icon);
  }
}

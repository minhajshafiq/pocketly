import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pocketly/core/constants/app_colors.dart';
import 'package:pocketly/core/constants/app_dimensions.dart';
import 'package:pocketly/core/constants/app_typography.dart';
import 'package:pocketly/core/widgets/app_card.dart';
import 'package:intl/intl.dart';
import 'package:pocketly/features/currency/currency.dart';
import 'package:pocketly/features/transactions/transactions.dart';

/// Widget pour afficher une carte de transaction individuelle
class TransactionCard extends StatelessWidget {
  final TransactionEntity transaction;
  final VoidCallback? onTap;

  const TransactionCard({
    required this.transaction,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isExpense = transaction.type == TransactionType.expense;

    return AppCard(
      onTap: () {
        if (onTap != null) {
          HapticFeedback.lightImpact();
          onTap!();
        }
      },
      padding: EdgeInsets.all(AppDimensions.paddingM),
      child: Row(
        children: [
          // Icône de catégorie
          _buildCategoryIcon(isDark),

          SizedBox(width: AppDimensions.paddingM),

          // Informations de la transaction
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Nom de la transaction
                Text(
                  transaction.name,
                  style: AppTypography.body.copyWith(
                    color: isDark ? AppColors.textOnDark : AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),

                SizedBox(height: AppDimensions.paddingXS),

                // Date formatée
                Text(
                  _formatDate(transaction.date),
                  style: AppTypography.caption.copyWith(
                    color: isDark
                        ? AppColors.textSecondaryOnDark
                        : AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(width: AppDimensions.paddingM),

          // Montant avec devise
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                isExpense ? '-' : '+',
                style: AppTypography.body.copyWith(
                  color: isExpense ? AppColors.error : AppColors.success,
                  fontWeight: FontWeight.bold,
                ),
              ),
              CurrencyDisplayWidget(
                amount: transaction.amount,
                style: AppTypography.body.copyWith(
                  color: isExpense ? AppColors.error : AppColors.success,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Construit l'icône de catégorie avec couleur ou l'image de la transaction
  Widget _buildCategoryIcon(bool isDark) {
    final isExpense = transaction.type == TransactionType.expense;
    final backgroundColor = isExpense
        ? AppColors.error.withValues(alpha: 0.2)
        : AppColors.success.withValues(alpha: 0.2);
    final iconColor = isExpense ? AppColors.error : AppColors.success;

    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
      ),
      child: ClipOval(
        child: transaction.imageUrl != null && transaction.imageUrl!.isNotEmpty
            ? Image.network(
                transaction.imageUrl!,
                fit: BoxFit.cover,
                width: 40,
                height: 40,
                errorBuilder: (context, error, stackTrace) {
                  // En cas d'erreur, afficher l'icône par défaut
                  return Center(
                    child: Icon(
                      isExpense ? Icons.arrow_upward : Icons.arrow_downward,
                      color: iconColor,
                      size: 20,
                    ),
                  );
                },
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    ),
                  );
                },
              )
            : Center(
                child: Icon(
                  isExpense ? Icons.arrow_upward : Icons.arrow_downward,
                  color: iconColor,
                  size: 20,
                ),
              ),
      ),
    );
  }

  /// Formate la date en format lisible - affiche uniquement l'heure
  String _formatDate(DateTime date) {
    return DateFormat.Hm().format(date);
  }

}

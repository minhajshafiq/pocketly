import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:pocketly/core/constants/app_colors.dart';
import 'package:pocketly/core/constants/app_dimensions.dart';
import 'package:pocketly/core/constants/app_typography.dart';
import 'package:pocketly/core/widgets/app_card.dart';
import 'package:pocketly/features/transactions/domain/entities/transaction_entity.dart';
import 'package:pocketly/generated/l10n/app_localizations.dart';
import 'package:pocketly/features/category/category.dart';
import 'package:pocketly/features/currency/currency.dart';

/// Widget d'en-tête pour les détails d'une transaction
/// Affiche le nom, le montant, la date et l'icône de catégorie
class TransactionDetailHeader extends ConsumerWidget {
  final TransactionEntity transaction;

  const TransactionDetailHeader({
    required this.transaction,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final category = ref.watch(categoryByIdProvider(transaction.categoryId));

    return AppCard(
      padding: EdgeInsets.all(AppDimensions.paddingL),
      child: Column(
        children: [
          // Image de transaction ou icône de catégorie
          Container(
            width: AppDimensions.iconXXL,
            height: AppDimensions.iconXXL,
            decoration: BoxDecoration(
              color: Color(int.parse('0xFF${category?.color.substring(1) ?? '6B5FF7'}')).withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: ClipOval(
              child: transaction.imageUrl != null && transaction.imageUrl!.isNotEmpty
                  ? Image.network(
                      transaction.imageUrl!,
                      fit: BoxFit.cover,
                      width: AppDimensions.iconXXL,
                      height: AppDimensions.iconXXL,
                      errorBuilder: (context, error, stackTrace) {
                        // En cas d'erreur, afficher l'icône de catégorie
                        return Center(
                          child: Text(
                            category?.iconName ?? '💰',
                            style: const TextStyle(fontSize: 40),
                          ),
                        );
                      },
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: SizedBox(
                            width: 32,
                            height: 32,
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
              child: Text(
                category?.iconName ?? '💰',
                style: const TextStyle(fontSize: 40),
                      ),
              ),
            ),
          ),

          SizedBox(height: AppDimensions.paddingM),

          // Nom de la transaction
          Text(
            transaction.name,
            style: AppTypography.heading.copyWith(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: isDark ? AppColors.textOnDark : AppColors.textPrimary,
            ),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: AppDimensions.paddingS),

          // Nom de la catégorie
          if (category != null)
            Text(
              category.name,
              style: AppTypography.body.copyWith(
                color: isDark ? AppColors.textSecondaryOnDark : AppColors.textSecondary,
              ),
            ),

          SizedBox(height: AppDimensions.paddingM),

          // Montant
          CurrencyDisplayWidget(
            amount: transaction.amount,
            style: AppTypography.heading.copyWith(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: transaction.isExpense ? AppColors.error : AppColors.success,
            ),
            decimals: 2,
          ),

          SizedBox(height: AppDimensions.paddingM),

          // Date
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: AppDimensions.paddingM,
              vertical: AppDimensions.paddingS,
            ),
            decoration: BoxDecoration(
              color: isDark
                  ? AppColors.surfaceDark
                  : AppColors.surface,
              borderRadius: BorderRadius.circular(AppDimensions.radiusS),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.calendar_today,
                  size: 16,
                  color: isDark ? AppColors.textSecondaryOnDark : AppColors.textSecondary,
                ),
                SizedBox(width: AppDimensions.paddingS),
                Text(
                  () {
                    final formatted = DateFormat('EEEE dd MMMM yyyy', 'fr_FR').format(transaction.date);
                    // Capitaliser le mois en français
                    final parts = formatted.split(' ');
                    if (parts.length >= 4) {
                      // Format: "lundi 15 novembre 2024" - le mois est à l'index 2
                      parts[2] = parts[2][0].toUpperCase() + parts[2].substring(1);
                      return parts.join(' ');
                    }
                    return formatted;
                  }(),
                  style: AppTypography.body.copyWith(
                    color: isDark ? AppColors.textOnDark : AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),

          // Badge de récurrence si applicable
          if (transaction.isRecurring) ...[
            SizedBox(height: AppDimensions.paddingM),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: AppDimensions.paddingM,
                vertical: AppDimensions.paddingS,
              ),
              decoration: BoxDecoration(
                color: AppColors.info.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(AppDimensions.radiusS),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.repeat,
                    size: 16,
                    color: AppColors.info,
                  ),
                  SizedBox(width: AppDimensions.paddingS),
                  Text(
                    l10n.recurringTransaction,
                    style: AppTypography.caption.copyWith(
                      color: AppColors.info,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

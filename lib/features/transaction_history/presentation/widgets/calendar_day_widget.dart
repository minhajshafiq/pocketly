import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pocketly/core/constants/app_colors.dart';
import 'package:pocketly/core/constants/app_dimensions.dart';
import 'package:pocketly/core/constants/app_typography.dart';
import 'package:pocketly/features/transaction_history/domain/entities/calendar_day_entity.dart';

/// Widget pour afficher un jour dans le calendrier
class CalendarDayWidget extends StatelessWidget {
  final CalendarDayEntity day;
  final VoidCallback onTap;

  const CalendarDayWidget({
    required this.day,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        onTap();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutCubic,
        width: double.infinity,
        height: 52,
        constraints: const BoxConstraints(
          minHeight: 52,
          maxHeight: 52,
        ),
        decoration: BoxDecoration(
          gradient: day.isSelected
              ? LinearGradient(
                  colors: [AppColors.primary, AppColors.secondary],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
          color: day.isSelected
              ? null
              : day.isToday
                  ? AppColors.primary.withValues(alpha: 0.1)
                  : isDark
                      ? AppColors.surfaceDark
                      : AppColors.surface,
          borderRadius: BorderRadius.circular(26), // Forme de pilule (hauteur/2)
          border: Border.all(
            color: day.isToday
                ? AppColors.primary
                : day.isSelected
                    ? AppColors.primary
                    : isDark
                        ? AppColors.borderDark
                        : AppColors.borderLight,
            width: day.isToday || day.isSelected ? 2 : 1,
          ),
          boxShadow: day.isSelected
              ? [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.25),
                    blurRadius: 12,
                    spreadRadius: 0,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [],
        ),
        child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppDimensions.paddingXS,
              vertical: 4,
            ),
            child: Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                // Contenu principal
                Column(
            mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
            children: [
              // Numéro du jour
                    Flexible(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                '${day.date.day}',
                          style: AppTypography.bodyBold.copyWith(
                            fontSize: AppDimensions.fontSizeM,
                  color: day.isSelected
                      ? Colors.white
                      : day.isToday
                          ? AppColors.primary
                          : day.isCurrentMonth
                              ? isDark
                                  ? AppColors.textOnDark
                                  : AppColors.textPrimary
                              : isDark
                                  ? AppColors.textSecondaryOnDark.withValues(alpha: 0.5)
                                  : AppColors.textSecondary.withValues(alpha: 0.5),
                  fontWeight: day.isToday || day.isSelected
                      ? FontWeight.bold
                                : FontWeight.w600,
                            height: 1.1,
                          ),
                        ),
                ),
              ),
              if (day.hasTransactions) ...[
                      SizedBox(height: 2),
                      _buildTransactionBubbles(isDark),
                    ],
                  ],
                ),
            ],
            ),
          ),
        ),
      );
  }

  /// Construit les bulles d'icônes de transactions
  Widget _buildTransactionBubbles(bool isDark) {
    final transactions = day.transactions;
    final transactionCount = day.transactionCount;

    if (transactions.isEmpty) return const SizedBox.shrink();

    // Si 1 transaction : afficher 1 bulle
    if (transactionCount == 1) {
      return _buildSingleBubble(transactions[0], isDark);
    }

    // Si 2 transactions : afficher 2 bulles
    if (transactionCount == 2 && transactions.length >= 2) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: _buildSingleBubble(transactions[0], isDark),
          ),
          SizedBox(width: 2),
          Flexible(
            child: _buildSingleBubble(transactions[1], isDark),
          ),
        ],
      );
    }

    // Si 3+ transactions : afficher la première bulle + bulle "+N"
    if (transactionCount >= 3) {
      final extraCount = transactionCount - 1;
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: _buildSingleBubble(transactions[0], isDark),
          ),
          SizedBox(width: 2),
          Flexible(
            child: _buildCountBubble(extraCount, isDark),
          ),
        ],
      );
    }

    return const SizedBox.shrink();
  }

  /// Construit une bulle unique pour une transaction
  Widget _buildSingleBubble(CalendarTransactionItem transaction, bool isDark) {
    final isExpense = transaction.type == 'expense';
    final borderColor = isExpense ? AppColors.error : AppColors.success;
    final backgroundColor = day.isSelected
        ? Colors.white.withValues(alpha: 0.2)
        : (isExpense ? AppColors.error : AppColors.success).withValues(alpha: 0.15);

    return Container(
      width: 16,
      height: 16,
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
        border: Border.all(
          color: day.isSelected ? Colors.white : borderColor,
          width: 2,
        ),
      ),
      child: ClipOval(
        child: transaction.imageUrl != null && transaction.imageUrl!.isNotEmpty
            ? Image.network(
                transaction.imageUrl!,
                fit: BoxFit.cover,
                width: 16,
                height: 16,
                errorBuilder: (context, error, stackTrace) {
                  return Center(
                    child: Icon(
                      isExpense ? Icons.arrow_upward : Icons.arrow_downward,
                      size: 10,
                      color: day.isSelected ? Colors.white : borderColor,
                    ),
                  );
                },
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: SizedBox(
                      width: 8,
                      height: 8,
                      child: CircularProgressIndicator(
                        strokeWidth: 1.5,
                        color: day.isSelected ? Colors.white : borderColor,
                      ),
                    ),
                  );
                },
              )
            : Center(
                child: Icon(
                  isExpense ? Icons.arrow_upward : Icons.arrow_downward,
                  size: 10,
                  color: day.isSelected ? Colors.white : borderColor,
                ),
              ),
      ),
    );
  }

  /// Construit une bulle "+N" pour les transactions supplémentaires
  Widget _buildCountBubble(int count, bool isDark) {
    return Container(
      width: 16,
      height: 16,
      decoration: BoxDecoration(
        color: day.isSelected
            ? Colors.white.withValues(alpha: 0.25)
            : AppColors.primary,
        shape: BoxShape.circle,
        border: Border.all(
          color: day.isSelected ? Colors.white : AppColors.primary,
          width: 2,
        ),
      ),
      child: Center(
        child: Text(
          '+$count',
          style: AppTypography.caption.copyWith(
            fontSize: 8,
            color: day.isSelected ? Colors.white : Colors.white,
            fontWeight: FontWeight.bold,
            height: 1.0,
          ),
        ),
      ),
    );
  }
}

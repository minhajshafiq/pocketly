import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocketly/core/core.dart';
import 'package:pocketly/features/currency/currency.dart';
import 'package:pocketly/features/pockets/domain/entities/pocket_entity.dart';
import 'package:pocketly/features/pockets/presentation/providers/pocket_providers.dart';
import 'package:pocketly/features/pockets/presentation/widgets/edit_budget_rule_modal.dart';
import 'package:pocketly/generated/l10n/app_localizations.dart';
import 'package:pocketly/features/user/user.dart';

/// Widget affichant la règle 50/30/20 avec les catégories Besoins, Envies et Épargne
///
/// Affiche pour chaque catégorie :
/// - L'icône et le nom
/// - Le montant dépensé/épargné et le budget
/// - Le pourcentage recommandé
/// - Une barre de progression
class Rule502030Widget extends ConsumerWidget {
  const Rule502030Widget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final totalIncome = ref.watch(totalIncomeProvider);
    final pocketsAsync = ref.watch(userPocketsProvider);
    final userAsync = ref.watch(currentUserProvider);

    // Gérer les deux AsyncValues pour que le widget se rebuild dans tous les cas
    return userAsync.when(
      loading: () => _buildLoadingState(),
      error: (error, stack) => _buildErrorState(error),
      data: (user) {
        if (user == null) {
          return _buildLoadingState();
        }
        
        return pocketsAsync.when(
          data: (pockets) {
            // Récupérer la règle budgétaire personnalisée de l'utilisateur
            // Utiliser directement les valeurs de l'utilisateur (pas de ?? car user n'est pas null)
            final needsPercentage = user.budgetRuleNeedsPercentage;
            final wantsPercentage = user.budgetRuleWantsPercentage;
            final savingsPercentage = user.budgetRuleSavingsPercentage;

            // Debug: Vérifier les valeurs récupérées
            ref.read(loggerProvider).d('User ID: ${user.id}');
            ref.read(loggerProvider).d('Règle brute: ${user.budgetRuleNeeds}/${user.budgetRuleWants}/${user.budgetRuleSavings}');
            ref.read(loggerProvider).d('Pourcentages calculés: needs=$needsPercentage, wants=$wantsPercentage, savings=$savingsPercentage');
            ref.read(loggerProvider).d('Pourcentages en int: needs=${(needsPercentage * 100).toInt()}%, wants=${(wantsPercentage * 100).toInt()}%, savings=${(savingsPercentage * 100).toInt()}%');

          // Calculer les totaux par catégorie
          final needsPockets = pockets.needs;
          final wantsPockets = pockets.wants;
          final savingsPockets = pockets.savings;

          // Calculer les montants recommandés selon la règle budgétaire personnalisée
          final needsRecommended = totalIncome * needsPercentage;
          final wantsRecommended = totalIncome * wantsPercentage;
          final savingsRecommended = totalIncome * savingsPercentage;

          // Calculer les montants réels dépensés/épargnés
          final needsSpent = needsPockets.fold(0.0, (sum, p) => sum + p.spent);
          final wantsSpent = wantsPockets.fold(0.0, (sum, p) => sum + p.spent);
          final savingsSaved = savingsPockets.fold(0.0, (sum, p) => sum + p.savedAmount);

          // Titre de la règle personnalisée
          final ruleTitle = user.isDefaultBudgetRule
              ? 'Règle 50/30/20'
              : 'Règle ${user.budgetRuleNeeds}/${user.budgetRuleWants}/${user.budgetRuleSavings}';

          return AppCard(
            padding: EdgeInsets.all(AppDimensions.paddingM),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header avec titre, icône et bouton d'édition
                Row(
                  children: [
                    Icon(
                      AppIcons.budget,
                      size: 18,
                      color: isDark
                          ? AppColors.textSecondaryOnDark
                          : AppColors.textSecondary,
                    ),
                    SizedBox(width: AppDimensions.paddingS),
                    Text(
                      ruleTitle,
                      style: AppTypography.small.copyWith(
                        fontWeight: FontWeight.w600,
                        color: isDark
                            ? AppColors.textSecondaryOnDark
                            : AppColors.textSecondary,
                      ),
                    ),
                    const Spacer(),
                    // Bouton pour modifier la règle
                    InkWell(
                      onTap: () => _showEditBudgetRuleModal(context, ref, user!),
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        padding: EdgeInsets.all(AppDimensions.paddingXS),
                        child: Icon(
                          AppIcons.edit,
                          size: 16,
                          color: isDark
                              ? AppColors.textSecondaryOnDark
                              : AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: AppDimensions.paddingL),
                // Section Besoins
                _buildCategorySection(
                  context: context,
                  isDark: isDark,
                  category: PocketCategory.needs,
                  spent: needsSpent,
                  budget: needsRecommended,
                  recommended: needsRecommended,
                  percentage: (needsPercentage * 100).toInt(), // Pourcentage personnalisé
                  isEmpty: needsPockets.isEmpty,
                ),
                SizedBox(height: AppDimensions.paddingL),
                // Section Envies
                _buildCategorySection(
                  context: context,
                  isDark: isDark,
                  category: PocketCategory.wants,
                  spent: wantsSpent,
                  budget: wantsRecommended,
                  recommended: wantsRecommended,
                  percentage: (wantsPercentage * 100).toInt(), // Pourcentage personnalisé
                  isEmpty: wantsPockets.isEmpty,
                ),
                SizedBox(height: AppDimensions.paddingL),
                // Section Épargne
                _buildCategorySection(
                  context: context,
                  isDark: isDark,
                  category: PocketCategory.savings,
                  spent: savingsSaved,
                  budget: savingsRecommended,
                  recommended: savingsRecommended,
                  percentage: (savingsPercentage * 100).toInt(), // Pourcentage personnalisé
                  isEmpty: savingsPockets.isEmpty,
                  isSavings: true,
                ),
              ],
            ),
          );
        },
        loading: () => _buildLoadingState(),
        error: (error, stack) => _buildErrorState(error),
      );
      },
    );
  }

  Widget _buildCategorySection({
    required BuildContext context,
    required bool isDark,
    required PocketCategory category,
    required double spent,
    required double budget,
    required double recommended,
    required int percentage, // Pourcentage personnalisé de l'utilisateur
    required bool isEmpty,
    bool isSavings = false,
  }) {
    final l10n = AppLocalizations.of(context)!;
    final categoryColor = Color(
      int.parse(category.primaryColor.replaceFirst('#', '0xFF')),
    );
    final categoryName = category.getName(l10n);
    // Calculer le pourcentage de progression réel (spent / budget recommandé)
    // Le budget est maintenant le montant recommandé selon la règle 50/30/20
    final progress = budget > 0 ? (spent / budget).clamp(0.0, 1.0) : 0.0;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppDimensions.paddingS),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header de la catégorie
          Row(
            children: [
              // Icône
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: categoryColor.withValues(alpha: 0.3),
                    width: 1.5,
                  ),
                ),
                child: Icon(
                  _getCategoryIcon(category),
                  size: 18,
                  color: categoryColor,
                ),
              ),
              SizedBox(width: AppDimensions.paddingS),
            // Nom de la catégorie
            Text(
              categoryName,
              style: AppTypography.small.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            // Badge "Dépassement" si budget dépassé (pour needs et wants uniquement)
            if (!isSavings && spent > budget)
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: AppDimensions.paddingXS,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: AppColors.error.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      AppIcons.warning,
                      size: 15,
                      color: AppColors.error,
                    ),
                    SizedBox(width: 5),
                    Text(
                      'Dépassement',
                      style: AppTypography.caption.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.error,
                      ),
                    ),
                  ],
                ),
              )
            // Bouton info avec "Vide" si vide (seulement si pas de dépassement)
            else if (isEmpty)
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: AppDimensions.paddingXS,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: isDark
                      ? AppColors.surfaceDark
                      : AppColors.surfaceVariant,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      AppIcons.info,
                      size: 13,
                      color: isDark
                          ? AppColors.textSecondaryOnDark
                          : AppColors.textSecondary,
                    ),
                    SizedBox(width: 5),
                    Text(
                      'Vide',
                      style: AppTypography.caption.copyWith(
                        color: isDark
                            ? AppColors.textSecondaryOnDark
                            : AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
        SizedBox(height: AppDimensions.paddingM),
        // Barre de progression
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: progress.clamp(0.0, 1.0),
            minHeight: 6,
            backgroundColor: AppColors.getProgressBarBackground(isDark),
            valueColor: AlwaysStoppedAnimation<Color>(categoryColor),
          ),
        ),
        SizedBox(height: AppDimensions.paddingM),
        // Montants et pourcentage de la règle
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Montant dépensé/épargné et budget avec icône d'avertissement si dépassé
            Row(
              children: [
                Icon(
                  AppIcons.wallet,
                  size: 14,
                  color: isDark
                      ? AppColors.textSecondaryOnDark
                      : AppColors.textSecondary,
                ),
                SizedBox(width: 6),
                CurrencyAmountText(
                  amount: spent,
                  style: AppTypography.small.copyWith(
                    fontWeight: FontWeight.w600,
                    color: !isSavings && spent > budget
                        ? AppColors.error
                        : null,
                  ),
                  decimals: 0,
                ),
                Text(
                  ' / ',
                  style: AppTypography.small.copyWith(
                    color: isDark
                        ? AppColors.textSecondaryOnDark
                        : AppColors.textSecondary,
                  ),
                ),
                CurrencyAmountText(
                  amount: budget,
                  style: AppTypography.small.copyWith(
                    color: isDark
                        ? AppColors.textSecondaryOnDark
                        : AppColors.textSecondary,
                  ),
                  decimals: 0,
                ),
                // Icône d'avertissement si budget dépassé (pour needs et wants uniquement)
                if (!isSavings && spent > budget) ...[
                  SizedBox(width: 6),
                  Icon(
                    AppIcons.warning,
                    size: 14,
                    color: AppColors.error,
                  ),
                ],
              ],
            ),
            // Pourcentage de la règle (50%, 30%, 20%)
            Row(
              children: [
                Text(
                  '$percentage%',
                  style: AppTypography.small.copyWith(
                    color: categoryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(width: 6),
                Icon(
                  AppIcons.flag,
                  size: 14,
                  color: categoryColor,
                ),
              ],
            ),
          ],
        ),
        ],
      ),
    );
  }

  IconData _getCategoryIcon(PocketCategory category) {
    return switch (category) {
      PocketCategory.needs => AppIcons.home,
      PocketCategory.wants => AppIcons.favorite,
      PocketCategory.savings => AppIcons.savings,
    };
  }

  Widget _buildLoadingState() {
    return AppCard(
      padding: EdgeInsets.all(AppDimensions.paddingM),
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildErrorState(Object error) {
    return AppCard(
      padding: EdgeInsets.all(AppDimensions.paddingM),
      child: Center(
        child: Text(
          'Erreur: $error',
          style: AppTypography.body.copyWith(color: AppColors.error),
        ),
      ),
    );
  }

  /// Affiche la modale pour modifier la règle budgétaire
  void _showEditBudgetRuleModal(BuildContext context, WidgetRef ref, UserEntity user) {
    showEditBudgetRuleModal(context, user);
  }
}


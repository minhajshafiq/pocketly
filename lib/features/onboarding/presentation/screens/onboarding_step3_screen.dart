import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pocketly/core/core.dart';
import 'package:pocketly/core/widgets/animated_page_header.dart';
import 'package:pocketly/generated/l10n/app_localizations.dart';
import 'package:pocketly/features/onboarding/onboarding.dart';
import 'package:pocketly/features/pockets/pockets.dart';
import 'package:pocketly/features/user/user.dart';

/// Écran d'onboarding - Étape 3 : Première dépense
///
/// Permet à l'utilisateur d'ajouter sa première dépense pour découvrir l'app
class OnboardingStep3Screen extends ConsumerStatefulWidget {
  const OnboardingStep3Screen({super.key});

  @override
  ConsumerState<OnboardingStep3Screen> createState() =>
      _OnboardingStep3ScreenState();
}

class _OnboardingStep3ScreenState
    extends ConsumerState<OnboardingStep3Screen> {
  static const int _totalSteps = 4;
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  ExpenseCategory _selectedCategory = ExpenseCategory.needs;
  bool _showValidationError = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _amountController.dispose();
    _nameController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final isIOS = Platform.isIOS;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.background,
      body: PlatformSafeArea(
        top: true,
        bottom: false,
        padding: EdgeInsets.only(top: AppDimensions.paddingS),
        child: Stack(
          children: [
            // Contenu scrollable
            SingleChildScrollView(
              controller: _scrollController,
                physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.only(
                top: 80, // Espace pour le header
                left: AppDimensions.paddingL,
                right: AppDimensions.paddingL,
                bottom: AppDimensions.paddingL,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildProgressIndicator(isDark),
                    SizedBox(height: AppDimensions.paddingXL),
                    _buildTitle(isDark),
                    SizedBox(height: AppDimensions.paddingS),
                    _buildSubtitle(isDark),
                    SizedBox(height: AppDimensions.paddingXL),
                  _buildNameInput(isDark),
                  SizedBox(height: AppDimensions.paddingL),
                  _buildAmountInput(isDark),
                  SizedBox(height: AppDimensions.paddingL),
                  _buildQuickSuggestions(isDark),
                    SizedBox(height: AppDimensions.paddingL),
                    _buildCategorySelector(isDark),
                    SizedBox(height: AppDimensions.paddingM),
                    _buildHelperText(isDark),
                    if (_showValidationError)
                      Padding(
                        padding: EdgeInsets.only(top: AppDimensions.paddingS),
                        child: _buildErrorMessage()
                            .animate()
                            .fadeIn(duration: 200.ms)
                            .slideY(begin: -0.1, end: 0),
                      ),
                  SizedBox(height: AppDimensions.paddingXL),
                  SizedBox(
                    width: double.infinity,
                    child: _buildBottomActions(context, isIOS),
                  ),
                  SizedBox(height: AppDimensions.paddingXL),
                ],
              ),
            ),

            // Header sticky animé
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: AnimatedPageHeader(
                title: AppLocalizations.of(context)!.onboardingStepProgress(3, _totalSteps),
                scrollController: _scrollController,
                showBackButton: true,
                actionButton: _buildSkipButton(isDark, isIOS),
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildProgressIndicator(bool isDark) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.onboardingStepProgress(3, _totalSteps),
          style: AppTypography.caption.copyWith(
            color: isDark
                ? AppColors.textSecondaryOnDark
                : AppColors.textSecondary,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: AppDimensions.paddingXS),
        ClipRRect(
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
          child: LinearProgressIndicator(
            minHeight: 8,
            value: 3 / _totalSteps,
            backgroundColor: isDark ? AppColors.grey700 : AppColors.grey200,
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.success),
          ),
        ),
      ],
    );
  }

  Widget _buildTitle(bool isDark) {
    final l10n = AppLocalizations.of(context)!;
    return Text(
      l10n.onboardingStep3Title,
      style: AppTypography.heading.copyWith(
        color: isDark ? AppColors.textOnDark : AppColors.textPrimary,
        fontWeight: FontWeight.bold,
      ),
    )
        .animate()
        .fadeIn(duration: 400.ms)
        .slideY(begin: 0.1, end: 0, curve: Curves.easeOutCubic);
  }

  Widget _buildSubtitle(bool isDark) {
    final l10n = AppLocalizations.of(context)!;
    return Text(
      l10n.onboardingStep3Subtitle,
      style: AppTypography.body.copyWith(
        color: isDark
            ? AppColors.textSecondaryOnDark
            : AppColors.textSecondary,
      ),
    )
        .animate()
        .fadeIn(duration: 400.ms, delay: 100.ms)
        .slideY(begin: 0.1, end: 0, curve: Curves.easeOutCubic);
  }

  Widget _buildAmountInput(bool isDark) {
    final theme = Theme.of(context);
    final isDarkTheme = theme.brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context)!;
    
    return AppTextField(
      controller: _amountController,
      label: l10n.onboardingExpenseAmountLabel,
      hint: '0',
      type: AppTextFieldType.number,
      textInputAction: TextInputAction.next,
      suffixIcon: Padding(
        padding: EdgeInsets.only(right: AppDimensions.paddingM),
        child: Text(
          '€',
          style: AppTypography.body.copyWith(
            color: isDarkTheme
                ? AppColors.textSecondaryOnDark
                : AppColors.textSecondary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      onChanged: (_) {
        if (_showValidationError) {
          setState(() => _showValidationError = false);
        }
      },
    )
        .animate()
        .fadeIn(duration: 400.ms, delay: 300.ms)
        .slideY(begin: 0.1, end: 0, curve: Curves.easeOutCubic);
  }

  Widget _buildCategorySelector(bool isDark) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.onboardingCategoryLabel,
          style: AppTypography.title.copyWith(
            color: isDark ? AppColors.textOnDark : AppColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: AppDimensions.paddingM),
        _buildCategoryCard(
          icon: AppIcons.home,
          title: l10n.pocketCategoryNeeds,
          description: l10n.onboardingCategoryNeedsDescription,
          category: ExpenseCategory.needs,
          isDark: isDark,
        ),
        SizedBox(height: AppDimensions.paddingM),
        _buildCategoryCard(
          icon: AppIcons.favorite,
          title: l10n.pocketCategoryWants,
          description: l10n.onboardingCategoryWantsDescription,
          category: ExpenseCategory.wants,
          isDark: isDark,
        ),
        SizedBox(height: AppDimensions.paddingM),
        _buildCategoryCard(
          icon: AppIcons.savings,
          title: l10n.pocketCategorySavings,
          description: l10n.onboardingCategorySavingsDescription,
          category: ExpenseCategory.savings,
          isDark: isDark,
        ),
      ],
    )
        .animate()
        .fadeIn(duration: 400.ms, delay: 300.ms)
        .slideY(begin: 0.1, end: 0, curve: Curves.easeOutCubic);
  }

  Widget _buildQuickSuggestions(bool isDark) {
    final l10n = AppLocalizations.of(context)!;
    final suggestions = [
      _ExpenseSuggestion(
        label: l10n.onboardingSuggestionGroceries,
        amount: 20,
        category: ExpenseCategory.needs,
      ),
      _ExpenseSuggestion(
        label: l10n.onboardingSuggestionTransport,
        amount: 10,
        category: ExpenseCategory.needs,
      ),
      _ExpenseSuggestion(
        label: l10n.onboardingSuggestionSnacks,
        amount: 5,
        category: ExpenseCategory.wants,
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.onboardingQuickSuggestions,
          style: AppTypography.title.copyWith(
            color: isDark ? AppColors.textOnDark : AppColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: AppDimensions.paddingS),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.only(bottom: AppDimensions.paddingXS),
          child: Row(
            children: suggestions
                .map(
                  (suggestion) => Padding(
                    padding: EdgeInsets.only(right: AppDimensions.paddingS),
                    child: _buildSuggestionChip(suggestion, isDark),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    )
        .animate()
        .fadeIn(duration: 400.ms, delay: 320.ms)
        .slideY(begin: 0.1, end: 0, curve: Curves.easeOutCubic);
  }

  Widget _buildSuggestionChip(
    _ExpenseSuggestion suggestion,
    bool isDark,
  ) {
    final color = _expenseCategoryColor(suggestion.category);

    return GestureDetector(
      onTap: () => _applySuggestion(suggestion),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingM,
          vertical: AppDimensions.paddingS,
        ),
        decoration: BoxDecoration(
          color: color.withValues(alpha: isDark ? 0.25 : 0.12),
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
          border: Border.all(color: color.withValues(alpha: 0.4)),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.15),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(AppIcons.custom, color: color, size: 16),
                SizedBox(width: AppDimensions.paddingXS),
                Text(
                  suggestion.label,
                  style: AppTypography.body.copyWith(
                    color: isDark ? AppColors.textOnDark : AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(height: AppDimensions.paddingXS / 2),
            Text(
              '${suggestion.amount.toStringAsFixed(0)} €',
              style: AppTypography.caption.copyWith(
                color: color,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryCard({
    required IconData icon,
    required String title,
    required String description,
    required ExpenseCategory category,
    required bool isDark,
  }) {
    final isSelected = _selectedCategory == category;
    final color = _expenseCategoryColor(category);

    return GestureDetector(
      onTap: () {
        HapticFeedback.selectionClick();
        setState(() => _selectedCategory = category);
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(AppDimensions.paddingL),
        decoration: BoxDecoration(
          color: isDark ? AppColors.surfaceDark : AppColors.surface,
          borderRadius: BorderRadius.circular(AppDimensions.radiusL),
          border: Border.all(
            color: isSelected ? color : (isDark ? AppColors.grey700 : AppColors.grey200),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(AppDimensions.paddingM),
              decoration: BoxDecoration(
                color: (isSelected ? color : color.withValues(alpha: 0.1)),
                borderRadius: BorderRadius.circular(AppDimensions.radiusM),
              ),
              child: Icon(
                icon,
                color: isSelected ? Colors.white : color,
                size: AppDimensions.iconM,
              ),
            ),
            SizedBox(width: AppDimensions.paddingM),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTypography.title.copyWith(
                      color: isSelected ? color : (isDark ? AppColors.textOnDark : AppColors.textPrimary),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: AppDimensions.paddingXS),
                  Text(
                    description,
                    style: AppTypography.caption.copyWith(
                      color: isDark
                          ? AppColors.textSecondaryOnDark
                          : AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Icon(
                AppIcons.success,
                color: color,
                size: AppDimensions.iconM,
              ),
          ],
        ),
      ),
    );
  }

  Color _expenseCategoryColor(ExpenseCategory category) {
    final pocketCategory = switch (category) {
      ExpenseCategory.needs => PocketCategory.needs,
      ExpenseCategory.wants => PocketCategory.wants,
      ExpenseCategory.savings => PocketCategory.savings,
    };
    final hex = pocketCategory.primaryColor.replaceFirst('#', '0xFF');
    return Color(int.parse(hex));
  }

  void _applySuggestion(_ExpenseSuggestion suggestion) {
    HapticFeedback.selectionClick();
    setState(() {
      _selectedCategory = suggestion.category;
      _amountController.text =
          suggestion.amount.toStringAsFixed(suggestion.amount % 1 == 0 ? 0 : 2);
      _nameController.text = suggestion.label;
      _showValidationError = false;
    });
  }

  Widget _buildNameInput(bool isDark) {
    final l10n = AppLocalizations.of(context)!;
    return AppTextField(
      controller: _nameController,
      label: l10n.onboardingExpenseNameLabel,
      hint: l10n.onboardingExpenseNameHint,
      icon: AppIcons.tag,
      textInputAction: TextInputAction.done,
      onChanged: (_) {
        if (_showValidationError) {
          setState(() => _showValidationError = false);
        }
      },
    )
        .animate()
        .fadeIn(duration: 400.ms, delay: 200.ms)
        .slideY(begin: 0.1, end: 0, curve: Curves.easeOutCubic);
  }

  Widget _buildHelperText(bool isDark) {
    final l10n = AppLocalizations.of(context)!;
    return Row(
      children: [
        Icon(
          AppIcons.info,
          size: 16,
          color:
              isDark ? AppColors.textSecondaryOnDark : AppColors.textSecondary,
        ),
        SizedBox(width: AppDimensions.paddingXS),
        Expanded(
          child: Text(
            l10n.onboardingExpenseHelper,
            style: AppTypography.caption.copyWith(
              color: isDark
                  ? AppColors.textSecondaryOnDark
                  : AppColors.textSecondary,
            ),
          ),
        ),
      ],
    )
        .animate()
        .fadeIn(duration: 400.ms, delay: 500.ms)
        .slideY(begin: 0.1, end: 0, curve: Curves.easeOutCubic);
  }

  Widget _buildErrorMessage() {
    final l10n = AppLocalizations.of(context)!;
    return Text(
      l10n.onboardingExpenseValidationError,
      style: AppTypography.caption.copyWith(
        color: AppColors.error,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildBottomActions(BuildContext context, bool isIOS) {
    final l10n = AppLocalizations.of(context)!;
    return AppButton(
      width: double.infinity,
      text: _isLoading ? l10n.onboardingCreating : l10n.onboardingContinue,
      icon: _isLoading ? null : AppIcons.arrowRight,
          iconPosition: IconPosition.right,
          style: AppButtonStyle.primary,
          size: AppButtonSize.large,
      onPressed: _isLoading ? null : () => _handleContinue(context),
    );
  }

  Future<void> _handleContinue(BuildContext context) async {
    // Valider l'input
    final sanitized =
        _amountController.text.replaceAll(' ', '').replaceAll(',', '.');
    final amount = double.tryParse(sanitized);

    final name = _nameController.text.trim();

    if (amount == null || amount <= 0 || name.isEmpty) {
      _handleInvalidTap();
      return;
    }

    HapticFeedback.mediumImpact();

    // S'assurer que le provider est initialisé
    try {
      await ref.read(onboardingProvider.future);
    } catch (e) {
      ref.read(loggerProvider).w('[Step3] Provider déjà initialisé: $e');
    }

    // Sauvegarder dans le provider (AWAIT pour éviter les race conditions!)
    ref.read(loggerProvider).d('[Step3] Sauvegarde dépense: amount=$amount, category=$_selectedCategory, name=$name');
    await ref.read(onboardingProvider.notifier).setFirstExpenseAmount(amount);
    await ref.read(onboardingProvider.notifier).setFirstExpenseCategory(_selectedCategory);
    await ref.read(onboardingProvider.notifier).setFirstExpenseDescription(name);
    ref.read(loggerProvider).d('[Step3] Dépense sauvegardée dans l\'état local');

    // Vérifier que la sauvegarde a fonctionné
    final savedState = await ref.read(onboardingProvider.future);
    ref.read(loggerProvider).d('[Step3] État vérifié: firstExpenseAmount=${savedState.firstExpenseAmount}');

    // Afficher l'animation de chargement
    setState(() => _isLoading = true);

    try {
      ref.read(loggerProvider).i('Création des pockets par défaut...');

      // Récupérer l'utilisateur actuel
      final currentUser = await ref.read(currentUserProvider.future);
      if (!mounted) return; // Vérifier après await
      if (currentUser == null) {
        throw Exception('Utilisateur non connecté');
    }

      // Créer les pockets par défaut
      ref.read(loggerProvider).i('Création des pockets par défaut...');
      final useCase = ref.read(createDefaultPocketsUseCaseProvider);
      final createdPockets = await useCase(currentUser.id);
      if (!mounted) return; // Vérifier après await

      ref.read(loggerProvider).i('${createdPockets.length} pockets créés');

      if (!mounted) return;

      // Naviguer vers l'étape 4
      setState(() => _isLoading = false);
      if (!mounted) return;
      context.push(AppRoutePaths.step4);
    } catch (e) {
      ref.read(loggerProvider).e('Erreur lors de la création des pockets', error: e);

      if (!mounted) return;
      setState(() => _isLoading = false);

      // Afficher un message d'erreur mais continuer quand même
      final l10n = AppLocalizations.of(context)!;
      if (Platform.isIOS) {
        showCupertinoDialog(
          context: context,
          builder: (context) => CupertinoAlertDialog(
            title: Text(l10n.onboardingErrorTitle),
            content: Text('${l10n.onboardingErrorPocketsCreate}\n\n${l10n.errorTitle}: $e'),
            actions: [
              CupertinoDialogAction(
                child: Text(l10n.onboardingContinue),
                onPressed: () {
                  Navigator.of(context).pop();
                  context.push(AppRoutePaths.step4);
                },
              ),
            ],
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(l10n.onboardingErrorTitle),
            content: Text('${l10n.onboardingErrorPocketsCreate}\n\n${l10n.errorTitle}: $e'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  context.push(AppRoutePaths.step4);
                },
                child: Text(l10n.onboardingContinue),
              ),
            ],
          ),
        );
      }
    }
  }

  void _handleInvalidTap() {
    HapticFeedback.heavyImpact();
    setState(() => _showValidationError = true);
  }

  Widget _buildSkipButton(bool isDark, bool isIOS) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 100),
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.surface,
        shape: BoxShape.circle,
        border: Border.all(
          color: isDark
              ? AppColors.textSecondaryOnDark.withValues(alpha: 0.3)
              : AppColors.textSecondary.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: isIOS
          ? CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () => _handleSkip(context),
              child: Icon(
                CupertinoIcons.forward,
                color: isDark ? AppColors.textOnDark : AppColors.textPrimary,
                size: 22,
              ),
            )
          : IconButton(
              onPressed: () => _handleSkip(context),
              icon: Icon(
                Icons.fast_forward,
                color: isDark ? AppColors.textOnDark : AppColors.textPrimary,
                size: 22,
              ),
              padding: EdgeInsets.zero,
            ),
    );
  }

  void _handleSkip(BuildContext context) {
    HapticFeedback.lightImpact();
    context.push(AppRoutePaths.step4);
  }
}

class _ExpenseSuggestion {
  const _ExpenseSuggestion({
    required this.label,
    required this.amount,
    required this.category,
  });

  final String label;
  final double amount;
  final ExpenseCategory category;
}

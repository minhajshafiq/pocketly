import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pocketly/core/core.dart';
import 'package:pocketly/core/widgets/animated_page_header.dart';
import 'package:pocketly/features/onboarding/onboarding.dart';
import 'package:pocketly/features/category/category.dart';
import 'package:pocketly/features/transactions/transactions.dart';
import 'package:pocketly/features/user/user.dart';

/// Écran d'onboarding - Étape 1 : Découvrons votre budget
///
/// Permet à l'utilisateur de saisir son revenu mensuel et la fréquence
class OnboardingStep1Screen extends ConsumerStatefulWidget {
  const OnboardingStep1Screen({super.key});

  @override
  ConsumerState<OnboardingStep1Screen> createState() =>
      _OnboardingStep1ScreenState();
}

class _OnboardingStep1ScreenState
    extends ConsumerState<OnboardingStep1Screen> {
  static const int _totalSteps = 4;
  final TextEditingController _incomeController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  IncomeFrequency _selectedFrequency = IncomeFrequency.monthly;
  bool _showValidationError = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _incomeController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final isIOS = Platform.isIOS;

    return Scaffold(
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
                        _buildIncomeCard(context, isDark),
                        SizedBox(height: AppDimensions.paddingL),
                        _buildFrequencySelector(isDark),
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
                  _buildBottomActions(context, isIOS),
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
                title: 'Étape 1/$_totalSteps',
                scrollController: _scrollController,
                showBackButton: false,
                actionButton: _buildSkipButton(isDark, isIOS),
                ),
            ),

            // Loading overlay
            if (_isLoading) _buildLoadingOverlay(isDark),
          ],
        ),
      ),
    );
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

  Widget _buildProgressIndicator(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Étape 1/$_totalSteps',
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
            value: 1 / _totalSteps,
            backgroundColor: isDark ? AppColors.grey700 : AppColors.grey200,
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
          ),
        ),
      ],
    );
  }

  Widget _buildTitle(bool isDark) {
    return Text(
      'Quel est votre revenu mensuel ?',
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
    return Text(
      'Cela nous permet de personnaliser automatiquement votre budget.',
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

  Widget _buildIncomeCard(BuildContext context, bool isDark) {
    return Container(
      padding: EdgeInsets.all(AppDimensions.paddingL),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.surface,
        borderRadius: BorderRadius.circular(AppDimensions.radiusXL),
        border: Border.all(
          color: isDark ? AppColors.grey700 : AppColors.grey200,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Montant',
            style: AppTypography.title.copyWith(
              color: isDark ? AppColors.textOnDark : AppColors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: AppDimensions.paddingS),
          TextField(
            controller: _incomeController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            textInputAction: TextInputAction.done,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[0-9., ]')),
            ],
            style: AppTypography.display.copyWith(
              color: isDark ? AppColors.textOnDark : AppColors.textPrimary,
              fontWeight: FontWeight.bold,
            ),
            decoration: InputDecoration(
              hintText: '0',
              hintStyle: AppTypography.heading.copyWith(
                color: isDark
                    ? AppColors.textSecondaryOnDark
                    : AppColors.textSecondary,
              ),
              border: InputBorder.none,
              suffixIcon: Padding(
                padding: EdgeInsets.only(right: AppDimensions.paddingS),
                child: Text(
                  '€',
                  style: AppTypography.heading.copyWith(
                    color: isDark
                        ? AppColors.textOnDark
                        : AppColors.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              suffixIconConstraints: BoxConstraints(
                minWidth: AppDimensions.paddingXXL,
              ),
            ),
            onChanged: (_) {
              if (_showValidationError) {
                setState(() => _showValidationError = false);
              }
            },
          ),
        ],
      ),
    )
        .animate()
        .fadeIn(duration: 400.ms, delay: 200.ms)
        .slideY(begin: 0.1, end: 0, curve: Curves.easeOutCubic);
  }

  Widget _buildFrequencySelector(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Fréquence',
          style: AppTypography.title.copyWith(
            color: isDark ? AppColors.textOnDark : AppColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: AppDimensions.paddingM),
        Row(
          children: [
            Expanded(
              child: _buildFrequencyButton(
                label: 'Mensuel',
                frequency: IncomeFrequency.monthly,
                isDark: isDark,
              ),
            ),
            SizedBox(width: AppDimensions.paddingS),
            Expanded(
              child: _buildFrequencyButton(
                label: 'Hebdo',
                frequency: IncomeFrequency.weekly,
                isDark: isDark,
              ),
            ),
            SizedBox(width: AppDimensions.paddingS),
            Expanded(
              child: _buildFrequencyButton(
                label: 'Autre',
                frequency: IncomeFrequency.other,
                isDark: isDark,
              ),
            ),
          ],
        ),
      ],
    )
        .animate()
        .fadeIn(duration: 400.ms, delay: 300.ms)
        .slideY(begin: 0.1, end: 0, curve: Curves.easeOutCubic);
  }

  Widget _buildFrequencyButton({
    required String label,
    required IncomeFrequency frequency,
    required bool isDark,
  }) {
    final isSelected = _selectedFrequency == frequency;

    return GestureDetector(
      onTap: () {
        HapticFeedback.selectionClick();
        setState(() => _selectedFrequency = frequency);
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: AppDimensions.paddingM),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary
              : (isDark ? AppColors.surfaceDark : AppColors.surface),
          borderRadius: BorderRadius.circular(AppDimensions.radiusL),
          border: Border.all(
            color: isSelected
                ? AppColors.primary
                : (isDark ? AppColors.grey700 : AppColors.grey200),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: AppTypography.body.copyWith(
            color: isSelected
                ? Colors.white
                : (isDark ? AppColors.textOnDark : AppColors.textPrimary),
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildHelperText(bool isDark) {
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
            'Vous pourrez modifier ce montant à tout moment.',
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
        .fadeIn(duration: 400.ms, delay: 400.ms)
        .slideY(begin: 0.1, end: 0, curve: Curves.easeOutCubic);
  }

  Widget _buildErrorMessage() {
    return Text(
      'Veuillez saisir un montant valide',
      style: AppTypography.caption.copyWith(
        color: AppColors.error,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildBottomActions(BuildContext context, bool isIOS) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppButton(
          text: 'Continuer',
          icon: AppIcons.arrowRight,
          iconPosition: IconPosition.right,
          style: AppButtonStyle.gradient,
          size: AppButtonSize.large,
          onPressed: _isLoading ? null : () => _handleContinue(context),
        ),
      ],
    );
  }

  Widget _buildLoadingOverlay(bool isDark) {
    return Container(
      color: (isDark ? AppColors.backgroundDark : AppColors.background)
          .withValues(alpha: 0.8),
      child: Center(
        child: Container(
          padding: EdgeInsets.all(AppDimensions.paddingXL),
          decoration: BoxDecoration(
            color: isDark ? AppColors.surfaceDark : AppColors.surface,
            borderRadius: BorderRadius.circular(AppDimensions.radiusXL),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(),
              SizedBox(height: AppDimensions.paddingL),
              Text(
                'Personnalisation de votre budget...',
                style: AppTypography.body.copyWith(
                  color:
                      isDark ? AppColors.textOnDark : AppColors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        )
            .animate()
            .fadeIn(duration: 200.ms)
            .scale(begin: const Offset(0.8, 0.8), curve: Curves.easeOutCubic),
      ),
    );
  }

  Future<void> _handleContinue(BuildContext context) async {
    // Valider l'input
    final sanitized =
        _incomeController.text.replaceAll(' ', '').replaceAll(',', '.');
    final income = double.tryParse(sanitized);

    if (income == null || income <= 0) {
      _handleInvalidTap();
      return;
    }

    HapticFeedback.mediumImpact();

    // Sauvegarder dans le provider
    ref.read(onboardingProvider.notifier).setMonthlyIncome(income);
    ref
        .read(onboardingProvider.notifier)
        .setIncomeFrequency(_selectedFrequency);

    // Debug: Vérifier que la sauvegarde a fonctionné
    ref.read(loggerProvider).d('Sauvegarde: montant=$income, fréquence=$_selectedFrequency');

    // Vérifier immédiatement l'état du provider
    final savedIncome = ref.read(convertedMonthlyIncomeProvider);
    ref.read(loggerProvider).d('Vérifié dans le provider: $savedIncome');

    // Afficher l'animation de chargement
    setState(() => _isLoading = true);

    try {
      ref.read(loggerProvider).i('Création de la transaction de revenu dans la DB...');

      // Récupérer l'utilisateur actuel
      final currentUser = await ref.read(currentUserProvider.future);
      if (currentUser == null) {
        throw Exception('Utilisateur non connecté');
      }

      // Récupérer les catégories de type income
      final categories = await ref.read(categoryProvider.future);
      final incomeCategories = categories.where((c) => c.type == CategoryType.income).toList();

      if (incomeCategories.isEmpty) {
        throw Exception('Aucune catégorie de revenu disponible');
      }

      // Prendre la première catégorie de revenu (généralement "Salaire")
      final incomeCategory = incomeCategories.first;

      ref.read(loggerProvider).i('Catégorie de revenu: ${incomeCategory.name} (id: ${incomeCategory.id})');

      // Sauvegarder dans la base de données via le notifier (mise à jour optimiste + invalidation auto)
      await ref.read(transactionProvider.notifier).createTransaction(
        name: _getIncomeLabel(_selectedFrequency),
        amount: income,
        date: DateTime.now(),
        categoryId: incomeCategory.id!,
        type: TransactionType.income,
        userId: currentUser.id,
        notes: 'Transaction créée lors de l\'onboarding',
      );

      ref.read(loggerProvider).i('Transaction de revenu créée avec succès');

      if (!mounted) return;

      // Naviguer vers l'étape 2
      setState(() => _isLoading = false);
      context.push(AppRoutePaths.step2);
    } catch (e) {
      ref.read(loggerProvider).e('Erreur lors de la création de la transaction', error: e);

      if (!mounted) return;
      setState(() => _isLoading = false);

      // Afficher un message d'erreur mais continuer quand même
      if (Platform.isIOS) {
        showCupertinoDialog(
          context: context,
          builder: (context) => CupertinoAlertDialog(
            title: const Text('Attention'),
            content: Text('Une erreur est survenue lors de la sauvegarde de votre revenu. Vous pourrez le modifier plus tard.\n\nErreur: $e'),
            actions: [
              CupertinoDialogAction(
                child: const Text('Continuer'),
                onPressed: () {
                  Navigator.of(context).pop();
                  context.push(AppRoutePaths.step2);
                },
              ),
            ],
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Attention'),
            content: Text('Une erreur est survenue lors de la sauvegarde de votre revenu. Vous pourrez le modifier plus tard.\n\nErreur: $e'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  context.push(AppRoutePaths.step2);
                },
                child: const Text('Continuer'),
              ),
            ],
          ),
        );
      }
    }
  }

  /// Obtient le label de la transaction de revenu selon la fréquence
  String _getIncomeLabel(IncomeFrequency frequency) {
    return switch (frequency) {
      IncomeFrequency.monthly => 'Revenu mensuel',
      IncomeFrequency.weekly => 'Revenu hebdomadaire',
      IncomeFrequency.other => 'Revenu',
    };
  }

  void _handleInvalidTap() {
    HapticFeedback.heavyImpact();
    setState(() => _showValidationError = true);
  }

  void _handleSkip(BuildContext context) {
    HapticFeedback.lightImpact();
    context.go(AppRoutePaths.home);
  }
}

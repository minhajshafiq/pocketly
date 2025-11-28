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
                title: AppLocalizations.of(context)!.onboardingStepProgress(1, _totalSteps),
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
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.onboardingStepProgress(1, _totalSteps),
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
    final l10n = AppLocalizations.of(context)!;
    return Text(
      l10n.onboardingStep1IncomeTitle,
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
      l10n.onboardingStep1IncomeSubtitle,
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
            AppLocalizations.of(context)!.onboardingStep1IncomeAmountLabel,
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
          AppLocalizations.of(context)!.onboardingStep1FrequencyLabel,
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
                label: AppLocalizations.of(context)!.onboardingStep1FrequencyMonthly,
                frequency: IncomeFrequency.monthly,
                isDark: isDark,
              ),
            ),
            SizedBox(width: AppDimensions.paddingS),
            Expanded(
              child: _buildFrequencyButton(
                label: AppLocalizations.of(context)!.onboardingStep1FrequencyWeekly,
                frequency: IncomeFrequency.weekly,
                isDark: isDark,
              ),
            ),
            SizedBox(width: AppDimensions.paddingS),
            Expanded(
              child: _buildFrequencyButton(
                label: AppLocalizations.of(context)!.onboardingStep1FrequencyOther,
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
            AppLocalizations.of(context)!.onboardingStep1IncomeHelper,
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
    final l10n = AppLocalizations.of(context)!;
    return Text(
      l10n.onboardingStep1IncomeError,
      style: AppTypography.caption.copyWith(
        color: AppColors.error,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildBottomActions(BuildContext context, bool isIOS) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppButton(
          text: l10n.onboardingContinue,
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
                AppLocalizations.of(context)!.onboardingStep1Personalizing,
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

    // S'assurer que le provider est initialisé avant de l'utiliser
    ref.read(loggerProvider).d('[Step1] Initialisation du provider onboarding...');
    try {
      // Attendre que le provider soit chargé (force l'initialisation de SharedPreferences)
      await ref.read(onboardingProvider.future);
      ref.read(loggerProvider).d('[Step1] Provider initialisé');
    } catch (e) {
      ref.read(loggerProvider).w('[Step1] Provider déjà initialisé ou en cours: $e');
    }

    // Sauvegarder dans le provider en une seule opération (évite les race conditions)
    ref.read(loggerProvider).d('[Step1] AVANT setIncomeData: montant=$income, fréquence=$_selectedFrequency');
    await ref.read(onboardingProvider.notifier).setIncomeData(income, _selectedFrequency);
    ref.read(loggerProvider).d('[Step1] APRÈS setIncomeData');

    // Attendre un petit délai pour que l'état se propage
    await Future.delayed(const Duration(milliseconds: 100));

    // Vérifier immédiatement l'état du provider
    final savedIncome = ref.read(convertedMonthlyIncomeProvider);
    ref.read(loggerProvider).d('[Step1] Vérifié dans le provider: $savedIncome');

    // Vérifier directement l'état complet
    final fullState = await ref.read(onboardingProvider.future);
    ref.read(loggerProvider).d('[Step1] État complet: monthlyIncome=${fullState.monthlyIncome}, frequency=${fullState.incomeFrequency}, converted=${fullState.convertedMonthlyIncome}');

    // Activer le trial dès la première étape (pour que même en skippant, l'utilisateur l'ait)
    try {
      final currentUser = await ref.read(currentUserProvider.future);
      if (currentUser != null && !currentUser.isTrialActive && !currentUser.isPremium) {
        ref.read(loggerProvider).i('Activation du trial gratuit...');
        await ref.read(currentUserProvider.notifier).activateTrial(currentUser.id);
        ref.read(loggerProvider).i('Trial activé avec succès');
      }
    } catch (e) {
      // Ne pas bloquer l'onboarding si le trial ne peut pas être activé
      ref.read(loggerProvider).w('Erreur lors de l\'activation du trial: $e');
    }

    // Naviguer vers l'étape 2 (la transaction sera créée à la fin de l'onboarding)
    if (!mounted) return;
                  context.push(AppRoutePaths.step2);
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

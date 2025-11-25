import 'dart:io';
import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pocketly/core/core.dart';
import 'package:pocketly/core/widgets/animated_page_header.dart';
import 'package:pocketly/features/onboarding/presentation/providers/onboarding_providers.dart';

/// Écran d'onboarding - Étape 4 : Activation du trial et célébration
///
/// Félicite l'utilisateur, active le trial et redirige vers le dashboard
class OnboardingStep4Screen extends ConsumerStatefulWidget {
  const OnboardingStep4Screen({super.key});

  @override
  ConsumerState<OnboardingStep4Screen> createState() =>
      _OnboardingStep4ScreenState();
}

class _OnboardingStep4ScreenState
    extends ConsumerState<OnboardingStep4Screen> {
  static const int _totalSteps = 4;
  final ScrollController _scrollController = ScrollController();
  bool _showConfetti = false;
  bool _isActivatingTrial = false;
  final List<_ConfettiPiece> _confettiPieces = [];
  final math.Random _random = math.Random();

  @override
  void initState() {
    super.initState();
    // Afficher les confettis au chargement
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _triggerConfetti();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _triggerConfetti() {
    final size = MediaQuery.of(context).size;
    _generateConfettiPieces(size);
    setState(() => _showConfetti = true);
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _buildProgressIndicator(isDark),
                        SizedBox(height: AppDimensions.paddingXXL),
                        _buildCelebrationIcon(),
                        SizedBox(height: AppDimensions.paddingXL),
                        _buildTitle(isDark),
                        SizedBox(height: AppDimensions.paddingM),
                        _buildSubtitle(isDark),
                        SizedBox(height: AppDimensions.paddingXXL),
                        _buildTrialCard(isDark),
                        SizedBox(height: AppDimensions.paddingXL),
                        _buildFeaturesList(isDark),
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
                title: 'Étape $_totalSteps/$_totalSteps',
                scrollController: _scrollController,
                showBackButton: false,
                actionButton: _buildSkipButton(isDark, isIOS),
                ),
            ),

            // Confetti overlay
            if (_showConfetti) _buildConfettiOverlay(),
          ],
        ),
      ),
    );
  }


  Widget _buildProgressIndicator(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Étape $_totalSteps/$_totalSteps',
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
            value: 1.0,
            backgroundColor: isDark ? AppColors.grey700 : AppColors.grey200,
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.success),
          ),
        ),
      ],
    );
  }

  Widget _buildCelebrationIcon() {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: AppColors.successGradient,
        boxShadow: [
          BoxShadow(
            color: AppColors.success.withValues(alpha: 0.3),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Icon(
        AppIcons.success,
        color: Colors.white,
        size: 60,
      ),
    )
        .animate()
        .fadeIn(duration: 600.ms)
        .scale(
          begin: const Offset(0, 0),
          end: const Offset(1, 1),
          curve: Curves.elasticOut,
          duration: 800.ms,
        );
  }

  Widget _buildTitle(bool isDark) {
    return Text(
      'Félicitations ! 🎉',
      textAlign: TextAlign.center,
      style: AppTypography.display.copyWith(
        color: isDark ? AppColors.textOnDark : AppColors.textPrimary,
        fontWeight: FontWeight.bold,
      ),
    )
        .animate()
        .fadeIn(duration: 400.ms, delay: 200.ms)
        .slideY(begin: 0.1, end: 0, curve: Curves.easeOutCubic);
  }

  Widget _buildSubtitle(bool isDark) {
    return Text(
      'Vous êtes prêt à maîtriser votre budget !\nProfitez de 14 jours d\'essai gratuit.',
      textAlign: TextAlign.center,
      style: AppTypography.body.copyWith(
        color: isDark
            ? AppColors.textSecondaryOnDark
            : AppColors.textSecondary,
      ),
    )
        .animate()
        .fadeIn(duration: 400.ms, delay: 300.ms)
        .slideY(begin: 0.1, end: 0, curve: Curves.easeOutCubic);
  }

  Widget _buildTrialCard(bool isDark) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppDimensions.paddingXL),
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(AppDimensions.radiusXL),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.25),
            blurRadius: AppDimensions.elevationModal,
            offset: Offset(0, AppDimensions.paddingS),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(
            AppIcons.premium,
            color: Colors.white,
            size: AppDimensions.iconXL,
          ),
          SizedBox(height: AppDimensions.paddingM),
          Text(
            'Premium activé',
            style: AppTypography.heading.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: AppDimensions.paddingS),
          Text(
            '14 jours d\'essai gratuit',
            style: AppTypography.body.copyWith(
              color: Colors.white.withValues(alpha: 0.9),
            ),
          ),
        ],
      ),
    )
        .animate()
        .fadeIn(duration: 400.ms, delay: 400.ms)
        .slideY(begin: 0.1, end: 0, curve: Curves.easeOutCubic)
        .shimmer(duration: 2000.ms, delay: 600.ms);
  }

  Widget _buildFeaturesList(bool isDark) {
    final features = [
      _Feature(
        icon: AppIcons.budget,
        title: 'Budgets illimités',
        description: 'Créez autant de pockets que vous voulez',
      ),
      _Feature(
        icon: AppIcons.stats,
        title: 'Analyses détaillées',
        description: 'Suivez vos dépenses en temps réel',
      ),
      _Feature(
        icon: AppIcons.notification,
        title: 'Notifications intelligentes',
        description: 'Restez informé de vos finances',
      ),
    ];

    return Column(
      children: features.asMap().entries.map((entry) {
        final index = entry.key;
        final feature = entry.value;
        return Padding(
          padding: EdgeInsets.only(bottom: AppDimensions.paddingM),
          child: _buildFeatureItem(feature, isDark, index),
        );
      }).toList(),
    );
  }

  Widget _buildFeatureItem(_Feature feature, bool isDark, int index) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(AppDimensions.paddingM),
          decoration: BoxDecoration(
            color: AppColors.success.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(AppDimensions.radiusM),
          ),
          child: Icon(feature.icon, color: AppColors.success),
        ),
        SizedBox(width: AppDimensions.paddingM),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                feature.title,
                style: AppTypography.title.copyWith(
                  color: isDark
                      ? AppColors.textOnDark
                      : AppColors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: AppDimensions.paddingXS),
              Text(
                feature.description,
                style: AppTypography.body.copyWith(
                  color: isDark
                      ? AppColors.textSecondaryOnDark
                      : AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
        Icon(
          AppIcons.success,
          color: AppColors.success,
          size: AppDimensions.iconM,
        ),
      ],
    )
        .animate()
        .fadeIn(duration: 400.ms, delay: (500 + index * 100).ms)
        .slideX(begin: 0.1, end: 0, curve: Curves.easeOutCubic);
  }

  Widget _buildBottomActions(BuildContext context, bool isIOS) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppButton(
          text: _isActivatingTrial ? 'Activation en cours...' : 'Commencer',
          icon: AppIcons.arrowRight,
          iconPosition: IconPosition.right,
          style: AppButtonStyle.gradient,
          size: AppButtonSize.large,
          onPressed: _isActivatingTrial ? null : () => _handleFinish(context),
        ),
      ],
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

  void _handleSkip(BuildContext context) {
    HapticFeedback.lightImpact();
    context.go(AppRoutePaths.home);
  }

  Widget _buildConfettiOverlay() {
    return IgnorePointer(
      ignoring: true,
      child: Positioned.fill(
        child: Stack(
          children: _confettiPieces
              .map(
                (piece) => Positioned(
                  left: piece.left,
                  top: piece.startY,
                  child: Transform.rotate(
                    angle: piece.rotation,
                    child: Container(
                      width: piece.size,
                      height: piece.size * 0.6,
                      decoration: BoxDecoration(
                        color: piece.color,
                        borderRadius: BorderRadius.circular(piece.size / 3),
                      ),
                    ),
                  )
                      .animate()
                      .fadeIn(duration: 80.ms)
                      .moveY(
                        begin: 0,
                        end: piece.endY,
                        duration: 1400.ms,
                        curve: Curves.easeOut,
                      )
                      .fadeOut(duration: 200.ms, delay: 1100.ms),
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  void _handleFinish(BuildContext context) async {
    setState(() => _isActivatingTrial = true);
    HapticFeedback.heavyImpact();

    try {
      ref.read(loggerProvider).i('Finalisation de l\'onboarding');

      // Activer le trial et compléter l'onboarding
      await ref.read(onboardingProvider.notifier).completeOnboarding();

      ref.read(loggerProvider).i('Onboarding complété avec succès');

      if (!mounted) return;

      // Petit délai pour que l'utilisateur voie le message de succès
      await Future.delayed(const Duration(milliseconds: 500));

      if (!mounted) return;

      // Rediriger vers le home
      context.go(AppRoutePaths.home);
    } catch (e) {
      ref.read(loggerProvider).e('Erreur lors de la finalisation de l\'onboarding', error: e);

      if (!mounted) return;

      setState(() => _isActivatingTrial = false);

      // Afficher une erreur
      if (Platform.isIOS) {
        showCupertinoDialog(
          context: context,
          builder: (context) => CupertinoAlertDialog(
            title: const Text('Erreur'),
            content: Text('Une erreur est survenue: $e'),
            actions: [
              CupertinoDialogAction(
                child: const Text('OK'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Erreur'),
            content: Text('Une erreur est survenue: $e'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    }
  }

  void _generateConfettiPieces(Size size) {
    _confettiPieces
      ..clear()
      ..addAll(
        List.generate(
          30,
          (index) => _ConfettiPiece(
            left: _random.nextDouble() * size.width,
            startY: -_random.nextDouble() * 50,
            endY: size.height * (0.3 + _random.nextDouble() * 0.6),
            size: 8 + _random.nextDouble() * 12,
            rotation: _random.nextDouble() * math.pi * 2,
            color: _confettiColors[index % _confettiColors.length],
          ),
        ),
      );
  }
}

const List<Color> _confettiColors = [
  AppColors.primary,
  AppColors.secondary,
  AppColors.success,
  AppColors.warning,
  AppColors.info,
  AppColors.error,
];

class _ConfettiPiece {
  const _ConfettiPiece({
    required this.left,
    required this.startY,
    required this.endY,
    required this.size,
    required this.rotation,
    required this.color,
  });

  final double left;
  final double startY;
  final double endY;
  final double size;
  final double rotation;
  final Color color;
}

class _Feature {
  const _Feature({
    required this.icon,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final String title;
  final String description;
}

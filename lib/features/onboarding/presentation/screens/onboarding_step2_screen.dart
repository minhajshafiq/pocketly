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
import 'package:pocketly/features/currency/currency.dart';
import 'package:pocketly/features/onboarding/presentation/providers/onboarding_providers.dart';
import 'package:pocketly/features/pockets/pockets.dart';

/// Écran d'onboarding - Étape 2 : Présentation de la règle 50/30/20
///
/// Affiche visuellement la répartition budgétaire selon la règle 50/30/20
class OnboardingStep2Screen extends ConsumerStatefulWidget {
  const OnboardingStep2Screen({super.key});

  @override
  ConsumerState<OnboardingStep2Screen> createState() =>
      _OnboardingStep2ScreenState();
}

class _OnboardingStep2ScreenState extends ConsumerState<OnboardingStep2Screen> {
  static const int _totalSteps = 4;
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final isIOS = Platform.isIOS;
    final monthlyIncome = ref.watch(convertedMonthlyIncomeProvider) ?? 0;

    // Debug: Vérifier le montant récupéré
    ref.read(loggerProvider).d('Revenu mensuel récupéré: $monthlyIncome');

    // Calculer les montants selon la règle 50/30/20
    final needsAmount = monthlyIncome * 0.5;
    final wantsAmount = monthlyIncome * 0.3;
    final savingsAmount = monthlyIncome * 0.2;

    // Debug: Vérifier les montants calculés
    ref.read(loggerProvider).d('Besoins: $needsAmount, Envies: $wantsAmount, Épargne: $savingsAmount');

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
                    _buildDonutChart(
                      context,
                      monthlyIncome,
                      needsAmount,
                      wantsAmount,
                      savingsAmount,
                      isDark,
                    ),
                    SizedBox(height: AppDimensions.paddingXL),
                    _buildCategoryCards(
                      needsAmount,
                      wantsAmount,
                      savingsAmount,
                      isDark,
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
                title: 'Étape 2/$_totalSteps',
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
          'Étape 2/$_totalSteps',
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
            value: 2 / _totalSteps,
            backgroundColor: isDark ? AppColors.grey700 : AppColors.grey200,
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.secondary),
          ),
        ),
      ],
    );
  }

  Widget _buildTitle(bool isDark) {
    return Text(
      'Votre budget réparti automatiquement',
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
      'Nous utilisons la règle 50/30/20 pour optimiser votre budget.',
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

  Widget _buildDonutChart(
    BuildContext context,
    double total,
    double needs,
    double wants,
    double savings,
    bool isDark,
  ) {
    final needsColor = _categoryColor(PocketCategory.needs);
    final wantsColor = _categoryColor(PocketCategory.wants);
    final savingsColor = _categoryColor(PocketCategory.savings);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppDimensions.paddingXL),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.surface,
        borderRadius: BorderRadius.circular(AppDimensions.radiusXL),
        border: Border.all(
          color: isDark ? AppColors.grey700 : AppColors.grey200,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.15),
            blurRadius: AppDimensions.elevationCard,
            offset: Offset(0, AppDimensions.paddingXS),
          ),
        ],
      ),
      child: Column(
        children: [
          // Donut chart
          SizedBox(
            width: 260,
            height: 260,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Cercle extérieur animé
                SizedBox(
                  width: 200,
                  height: 200,
                  child: CustomPaint(
                  painter: _DonutChartPainter(
                    needsPercentage: 0.5,
                    wantsPercentage: 0.3,
                    savingsPercentage: 0.2,
                      needsColor: needsColor,
                      wantsColor: wantsColor,
                      savingsColor: savingsColor,
                      backgroundColor: isDark ? AppColors.grey800 : AppColors.grey200,
                  ),
                )
                    .animate()
                    .fadeIn(duration: 600.ms)
                    .scale(
                      begin: const Offset(0.8, 0.8),
                      curve: Curves.easeOutCubic,
                      ),
                    ),
                // Centre avec le total
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Total',
                      style: AppTypography.caption.copyWith(
                        color: isDark
                            ? AppColors.textSecondaryOnDark
                            : AppColors.textSecondary,
                      ),
                    ),
                    SizedBox(height: AppDimensions.paddingXS),
                    CurrencyAmountText(
                      amount: total,
                      style: AppTypography.heading.copyWith(
                        color: isDark
                            ? AppColors.textOnDark
                            : AppColors.textPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                      decimals: 0,
                    ),
                  ],
                )
                    .animate()
                    .fadeIn(duration: 400.ms, delay: 200.ms)
                    .scale(
                      begin: const Offset(0.5, 0.5),
                      curve: Curves.easeOutCubic,
                    ),
                ..._buildChartAmountTags(
                  needs: needs,
                  wants: wants,
                  savings: savings,
                  isDark: isDark,
                  needsColor: needsColor,
                  wantsColor: wantsColor,
                  savingsColor: savingsColor,
                    ),
              ],
            ),
          ),
          SizedBox(height: AppDimensions.paddingXL),
          // Légende
          _buildLegend(
            isDark: isDark,
            needsColor: needsColor,
            wantsColor: wantsColor,
            savingsColor: savingsColor,
          ),
        ],
      ),
    )
        .animate()
        .fadeIn(duration: 400.ms, delay: 200.ms)
        .slideY(begin: 0.1, end: 0, curve: Curves.easeOutCubic);
  }

  Widget _buildLegend({
    required bool isDark,
    required Color needsColor,
    required Color wantsColor,
    required Color savingsColor,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildLegendItem('Besoins', needsColor, '50%', isDark),
        _buildLegendItem('Envies', wantsColor, '30%', isDark),
        _buildLegendItem('Épargne', savingsColor, '20%', isDark),
      ],
    );
  }

  Widget _buildLegendItem(
    String label,
    Color color,
    String percentage,
    bool isDark,
  ) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: AppDimensions.paddingXS),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: AppTypography.caption.copyWith(
                color: isDark
                    ? AppColors.textSecondaryOnDark
                    : AppColors.textSecondary,
              ),
            ),
            Text(
              percentage,
              style: AppTypography.caption.copyWith(
                color: color,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }

  List<Widget> _buildChartAmountTags({
    required double needs,
    required double wants,
    required double savings,
    required bool isDark,
    required Color needsColor,
    required Color wantsColor,
    required Color savingsColor,
  }) {
    const double needsPercentage = 0.5;
    const double wantsPercentage = 0.3;
    const double savingsPercentage = 0.2;
    const double startAngle = -math.pi / 2;
    const double radius = 120;

    final needsAngle = needsPercentage * 2 * math.pi;
    final wantsAngle = wantsPercentage * 2 * math.pi;
    final savingsAngle = savingsPercentage * 2 * math.pi;

    final needsMidAngle = startAngle + needsAngle / 2;
    final wantsMidAngle = startAngle + needsAngle + wantsAngle / 2;
    final savingsMidAngle = startAngle + needsAngle + wantsAngle + savingsAngle / 2;

    Offset offsetForAngle(double angle) {
      return Offset(
        radius * math.cos(angle),
        radius * math.sin(angle),
      );
    }

    return [
      Transform.translate(
        offset: offsetForAngle(needsMidAngle),
        child: _buildChartAmountTag(
          label: 'Besoins',
          amount: needs,
          color: needsColor,
          isDark: isDark,
          delay: 250,
        ),
      ),
      Transform.translate(
        offset: offsetForAngle(wantsMidAngle),
        child: _buildChartAmountTag(
          label: 'Envies',
          amount: wants,
          color: wantsColor,
          isDark: isDark,
          delay: 300,
        ),
      ),
      Transform.translate(
        offset: offsetForAngle(savingsMidAngle),
        child: _buildChartAmountTag(
          label: 'Épargne',
          amount: savings,
          color: savingsColor,
          isDark: isDark,
          delay: 350,
        ),
      ),
    ];
  }

  Widget _buildChartAmountTag({
    required String label,
    required double amount,
    required Color color,
    required bool isDark,
    required int delay,
  }) {
    return Container(
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
            color: color.withValues(alpha: 0.2),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: AppTypography.caption.copyWith(
              color: isDark ? AppColors.textOnDark : AppColors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: AppDimensions.paddingXS),
          CurrencyAmountText(
            amount: amount,
            decimals: 0,
            style: AppTypography.title.copyWith(
              color: isDark ? Colors.white : AppColors.textPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    )
        .animate(delay: delay.ms)
        .fadeIn(duration: 300.ms)
        .scale(begin: const Offset(0.9, 0.9), end: const Offset(1, 1));
  }

  Color _categoryColor(PocketCategory category) {
    final hexColor = category.primaryColor.replaceFirst('#', '0xFF');
    return Color(int.parse(hexColor));
  }

  Widget _buildCategoryCards(
    double needs,
    double wants,
    double savings,
    bool isDark,
  ) {
    final needsColor = _categoryColor(PocketCategory.needs);
    final wantsColor = _categoryColor(PocketCategory.wants);
    final savingsColor = _categoryColor(PocketCategory.savings);

    return Column(
      children: [
        _buildCategoryCard(
          icon: AppIcons.home,
          title: 'Besoins',
          description: 'Loyer, courses, factures...',
          amount: needs,
          color: needsColor,
          isDark: isDark,
          delay: 300,
        ),
        SizedBox(height: AppDimensions.paddingM),
        _buildCategoryCard(
          icon: AppIcons.favorite,
          title: 'Envies',
          description: 'Loisirs, sorties, shopping...',
          amount: wants,
          color: wantsColor,
          isDark: isDark,
          delay: 400,
        ),
        SizedBox(height: AppDimensions.paddingM),
        _buildCategoryCard(
          icon: AppIcons.savings,
          title: 'Épargne',
          description: 'Économies, investissements...',
          amount: savings,
          color: savingsColor,
          isDark: isDark,
          delay: 500,
        ),
      ],
    );
  }

  Widget _buildCategoryCard({
    required IconData icon,
    required String title,
    required String description,
    required double amount,
    required Color color,
    required bool isDark,
    required int delay,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppDimensions.paddingL),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.surface,
        borderRadius: BorderRadius.circular(AppDimensions.radiusL),
        border: Border.all(
          color: color.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(AppDimensions.paddingM),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppDimensions.radiusM),
            ),
            child: Icon(icon, color: color, size: AppDimensions.iconL),
          ),
          SizedBox(width: AppDimensions.paddingM),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTypography.title.copyWith(
                    color: isDark
                        ? AppColors.textOnDark
                        : AppColors.textPrimary,
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
          CurrencyAmountText(
            amount: amount,
            style: AppTypography.title.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
            decimals: 0,
          ),
        ],
      ),
    )
        .animate()
        .fadeIn(duration: 400.ms, delay: delay.ms)
        .slideX(begin: 0.1, end: 0, curve: Curves.easeOutCubic);
  }

  Widget _buildBottomActions(BuildContext context, bool isIOS) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppButton(
          text: 'Continuer',
          icon: AppIcons.arrowRight,
          iconPosition: IconPosition.right,
          style: AppButtonStyle.primary,
          size: AppButtonSize.large,
          onPressed: () => _handleContinue(context),
        ),
      ],
    );
  }

  void _handleContinue(BuildContext context) {
    HapticFeedback.mediumImpact();
    context.push(AppRoutePaths.step3);
  }

  void _handleSkip(BuildContext context) {
    HapticFeedback.lightImpact();
    context.go(AppRoutePaths.home);
  }
}

/// Custom painter pour le graphique en donut
class _DonutChartPainter extends CustomPainter {
  _DonutChartPainter({
    required this.needsPercentage,
    required this.wantsPercentage,
    required this.savingsPercentage,
    required this.needsColor,
    required this.wantsColor,
    required this.savingsColor,
    required this.backgroundColor,
  });

  final double needsPercentage;
  final double wantsPercentage;
  final double savingsPercentage;
  final Color needsColor;
  final Color wantsColor;
  final Color savingsColor;
  final Color backgroundColor;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final strokeWidth = 30.0;

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    // Fond
    paint.color = backgroundColor;
    canvas.drawCircle(center, radius - strokeWidth / 2, paint);

    // Calculer les angles (en radians)
    const startAngle = -math.pi / 2; // Commencer en haut
    final needsAngle = 2 * math.pi * needsPercentage;
    final wantsAngle = 2 * math.pi * wantsPercentage;
    final savingsAngle = 2 * math.pi * savingsPercentage;

    // Arc Besoins (50% - Primary)
    paint.color = needsColor;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - strokeWidth / 2),
      startAngle,
      needsAngle,
      false,
      paint,
    );

    // Arc Envies (30% - Secondary)
    paint.color = wantsColor;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - strokeWidth / 2),
      startAngle + needsAngle,
      wantsAngle,
      false,
      paint,
    );

    // Arc Épargne (20% - Success)
    paint.color = savingsColor;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - strokeWidth / 2),
      startAngle + needsAngle + wantsAngle,
      savingsAngle,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

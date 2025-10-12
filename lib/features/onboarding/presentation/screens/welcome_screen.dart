import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';
import 'dart:async';
import 'package:pocketly/core/constants/app_constants.dart';
import 'package:pocketly/core/router/app_route_paths.dart';
import 'package:pocketly/core/widgets/app_button.dart';
import 'package:pocketly/generated/l10n/app_localizations.dart';

/// Écran de bienvenue pour l'application Pocketly.
/// 
/// Respecte les guidelines Apple HIG et Material Design
/// avec une interface adaptative selon la plateforme.
/// 
/// Les boutons AppButton s'adaptent automatiquement :
/// - iOS : Utilise CupertinoButton avec haptic feedback
/// - Android : Utilise Material Design avec animations
class WelcomeScreen extends ConsumerStatefulWidget {
  const WelcomeScreen({super.key});

  @override
  ConsumerState<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends ConsumerState<WelcomeScreen> {
  int _currentPage = 0;
  final PageController _pageController = PageController();
  Timer? _autoSlideTimer;

  @override
  void initState() {
    super.initState();
    _startAutoSlide();
    
    // Remove splash screen when welcome screen is ready
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FlutterNativeSplash.remove();
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _autoSlideTimer?.cancel();
    super.dispose();
  }

  void _startAutoSlide() {
    _autoSlideTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (mounted) {
        _nextPage();
      }
    });
  }

  void _stopAutoSlide() {
    _autoSlideTimer?.cancel();
  }

  void _nextPage() {
    final l10n = AppLocalizations.of(context)!;
    final welcomePages = _getWelcomePages(l10n);
    
    if (_currentPage < welcomePages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // Boucler vers la première page
      _pageController.animateToPage(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
    // Redémarrer le timer si on change de page manuellement
    _stopAutoSlide();
    _startAutoSlide();
  }


  void _getStarted() {
    // Navigation vers l'écran d'inscription avec GoRouter
    context.push(AppRoutePaths.signup);
  }

  void _login() {
    // Navigation vers l'écran de connexion avec GoRouter
    context.push(AppRoutePaths.signin);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final isIOS = Theme.of(context).platform == TargetPlatform.iOS;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.background,
      body: SafeArea(
        child: Stack(
          children: [
            // Contenu principal
            Column(
              children: [
                // Header avec logo et bouton skip
                _buildHeader(context, l10n, isDark, isIOS),
                
                // PageView avec les pages de bienvenue
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: _onPageChanged,
                    itemCount: _getWelcomePages(l10n).length,
                    itemBuilder: (context, index) {
                      return _buildWelcomePage(
                        context,
                        _getWelcomePages(l10n)[index],
                        l10n,
                        isDark,
                        isIOS,
                      );
                    },
                  ),
                ),
                
                // Espace pour les boutons fixes
                SizedBox(height: AppDimensions.paddingXXL * 2),
              ],
            ),
            
            // Indicateurs de page au-dessus des boutons
            Positioned(
              bottom: AppDimensions.paddingXXL * 3,
              left: 0,
              right: 0,
              child: _buildPageIndicators(context, isDark, isIOS),
            ),
            
            // Boutons fixes superposés en bas
            _buildFixedBottomButtons(context, l10n, isDark, isIOS),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, AppLocalizations l10n, bool isDark, bool isIOS) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppDimensions.pageHorizontalPadding,
        vertical: AppDimensions.paddingM,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Logo de l'application
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: AppDimensions.iconXL,
                height: AppDimensions.iconXL,
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                ),
                child: Icon(
                  Icons.account_balance_wallet,
                  color: Colors.white,
                  size: AppDimensions.iconM,
                ),
              ),
              SizedBox(width: AppDimensions.paddingS),
              Text(
                l10n.appTitle,
                style: AppTypography.title.copyWith(
                  color: isDark ? AppColors.textOnDark : AppColors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWelcomePage(
    BuildContext context,
    WelcomePageData pageData,
    AppLocalizations l10n,
    bool isDark,
    bool isIOS,
  ) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: AppDimensions.pageHorizontalPadding,
        vertical: AppDimensions.paddingXL,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Illustration
          Container(
            width: 240.w,
            height: 240.w,
            decoration: BoxDecoration(
              gradient: pageData.gradient,
              borderRadius: BorderRadius.circular(AppDimensions.radiusXL),
              boxShadow: [
                BoxShadow(
                  color: isDark 
                    ? Colors.black.withValues(alpha: 0.3)
                    : AppColors.primary.withValues(alpha: 0.2),
                  blurRadius: AppDimensions.elevationModal,
                  offset: Offset(0, AppDimensions.paddingS),
                ),
              ],
            ),
            child: Icon(
              pageData.icon,
              size: AppDimensions.iconXL * 2,
              color: Colors.white,
            ),
          )
            .animate()
            .scale(duration: 600.ms, curve: Curves.elasticOut)
            .fadeIn(duration: 800.ms),
          
          SizedBox(height: AppDimensions.paddingXXL),
          
          // Titre
          Text(
            pageData.title,
            textAlign: TextAlign.center,
            style: AppTypography.display.copyWith(
              color: isDark ? AppColors.textOnDark : AppColors.textPrimary,
              fontWeight: FontWeight.bold,
            ),
          )
            .animate()
            .fadeIn(duration: 600.ms, delay: 100.ms)
            .slideY(begin: 0.1, end: 0.0, curve: Curves.easeOutCubic),

          SizedBox(height: AppDimensions.paddingM),

          // Description
          Text(
            pageData.description,
            textAlign: TextAlign.center,
            style: AppTypography.body.copyWith(
              color: isDark ? AppColors.textSecondaryOnDark : AppColors.textSecondary,
              height: 1.6,
            ),
          )
            .animate()
            .fadeIn(duration: 600.ms, delay: 400.ms)
            .slideY(begin: 0.1, end: 0.0, curve: Curves.easeOutCubic),

          // Espace pour les boutons fixes
          SizedBox(height: AppDimensions.paddingXXL * 2),
        ],
      ),
    );
  }

  Widget _buildPageIndicators(BuildContext context, bool isDark, bool isIOS) {
    final l10n = AppLocalizations.of(context)!;
    final welcomePages = _getWelcomePages(l10n);
    
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppDimensions.pageHorizontalPadding,
        vertical: AppDimensions.paddingM,
      ),
      child: Column(
        children: [
          // Indicateurs de page avec animation
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              welcomePages.length,
              (index) => _buildPageIndicator(
                index == _currentPage,
                isDark,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFixedBottomButtons(BuildContext context, AppLocalizations l10n, bool isDark, bool isIOS) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Padding(
        padding: EdgeInsets.all(AppDimensions.pageHorizontalPadding),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Boutons fixes - toujours visibles en mode vertical
              Column(
                children: [
                  // Get Started en haut (bouton principal avec dégradé)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppDimensions.paddingS),
                    child: SizedBox(
                      width: double.infinity,
                      height: AppDimensions.buttonHeightLarge,
                      child: AppButton(
                        text: l10n.getStarted,
                        icon: Icons.rocket_launch,
                        onPressed: _getStarted,
                        style: AppButtonStyle.gradient,
                        size: AppButtonSize.large,
                        isFullWidth: true,
                        customBorderRadius: 28,
                        iconPosition: IconPosition.right,
                      )
                        .animate()
                        .fadeIn(duration: 300.ms)
                        .slideY(begin: 0.2, end: 0.0),
                    ),
                  ),
                  
                  SizedBox(height: AppDimensions.paddingM),
                  
                  // Login en bas (bouton outline avec même taille)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppDimensions.paddingS),
                    child: SizedBox(
                      width: double.infinity,
                      height: AppDimensions.buttonHeightLarge,
                      child: AppButton(
                        text: l10n.login,
                        icon: Icons.login,
                        onPressed: _login,
                        style: AppButtonStyle.outline,
                        size: AppButtonSize.large,
                        isFullWidth: true,
                        customBorderRadius: 28,
                        iconPosition: IconPosition.right,
                      )
                        .animate()
                        .fadeIn(duration: 300.ms, delay: 100.ms)
                        .slideY(begin: 0.2, end: 0.0),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPageIndicator(bool isActive, bool isDark) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
      margin: EdgeInsets.symmetric(horizontal: AppDimensions.paddingXS),
      width: isActive ? AppDimensions.paddingL : AppDimensions.paddingS,
      height: isActive ? AppDimensions.paddingS : AppDimensions.paddingXS,
      decoration: BoxDecoration(
        color: isActive 
          ? AppColors.primary 
          : (isDark ? AppColors.grey700 : AppColors.grey300),
        borderRadius: BorderRadius.circular(AppDimensions.radiusS),
        boxShadow: isActive ? [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.3),
            blurRadius: AppDimensions.elevationCard,
            offset: Offset(0, AppDimensions.paddingXS),
          ),
        ] : null,
      ),
    );
  }

  // Données des pages de bienvenue - maintenant générées dynamiquement avec les traductions
  List<WelcomePageData> _getWelcomePages(AppLocalizations l10n) {
    return [
      WelcomePageData(
        icon: Icons.account_balance_wallet,
        title: l10n.welcomeTitle,
        description: l10n.welcomeDescription,
        gradient: AppColors.primaryGradient,
      ),
      WelcomePageData(
        icon: Icons.analytics,
        title: l10n.trackSpendingTitle,
        description: l10n.trackSpendingDescription,
        gradient: AppColors.secondaryGradient,
      ),
      WelcomePageData(
        icon: Icons.savings,
        title: l10n.saveSmartTitle,
        description: l10n.saveSmartDescription,
        gradient: AppColors.successGradient,
      ),
      WelcomePageData(
        icon: Icons.security,
        title: l10n.secureTitle,
        description: l10n.secureDescription,
        gradient: AppColors.primaryGradient,
      ),
    ];
  }
}

class WelcomePageData {
  final IconData icon;
  final String title;
  final String description;
  final LinearGradient gradient;

  const WelcomePageData({
    required this.icon,
    required this.title,
    required this.description,
    required this.gradient,
  });
}
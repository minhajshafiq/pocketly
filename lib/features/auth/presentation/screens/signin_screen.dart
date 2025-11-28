import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:pocketly/generated/l10n/app_localizations.dart';
import 'package:pocketly/core/core.dart';
import 'package:pocketly/features/auth/auth.dart';
import 'package:pocketly/features/notifications/notifications.dart';

/// Constantes pour les animations
class _AnimationConstants {
  static const fadeDuration = Duration(milliseconds: 600);
  static const backButtonDuration = Duration(milliseconds: 400);
  static const notificationDelay = Duration(milliseconds: 300);

  static const delays = {
    'welcome': Duration(milliseconds: 100),
    'email': Duration(milliseconds: 200),
    'password': Duration(milliseconds: 300),
    'forgotPassword': Duration(milliseconds: 350),
    'signInButton': Duration(milliseconds: 400),
    'signUpLink': Duration(milliseconds: 500),
    'divider': Duration(milliseconds: 550),
    'socialButtons': Duration(milliseconds: 600),
  };
}

/// Regex pour la validation des emails
class _ValidationConstants {
  // RFC 5322 compliant email regex (more strict)
  static final emailRegex = RegExp(
    r'^[a-zA-Z0-9]+([\._-]?[a-zA-Z0-9]+)*@[a-zA-Z0-9]+([\.-]?[a-zA-Z0-9]+)*(\.[a-zA-Z]{2,})+$',
  );
  // Minimum 6 characters for password (temporarily reduced from 12)
  static const minPasswordLength = 6;
}

class SigninScreen extends ConsumerStatefulWidget {
  const SigninScreen({super.key});

  @override
  ConsumerState<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends ConsumerState<SigninScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _hasInteracted = false;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_onFieldChanged);
    _passwordController.addListener(_onFieldChanged);
  }

  void _onFieldChanged() {
    setState(() {
      if (!_hasInteracted) {
        _hasInteracted = true;
      }
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool get _isIOS => !kIsWeb && Platform.isIOS;

  /// Vérifie si le formulaire est valide
  bool get _isFormValid {
    return _emailController.text.trim().isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _passwordController.text.length >= _ValidationConstants.minPasswordLength &&
        _ValidationConstants.emailRegex.hasMatch(_emailController.text.trim());
  }

  /// Méthode générique pour gérer l'authentification
  Future<void> _handleAuthentication({
    required Future<void> Function() authAction,
    required String errorMessage,
  }) async {
    await authAction();

    if (!mounted) return;

    final authState = ref.read(authProvider);
    final l10n = AppLocalizations.of(context)!;

    authState.when(
      data: (state) => _handleAuthSuccess(state, l10n),
      error: (error, _) => _handleAuthError(error, l10n, errorMessage),
      loading: () {}, // Le loading est géré par le bouton
    );
  }

  /// Gère le succès de l'authentification
  void _handleAuthSuccess(AuthState state, AppLocalizations l10n) {
    if (state is! AuthAuthenticated) return;

    context.go(AppRoutePaths.home);

    Future.delayed(_AnimationConstants.notificationDelay, () {
      if (mounted) {
        InAppNotificationService.showSuccess(
          context,
          title: l10n.success,
          message: l10n.signInSuccess,
        );
      }
    });
  }

  /// Gère les erreurs d'authentification
  void _handleAuthError(
    Object error,
    AppLocalizations l10n,
    String fallbackMessage,
  ) {
    String message;

    if (error is AuthenticationError ||
        error is NetworkError ||
        error is ValidationError) {
      message = (error as dynamic).userMessage as String;
    } else {
      message = fallbackMessage;
    }

    InAppNotificationService.showError(
      context,
      title: l10n.errorTitle,
      message: message,
    );
  }

  /// Connexion avec email/password
  Future<void> _handleSignin() async {
    if (!_formKey.currentState!.validate()) return;

    final email = _emailController.text.trim();
    final rateLimiter = ref.read(authRateLimiterProvider);
    final l10n = AppLocalizations.of(context)!;

    // Vérifier le rate limiting
    if (!rateLimiter.canAttempt(email)) {
      final timeUntilUnlock = rateLimiter.timeUntilUnlock(email);
      final minutes =
          (timeUntilUnlock?.inMinutes ?? 0) +
          1; // +1 pour arrondir au supérieur

      InAppNotificationService.showError(
        context,
        title: l10n.tooManyAttempts,
        message: l10n.rateLimitMessage(minutes),
      );
      return;
    }

    // Enregistrer la tentative AVANT l'authentification
    rateLimiter.recordAttempt(email);

    await _handleAuthentication(
      authAction: () => ref
          .read(authProvider.notifier)
          .signIn(email: email, password: _passwordController.text),
      errorMessage: l10n.unexpectedError,
    );

    // Si la connexion réussit, réinitialiser le compteur
    final authState = ref.read(authProvider);
    authState.whenData((state) {
      if (state is AuthAuthenticated) {
        rateLimiter.reset(email);
      }
    });
  }

  /// Connexion avec Google
  Future<void> _handleGoogleSignin() async {
    final l10n = AppLocalizations.of(context)!;
    InAppNotificationService.showInfo(
      context,
      message: l10n.featureComingSoon,
    );
  }

  /// Connexion avec Apple
  Future<void> _handleAppleSignin() async {
    final l10n = AppLocalizations.of(context)!;
    InAppNotificationService.showInfo(
      context,
      message: l10n.featureComingSoon,
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeColors = ThemeColors.fromContext(context);
    final authState = ref.watch(authProvider);

    return _isIOS
        ? _buildIOS(themeColors, authState)
        : _buildAndroid(themeColors, authState);
  }

  Widget _buildIOS(ThemeColors colors, AsyncValue<AuthState> authState) {
    return CupertinoPageScaffold(
      backgroundColor: colors.background,
      child: _buildSigninContent(colors, authState),
    );
  }

  Widget _buildAndroid(ThemeColors colors, AsyncValue<AuthState> authState) {
    return Scaffold(
      backgroundColor: colors.background,
      body: _buildSigninContent(colors, authState),
    );
  }

  Widget _buildSigninContent(
    ThemeColors colors,
    AsyncValue<AuthState> authState,
  ) {
    return PlatformSafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppDimensions.paddingL),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: AppDimensions.paddingL),
              _buildBackButton(colors),
              SizedBox(height: AppDimensions.paddingL),
              _buildWelcomeSection(colors),
              SizedBox(height: AppDimensions.paddingL),
              _buildForm(colors, authState),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildForm(ThemeColors colors, AsyncValue<AuthState> authState) {
    return Form(
      key: _formKey,
      autovalidateMode: _hasInteracted
          ? AutovalidateMode.onUserInteraction
          : AutovalidateMode.disabled,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildEmailField(colors),
          SizedBox(height: AppDimensions.paddingM),
          _buildPasswordField(colors),
          SizedBox(height: AppDimensions.paddingS),
          _buildForgotPasswordLink(colors),
          SizedBox(height: AppDimensions.paddingM),
          _buildSigninButton(colors, authState),
          SizedBox(height: AppDimensions.paddingM),
          _buildSignUpLink(colors),
          SizedBox(height: AppDimensions.paddingM),
          _buildDivider(colors),
          SizedBox(height: AppDimensions.paddingM),
          _buildSocialLoginButtons(colors),
          SizedBox(height: AppDimensions.paddingL),
        ],
      ),
    );
  }

  Widget _buildBackButton(ThemeColors colors) {
    final l10n = AppLocalizations.of(context)!;

    return Align(
          alignment: Alignment.centerLeft,
          child: Semantics(
            label: l10n.backButton,
            button: true,
            child: Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: colors.surface,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(28),
                  onTap: () {
                    final router = GoRouter.of(context);
                    if (router.canPop()) {
                      router.pop();
                    } else {
                      context.go(AppRoutePaths.welcome);
                    }
                  },
                  child: Icon(
                    AppIcons.back,
                    color: AppColors.primary,
                    size: 24,
                  ),
                ),
              ),
            ),
          ),
        )
        .animate()
        .fadeIn(duration: _AnimationConstants.backButtonDuration)
        .scale(begin: const Offset(0.8, 0.8), end: const Offset(1.0, 1.0));
  }

  Widget _buildWelcomeSection(ThemeColors colors) {
    final l10n = AppLocalizations.of(context)!;

    return Material(
          color: Colors.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.signinWelcomeTitle,
                style: AppTypography.display.copyWith(
                  color: colors.textPrimary,
                  fontWeight: FontWeight.bold,
                  height: 1.2,
                ),
              ),
              SizedBox(height: AppDimensions.paddingM),
              Text(
                l10n.signinWelcomeDescription,
                style: AppTypography.body.copyWith(color: colors.textSecondary),
              ),
            ],
          ),
        )
        .animate()
        .fadeIn(
          duration: _AnimationConstants.fadeDuration,
          delay: _AnimationConstants.delays['welcome'],
        )
        .slideY(begin: 0.2, end: 0.0, curve: Curves.easeOutCubic);
  }

  Widget _buildEmailField(ThemeColors colors) {
    final l10n = AppLocalizations.of(context)!;

    return AppTextField(
          controller: _emailController,
          label: l10n.emailAddress,
          type: AppTextFieldType.email,
          validator: _validateEmail,
          showValidationErrors: true,
          hasBeenSubmitted: _hasInteracted,
        )
        .animate()
        .fadeIn(
          duration: _AnimationConstants.fadeDuration,
          delay: _AnimationConstants.delays['email'],
        )
        .slideY(begin: 0.1, end: 0.0, curve: Curves.easeOutCubic);
  }

  Widget _buildPasswordField(ThemeColors colors) {
    final l10n = AppLocalizations.of(context)!;

    return AppTextField(
          controller: _passwordController,
          label: l10n.password,
          type: AppTextFieldType.password,
          validator: _validatePassword,
          showValidationErrors: true,
          hasBeenSubmitted: _hasInteracted,
          showPasswordToggle: true,
        )
        .animate()
        .fadeIn(
          duration: _AnimationConstants.fadeDuration,
          delay: _AnimationConstants.delays['password'],
        )
        .slideY(begin: 0.1, end: 0.0, curve: Curves.easeOutCubic);
  }

  Widget _buildForgotPasswordLink(ThemeColors colors) {
    final l10n = AppLocalizations.of(context)!;

    return Align(
      alignment: Alignment.centerRight,
      child: Semantics(
        label: l10n.forgotPassword,
        button: true,
        child: TextButton(
          key: const Key('signin_forgot_password'),
          onPressed: () => context.push(AppRoutePaths.forgotPassword),
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Text(
            l10n.forgotPassword,
            style: AppTypography.body.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
              decoration: TextDecoration.none,
            ),
          ),
        ),
      ),
    ).animate().fadeIn(
      duration: _AnimationConstants.fadeDuration,
      delay: _AnimationConstants.delays['forgotPassword'],
    );
  }

  Widget _buildSigninButton(ThemeColors colors, AsyncValue authState) {
    final l10n = AppLocalizations.of(context)!;
    final isLoading = authState.isLoading;

    return AppButton(
          text: l10n.signIn,
          onPressed: (isLoading || !_isFormValid) ? null : _handleSignin,
          style: AppButtonStyle.gradient,
          size: AppButtonSize.large,
          isFullWidth: true,
          isLoading: isLoading,
          customBorderRadius: 28,
          icon: AppIcons.arrowRight,
          iconPosition: IconPosition.right,
        )
        .animate()
        .fadeIn(
          duration: _AnimationConstants.fadeDuration,
          delay: _AnimationConstants.delays['signInButton'],
        )
        .scale(
          begin: const Offset(0.95, 0.95),
          end: const Offset(1.0, 1.0),
          curve: Curves.easeOutCubic,
        );
  }

  Widget _buildSignUpLink(ThemeColors colors) {
    final l10n = AppLocalizations.of(context)!;

    return Material(
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(AppIcons.profile, size: 18, color: colors.textSecondary),
          const SizedBox(width: 8),
          Text(
            l10n.noAccountYet,
            style: AppTypography.body.copyWith(color: colors.textSecondary),
          ),
          TextButton(
            onPressed: () => context.push(AppRoutePaths.signup),
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(
              l10n.signUp,
              style: AppTypography.body.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
                decoration: TextDecoration.none,
              ),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(
      duration: _AnimationConstants.fadeDuration,
      delay: _AnimationConstants.delays['signUpLink'],
    );
  }

  Widget _buildDivider(ThemeColors colors) {
    final l10n = AppLocalizations.of(context)!;

    return Material(
      color: Colors.transparent,
      child: Row(
        children: [
          Expanded(child: Container(height: 1, color: colors.border)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              l10n.or,
              style: AppTypography.small.copyWith(color: colors.textSecondary),
            ),
          ),
          Expanded(child: Container(height: 1, color: colors.border)),
        ],
      ),
    ).animate().fadeIn(
      duration: _AnimationConstants.fadeDuration,
      delay: _AnimationConstants.delays['divider'],
    );
  }

  Widget _buildSocialLoginButtons(ThemeColors colors) {
    return Row(
          children: [
            Expanded(child: _buildGoogleButton(colors)),
            const SizedBox(width: 12),
            Expanded(child: _buildAppleButton(colors)),
          ],
        )
        .animate()
        .fadeIn(
          duration: _AnimationConstants.fadeDuration,
          delay: _AnimationConstants.delays['socialButtons'],
        )
        .slideY(begin: 0.1, end: 0.0, curve: Curves.easeOutCubic);
  }

  Widget _buildGoogleButton(ThemeColors colors) {
    final l10n = AppLocalizations.of(context)!;

    return AppButton(
      text: l10n.google,
      onPressed: _handleGoogleSignin,
      style: AppButtonStyle.outline,
      size: AppButtonSize.large,
      isFullWidth: true,
      customBorderRadius: 28,
      customColor: colors.surface,
      customTextColor: colors.textPrimary,
      icon: AppIcons.google,
    );
  }

  Widget _buildAppleButton(ThemeColors colors) {
    final l10n = AppLocalizations.of(context)!;

    return AppButton(
      text: l10n.apple,
      onPressed: _handleAppleSignin,
      style: AppButtonStyle.primary,
      size: AppButtonSize.large,
      isFullWidth: true,
      customBorderRadius: 28,
      customColor: colors.isDark ? Colors.white : Colors.black,
      customTextColor: colors.isDark ? Colors.black : Colors.white,
      icon: AppIcons.apple,
    );
  }

  String? _validateEmail(String? value) {
    final l10n = AppLocalizations.of(context)!;

    if (value == null || value.isEmpty) {
      return l10n.emailValidationRequired;
    }

    // Utiliser trim() pour cohérence avec _isFormValid
    if (!_ValidationConstants.emailRegex.hasMatch(value.trim())) {
      return l10n.emailValidationInvalid;
    }

    return null;
  }

  String? _validatePassword(String? value) {
    final l10n = AppLocalizations.of(context)!;

    if (value == null || value.isEmpty) {
      return l10n.passwordValidationRequired;
    }

    if (value.length < _ValidationConstants.minPasswordLength) {
      return l10n.passwordValidationMinLength;
    }

    return null;
  }
}

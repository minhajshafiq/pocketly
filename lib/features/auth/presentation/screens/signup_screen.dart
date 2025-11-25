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

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _hasInteracted = false;

  @override
  void initState() {
    super.initState();
    // Ajouter des listeners pour reconstruire le widget quand les champs changent
    _nameController.addListener(_onFieldChanged);
    _emailController.addListener(_onFieldChanged);
    _passwordController.addListener(_onFieldChanged);
    _confirmPasswordController.addListener(_onFieldChanged);
  }

  void _onFieldChanged() {
    setState(() {
      // Marquer que l'utilisateur a commencé à interagir
      if (!_hasInteracted) {
        _hasInteracted = true;
      }
      // Reconstruire le widget pour mettre à jour l'état du bouton
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  bool get _isIOS => !kIsWeb && Platform.isIOS;

  // RFC 5322 compliant email regex (more strict)
  static final _emailRegex = RegExp(
    r'^[a-zA-Z0-9]+([\._-]?[a-zA-Z0-9]+)*@[a-zA-Z0-9]+([\.-]?[a-zA-Z0-9]+)*(\.[a-zA-Z]{2,})+$',
  );
  // NIST recommends minimum 12 characters for strong passwords
  static const _minPasswordLength = 12;

  /// Vérifie si le formulaire est valide
  bool get _isFormValid {
    return _emailController.text.trim().isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _confirmPasswordController.text.isNotEmpty &&
        _passwordController.text == _confirmPasswordController.text &&
        _passwordController.text.length >= _minPasswordLength &&
        _emailRegex.hasMatch(_emailController.text.trim());
  }

  /// Inscription avec email/password
  Future<void> _handleSignup() async {
    if (!_formKey.currentState!.validate()) return;

    // Appeler signUp (ne lance pas d'exception car utilise AsyncValue.guard)
    await ref
        .read(authProvider.notifier)
        .signUp(
          email: _emailController.text.trim(),
          password: _passwordController.text,
          name: _nameController.text.trim().isNotEmpty
              ? _nameController.text.trim()
              : null,
        );

    if (!mounted) return;

    // Vérifier l'état d'authentification après signUp
    final authState = ref.read(authProvider);
    final l10n = AppLocalizations.of(context)!;

    await authState.when(
      data: (state) async {
        // Seulement continuer si authentifié
        if (state is AuthAuthenticated) {
          // Afficher la modal de bienvenue après inscription réussie
          await _showWelcomeModal();

          // Rediriger vers l'onboarding
          if (mounted) {
            context.go(AppRoutePaths.step1);
          }
        }
      },
      error: (error, stackTrace) async {
        _handleSignupError(error, l10n);
      },
      loading: () async {
        // En cours de chargement, ne rien faire
      },
    );
  }

  /// Gère les erreurs d'inscription
  void _handleSignupError(Object error, AppLocalizations l10n) {
    String message;

    if (error is AuthenticationError ||
        error is NetworkError ||
        error is ValidationError) {
      message = (error as dynamic).userMessage as String;
    } else {
      message = l10n.unexpectedError;
    }

    InAppNotificationService.showError(
      context,
      title: l10n.errorTitle,
      message: message,
    );
  }

  Future<void> _showWelcomeModal() async {
    if (_isIOS) {
      await _showCupertinoWelcomeModal();
    } else {
      await _showMaterialWelcomeModal();
    }
  }

  Future<void> _showCupertinoWelcomeModal() async {
    final l10n = AppLocalizations.of(context)!;

    return showCupertinoDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => CupertinoAlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              l10n.welcomeModalTitle,
              style: AppTypography.title.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 8),
            const Text('🎉', style: TextStyle(fontSize: 24)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12),
            Text(
              l10n.welcomeModalMessage,
              style: AppTypography.body.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              height: AppDimensions.buttonHeightLarge,
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(28),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  l10n.getStartedButton,
                  style: AppTypography.button.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showMaterialWelcomeModal() async {
    final l10n = AppLocalizations.of(context)!;

    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        contentPadding: const EdgeInsets.all(24),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  l10n.welcomeModalTitle,
                  style: AppTypography.title.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 8),
                const Text('🎉', style: TextStyle(fontSize: 24)),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              l10n.welcomeModalMessage,
              style: AppTypography.body.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              height: AppDimensions.buttonHeightLarge,
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(28),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(28),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Center(
                    child: Text(
                      l10n.getStartedButton,
                      style: AppTypography.button.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final themeColors = ThemeColors.fromContext(context);
    final authState = ref.watch(authProvider);

    return _isIOS
        ? _buildIOS(context, l10n, themeColors, authState)
        : _buildAndroid(context, l10n, themeColors, authState);
  }

  Widget _buildIOS(
    BuildContext context,
    AppLocalizations l10n,
    ThemeColors colors,
    AsyncValue<AuthState> authState,
  ) {
    return CupertinoPageScaffold(
      backgroundColor: colors.background,
      child: _buildSignupContent(l10n, colors, authState),
    );
  }

  Widget _buildAndroid(
    BuildContext context,
    AppLocalizations l10n,
    ThemeColors colors,
    AsyncValue<AuthState> authState,
  ) {
    return Scaffold(
      backgroundColor: colors.background,
      body: _buildSignupContent(l10n, colors, authState),
    );
  }

  Widget _buildSignupContent(
    AppLocalizations l10n,
    ThemeColors colors,
    AsyncValue<AuthState> authState,
  ) {
    return PlatformSafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: AppDimensions.paddingL),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: AppDimensions.paddingL),
                _buildBackButton(colors),
                SizedBox(height: AppDimensions.paddingL),
                _buildWelcomeSection(colors),
                SizedBox(height: AppDimensions.paddingL),
                Expanded(
                  child: SingleChildScrollView(
                    child: Form(
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
                          SizedBox(height: AppDimensions.paddingM),
                          _buildConfirmPasswordField(colors),
                          SizedBox(height: AppDimensions.paddingM),
                          _buildSignupButton(colors, authState),
                          SizedBox(height: AppDimensions.paddingM),
                          _buildLoginLink(colors),
                          SizedBox(height: AppDimensions.paddingM),
                          _buildDivider(colors),
                          SizedBox(height: AppDimensions.paddingM),
                          _buildSocialLoginButtons(colors),
                          SizedBox(height: AppDimensions.paddingL),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
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
                  onTap: () => GoRouter.of(context).pop(),
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
        .fadeIn(duration: 400.ms)
        .scale(begin: const Offset(0.8, 0.8), end: const Offset(1.0, 1.0));
  }

  Widget _buildWelcomeSection(ThemeColors colors) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Material(
              color: Colors.transparent,
              child: Text(
                l10n.signupWelcomeTitle,
                style: AppTypography.display.copyWith(
                  color: colors.textPrimary,
                  fontWeight: FontWeight.bold,
                  height: 1.2,
                ),
              ),
            ),
            SizedBox(height: AppDimensions.paddingM),
            Material(
              color: Colors.transparent,
              child: Text(
                l10n.signupWelcomeDescription,
                style: AppTypography.body.copyWith(color: colors.textSecondary),
              ),
            ),
          ],
        )
        .animate()
        .fadeIn(duration: 600.ms, delay: 100.ms)
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
        .fadeIn(duration: 600.ms, delay: 200.ms)
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
        .fadeIn(duration: 600.ms, delay: 300.ms)
        .slideY(begin: 0.1, end: 0.0, curve: Curves.easeOutCubic);
  }

  Widget _buildConfirmPasswordField(ThemeColors colors) {
    final l10n = AppLocalizations.of(context)!;

    return AppTextField(
          controller: _confirmPasswordController,
          label: l10n.confirmPassword,
          type: AppTextFieldType.password,
          validator: _validateConfirmPassword,
          showValidationErrors: true,
          hasBeenSubmitted: _hasInteracted,
          showPasswordToggle: true,
        )
        .animate()
        .fadeIn(duration: 600.ms, delay: 400.ms)
        .slideY(begin: 0.1, end: 0.0, curve: Curves.easeOutCubic);
  }

  Widget _buildSignupButton(
    ThemeColors colors,
    AsyncValue<AuthState> authState,
  ) {
    final l10n = AppLocalizations.of(context)!;
    final isLoading = authState.isLoading;
    final isFormValid = _isFormValid;

    return AppButton(
          text: l10n.signUp,
          onPressed: (isLoading || !isFormValid) ? null : _handleSignup,
          style: AppButtonStyle.gradient,
          size: AppButtonSize.large,
          isFullWidth: true,
          isLoading: isLoading,
          customBorderRadius: 28,
          icon: AppIcons.arrowRight,
          iconPosition: IconPosition.right,
        )
        .animate()
        .fadeIn(duration: 600.ms, delay: 500.ms)
        .scale(
          begin: const Offset(0.95, 0.95),
          end: const Offset(1.0, 1.0),
          curve: Curves.easeOutCubic,
        );
  }

  Widget _buildLoginLink(ThemeColors colors) {
    final l10n = AppLocalizations.of(context)!;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(AppIcons.profile, size: 18, color: colors.textSecondary),
        const SizedBox(width: 8),
        Material(
          color: Colors.transparent,
          child: Text(
            l10n.alreadyHaveAccount,
            style: AppTypography.body.copyWith(color: colors.textSecondary),
          ),
        ),
        TextButton(
          onPressed: () {
            context.push(AppRoutePaths.signin);
          },
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Material(
            color: Colors.transparent,
            child: Text(
              l10n.signIn,
              style: AppTypography.body.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
                decoration: TextDecoration.none,
              ),
            ),
          ),
        ),
      ],
    ).animate().fadeIn(duration: 600.ms, delay: 550.ms);
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
    ).animate().fadeIn(duration: 600.ms, delay: 600.ms);
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
        .fadeIn(duration: 600.ms, delay: 650.ms)
        .slideY(begin: 0.1, end: 0.0, curve: Curves.easeOutCubic);
  }

  Widget _buildGoogleButton(ThemeColors colors) {
    final l10n = AppLocalizations.of(context)!;

    return AppButton(
      text: l10n.google,
      onPressed: () {
        // TODO: Implement Google sign up
      },
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
      onPressed: () {
        // TODO: Implement Apple sign up
      },
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
    // Utiliser la même regex stricte que _isFormValid pour cohérence
    if (!_emailRegex.hasMatch(value.trim())) {
      return l10n.emailValidationInvalid;
    }
    return null;
  }

  String? _validatePassword(String? value) {
    final l10n = AppLocalizations.of(context)!;

    if (value == null || value.isEmpty) {
      return l10n.passwordValidationRequired;
    }
    if (value.length < _minPasswordLength) {
      return l10n.passwordValidationMinLength;
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    final l10n = AppLocalizations.of(context)!;

    if (value == null || value.isEmpty) {
      return l10n.confirmPasswordRequired;
    }
    // Vérifier aussi la longueur minimale pour cohérence avec _validatePassword
    if (value.length < _minPasswordLength) {
      return l10n.passwordValidationMinLength;
    }
    if (value != _passwordController.text) {
      return l10n.passwordsDoNotMatch;
    }
    return null;
  }
}

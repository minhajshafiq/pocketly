import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:pocketly/generated/l10n/app_localizations.dart';
import 'package:pocketly/core/constants/app_constants.dart';
import 'package:pocketly/core/router/app_route_paths.dart';
import 'package:pocketly/core/widgets/app_button.dart';
import 'package:pocketly/core/widgets/app_text_field.dart';
import 'package:pocketly/core/widgets/platform_safe_area.dart';

/// Provider pour gérer l'état de connexion
final signinStateProvider = NotifierProvider<SigninStateNotifier, SigninState>(
  () => SigninStateNotifier(),
);

/// État de connexion
class SigninState {
  final bool isLoading;
  final String? error;
  final bool isPasswordVisible;

  const SigninState({
    this.isLoading = false,
    this.error,
    this.isPasswordVisible = false,
  });

  SigninState copyWith({
    bool? isLoading,
    String? error,
    bool? isPasswordVisible,
  }) {
    return SigninState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
    );
  }
}

/// Notifier pour gérer l'état de connexion
class SigninStateNotifier extends Notifier<SigninState> {
  @override
  SigninState build() => const SigninState();

  void setLoading(bool loading) {
    state = state.copyWith(isLoading: loading);
  }

  void setError(String? error) {
    state = state.copyWith(error: error);
  }

  void togglePasswordVisibility() {
    state = state.copyWith(isPasswordVisible: !state.isPasswordVisible);
  }

  void clearError() {
    state = state.copyWith(error: null);
  }
}

/// Provider pour obtenir les couleurs du thème
final signinThemeColorsProvider = Provider<ThemeColors>((ref) {
  // Dans Riverpod 3.0, on doit passer le contexte depuis le widget
  // Ce provider sera utilisé avec un contexte passé depuis le widget
  throw UnimplementedError('Use signinThemeColorsProvider.withContext(context)');
});

/// Extension pour utiliser le provider avec un contexte
extension SigninThemeColorsProviderExtension on WidgetRef {
  ThemeColors getSigninThemeColors(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    return ThemeColors(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      surface: isDark ? AppColors.surfaceDark : AppColors.surface,
      background: isDark ? AppColors.backgroundDark : AppColors.background,
      onSurface: isDark ? AppColors.textOnDark : AppColors.textPrimary,
      onBackground: isDark ? AppColors.textOnDark : AppColors.textPrimary,
      textPrimary: isDark ? AppColors.textOnDark : AppColors.textPrimary,
      textSecondary: isDark ? AppColors.textSecondaryOnDark : AppColors.textSecondary,
      border: isDark ? AppColors.borderDark : AppColors.borderLight,
      isDark: isDark,
    );
  }
}

/// Classe pour les couleurs du thème
class ThemeColors {
  final Color primary;
  final Color secondary;
  final Color surface;
  final Color background;
  final Color onSurface;
  final Color onBackground;
  final Color textPrimary;
  final Color textSecondary;
  final Color border;
  final bool isDark;

  const ThemeColors({
    required this.primary,
    required this.secondary,
    required this.surface,
    required this.background,
    required this.onSurface,
    required this.onBackground,
    required this.textPrimary,
    required this.textSecondary,
    required this.border,
    required this.isDark,
  });
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

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool get _isIOS => !kIsWeb && Platform.isIOS;

  Future<void> _handleSignin() async {
    if (!_formKey.currentState!.validate()) return;

    ref.read(signinStateProvider.notifier).setLoading(true);
    ref.read(signinStateProvider.notifier).clearError();

    try {
      // Simulate signin process
      await Future.delayed(const Duration(seconds: 2));
      
      if (mounted) {
        _showSuccessMessage();
      }
    } catch (e) {
      if (mounted) {
        ref.read(signinStateProvider.notifier).setError('Erreur de connexion');
      }
    } finally {
      if (mounted) {
        ref.read(signinStateProvider.notifier).setLoading(false);
      }
    }
  }

  void _showSuccessMessage() {
    final l10n = AppLocalizations.of(context)!;
    
    if (_isIOS) {
      _showCupertinoAlert(
        title: l10n.success,
        content: 'Connexion réussie !',
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Connexion réussie !'),
          backgroundColor: AppColors.success,
        ),
      );
    }
    
    // Rediriger vers la page d'accueil après succès
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        context.go(AppRoutePaths.home);
      }
    });
  }

  void _showCupertinoAlert({required String title, required String content}) {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          CupertinoDialogAction(
            child: const Text('OK'),
            onPressed: () => context.pop(),
          ),
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final themeColors = ref.getSigninThemeColors(context);
    final signinState = ref.watch(signinStateProvider);

    return _isIOS 
        ? _buildIOS(context, l10n, themeColors, signinState) 
        : _buildAndroid(context, l10n, themeColors, signinState);
  }

  Widget _buildIOS(BuildContext context, AppLocalizations l10n, ThemeColors colors, SigninState signinState) {
    return CupertinoPageScaffold(
      backgroundColor: colors.background,
      child: _buildSigninContent(l10n, colors, signinState),
    );
  }

  Widget _buildAndroid(BuildContext context, AppLocalizations l10n, ThemeColors colors, SigninState signinState) {
    return Scaffold(
      backgroundColor: colors.background,
      body: _buildSigninContent(l10n, colors, signinState),
    );
  }

  Widget _buildSigninContent(AppLocalizations l10n, ThemeColors colors, SigninState signinState) {
    return PlatformSafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppDimensions.paddingL,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: AppDimensions.paddingL),
                _buildBackButton(colors),
                SizedBox(height: AppDimensions.paddingL),
                _buildWelcomeSection(colors),
                SizedBox(height: AppDimensions.paddingL),
                Expanded(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _buildEmailField(colors),
                        SizedBox(height: AppDimensions.paddingM),
                        _buildPasswordField(colors, signinState),
                        SizedBox(height: AppDimensions.paddingS),
                        _buildForgotPasswordLink(colors),
                        if (signinState.error != null) ...[
                          SizedBox(height: AppDimensions.paddingM),
                          _buildErrorBanner(signinState.error!),
                        ],
                        SizedBox(height: AppDimensions.paddingM),
                        _buildSigninButton(colors, signinState),
                        SizedBox(height: AppDimensions.paddingM),
                        _buildSignUpLink(colors),
                        SizedBox(height: AppDimensions.paddingM),
                        _buildDivider(colors),
                        SizedBox(height: AppDimensions.paddingM),
                        _buildSocialLoginButtons(colors),
                        SizedBox(height: AppDimensions.paddingL),
                      ],
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
    return Align(
      alignment: Alignment.centerLeft,
      child: Semantics(
        label: 'Retour',
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
              onTap: () => context.pop(),
              child: Icon(
                _isIOS ? CupertinoIcons.chevron_left : Icons.arrow_back,
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Material(
          color: Colors.transparent,
          child: Text(
            'Bon retour\nparmi nous !',
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
            'Connectez-vous à votre compte',
            style: AppTypography.body.copyWith(
              color: colors.textSecondary,
            ),
          ),
        ),
      ],
    )
        .animate()
        .fadeIn(duration: 600.ms, delay: 100.ms)
        .slideY(begin: 0.2, end: 0.0, curve: Curves.easeOutCubic);
  }

  Widget _buildEmailField(ThemeColors colors) {
    return AppTextField(
      controller: _emailController,
      label: 'Adresse email',
      type: AppTextFieldType.email,
      validator: _validateEmail,
      showValidationErrors: true,
    )
        .animate()
        .fadeIn(duration: 600.ms, delay: 200.ms)
        .slideY(begin: 0.1, end: 0.0, curve: Curves.easeOutCubic);
  }


  Widget _buildPasswordField(ThemeColors colors, SigninState signinState) {
    return AppTextField(
      controller: _passwordController,
      label: 'Mot de passe',
      type: AppTextFieldType.password,
      validator: _validatePassword,
      showValidationErrors: true,
      showPasswordToggle: true,
    )
        .animate()
        .fadeIn(duration: 600.ms, delay: 300.ms)
        .slideY(begin: 0.1, end: 0.0, curve: Curves.easeOutCubic);
  }


  Widget _buildForgotPasswordLink(ThemeColors colors) {
    return Align(
      alignment: Alignment.centerRight,
      child: Semantics(
        label: 'Mot de passe oublié',
        button: true,
        child: TextButton(
          key: const Key('signin_forgot_password'),
          onPressed: () {
            // TODO: Implement forgot password
          },
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Material(
            color: Colors.transparent,
            child: Text(
              'Mot de passe oublié ?',
              style: AppTypography.body.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w500,
                decoration: TextDecoration.none,
              ),
            ),
          ),
        ),
      ),
    )
        .animate()
        .fadeIn(duration: 600.ms, delay: 350.ms);
  }

  Widget _buildErrorBanner(String error) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.error.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppDimensions.radiusS),
        border: Border.all(color: AppColors.error.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Icon(Icons.error_outline, color: AppColors.error, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Material(
              color: Colors.transparent,
              child: Text(
                error,
                style: AppTypography.error.copyWith(color: AppColors.error),
              ),
            ),
          ),
        ],
      ),
    )
        .animate()
        .fadeIn(duration: 300.ms)
        .slideY(begin: -0.1, end: 0.0);
  }

  Widget _buildSigninButton(ThemeColors colors, SigninState signinState) {
    return AppButton(
      text: 'Se connecter',
      onPressed: signinState.isLoading ? null : _handleSignin,
      style: AppButtonStyle.gradient,
      size: AppButtonSize.large,
      isFullWidth: true,
      isLoading: signinState.isLoading,
      customBorderRadius: 28,
      icon: Icons.arrow_forward,
      iconPosition: IconPosition.right,
    )
        .animate()
        .fadeIn(duration: 600.ms, delay: 400.ms)
        .scale(begin: const Offset(0.95, 0.95), end: const Offset(1.0, 1.0), curve: Curves.easeOutCubic);
  }

  Widget _buildSignUpLink(ThemeColors colors) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          _isIOS ? CupertinoIcons.person : Icons.person_outline,
          size: 18,
          color: colors.textSecondary,
        ),
        const SizedBox(width: 8),
        Material(
          color: Colors.transparent,
          child: Text(
            'Pas encore de compte ? ',
            style: AppTypography.body.copyWith(
              color: colors.textSecondary,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            context.push(AppRoutePaths.signup);
          },
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Material(
            color: Colors.transparent,
            child: Text(
              'S\'inscrire',
              style: AppTypography.body.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
                decoration: TextDecoration.none,
              ),
            ),
          ),
        ),
      ],
    )
        .animate()
        .fadeIn(duration: 600.ms, delay: 500.ms);
  }

  Widget _buildDivider(ThemeColors colors) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 1,
            color: colors.border,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'ou',
            style: AppTypography.small.copyWith(
              color: colors.textSecondary,
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 1,
            color: colors.border,
          ),
        ),
      ],
    )
        .animate()
        .fadeIn(duration: 600.ms, delay: 550.ms);
  }

  Widget _buildSocialLoginButtons(ThemeColors colors) {
    return Row(
      children: [
        Expanded(
          child: _buildGoogleButton(colors),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildAppleButton(colors),
        ),
      ],
    )
        .animate()
        .fadeIn(duration: 600.ms, delay: 600.ms)
        .slideY(begin: 0.1, end: 0.0, curve: Curves.easeOutCubic);
  }

  Widget _buildGoogleButton(ThemeColors colors) {
    return AppButton(
      text: 'Google',
      onPressed: () {
        // TODO: Implement Google sign in
      },
      style: AppButtonStyle.outline,
      size: AppButtonSize.large,
      isFullWidth: true,
      customBorderRadius: 28,
      customColor: colors.surface,
      customTextColor: colors.textPrimary,
      icon: Icons.g_mobiledata,
    );
  }

  Widget _buildAppleButton(ThemeColors colors) {
    return AppButton(
      text: 'Apple',
      onPressed: () {
        // TODO: Implement Apple sign in
      },
      style: AppButtonStyle.primary,
      size: AppButtonSize.large,
      isFullWidth: true,
      customBorderRadius: 28,
      customColor: colors.isDark ? Colors.white : Colors.black,
      customTextColor: colors.isDark ? Colors.black : Colors.white,
      icon: CupertinoIcons.app_badge_fill,
    );
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Veuillez saisir votre email';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Veuillez saisir un email valide';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Veuillez saisir votre mot de passe';
    }
    if (value.length < 6) {
      return 'Le mot de passe doit contenir au moins 6 caractères';
    }
    return null;
  }
}

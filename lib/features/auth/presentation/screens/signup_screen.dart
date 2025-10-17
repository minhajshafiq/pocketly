import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:pocketly/generated/l10n/app_localizations.dart';
import 'package:pocketly/core/constants/app_constants.dart';
import 'package:pocketly/core/router/app_route_paths.dart';
import 'package:pocketly/core/widgets/app_button.dart';
import 'package:pocketly/core/widgets/app_text_field.dart';
import 'package:pocketly/core/widgets/platform_safe_area.dart';
import 'package:pocketly/features/auth/presentation/providers/auth_state_provider.dart';
import 'package:pocketly/features/auth/domain/failures/auth_failures.dart' as auth_failures;

/// Provider pour obtenir les couleurs du thème
final signupThemeColorsProvider = Provider<ThemeColors>((ref) {
  throw UnimplementedError('Use signupThemeColorsProvider.withContext(context)');
});

/// Extension pour utiliser le provider avec un contexte
extension SignupThemeColorsProviderExtension on WidgetRef {
  ThemeColors getSignupThemeColors(BuildContext context) {
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
  bool _hasBeenSubmitted = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  bool get _isIOS => !kIsWeb && Platform.isIOS;

  /// Inscription avec email/password
  Future<void> _handleSignup() async {
    setState(() {
      _hasBeenSubmitted = true;
    });
    
    if (!_formKey.currentState!.validate()) return;

    try {
      // Utiliser AuthActions pour s'inscrire et récupérer directement le UserEntity
      await ref.read(authActionsProvider).signUpWithEmailPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text,
        name: _nameController.text.trim().isNotEmpty ? _nameController.text.trim() : null,
      );

      // Afficher la modal de bienvenue après inscription réussie
      if (mounted) {
        await _showWelcomeModal();
        
        // Rediriger vers l'onboarding
        if (mounted) {
          context.go(AppRoutePaths.step1);
        }
      }
    } on auth_failures.SignUpFailure {
      _showError('Impossible de créer le compte');
    } on auth_failures.EmailAlreadyInUseFailure {
      _showError('Cet email est déjà utilisé');
    } on auth_failures.WeakPasswordFailure {
      _showError('Le mot de passe doit contenir au moins 8 caractères');
    } on auth_failures.InvalidEmailFailure {
      _showError('Adresse email invalide');
    } on auth_failures.NetworkFailure {
      _showError('Vérifiez votre connexion Internet');
    } on auth_failures.AuthFailure catch (e) {
      _showError(e.message);
    } catch (e) {
      _showError('Une erreur inattendue s\'est produite');
    }
  }

  void _showError(String message) {
    if (!mounted) return;
    
    if (_isIOS) {
      _showCupertinoAlert(
        title: 'Erreur',
        content: message,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: AppColors.error,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
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
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
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
    return showCupertinoDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => CupertinoAlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Bienvenue !',
              style: AppTypography.title.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              '🎉',
              style: const TextStyle(fontSize: 24),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12),
            Text(
              'Ton essai Premium de 14 jours est activé',
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
                  'Commencer >',
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
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28),
        ),
        contentPadding: const EdgeInsets.all(24),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Bienvenue !',
                  style: AppTypography.title.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  '🎉',
                  style: const TextStyle(fontSize: 24),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              'Ton essai Premium de 14 jours est activé',
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
                      'Commencer >',
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
    final themeColors = ref.getSignupThemeColors(context);
    final authState = ref.watch(authStateProvider);

    return _isIOS 
        ? _buildIOS(context, l10n, themeColors, authState) 
        : _buildAndroid(context, l10n, themeColors, authState);
  }

  Widget _buildIOS(BuildContext context, AppLocalizations l10n, ThemeColors colors, AsyncValue authState) {
    return CupertinoPageScaffold(
      backgroundColor: colors.background,
      child: _buildSignupContent(l10n, colors, authState),
    );
  }

  Widget _buildAndroid(BuildContext context, AppLocalizations l10n, ThemeColors colors, AsyncValue authState) {
    return Scaffold(
      backgroundColor: colors.background,
      body: _buildSignupContent(l10n, colors, authState),
    );
  }

  Widget _buildSignupContent(AppLocalizations l10n, ThemeColors colors, AsyncValue authState) {
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
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Material(
          color: Colors.transparent,
          child: Text(
            'Créer un\ncompte',
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
            'Rejoignez-nous et commencez votre aventure',
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
      hasBeenSubmitted: _hasBeenSubmitted,
    )
        .animate()
        .fadeIn(duration: 600.ms, delay: 200.ms)
        .slideY(begin: 0.1, end: 0.0, curve: Curves.easeOutCubic);
  }


  Widget _buildPasswordField(ThemeColors colors) {
    return AppTextField(
      controller: _passwordController,
      label: 'Mot de passe',
      type: AppTextFieldType.password,
      validator: _validatePassword,
      showValidationErrors: true,
      hasBeenSubmitted: _hasBeenSubmitted,
      showPasswordToggle: true,
    )
        .animate()
        .fadeIn(duration: 600.ms, delay: 300.ms)
        .slideY(begin: 0.1, end: 0.0, curve: Curves.easeOutCubic);
  }


  Widget _buildConfirmPasswordField(ThemeColors colors) {
    return AppTextField(
      controller: _confirmPasswordController,
      label: 'Confirmer le mot de passe',
      type: AppTextFieldType.password,
      validator: _validateConfirmPassword,
      showValidationErrors: true,
      hasBeenSubmitted: _hasBeenSubmitted,
      showPasswordToggle: true,
    )
        .animate()
        .fadeIn(duration: 600.ms, delay: 400.ms)
        .slideY(begin: 0.1, end: 0.0, curve: Curves.easeOutCubic);
  }



  Widget _buildSignupButton(ThemeColors colors, AsyncValue authState) {
    final isLoading = authState.isLoading;
    
    return AppButton(
      text: 'S\'inscrire',
      onPressed: isLoading ? null : _handleSignup,
      style: AppButtonStyle.gradient,
      size: AppButtonSize.large,
      isFullWidth: true,
      isLoading: isLoading,
      customBorderRadius: 28,
      icon: AppIcons.add,
      iconPosition: IconPosition.right,
    )
        .animate()
        .fadeIn(duration: 600.ms, delay: 500.ms)
        .scale(begin: const Offset(0.95, 0.95), end: const Offset(1.0, 1.0), curve: Curves.easeOutCubic);
  }

  Widget _buildLoginLink(ThemeColors colors) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          AppIcons.profile,
          size: 18,
          color: colors.textSecondary,
        ),
        const SizedBox(width: 8),
        Material(
          color: Colors.transparent,
          child: Text(
            'Déjà un compte ? ',
            style: AppTypography.body.copyWith(
              color: colors.textSecondary,
            ),
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
              'Se connecter',
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
        .fadeIn(duration: 600.ms, delay: 550.ms);
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
        .fadeIn(duration: 600.ms, delay: 600.ms);
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
        .fadeIn(duration: 600.ms, delay: 650.ms)
        .slideY(begin: 0.1, end: 0.0, curve: Curves.easeOutCubic);
  }

  Widget _buildGoogleButton(ThemeColors colors) {
    return AppButton(
      text: 'Google',
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
    return AppButton(
      text: 'Apple',
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
    if (value == null || value.isEmpty) {
      return 'Veuillez saisir votre email';
    }
    // Regex plus permissive et standard pour les emails
    if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(value)) {
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

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Veuillez confirmer votre mot de passe';
    }
    if (value != _passwordController.text) {
      return 'Les mots de passe ne correspondent pas';
    }
    return null;
  }
}

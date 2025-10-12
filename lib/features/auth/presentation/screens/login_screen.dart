import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:pocketly/generated/l10n/app_localizations.dart';
import 'package:pocketly/core/constants/app_constants.dart';

/// Provider pour gérer l'état de connexion
final loginStateProvider = NotifierProvider<LoginStateNotifier, LoginState>(
  () => LoginStateNotifier(),
);

/// État de connexion
class LoginState {
  final bool isLoading;
  final String? error;
  final bool isPasswordVisible;

  const LoginState({
    this.isLoading = false,
    this.error,
    this.isPasswordVisible = false,
  });

  LoginState copyWith({
    bool? isLoading,
    String? error,
    bool? isPasswordVisible,
  }) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
    );
  }
}

/// Notifier pour gérer l'état de connexion
class LoginStateNotifier extends Notifier<LoginState> {
  @override
  LoginState build() => const LoginState();

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
final themeColorsProvider = Provider<ThemeColors>((ref) {
  // Dans Riverpod 3.0, on doit passer le contexte depuis le widget
  // Ce provider sera utilisé avec un contexte passé depuis le widget
  throw UnimplementedError('Use themeColorsProvider.withContext(context)');
});

/// Extension pour utiliser le provider avec un contexte
extension ThemeColorsProviderExtension on WidgetRef {
  ThemeColors getThemeColors(BuildContext context) {
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

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
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

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    ref.read(loginStateProvider.notifier).setLoading(true);
    ref.read(loginStateProvider.notifier).clearError();

    try {
      // Simulate login process
      await Future.delayed(const Duration(seconds: 2));
      
      if (mounted) {
        _showSuccessMessage();
      }
    } catch (e) {
      if (mounted) {
        ref.read(loginStateProvider.notifier).setError('Erreur de connexion');
      }
    } finally {
      if (mounted) {
        ref.read(loginStateProvider.notifier).setLoading(false);
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

  void _togglePasswordVisibility() {
    ref.read(loginStateProvider.notifier).togglePasswordVisibility();
    
    // Haptic feedback for iOS
    if (_isIOS) {
      HapticFeedback.lightImpact();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final themeColors = ref.getThemeColors(context);
    final loginState = ref.watch(loginStateProvider);

    return _isIOS 
        ? _buildIOS(context, l10n, themeColors, loginState) 
        : _buildAndroid(context, l10n, themeColors, loginState);
  }

  Widget _buildIOS(BuildContext context, AppLocalizations l10n, ThemeColors colors, LoginState loginState) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          'Connexion',
          style: AppTypography.iosNavTitle.copyWith(
            color: colors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: colors.surface,
        border: null,
      ),
      child: SafeArea(
        child: _buildLoginContent(l10n, colors, loginState),
      ),
    );
  }

  Widget _buildAndroid(BuildContext context, AppLocalizations l10n, ThemeColors colors, LoginState loginState) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Connexion',
          style: AppTypography.materialAppBarTitle.copyWith(
            color: colors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: colors.textPrimary,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              colors.background,
              colors.surface,
            ],
            stops: const [0.0, 0.3],
          ),
        ),
        child: SafeArea(
          child: _buildLoginContent(l10n, colors, loginState),
        ),
      ),
    );
  }

  Widget _buildLoginContent(AppLocalizations l10n, ThemeColors colors, LoginState loginState) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: AppDimensions.maxContentWidth,
              maxHeight: constraints.maxHeight,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppDimensions.paddingL,
                vertical: AppDimensions.paddingM,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildBrandSection(colors),
                  SizedBox(height: AppDimensions.paddingL),
                  AppContainer.elevated(
                    elevation: 2.0,
                    padding: EdgeInsets.all(AppDimensions.paddingL),
                    margin: EdgeInsets.symmetric(horizontal: AppDimensions.paddingS),
                    backgroundColor: colors.surface,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _buildWelcomeSection(colors),
                          SizedBox(height: AppDimensions.paddingL),
                          _buildEmailField(colors),
                          SizedBox(height: AppDimensions.paddingM),
                          _buildPasswordField(colors, loginState),
                          SizedBox(height: AppDimensions.paddingS),
                          _buildForgotPasswordLink(colors),
                          if (loginState.error != null) ...[
                            SizedBox(height: AppDimensions.paddingS),
                            _buildErrorBanner(loginState.error!),
                          ],
                          SizedBox(height: AppDimensions.paddingL),
                          _buildLoginButton(colors, loginState),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: AppDimensions.paddingL),
                  _buildSignUpLink(colors),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildBrandSection(ThemeColors colors) {
    return Column(
      children: [
        // Logo
        Semantics(
          label: 'Logo Pocketly',
          child: Container(
            key: const Key('login_logo'),
            width: 50,
            height: 50,
        decoration: BoxDecoration(
          gradient: AppColors.primaryGradient,
          borderRadius: BorderRadius.circular(AppDimensions.radiusL),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.3),
              blurRadius: 15,
              offset: const Offset(0, 6),
            ),
          ],
        ),
            child: const Icon(
              Icons.account_balance_wallet,
              color: Colors.white,
              size: 24,
            ),
          ),
        ),
        SizedBox(height: AppDimensions.paddingM),
        
        // Brand name
        Material(
          color: Colors.transparent,
          child: Text(
            'Pocketly',
            style: AppTypography.title.copyWith(
              color: colors.textPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: AppDimensions.paddingXS),
        
        // Tagline
        Material(
          color: Colors.transparent,
          child: Text(
            'Votre compagnon financier intelligent',
            style: AppTypography.small.copyWith(
              color: colors.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    )
        .animate()
        .fadeIn(duration: 600.ms, delay: 100.ms)
        .slideY(begin: 0.2, end: 0.0, curve: Curves.easeOutCubic);
  }

  Widget _buildWelcomeSection(ThemeColors colors) {
    return Column(
      children: [
        // Welcome message
        Material(
          color: Colors.transparent,
          child: Text(
            'Bon retour parmi nous !',
            style: AppTypography.title.copyWith(
              color: colors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(height: AppDimensions.paddingS),
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
        .fadeIn(duration: 600.ms, delay: 200.ms)
        .slideY(begin: 0.1, end: 0.0, curve: Curves.easeOutCubic);
  }

  Widget _buildEmailField(ThemeColors colors) {
    return Semantics(
      label: 'Champ email',
      textField: true,
      child: Container(
        key: const Key('login_email_field'),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
          border: Border.all(color: colors.border, width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: _isIOS ? _buildCupertinoEmailField(colors) : _buildMaterialEmailField(colors),
      ),
    )
        .animate()
        .fadeIn(duration: 600.ms, delay: 200.ms)
        .slideX(begin: -0.1, end: 0.0, curve: Curves.easeOutCubic);
  }

  Widget _buildCupertinoEmailField(ThemeColors colors) {
    return CupertinoTextFormFieldRow(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      placeholder: 'Adresse email',
      style: AppTypography.body.copyWith(color: colors.textPrimary),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      prefix: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: Icon(CupertinoIcons.mail, size: 20, color: AppColors.primary),
      ),
      decoration: const BoxDecoration(),
      validator: _validateEmail,
    );
  }

  Widget _buildMaterialEmailField(ThemeColors colors) {
    return TextFormField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      style: AppTypography.body.copyWith(color: colors.textPrimary),
      decoration: InputDecoration(
        hintText: 'Adresse email',
        hintStyle: AppTypography.body.copyWith(color: colors.textSecondary),
        prefixIcon: Icon(Icons.email_outlined, size: 20, color: AppColors.primary),
        border: InputBorder.none,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      ),
      validator: _validateEmail,
    );
  }

  Widget _buildPasswordField(ThemeColors colors, LoginState loginState) {
    return Semantics(
      label: 'Champ mot de passe',
      textField: true,
      child: Container(
        key: const Key('login_password_field'),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
          border: Border.all(color: colors.border, width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: _isIOS ? _buildCupertinoPasswordField(colors, loginState) : _buildMaterialPasswordField(colors, loginState),
      ),
    )
        .animate()
        .fadeIn(duration: 600.ms, delay: 300.ms)
        .slideX(begin: 0.1, end: 0.0, curve: Curves.easeOutCubic);
  }

  Widget _buildCupertinoPasswordField(ThemeColors colors, LoginState loginState) {
    return Row(
      children: [
        Expanded(
          child: CupertinoTextFormFieldRow(
            controller: _passwordController,
            obscureText: !loginState.isPasswordVisible,
            placeholder: 'Mot de passe',
            style: AppTypography.body.copyWith(color: colors.textPrimary),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            prefix: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Icon(CupertinoIcons.lock, size: 20, color: AppColors.primary),
            ),
            decoration: const BoxDecoration(),
            validator: _validatePassword,
          ),
        ),
        CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: _togglePasswordVisibility,
          child: Icon(
            loginState.isPasswordVisible ? CupertinoIcons.eye_slash : CupertinoIcons.eye,
            size: 20,
            color: colors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildMaterialPasswordField(ThemeColors colors, LoginState loginState) {
    return TextFormField(
      controller: _passwordController,
      obscureText: !loginState.isPasswordVisible,
      style: AppTypography.body.copyWith(color: colors.textPrimary),
      decoration: InputDecoration(
        hintText: 'Mot de passe',
        hintStyle: AppTypography.body.copyWith(color: colors.textSecondary),
        prefixIcon: Icon(Icons.lock_outlined, size: 20, color: AppColors.primary),
        suffixIcon: IconButton(
          icon: Icon(
            loginState.isPasswordVisible ? Icons.visibility_off : Icons.visibility,
            size: 20,
            color: colors.textSecondary,
          ),
          onPressed: _togglePasswordVisibility,
        ),
        border: InputBorder.none,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      ),
      validator: _validatePassword,
    );
  }

  Widget _buildForgotPasswordLink(ThemeColors colors) {
    return Align(
      alignment: Alignment.centerRight,
      child: Semantics(
        label: 'Mot de passe oublié',
        button: true,
        child: TextButton(
          key: const Key('login_forgot_password'),
          onPressed: () {
            // TODO: Implement forgot password
          },
          child: Material(
            color: Colors.transparent,
            child: Text(
              'Mot de passe oublié ?',
            style: AppTypography.link.copyWith(
              color: AppColors.primary,
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

  Widget _buildLoginButton(ThemeColors colors, LoginState loginState) {
    return Semantics(
      label: 'Bouton de connexion',
      button: true,
      child: Container(
        key: const Key('login_button'),
        width: double.infinity,
        height: AppDimensions.buttonHeightLarge,
        decoration: BoxDecoration(
          gradient: AppColors.primaryGradient,
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(AppDimensions.radiusM),
            onTap: loginState.isLoading ? null : _handleLogin,
            child: Center(
              child: loginState.isLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Material(
                          color: Colors.transparent,
                          child: Text(
                            'Se connecter',
                            style: AppTypography.button.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                          size: 18,
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    )
        .animate()
        .fadeIn(duration: 600.ms, delay: 400.ms)
        .slideY(begin: 0.1, end: 0.0, curve: Curves.easeOutCubic);
  }

  Widget _buildSignUpLink(ThemeColors colors) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.person_outline,
          size: AppDimensions.iconS,
          color: colors.textSecondary,
        ),
        SizedBox(width: AppDimensions.paddingS),
        Material(
          color: Colors.transparent,
          child: Text(
            'Pas encore de compte ? ',
            style: AppTypography.small.copyWith(
              color: colors.textSecondary,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            // TODO: Implement sign up navigation
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
              style: AppTypography.link.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    )
        .animate()
        .fadeIn(duration: 600.ms, delay: 500.ms);
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
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:pocketly/generated/l10n/app_localizations.dart';
import 'package:pocketly/core/core.dart';
import 'package:pocketly/features/auth/presentation/providers/auth_providers.dart';
import 'package:pocketly/features/notifications/notifications.dart';

/// Écran de demande de réinitialisation de mot de passe
///
/// Permet à l'utilisateur d'entrer son email pour recevoir
/// un lien de réinitialisation de mot de passe.
class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _hasInteracted = false;
  bool _isLoading = false;
  bool _emailSent = false;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_onFieldChanged);
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
    super.dispose();
  }

  bool get _isIOS => !kIsWeb && Platform.isIOS;

  /// Vérifie si le formulaire est valide
  bool get _isFormValid {
    return _emailController.text.trim().isNotEmpty &&
           RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
               .hasMatch(_emailController.text.trim());
  }

  /// Valide l'email
  String? _validateEmail(String? value) {
    final l10n = AppLocalizations.of(context)!;

    if (value == null || value.trim().isEmpty) {
      return l10n.emailValidationRequired;
    }

    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (!emailRegex.hasMatch(value.trim())) {
      return l10n.emailValidationInvalid;
    }

    return null;
  }

  /// Envoie l'email de réinitialisation
  Future<void> _handleResetPassword() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    final l10n = AppLocalizations.of(context)!;

    try {
      await ref.read(authProvider.notifier).resetPassword(
        _emailController.text.trim(),
      );

      if (!mounted) return;

      setState(() {
        _isLoading = false;
        _emailSent = true;
      });

      InAppNotificationService.showSuccess(
        context,
        title: l10n.success,
        message: l10n.resetPasswordEmailSent,
      );

      // Retourner à l'écran de connexion après 3 secondes
      Future.delayed(const Duration(seconds: 3), () {
        if (mounted) {
          GoRouter.of(context).pop();
        }
      });
    } catch (error) {
      if (!mounted) return;

      setState(() {
        _isLoading = false;
      });

      String errorMessage = l10n.unexpectedError;

      if (error is AuthenticationError) {
        errorMessage = error.technicalMessage;
      } else if (error is NetworkError) {
        errorMessage = 'Network error. Please check your connection.';
      }

      InAppNotificationService.showError(
        context,
        title: l10n.errorTitle,
        message: errorMessage,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(AppDimensions.paddingL),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: AppDimensions.paddingL),

                // Bouton retour
                _buildBackButton(),

                SizedBox(height: AppDimensions.paddingXL),

                // Header avec icône
                if (!_emailSent) ...[
                  Center(
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        gradient: AppColors.primaryGradient,
                        borderRadius: BorderRadius.circular(AppDimensions.radiusL),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withValues(alpha: 0.3),
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Icon(
                        _isIOS ? CupertinoIcons.lock_shield : Icons.lock_reset,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                  ).animate().fadeIn().scale(),
                ] else ...[
                  // Icône de succès
                  Center(
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: AppColors.success,
                        borderRadius: BorderRadius.circular(AppDimensions.radiusL),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.success.withValues(alpha: 0.3),
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Icon(
                        _isIOS ? CupertinoIcons.checkmark_alt : Icons.check,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                  ).animate().fadeIn().scale(),
                ],

                SizedBox(height: AppDimensions.paddingXL),

                // Titre
                Text(
                  _emailSent ? l10n.checkYourEmail : l10n.forgotPasswordTitle,
                  style: AppTypography.heading.copyWith(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: isDark ? AppColors.textOnDark : AppColors.textPrimary,
                  ),
                  textAlign: TextAlign.center,
                ).animate().fadeIn(delay: 100.ms).slideY(begin: 0.2, end: 0),

                SizedBox(height: AppDimensions.paddingM),

                // Sous-titre
                Text(
                  _emailSent
                      ? l10n.resetPasswordEmailSentDescription
                      : l10n.forgotPasswordSubtitle,
                  style: AppTypography.body.copyWith(
                    color: isDark ? AppColors.textSecondaryOnDark : AppColors.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.2, end: 0),

                SizedBox(height: AppDimensions.paddingXL * 2),

                if (!_emailSent) ...[
                  // Champ email
                  AppTextField(
                    controller: _emailController,
                    label: l10n.emailAddress,
                    type: AppTextFieldType.email,
                    validator: _validateEmail,
                    showValidationErrors: true,
                    hasBeenSubmitted: _hasInteracted,
                    textInputAction: TextInputAction.done,
                    enabled: !_isLoading,
                    onSubmitted: (_) => _isFormValid && !_isLoading ? _handleResetPassword() : null,
                  ).animate().fadeIn(delay: 300.ms).slideX(begin: -0.2, end: 0),

                  SizedBox(height: AppDimensions.paddingXL * 2),

                  // Bouton d'envoi
                  AppButton(
                    text: l10n.sendResetLink,
                    onPressed: _isFormValid && !_isLoading ? _handleResetPassword : null,
                    style: AppButtonStyle.gradient,
                    size: AppButtonSize.large,
                    isFullWidth: true,
                    isLoading: _isLoading,
                    icon: _isIOS ? CupertinoIcons.mail : Icons.email_outlined,
                    iconPosition: IconPosition.left,
                  ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.2, end: 0),

                  SizedBox(height: AppDimensions.paddingXL),

                  // Lien retour à la connexion
                  Center(
                    child: TextButton(
                      onPressed: _isLoading ? null : () => GoRouter.of(context).pop(),
                      child: Text(
                        l10n.backToSignIn,
                        style: AppTypography.body.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ).animate().fadeIn(delay: 500.ms),
                ] else ...[
                  // Message de confirmation
                  Container(
                    padding: EdgeInsets.all(AppDimensions.paddingL),
                    decoration: BoxDecoration(
                      color: AppColors.success.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                      border: Border.all(
                        color: AppColors.success.withValues(alpha: 0.3),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          _isIOS ? CupertinoIcons.info_circle : Icons.info_outline,
                          color: AppColors.success,
                          size: 24,
                        ),
                        SizedBox(width: AppDimensions.paddingM),
                        Expanded(
                          child: Text(
                            l10n.resetPasswordEmailInfo,
                            style: AppTypography.small.copyWith(
                              color: isDark ? AppColors.textOnDark : AppColors.textPrimary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ).animate().fadeIn(delay: 300.ms).scale(),

                  SizedBox(height: AppDimensions.paddingXL),

                  // Bouton retour
                  AppButton(
                    text: l10n.backToSignIn,
                    onPressed: () => GoRouter.of(context).pop(),
                    style: AppButtonStyle.outline,
                    size: AppButtonSize.large,
                    isFullWidth: true,
                    icon: _isIOS ? CupertinoIcons.arrow_left : Icons.arrow_back,
                    iconPosition: IconPosition.left,
                  ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.2, end: 0),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBackButton() {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          color: isDark ? AppColors.surfaceDark : AppColors.surface,
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
              _isIOS ? CupertinoIcons.back : Icons.arrow_back,
              color: isDark ? AppColors.textOnDark : AppColors.textPrimary,
            ),
          ),
        ),
      ),
    ).animate().fadeIn().slideX(begin: -0.2, end: 0);
  }
}

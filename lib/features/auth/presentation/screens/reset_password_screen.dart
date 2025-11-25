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

/// Écran de réinitialisation de mot de passe
///
/// Accessible via deep link: pocketly://reset-password
/// Permet à l'utilisateur de créer un nouveau mot de passe après
/// avoir cliqué sur le lien de réinitialisation reçu par email.
class ResetPasswordScreen extends ConsumerStatefulWidget {
  const ResetPasswordScreen({
    super.key,
    this.token,
  });

  /// Token optionnel (géré automatiquement par Supabase via la session)
  final String? token;

  @override
  ConsumerState<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends ConsumerState<ResetPasswordScreen> {
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _hasInteracted = false;

  @override
  void initState() {
    super.initState();
    // Ajouter des listeners pour reconstruire le widget quand les champs changent
    _newPasswordController.addListener(_onFieldChanged);
    _confirmPasswordController.addListener(_onFieldChanged);
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
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  bool get _isIOS => !kIsWeb && Platform.isIOS;

  /// Vérifie si le formulaire est valide
  bool get _isFormValid {
    final newPassword = _newPasswordController.text;
    final confirmPassword = _confirmPasswordController.text;

    return newPassword.isNotEmpty &&
           confirmPassword.isNotEmpty &&
           newPassword.length >= 12 &&
           newPassword == confirmPassword;
  }

  /// Valide le nouveau mot de passe
  String? _validateNewPassword(String? value) {
    final l10n = AppLocalizations.of(context)!;

    if (value == null || value.isEmpty) {
      return l10n.passwordValidationRequired;
    }

    if (value.length < 12) {
      return l10n.passwordMinLength;
    }

    return null;
  }

  /// Valide la confirmation du mot de passe
  String? _validateConfirmPassword(String? value) {
    final l10n = AppLocalizations.of(context)!;

    if (value == null || value.isEmpty) {
      return l10n.passwordValidationRequired;
    }

    if (value != _newPasswordController.text) {
      return l10n.passwordsDoNotMatch;
    }

    return null;
  }

  /// Met à jour le mot de passe
  Future<void> _handleUpdatePassword() async {
    if (!_formKey.currentState!.validate()) return;

    final l10n = AppLocalizations.of(context)!;

    // Appeler updatePassword
    await ref.read(authProvider.notifier).updatePassword(
      _newPasswordController.text,
    );

    if (!mounted) return;

    // Vérifier le résultat
    final authState = ref.read(authProvider);

    authState.when(
      data: (state) {
        // Afficher un message de succès
        InAppNotificationService.showSuccess(
          context,
          title: l10n.success,
          message: l10n.passwordUpdatedSuccess,
        );

        // Rediriger vers l'écran de connexion après un délai
        Future.delayed(const Duration(seconds: 2), () {
          if (mounted) {
            context.go(AppRoutePaths.signin);
          }
        });
      },
      error: (error, stackTrace) {
        // Gérer les erreurs
        String errorMessage = l10n.unexpectedError;

        if (error is AuthenticationError) {
          // Vérifier si c'est un lien expiré
          final message = error.technicalMessage.toLowerCase();
          if (message.contains('expired') || message.contains('invalid')) {
            errorMessage = l10n.passwordResetLinkExpired;
          } else {
            errorMessage = error.technicalMessage;
          }
        } else if (error is NetworkError) {
          errorMessage = 'Network error. Please check your connection.';
        }

        InAppNotificationService.showError(
          context,
          title: l10n.errorTitle,
          message: errorMessage,
        );
      },
      loading: () {
        // L'indicateur de chargement est déjà affiché par le bouton
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final authState = ref.watch(authProvider);
    final isLoading = authState.isLoading;

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
                SizedBox(height: AppDimensions.paddingXL),

                // Header avec icône
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

                SizedBox(height: AppDimensions.paddingXL),

                // Titre
                Text(
                  l10n.resetPasswordTitle,
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
                  l10n.resetPasswordSubtitle,
                  style: AppTypography.body.copyWith(
                    color: isDark ? AppColors.textSecondaryOnDark : AppColors.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.2, end: 0),

                SizedBox(height: AppDimensions.paddingXL * 2),

                // Champ nouveau mot de passe
                AppTextField(
                  controller: _newPasswordController,
                  label: l10n.newPassword,
                  type: AppTextFieldType.password,
                  validator: _validateNewPassword,
                  showValidationErrors: true,
                  hasBeenSubmitted: _hasInteracted,
                  showPasswordToggle: true,
                  textInputAction: TextInputAction.next,
                  enabled: !isLoading,
                ).animate().fadeIn(delay: 300.ms).slideX(begin: -0.2, end: 0),

                SizedBox(height: AppDimensions.paddingL),

                // Champ confirmation mot de passe
                AppTextField(
                  controller: _confirmPasswordController,
                  label: l10n.confirmPassword,
                  type: AppTextFieldType.password,
                  validator: _validateConfirmPassword,
                  showValidationErrors: true,
                  hasBeenSubmitted: _hasInteracted,
                  showPasswordToggle: true,
                  textInputAction: TextInputAction.done,
                  enabled: !isLoading,
                  onSubmitted: (_) => _isFormValid && !isLoading ? _handleUpdatePassword() : null,
                ).animate().fadeIn(delay: 400.ms).slideX(begin: -0.2, end: 0),

                SizedBox(height: AppDimensions.paddingXL * 2),

                // Bouton de mise à jour
                AppButton(
                  text: l10n.updatePassword,
                  onPressed: _isFormValid && !isLoading ? _handleUpdatePassword : null,
                  style: AppButtonStyle.gradient,
                  size: AppButtonSize.large,
                  isFullWidth: true,
                  isLoading: isLoading,
                  icon: _isIOS ? CupertinoIcons.checkmark_shield : Icons.check_circle_outline,
                  iconPosition: IconPosition.left,
                ).animate().fadeIn(delay: 500.ms).slideY(begin: 0.2, end: 0),

                SizedBox(height: AppDimensions.paddingXL),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

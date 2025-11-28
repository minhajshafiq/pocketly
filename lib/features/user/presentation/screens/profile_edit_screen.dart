import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart' as router;
import 'package:pocketly/core/core.dart';
import 'package:pocketly/core/widgets/animated_page_header.dart';
import 'package:pocketly/features/user/domain/entities/user_entity.dart';
import 'package:pocketly/features/user/presentation/providers/avatar_providers.dart';
import 'package:pocketly/features/user/presentation/providers/user_provider.dart';
import 'package:pocketly/features/user/presentation/widgets/avatar_display_widget.dart';
import 'package:pocketly/features/user/presentation/widgets/avatar_picker_widget.dart';
import 'package:pocketly/generated/l10n/app_localizations.dart';
import 'package:pocketly/features/notifications/notifications.dart';
import 'package:pocketly/features/auth/auth.dart';
import 'package:pocketly/features/settings/presentation/widgets/settings_button_tile.dart';

/// Écran d'édition du profil utilisateur.
///
/// Permet de modifier l'avatar et le nom de l'utilisateur.
class ProfileEditScreen extends ConsumerStatefulWidget {
  const ProfileEditScreen({super.key});

  @override
  ConsumerState<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends ConsumerState<ProfileEditScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scrollController = ScrollController();
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  bool _isSaving = false;

  bool get _isIOS => Platform.isIOS;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final currentUserAsync = ref.watch(currentUserProvider);
    final avatarState = ref.watch(avatarControllerProvider);

    return currentUserAsync.when(
      data: (user) {
        if (user == null) {
          return _buildErrorScreen(l10n, isDark);
        }

        // Initialiser les controllers avec les données actuelles
        if (_nameController.text.isEmpty) {
          _nameController.text = user.name ?? '';
        }
        if (_emailController.text.isEmpty) {
          _emailController.text = user.email;
        }

        return _buildLayout(context, l10n, isDark, user, avatarState);
      },
      loading: () => _buildLoadingScreen(isDark),
      error: (error, stack) => _buildErrorScreen(l10n, isDark),
    );
  }

  Widget _buildLayout(
    BuildContext context,
    AppLocalizations l10n,
    bool isDark,
    UserEntity user,
    AsyncValue<void> avatarState,
  ) {
    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.background,
      body: PlatformSafeArea(
        top: true,
        bottom: false,
        padding: EdgeInsets.only(top: AppDimensions.paddingS),
        child: Stack(
          children: [
            // Contenu scrollable
            SingleChildScrollView(
              controller: _scrollController,
              padding: EdgeInsets.only(
                top: 80, // Espace pour le header
                left: AppDimensions.paddingL,
                right: AppDimensions.paddingL,
                bottom: AppDimensions.paddingL,
        ),
              child: _buildContent(context, l10n, isDark, user, avatarState),
            ),

            // Header sticky animé avec boutons Cancel et Save
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: AnimatedPageHeader(
                title: l10n.editProfile,
                scrollController: _scrollController,
                showBackButton: false,
                leadingButton: _buildCancelButton(context, l10n, isDark),
                actionButton: _buildSaveButton(context, l10n, user, isDark),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCancelButton(
    BuildContext context,
    AppLocalizations l10n,
    bool isDark,
  ) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 100),
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
      child: IconButton(
        onPressed: () => router.GoRouter.of(context).pop(),
        icon: Icon(
          _isIOS ? CupertinoIcons.xmark : Icons.close,
          color: isDark ? AppColors.textOnDark : AppColors.textPrimary,
        ),
        padding: EdgeInsets.zero,
      ),
    );
  }

  Widget _buildSaveButton(
    BuildContext context,
    AppLocalizations l10n,
    UserEntity user,
    bool isDark,
  ) {
    if (_isSaving) {
      return Padding(
        padding: EdgeInsets.all(AppDimensions.paddingS),
        child: _isIOS
            ? const CupertinoActivityIndicator(radius: 10)
            : const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
      );
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 100),
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
      child: IconButton(
        onPressed: () => _handleSave(user),
        icon: Icon(
          _isIOS ? CupertinoIcons.check_mark : Icons.check,
          color: AppColors.primary,
        ),
        padding: EdgeInsets.zero,
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    AppLocalizations l10n,
    bool isDark,
    UserEntity user,
    AsyncValue<void> avatarState,
  ) {
    return Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Avatar Section
            _buildAvatarSection(user),

            SizedBox(height: AppDimensions.paddingXL * 2),

            // Name Field
            _buildNameField(l10n, isDark),

            SizedBox(height: AppDimensions.paddingL),

            // Email (read-only)
            _buildEmailField(l10n, isDark, user),

            SizedBox(height: AppDimensions.paddingL),

            // Options de compte
            _buildAccountOptions(context, l10n, isDark),

            SizedBox(height: AppDimensions.paddingXL),

            // Avatar State Messages
            avatarState.when(
              data: (_) => const SizedBox.shrink(),
              loading: () => _buildAvatarLoadingMessage(l10n, isDark),
              error: (error, stack) => _buildAvatarErrorMessage(error, isDark),
            ),
          ],
      ),
    );
  }

  Widget _buildAvatarSection(UserEntity user) {
    final name = _nameController.text.trim().isEmpty
        ? user.email
        : _nameController.text.trim();

    return Center(
      child: Stack(
        children: [
          AvatarDisplayWidget(
            avatarUrl: user.avatarUrl,
            userName: name,
            size: 120,
          ),
          Positioned(bottom: 0, right: 0, child: const AvatarPickerWidget()),
        ],
      ),
    );
  }

  Widget _buildNameField(AppLocalizations l10n, bool isDark) {
    return AppTextField(
      controller: _nameController,
      label: l10n.fullName,
      hint: l10n.enterFullName,
      textInputAction: TextInputAction.done,
    );
  }

  Widget _buildEmailField(AppLocalizations l10n, bool isDark, UserEntity user) {
    return AppTextField(
      controller: _emailController,
      label: l10n.email,
      enabled: false,
    );
  }

  Widget _buildAccountOptions(
    BuildContext context,
    AppLocalizations l10n,
    bool isDark,
  ) {
    return AppCard(
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          SettingsButtonTile(
            icon: AppIcons.email,
            title: 'Changer l\'email',
            onTap: () => _showChangeEmailModal(context, l10n, isDark),
            iconBackgroundColor: AppColors.secondary,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppDimensions.paddingM),
            child: Divider(
              height: 1,
              thickness: 0.5,
              color: isDark
                  ? AppColors.borderDark.withValues(alpha: 0.3)
                  : AppColors.borderLight.withValues(alpha: 0.3),
            ),
          ),
          SettingsButtonTile(
            icon: AppIcons.lock,
            title: 'Changer le mot de passe',
            onTap: () => _showChangePasswordModal(context, l10n, isDark),
            iconBackgroundColor: AppColors.secondary,
          ),
        ],
      ),
    );
  }

  void _showChangeEmailModal(
    BuildContext context,
    AppLocalizations l10n,
    bool isDark,
  ) {
    final currentEmail = _emailController.text;

    showGeneralDialog<void>(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black.withValues(alpha: 0.5),
      transitionDuration: const Duration(milliseconds: 300),
      useRootNavigator: true,
      pageBuilder: (context, animation, secondaryAnimation) {
        return _ModalWithDrag(
          animation: animation,
          child: _ChangeEmailModal(
            currentEmail: currentEmail,
            onEmailUpdated: () async {
              await ref.read(currentUserProvider.notifier).refreshUser();
            },
          ),
        );
      },
    );
  }

  void _showChangePasswordModal(
    BuildContext context,
    AppLocalizations l10n,
    bool isDark,
  ) {
    showGeneralDialog<void>(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black.withValues(alpha: 0.5),
      transitionDuration: const Duration(milliseconds: 300),
      useRootNavigator: true,
      pageBuilder: (context, animation, secondaryAnimation) {
        return _ModalWithDrag(
          animation: animation,
          child: const _ChangePasswordModal(),
        );
      },
    );
  }

  Widget _buildAvatarLoadingMessage(AppLocalizations l10n, bool isDark) {
    return AppCard(
      padding: EdgeInsets.all(AppDimensions.paddingM),
      child: Row(
        children: [
          if (_isIOS)
            const CupertinoActivityIndicator()
          else
            const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          SizedBox(width: AppDimensions.paddingM),
          Expanded(
            child: Text(
              l10n.uploadingAvatar,
              style: AppTypography.body.copyWith(
                color: isDark ? AppColors.textOnDark : AppColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatarErrorMessage(Object error, bool isDark) {
    return AppCard(
      padding: EdgeInsets.all(AppDimensions.paddingM),
      child: Row(
        children: [
          Icon(
            _isIOS
                ? CupertinoIcons.exclamationmark_circle
                : Icons.error_outline,
            color: AppColors.error,
            size: 20,
          ),
          SizedBox(width: AppDimensions.paddingM),
          Expanded(
            child: Text(
              error.toString(),
              style: AppTypography.body.copyWith(color: AppColors.error),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingScreen(bool isDark) {
    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.background,
      body: Center(
        child: _isIOS
            ? const CupertinoActivityIndicator()
            : const CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildErrorScreen(AppLocalizations l10n, bool isDark) {
    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.background,
      body: Center(
        child: Text(
          l10n.errorLoadingProfile,
          style: AppTypography.body.copyWith(color: AppColors.error),
        ),
      ),
    );
  }

  Future<void> _handleSave(UserEntity currentUser) async {
    if (_isSaving) return;

    final newName = _nameController.text.trim();

    // Vérifier s'il y a des changements
    if (newName == (currentUser.name ?? '')) {
      // Pas de changement, retourner
      router.GoRouter.of(context).pop();
      return;
    }

    setState(() {
      _isSaving = true;
    });

    try {
      // Mettre à jour le nom via le provider
      final updatedUser = currentUser.copyWith(name: newName);
      await ref.read(currentUserProvider.notifier).updateUser(updatedUser);

      // Afficher une notification de succès
      if (mounted) {
        final l10n = AppLocalizations.of(context)!;
        InAppNotificationService.showSuccess(
          context,
          message: l10n.profileUpdated,
        );
        router.GoRouter.of(context).pop();
      }
    } catch (e) {
      // Afficher une notification d'erreur
      if (mounted) {
        final l10n = AppLocalizations.of(context)!;
        InAppNotificationService.showError(
          context,
          message: l10n.errorUpdatingProfile,
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSaving = false;
        });
      }
    }
  }
}

/// Wrapper pour ajouter le drag-to-dismiss aux modals
class _ModalWithDrag extends StatefulWidget {
  final Animation<double> animation;
  final Widget child;

  const _ModalWithDrag({
    required this.animation,
    required this.child,
  });

  @override
  State<_ModalWithDrag> createState() => _ModalWithDragState();
}

class _ModalWithDragState extends State<_ModalWithDrag> {
  double _dragOffset = 0.0;

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, 1),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: widget.animation,
        curve: Curves.easeOut,
      )),
      child: GestureDetector(
        onVerticalDragUpdate: (details) {
          if (details.delta.dy > 0) {
            setState(() {
              _dragOffset = (_dragOffset + details.delta.dy).clamp(0.0, double.infinity);
            });
          }
        },
        onVerticalDragEnd: (details) {
          if (_dragOffset > 100 || details.velocity.pixelsPerSecond.dy > 500) {
            Navigator.of(context).pop();
          } else {
            setState(() => _dragOffset = 0.0);
          }
        },
        child: Transform.translate(
          offset: Offset(0, _dragOffset),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Material(
              color: Colors.transparent,
              child: Container(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.9,
                ),
                decoration: ShapeDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(AppDimensions.radiusXL),
                    ),
                  ),
                ),
                child: widget.child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Modal pour changer l'email
class _ChangeEmailModal extends ConsumerStatefulWidget {
  final String currentEmail;
  final VoidCallback onEmailUpdated;

  const _ChangeEmailModal({
    required this.currentEmail,
    required this.onEmailUpdated,
  });

  @override
  ConsumerState<_ChangeEmailModal> createState() => _ChangeEmailModalState();
}

class _ChangeEmailModalState extends ConsumerState<_ChangeEmailModal> {
  final _formKey = GlobalKey<FormState>();
  final _newEmailController = TextEditingController();
  bool _isLoading = false;
  
  bool get _isIOS => !kIsWeb && Platform.isIOS;

  @override
  void dispose() {
    _newEmailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return PlatformSafeArea(
      bottom: true,
      child: Container(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Poignée de drag
            Container(
              margin: EdgeInsets.only(top: AppDimensions.paddingS, bottom: AppDimensions.paddingXS),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: (isDark ? AppColors.textSecondaryOnDark : AppColors.textSecondary)
                    .withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            // Header
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppDimensions.paddingL, vertical: AppDimensions.paddingM),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Changer l\'email',
                    style: AppTypography.heading.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: isDark ? AppColors.textOnDark : AppColors.textPrimary,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(
                      _isIOS ? CupertinoIcons.xmark : Icons.close,
                      color: isDark ? AppColors.textSecondaryOnDark : AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            // Contenu
            Flexible(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: AppDimensions.paddingL),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Email actuel: ${widget.currentEmail}',
                        style: AppTypography.body.copyWith(
                          color: isDark
                              ? AppColors.textSecondaryOnDark
                              : AppColors.textSecondary,
                        ),
                      ),
                      SizedBox(height: AppDimensions.paddingL),
                      AppTextField(
                        controller: _newEmailController,
                        label: 'Nouvel email',
                        hint: 'Entrez votre email',
                        type: AppTextFieldType.email,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return l10n.emailValidationRequired;
                          }
                          final emailRegex = RegExp(
                            r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                          );
                          if (!emailRegex.hasMatch(value)) {
                            return l10n.emailValidationInvalid;
                          }
                          if (value == widget.currentEmail) {
                            return 'Le nouvel email doit être différent de l\'email actuel';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: AppDimensions.paddingXL),
                    ],
                  ),
                ),
              ),
            ),
            // Boutons d'action
            Padding(
              padding: EdgeInsets.all(AppDimensions.paddingL),
              child: Row(
                children: [
                  Expanded(
                    child: AppButton(
                      text: l10n.cancel,
                      onPressed: _isLoading ? null : () => Navigator.of(context).pop(),
                      style: AppButtonStyle.outline,
                      size: AppButtonSize.large,
                    ),
                  ),
                  SizedBox(width: AppDimensions.paddingM),
                  Expanded(
                    child: AppButton(
                      text: l10n.save,
                      onPressed: _isLoading ? null : _handleSave,
                      isLoading: _isLoading,
                      style: AppButtonStyle.primary,
                      size: AppButtonSize.large,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleSave() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      await ref.read(authProvider.notifier).updateEmail(
            _newEmailController.text.trim(),
          );

      if (mounted) {
        Navigator.of(context).pop();
        InAppNotificationService.showSuccess(
          context,
          message: 'Email mis à jour avec succès',
        );
        widget.onEmailUpdated();
      }
    } catch (e) {
      if (mounted) {
        InAppNotificationService.showError(
          context,
          message: 'Erreur lors de la mise à jour de l\'email',
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }
}

/// Modal pour changer le mot de passe
class _ChangePasswordModal extends ConsumerStatefulWidget {
  const _ChangePasswordModal();

  @override
  ConsumerState<_ChangePasswordModal> createState() => _ChangePasswordModalState();
}

class _ChangePasswordModalState extends ConsumerState<_ChangePasswordModal> {
  final _formKey = GlobalKey<FormState>();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isLoading = false;
  
  bool get _isIOS => !kIsWeb && Platform.isIOS;

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return PlatformSafeArea(
      bottom: true,
      child: Container(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Poignée de drag
            Container(
              margin: EdgeInsets.only(top: AppDimensions.paddingS, bottom: AppDimensions.paddingXS),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: (isDark ? AppColors.textSecondaryOnDark : AppColors.textSecondary)
                    .withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            // Header
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppDimensions.paddingL, vertical: AppDimensions.paddingM),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Changer le mot de passe',
                    style: AppTypography.heading.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: isDark ? AppColors.textOnDark : AppColors.textPrimary,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(
                      _isIOS ? CupertinoIcons.xmark : Icons.close,
                      color: isDark ? AppColors.textSecondaryOnDark : AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            // Contenu
            Flexible(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: AppDimensions.paddingL),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppTextField(
                        controller: _currentPasswordController,
                        label: 'Mot de passe actuel',
                        hint: 'Entrez votre mot de passe',
                        type: AppTextFieldType.password,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return l10n.passwordValidationRequired;
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: AppDimensions.paddingM),
                      AppTextField(
                        controller: _newPasswordController,
                        label: 'Nouveau mot de passe',
                        hint: 'Entrez votre mot de passe',
                        type: AppTextFieldType.password,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return l10n.passwordValidationRequired;
                          }
                          if (value.length < 12) {
                            return l10n.passwordMinLength;
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: AppDimensions.paddingM),
                      AppTextField(
                        controller: _confirmPasswordController,
                        label: l10n.confirmPassword,
                        hint: l10n.confirmPassword ?? 'Confirmez votre mot de passe',
                        type: AppTextFieldType.password,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return l10n.passwordValidationRequired;
                          }
                          if (value != _newPasswordController.text) {
                            return l10n.passwordsDoNotMatch;
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: AppDimensions.paddingXL),
                    ],
                  ),
                ),
              ),
            ),
            // Boutons d'action
            Padding(
              padding: EdgeInsets.all(AppDimensions.paddingL),
              child: Row(
                children: [
                  Expanded(
                    child: AppButton(
                      text: l10n.cancel,
                      onPressed: _isLoading ? null : () => Navigator.of(context).pop(),
                      style: AppButtonStyle.outline,
                      size: AppButtonSize.large,
                    ),
                  ),
                  SizedBox(width: AppDimensions.paddingM),
                  Expanded(
                    child: AppButton(
                      text: l10n.save,
                      onPressed: _isLoading ? null : _handleSave,
                      isLoading: _isLoading,
                      style: AppButtonStyle.primary,
                      size: AppButtonSize.large,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleSave() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      await ref.read(authProvider.notifier).updatePassword(
            _newPasswordController.text.trim(),
          );

      if (mounted) {
        Navigator.of(context).pop();
        InAppNotificationService.showSuccess(
          context,
          message: 'Mot de passe mis à jour avec succès',
        );
      }
    } catch (e) {
      if (mounted) {
        InAppNotificationService.showError(
          context,
          message: 'Erreur lors de la mise à jour du mot de passe',
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }
}

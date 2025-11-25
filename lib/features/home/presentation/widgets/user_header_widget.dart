import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pocketly/core/constants/app_colors.dart';
import 'package:pocketly/core/constants/app_dimensions.dart';
import 'package:pocketly/core/constants/app_icons.dart';
import 'package:pocketly/core/constants/app_typography.dart';
import 'package:pocketly/core/router/app_route_paths.dart';
import 'package:pocketly/generated/l10n/app_localizations.dart';
import 'package:pocketly/features/user/user.dart';

/// Widget d'en-tête avec informations utilisateur.
///
/// Affiche le message de bienvenue, la photo de profil et l'icône de notifications.
class UserHeaderWidget extends ConsumerWidget {
  const UserHeaderWidget({super.key});

  bool get _isIOS => !kIsWeb && Platform.isIOS;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(currentUserProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return userAsync.when(
      data: (user) {
        if (user == null) {
          return _buildLoadingState(isDark);
        }

        // Construire le libellé: nom complet s'il existe, sinon email tronqué avant '@'
        final hasName = (user.name != null && user.name!.trim().isNotEmpty);
        final displayName = hasName
            ? user.name!.trim()
            : (user.email.contains('@')
                  ? user.email.split('@').first
                  : user.email);

        return Padding(
          padding: EdgeInsets.all(AppDimensions.paddingM),
          child: Row(
            children: [
              // Photo de profil ou initiales à gauche
              _buildProfileAvatar(displayName, user.avatarUrl, isDark),

              SizedBox(width: AppDimensions.paddingM),

              // Message de bienvenue et nom
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.welcome,
                      style: AppTypography.small.copyWith(
                        color: isDark
                            ? AppColors.textSecondaryOnDark
                            : AppColors.textSecondary,
                      ),
                    ),
                    SizedBox(height: AppDimensions.paddingXS),
                    Text(
                      displayName,
                      style: AppTypography.heading.copyWith(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: isDark
                            ? AppColors.textOnDark
                            : AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),

              // Icône notifications à droite
              _buildNotificationButton(context, isDark),
            ],
          ),
        );
      },
      loading: () => _buildLoadingState(isDark),
      error: (error, stack) => _buildErrorState(isDark),
    );
  }

  /// Construit le bouton de notifications
  Widget _buildNotificationButton(BuildContext context, bool isDark) {
    if (_isIOS) {
      return CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: () => context.push(AppRoutePaths.notificationsCenter),
        child: Container(
          width: 52,
          height: 52,
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
          child: Icon(
            AppIcons.notification,
            size: 20,
            color: isDark ? AppColors.textOnDark : AppColors.textPrimary,
          ),
        ),
      );
    }

    return InkWell(
      onTap: () => context.push(AppRoutePaths.notificationsCenter),
      borderRadius: BorderRadius.circular(26),
      child: Container(
        width: 52,
        height: 52,
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
        child: Icon(
          AppIcons.notification,
          size: 20,
          color: isDark ? AppColors.textOnDark : AppColors.textPrimary,
        ),
      ),
    );
  }

  /// Construit l'avatar de profil
  Widget _buildProfileAvatar(String name, String? avatar, bool isDark) {
    // Extraire les initiales (première lettre de chaque mot)
    final initials = name
        .split(' ')
        .take(2)
        .map((word) => word.isNotEmpty ? word[0].toUpperCase() : '')
        .join();

    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [AppColors.primary, AppColors.secondary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: avatar != null && avatar.isNotEmpty
          ? ClipOval(
              child: Image.network(
                avatar,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stack) =>
                    _buildInitialsAvatar(initials),
              ),
            )
          : _buildInitialsAvatar(initials),
    );
  }

  /// Construit l'avatar avec initiales
  Widget _buildInitialsAvatar(String initials) {
    return Center(
      child: Text(
        initials,
        style: AppTypography.title.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  /// État de chargement
  Widget _buildLoadingState(bool isDark) {
    return Padding(
      padding: EdgeInsets.all(AppDimensions.paddingM),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: isDark ? AppColors.surfaceDark : AppColors.surface,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: AppDimensions.paddingM),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 80,
                  height: 12,
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.surfaceDark : AppColors.surface,
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                SizedBox(height: AppDimensions.paddingXS),
                Container(
                  width: 120,
                  height: 20,
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.surfaceDark : AppColors.surface,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: isDark ? AppColors.surfaceDark : AppColors.surface,
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
  }

  /// État d'erreur
  Widget _buildErrorState(bool isDark) {
    return Consumer(
      builder: (context, ref, child) {
        final l10n = AppLocalizations.of(context)!;

        return Padding(
          padding: EdgeInsets.all(AppDimensions.paddingM),
          child: Row(
            children: [
              Icon(AppIcons.errorOutline, color: AppColors.error),
              SizedBox(width: AppDimensions.paddingS),
              Expanded(
                child: Text(
                  l10n.errorLoadingUser,
                  style: AppTypography.body.copyWith(color: AppColors.error),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

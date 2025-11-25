import 'package:flutter/material.dart';
import 'package:pocketly/core/constants/app_colors.dart';
import 'package:pocketly/core/constants/app_dimensions.dart';
import 'package:pocketly/core/constants/app_icons.dart';
import 'package:pocketly/core/constants/app_typography.dart';
import 'package:pocketly/core/services/logger_service.dart';
import 'package:pocketly/core/widgets/app_card.dart';
import 'package:pocketly/features/user/domain/entities/user_entity.dart';
import 'package:pocketly/features/user/presentation/widgets/avatar_display_widget.dart';
import 'package:pocketly/generated/l10n/app_localizations.dart';

const _logger = LoggerService();

/// Widget pour afficher la carte de profil utilisateur
class UserProfileCard extends StatelessWidget {
  final UserEntity user;
  final VoidCallback? onEditTap;

  const UserProfileCard({required this.user, this.onEditTap, super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AppCard(
      padding: EdgeInsets.all(AppDimensions.paddingM),
      child: Row(
        children: [
          // Avatar avec initiales
          _buildAvatar(),

          SizedBox(width: AppDimensions.paddingM),

          // Informations utilisateur
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Nom complet
                Text(
                  user.displayName,
                  style: AppTypography.body.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isDark
                        ? AppColors.textOnDark
                        : AppColors.textPrimary,
                  ),
                ),

                SizedBox(height: AppDimensions.paddingXS),

                // Email
                Text(
                  user.email,
                  style: AppTypography.small.copyWith(
                    color: isDark
                        ? AppColors.textSecondaryOnDark
                        : AppColors.textSecondary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),

                SizedBox(height: AppDimensions.paddingXS),

                // Badge "Compte actif"
                _buildStatusBadge(l10n, isDark),
              ],
            ),
          ),

          // Bouton d'édition
          if (onEditTap != null) ...[
            SizedBox(width: AppDimensions.paddingS),
            _buildEditButton(isDark),
          ],
        ],
      ),
    );
  }

  /// Construit l'avatar avec AvatarDisplayWidget
  Widget _buildAvatar() {
    return AvatarDisplayWidget(
      avatarUrl: user.avatarUrl,
      userName: user.displayName,
      size: AppDimensions.iconXL,
    );
  }

  /// Construit le badge de statut
  Widget _buildStatusBadge(AppLocalizations l10n, bool isDark) {
    // Récupérer le statut de l'utilisateur
    final status = user.status;

    _logger.d('Status calculé: $status');
    _logger.d('Trial: ${user.premiumTrialStart} → ${user.premiumTrialEnd}');
    _logger.d('isPremium: ${user.isPremium}, isTrialActive: ${user.isTrialActive}');
    _logger.d('NOW (UTC): ${DateTime.now().toUtc()}');
    _logger.d('Trial Days Left: ${user.trialDaysLeft}');

    // Déterminer le texte et la couleur selon le statut
    String statusText;
    Color statusColor;

    switch (status) {
      case 'premium':
        statusText = l10n.statusPremium;
        statusColor = const Color(0xFF9333EA); // Purple
        break;
      case 'trial':
        statusText = l10n.statusTrial;
        statusColor = const Color(0xFFF97316); // Orange
        break;
      case 'free':
      default:
        statusText = l10n.statusFree;
        statusColor = const Color(0xFF6B7280); // Gray
        break;
    }

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingS,
        vertical: AppDimensions.paddingXS,
      ),
      decoration: BoxDecoration(
        color: statusColor.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(AppDimensions.radiusS),
      ),
      child: Text(
        statusText,
        style: AppTypography.label.copyWith(
          color: statusColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  /// Construit le bouton d'édition
  Widget _buildEditButton(bool isDark) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onEditTap,
        borderRadius: BorderRadius.circular(AppDimensions.radiusXS),
        child: Container(
          padding: EdgeInsets.all(AppDimensions.paddingXS),
          child: Icon(
            AppIcons.edit,
            size: AppDimensions.iconM,
            color: isDark
                ? AppColors.textSecondaryOnDark
                : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }
}

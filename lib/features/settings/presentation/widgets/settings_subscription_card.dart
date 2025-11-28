import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:pocketly/core/constants/app_colors.dart';
import 'package:pocketly/core/constants/app_dimensions.dart';
import 'package:pocketly/core/constants/app_icons.dart';
import 'package:pocketly/core/constants/app_typography.dart';
import 'package:pocketly/core/widgets/app_card.dart';
import 'package:pocketly/features/notifications/notifications.dart';
import 'package:pocketly/features/subscription/domain/entities/subscription_status_entity.dart';
import 'package:pocketly/features/subscription/presentation/providers/subscription_providers.dart';
import 'package:pocketly/features/user/user.dart';
import 'package:pocketly/generated/l10n/app_localizations.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:purchases_ui_flutter/purchases_ui_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

/// Widget affichant les informations d'abonnement et les options de gestion
class SettingsSubscriptionCard extends ConsumerWidget {
  const SettingsSubscriptionCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final userAsync = ref.watch(currentUserProvider);

    return userAsync.when(
      data: (user) {
        if (user == null) return const SizedBox.shrink();

        return AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header avec icône et titre
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(AppDimensions.paddingS),
                    decoration: BoxDecoration(
                      gradient: user.canAccessPremium
                          ? LinearGradient(
                              colors: [AppColors.primary, AppColors.secondary],
                            )
                          : null,
                      color: user.canAccessPremium
                          ? null
                          : (isDark
                              ? AppColors.surfaceDark
                              : AppColors.surface),
                      borderRadius:
                          BorderRadius.circular(AppDimensions.radiusM),
                    ),
                    child: Icon(
                      user.canAccessPremium
                          ? AppIcons.starRounded
                          : AppIcons.lock,
                      color: user.canAccessPremium
                          ? Colors.white
                          : (isDark
                              ? AppColors.textSecondaryOnDark
                              : AppColors.textSecondary),
                      size: 20,
                    ),
                  ),
                  SizedBox(width: AppDimensions.paddingM),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.subscription,
                          style: AppTypography.body.copyWith(
                            fontWeight: FontWeight.bold,
                            color: isDark
                                ? AppColors.textOnDark
                                : AppColors.textPrimary,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          _getStatusText(user, l10n),
                          style: AppTypography.small.copyWith(
                            color: _getStatusColor(user),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Badge statut
                  _buildStatusBadge(user, l10n, isDark),
                ],
              ),

              // Informations détaillées
              if (user.canAccessPremium) ...[
                SizedBox(height: AppDimensions.paddingM),

                // Type d'abonnement (Monthly/Yearly) - seulement si premium payant
                if (user.isPremium && !user.isTrialActive && user.activeSubscriptionType != null) ...[
                  _buildDetailRow(
                    icon: AppIcons.starRounded,
                    label: l10n.subscriptionPlan,
                    value: _getSubscriptionTypeLabel(user.activeSubscriptionType, l10n),
                    isDark: isDark,
                    valueColor: AppColors.primary,
                  ),
                  SizedBox(height: AppDimensions.paddingS),
                ],

                _buildDetailRow(
                  icon: AppIcons.calendar,
                  label: user.isTrialActive
                      ? l10n.trialEnd
                      : l10n.renewal,
                  value: user.isTrialActive
                      ? (user.premiumTrialEnd != null
                          ? DateFormat.yMMMd().format(user.premiumTrialEnd!)
                          : l10n.unknown)
                      : (user.premiumExpiresAt != null
                      ? DateFormat.yMMMd().format(user.premiumExpiresAt!)
                          : l10n.unknown),
                  isDark: isDark,
                ),
                if (user.isTrialActive && user.trialDaysLeft > 0) ...[
                  SizedBox(height: AppDimensions.paddingS),
                  _buildDetailRow(
                    icon: AppIcons.target,
                    label: l10n.daysRemaining,
                    value: l10n.daysRemainingCount(user.trialDaysLeft),
                    isDark: isDark,
                    valueColor: user.trialDaysLeft <= 3
                        ? AppColors.warning
                        : AppColors.success,
                  ),
                ],
              ],

              SizedBox(height: AppDimensions.paddingM),
              Divider(height: 1),
              SizedBox(height: AppDimensions.paddingM),

              // Actions
              if (user.canAccessPremium) ...[
                // Bouton Gérer l'abonnement
                _buildActionButton(
                  context: context,
                  icon: AppIcons.settings,
                  label: l10n.manageSubscription,
                  onPressed: () => _handleManageSubscription(context, ref),
                  isDark: isDark,
                ),
              ],

              // Bouton Upgrade (si pas premium)
              if (!user.canAccessPremium) ...[
                SizedBox(height: AppDimensions.paddingS),
                _buildUpgradeButton(context, ref, l10n, isDark),
              ],
            ],
          ),
        );
      },
      loading: () => AppCard(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(AppDimensions.paddingL),
            child: const CircularProgressIndicator(),
          ),
        ),
      ),
      error: (error, stack) => const SizedBox.shrink(),
    );
  }

  Widget _buildStatusBadge(
      UserEntity user, AppLocalizations l10n, bool isDark) {
    String text;
    Color color;

    if (user.isTrialActive) {
      text = l10n.statusTrial;
      color = AppColors.info;
    } else if (user.isPremium) {
      text = l10n.statusPremium;
      color = AppColors.success;
    } else {
      text = l10n.statusFree;
      color = isDark ? AppColors.textSecondaryOnDark : AppColors.textSecondary;
    }

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingS,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppDimensions.radiusS),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Text(
        text,
        style: AppTypography.small.copyWith(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: 11,
        ),
      ),
    );
  }

  Widget _buildDetailRow({
    required IconData icon,
    required String label,
    required String value,
    required bool isDark,
    Color? valueColor,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: isDark
              ? AppColors.textSecondaryOnDark
              : AppColors.textSecondary,
        ),
        SizedBox(width: AppDimensions.paddingS),
        Text(
          label,
          style: AppTypography.small.copyWith(
            color: isDark
                ? AppColors.textSecondaryOnDark
                : AppColors.textSecondary,
          ),
        ),
        Spacer(),
        Text(
          value,
          style: AppTypography.small.copyWith(
            color: valueColor ??
                (isDark ? AppColors.textOnDark : AppColors.textPrimary),
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required BuildContext context,
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
    required bool isDark,
  }) {
    if (Platform.isIOS) {
      return CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: onPressed,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: AppDimensions.paddingM,
            vertical: AppDimensions.paddingS,
          ),
          decoration: BoxDecoration(
            color: isDark
                ? AppColors.surfaceDark.withValues(alpha: 0.5)
                : AppColors.surface,
            borderRadius: BorderRadius.circular(AppDimensions.radiusM),
            border: Border.all(
              color: isDark ? AppColors.borderDark : AppColors.borderLight,
            ),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                size: 18,
                color:
                    isDark ? AppColors.textOnDark : AppColors.textPrimary,
              ),
              SizedBox(width: AppDimensions.paddingS),
              Expanded(
                child: Text(
                  label,
                  style: AppTypography.body.copyWith(
                    color: isDark
                        ? AppColors.textOnDark
                        : AppColors.textPrimary,
                  ),
                ),
              ),
              Icon(
                CupertinoIcons.chevron_right,
                size: 16,
                color: isDark
                    ? AppColors.textSecondaryOnDark
                    : AppColors.textSecondary,
              ),
            ],
          ),
        ),
      );
    }

    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingM,
          vertical: AppDimensions.paddingS,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        ),
      ),
      child: Row(
        children: [
          Icon(icon, size: 18),
          SizedBox(width: AppDimensions.paddingS),
          Expanded(
            child: Text(
              label,
              style: AppTypography.body,
            ),
          ),
          Icon(
            Icons.chevron_right,
            size: 18,
            color: isDark
                ? AppColors.textSecondaryOnDark
                : AppColors.textSecondary,
          ),
        ],
      ),
    );
  }

  Widget _buildUpgradeButton(
    BuildContext context,
    WidgetRef ref,
    AppLocalizations l10n,
    bool isDark,
  ) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primary, AppColors.secondary],
        ),
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _handleUpgradePremium(context, ref),
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppDimensions.paddingM,
              vertical: AppDimensions.paddingM,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(AppIcons.starRounded, color: Colors.white, size: 20),
                SizedBox(width: AppDimensions.paddingS),
                Text(
                  l10n.upgradeToPremium,
                  style: AppTypography.body.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _getStatusText(UserEntity user, AppLocalizations l10n) {
    if (user.isTrialActive) {
      return l10n.trialActive;
    } else if (user.isPremium) {
      return l10n.subscriptionActive;
    } else {
      return l10n.freeAccount;
    }
  }

  Color _getStatusColor(UserEntity user) {
    if (user.isTrialActive) {
      return AppColors.info;
    } else if (user.isPremium) {
      return AppColors.success;
    } else {
      return AppColors.textSecondary;
    }
  }

  String _getSubscriptionTypeLabel(String? subscriptionType, AppLocalizations l10n) {
    if (subscriptionType == null) return l10n.statusPremium;

    switch (subscriptionType.toLowerCase()) {
      case 'monthly':
        return l10n.subscriptionMonthly;
      case 'yearly':
      case 'annual':
        return l10n.subscriptionYearly;
      default:
        return l10n.statusPremium;
    }
  }

  /// Ouvre la page de gestion d'abonnement native (App Store / Play Store)
  Future<void> _handleManageSubscription(
      BuildContext context, WidgetRef ref) async {
    try {
      final Uri url;

      if (Platform.isIOS) {
        // URL pour gérer les abonnements sur iOS
        url = Uri.parse('https://apps.apple.com/account/subscriptions');
      } else {
        // URL pour gérer les abonnements sur Android
        url = Uri.parse(
            'https://play.google.com/store/account/subscriptions');
      }

      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } else {
        throw Exception('Cannot open management page');
      }
    } catch (e) {
      if (context.mounted) {
        final l10n = AppLocalizations.of(context)!;
        InAppNotificationService.showError(
          context,
          title: l10n.error,
          message: l10n.errorOpeningSubscriptionManagement,
        );
      }
    }
  }

  /// Affiche le paywall pour upgrade
  Future<void> _handleUpgradePremium(
      BuildContext context, WidgetRef ref) async {
    try {
      // Afficher le paywall
      final paywallResult = await RevenueCatUI.presentPaywall();

      // Si achat réussi, synchroniser avec Supabase
      if (paywallResult == PaywallResult.purchased ||
          paywallResult == PaywallResult.restored) {

        // Récupérer les infos actualisées
        final customerInfo = await Purchases.getCustomerInfo();
        final hasActiveSubscription = customerInfo.entitlements.active.isNotEmpty;

        if (hasActiveSubscription) {
          // Synchroniser avec Supabase
          await ref
              .read(subscriptionRepositoryProvider)
              .syncSubscriptionToBackend(
                _parseCustomerInfoToStatus(customerInfo),
              );
        }

        // Rafraîchir l'UI
        ref.invalidate(currentUserProvider);
        ref.invalidate(canAccessPremiumProvider);

        if (context.mounted) {
          final l10n = AppLocalizations.of(context)!;
          InAppNotificationService.showSuccess(
            context,
            title: l10n.success,
            message: paywallResult == PaywallResult.purchased
                ? l10n.subscriptionPurchaseSuccess
                : l10n.subscriptionRestoreSuccess,
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        final l10n = AppLocalizations.of(context)!;
        InAppNotificationService.showError(
          context,
          title: l10n.error,
          message: l10n.subscriptionPurchaseError(e.toString()),
        );
      }
    }
  }

  SubscriptionStatusEntity _parseCustomerInfoToStatus(
      CustomerInfo customerInfo) {
    final entitlements = customerInfo.entitlements.active;

    if (entitlements.isEmpty) {
      return const SubscriptionStatusEntity(
        status: SubscriptionStatus.free,
        isPremium: false,
      );
    }

    final entitlement = entitlements.values.first;

    // Déterminer le type d'abonnement à partir du productIdentifier
    final productId = entitlement.productIdentifier;
    String? subscriptionType;

    if (productId.contains('monthly')) {
      subscriptionType = 'monthly';
    } else if (productId.contains('yearly') || productId.contains('annual')) {
      subscriptionType = 'yearly';
    }

    return SubscriptionStatusEntity(
      status: SubscriptionStatus.premium,
      isPremium: true,
      expirationDate: entitlement.expirationDate != null
          ? DateTime.parse(entitlement.expirationDate!)
          : null,
      activeSubscriptionType: subscriptionType,
      willRenew: entitlement.willRenew,
    );
  }
}

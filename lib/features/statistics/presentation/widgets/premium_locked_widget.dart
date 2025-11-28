import 'dart:io';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocketly/core/constants/app_colors.dart';
import 'package:pocketly/core/constants/app_dimensions.dart';
import 'package:pocketly/core/constants/app_icons.dart';
import 'package:pocketly/core/constants/app_typography.dart';
import 'package:pocketly/features/notifications/notifications.dart';
import 'package:pocketly/features/subscription/domain/entities/subscription_status_entity.dart';
import 'package:pocketly/features/subscription/presentation/providers/subscription_providers.dart';
import 'package:pocketly/generated/l10n/app_localizations.dart';
import 'package:pocketly/features/user/user.dart';
import 'package:purchases_ui_flutter/purchases_ui_flutter.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

/// Overlay affiché quand l'utilisateur n'a pas accès aux fonctionnalités premium
class PremiumLockedOverlay extends ConsumerWidget {
  const PremiumLockedOverlay({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context)!;
    final userAsync = ref.watch(currentUserProvider);

    return Positioned.fill(
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
          child: Container(
            alignment: Alignment.center,
            color: Colors.black.withOpacity(isDark ? 0.55 : 0.35),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: AppDimensions.paddingL),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 420),
        child: Column(
                  mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              l10n.premiumFeature,
              style: AppTypography.display.copyWith(
                fontWeight: FontWeight.bold,
                        color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
                    SizedBox(height: AppDimensions.paddingS),
            Text(
                      l10n.premiumFeatureOnlyMembers,
              style: AppTypography.body.copyWith(
                        color: Colors.white.withValues(alpha: 0.85),
                        fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: AppDimensions.paddingXL),
                    userAsync.when(
                      data: (_) => _buildUpsellCard(context, l10n, ref),
                      loading: () => Padding(
                        padding: EdgeInsets.all(AppDimensions.paddingM),
                        child: const CircularProgressIndicator(),
                      ),
                      error: (error, stack) => const SizedBox.shrink(),
                    ),
          ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUpsellCard(
    BuildContext context,
    AppLocalizations l10n,
    WidgetRef ref,
  ) {
    final openPaywall = () => _handleUpgradePremium(context, ref);

    return Semantics(
      button: true,
      label: l10n.upgradeToPremium,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: openPaywall,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(AppDimensions.paddingL),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.primary,
                AppColors.secondary,
              ],
            ),
            borderRadius: BorderRadius.circular(AppDimensions.radiusXL),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.25),
                blurRadius: 30,
                offset: const Offset(0, 18),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          l10n.subscriptionUnlockFeatures,
                          style: AppTypography.heading.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        if (l10n.premiumUnlockDescription.isNotEmpty) ...[
                          SizedBox(height: AppDimensions.paddingS),
                          Text(
                            l10n.premiumUnlockDescription,
                            style: AppTypography.body.copyWith(
                              color: Colors.white.withValues(alpha: 0.85),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  SizedBox(width: AppDimensions.paddingM),
                  _buildBrandBadge(),
                ],
              ),
              SizedBox(height: AppDimensions.paddingL),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: AppDimensions.paddingM,
                  vertical: AppDimensions.paddingS,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.18),
                  borderRadius: BorderRadius.circular(AppDimensions.radiusL),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.35),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      AppIcons.starRounded,
                      color: Colors.white,
                    ),
                    SizedBox(width: AppDimensions.paddingS),
                    Text(
                      l10n.upgradeToPremium,
                      style: AppTypography.body.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBrandBadge() {
    const logoUrl =
        'https://bwdqbfromrqpcphcydoq.supabase.co/storage/v1/object/public/Pocketly-files/icon.png';
    return SizedBox(
      width: 56,
      height: 56,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        child: Image.network(
          logoUrl,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(AppDimensions.radiusM),
              ),
              child: Center(
                child: Icon(
                  AppIcons.wallet,
                  color: Colors.white,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  /// Gère le démarrage du trial
  Future<void> _handleStartTrial(
    BuildContext context,
    WidgetRef ref,
    String userId,
  ) async {
    try {
      // Activer le trial
      await ref.read(currentUserProvider.notifier).activateTrial(userId);

      if (context.mounted) {
        final l10n = AppLocalizations.of(context)!;
        _showSuccessMessage(context, l10n.trialActivated);
      }
    } catch (e) {
      if (context.mounted) {
        final l10n = AppLocalizations.of(context)!;
        _showErrorMessage(context, l10n.errorActivatingTrial);
      }
    }
  }

  /// Gère l'upgrade vers premium avec le paywall natif RevenueCat
  Future<void> _handleUpgradePremium(
    BuildContext context,
    WidgetRef ref,
  ) async {
    try {
      // Afficher le paywall natif RevenueCat
      final paywallResult = await RevenueCatUI.presentPaywall();

      // Si achat ou restauration réussi, synchroniser avec Supabase
      if (paywallResult == PaywallResult.purchased ||
          paywallResult == PaywallResult.restored) {

        // 1. Récupérer les infos actualisées de RevenueCat
        final customerInfo = await Purchases.getCustomerInfo();

        // 2. Vérifier si l'utilisateur a un abonnement actif
        final hasActiveSubscription = customerInfo.entitlements.active.isNotEmpty;

        if (hasActiveSubscription) {
          // 3. Synchroniser avec Supabase via le repository
          await ref
              .read(subscriptionRepositoryProvider)
              .syncSubscriptionToBackend(
                _parseCustomerInfoToStatus(customerInfo),
              );
        }

        // 4. Invalider les providers pour rafraîchir l'UI instantanément
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

  /// Parse les informations RevenueCat en SubscriptionStatusEntity
  SubscriptionStatusEntity _parseCustomerInfoToStatus(CustomerInfo customerInfo) {
    final entitlements = customerInfo.entitlements.active;

    if (entitlements.isEmpty) {
      return const SubscriptionStatusEntity(
        status: SubscriptionStatus.free,
        isPremium: false,
        expirationDate: null,
      );
    }

    // Récupérer le premier entitlement actif
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

  /// Affiche un message de succès
  void _showSuccessMessage(BuildContext context, String message) {
    if (Platform.isIOS) {
      showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: Icon(AppIcons.checkCircle, color: Colors.green, size: 48),
          content: Text(message),
          actions: [
            CupertinoDialogAction(
              child: const Text('OK'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(AppIcons.checkCircle, color: Colors.white),
              SizedBox(width: AppDimensions.paddingS),
              Expanded(child: Text(message)),
            ],
          ),
          backgroundColor: AppColors.success,
        ),
      );
    }
  }

  /// Affiche un message d'erreur
  void _showErrorMessage(BuildContext context, String message) {
    if (Platform.isIOS) {
      showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: Icon(AppIcons.error, color: Colors.red, size: 48),
          content: Text(message),
          actions: [
            CupertinoDialogAction(
              child: const Text('OK'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(AppIcons.error, color: Colors.white),
              SizedBox(width: AppDimensions.paddingS),
              Expanded(child: Text(message)),
            ],
          ),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }
}

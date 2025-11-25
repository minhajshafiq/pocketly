import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pocketly/core/core.dart';
import 'package:pocketly/features/subscription/domain/entities/subscription_offer_entity.dart';
import 'package:pocketly/features/subscription/presentation/providers/subscription_providers.dart';
import 'package:pocketly/features/subscription/presentation/widgets/subscription_features_list.dart';
import 'package:pocketly/features/subscription/presentation/widgets/subscription_loading_overlay.dart';
import 'package:pocketly/features/subscription/presentation/widgets/subscription_offer_card.dart';
import 'package:pocketly/features/subscription/presentation/widgets/subscription_purchase_button.dart';
import 'package:pocketly/features/user/user.dart';
import 'package:pocketly/generated/l10n/app_localizations.dart';
import 'package:pocketly/features/notifications/notifications.dart';

/// Écran du paywall pour les abonnements Premium
///
/// Design moderne et adaptatif avec animations
class PaywallScreen extends ConsumerStatefulWidget {
  const PaywallScreen({super.key});

  @override
  ConsumerState<PaywallScreen> createState() => _PaywallScreenState();
}

class _PaywallScreenState extends ConsumerState<PaywallScreen> {
  int _selectedOfferIndex = 1; // Yearly par défaut

  @override
  Widget build(BuildContext context) {
    final offersAsync = ref.watch(subscriptionOffersProvider);
    final controllerState = ref.watch(subscriptionControllerProvider);

    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? Colors.grey[900] : Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Platform.isIOS ? CupertinoIcons.xmark : Icons.close,
            color: isDark ? Colors.white : Colors.black,
          ),
          onPressed: () => GoRouter.of(context).pop(),
        ),
      ),
      body: Stack(
        children: [
          // Contenu principal
          offersAsync.when(
            data: (offers) => _buildContent(context, offers, isDark),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stack) => Center(
              child: ErrorDisplay(
                error: UnknownError(
                  technicalMessage: error.toString(),
                  stackTrace: stack,
                ),
                onRetry: () => ref.invalidate(subscriptionOffersProvider),
              ),
            ),
          ),

          // Overlay de chargement
          if (controllerState.isPurchasing || controllerState.isRestoring)
            SubscriptionLoadingOverlay(
              message: controllerState.isPurchasing
                  ? AppLocalizations.of(context)!.subscriptionPurchasing
                  : AppLocalizations.of(context)!.subscriptionRestoring,
            ),
        ],
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    List<SubscriptionOfferEntity> offers,
    bool isDark,
  ) {
    final l10n = AppLocalizations.of(context)!;
    final userAsync = ref.watch(currentUserProvider);

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          // Header avec icône Premium
          _buildHeader(isDark).animate().fadeIn(duration: 500.ms).slideY(
                begin: -0.2,
                end: 0,
                duration: 500.ms,
                curve: Curves.easeOut,
              ),

          const SizedBox(height: 32),

          // Titre
          Text(
            l10n.subscriptionUnlockFeatures,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Colors.black,
              height: 1.2,
            ),
            textAlign: TextAlign.center,
          ).animate().fadeIn(delay: 200.ms, duration: 500.ms).slideY(
                begin: -0.1,
                end: 0,
                delay: 200.ms,
                duration: 500.ms,
              ),

          const SizedBox(height: 32),

          // Section Trial Gratuit
          userAsync.when(
            data: (user) {
              if (user == null) return const SizedBox.shrink();

              // Ne pas afficher si l'utilisateur est déjà premium ou a déjà eu un trial
              final hasHadTrial = user.premiumTrialStart != null;
              final isTrialActive = user.isTrialActive;
              final isPremium = user.isPremium;

              if (isPremium) return const SizedBox.shrink();

              if (isTrialActive) {
                // Afficher les jours restants
                return _buildActiveTrialBanner(user, isDark, l10n);
              } else if (!hasHadTrial) {
                // Afficher le bouton pour commencer le trial
                return _buildFreeTrialCard(isDark, l10n);
              }
              return const SizedBox.shrink();
            },
            loading: () => const SizedBox.shrink(),
            error: (_, __) => const SizedBox.shrink(),
          ),

          const SizedBox(height: 24),

          // Cartes d'offres
          ...offers.asMap().entries.map((entry) {
            final index = entry.key;
            final offer = entry.value;

            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: SubscriptionOfferCard(
                offer: offer,
                isSelected: _selectedOfferIndex == index,
                onTap: () {
                  setState(() {
                    _selectedOfferIndex = index;
                  });
                },
              ).animate().fadeIn(
                    delay: (300 + index * 100).ms,
                    duration: 500.ms,
                  ).slideX(
                    begin: 0.2,
                    end: 0,
                    delay: (300 + index * 100).ms,
                    duration: 500.ms,
                    curve: Curves.easeOut,
                  ),
            );
          }),

          const SizedBox(height: 32),

          // Bouton S'abonner
          SizedBox(
            width: double.infinity,
            child: SubscriptionPurchaseButton(
              text: l10n.subscriptionStartNow,
              onPressed: () => _handlePurchase(offers[_selectedOfferIndex]),
              isLoading: ref.watch(subscriptionControllerProvider).isPurchasing,
            ),
          ).animate().fadeIn(delay: 600.ms, duration: 500.ms).scale(
                delay: 600.ms,
                duration: 500.ms,
                curve: Curves.easeOut,
              ),

          const SizedBox(height: 24),

          // Liste des fonctionnalités
          const SubscriptionFeaturesList().animate().fadeIn(
                delay: 700.ms,
                duration: 500.ms,
              ),

          const SizedBox(height: 32),

          // Bouton Restaurer
          TextButton(
            onPressed: _handleRestore,
            child: Text(
              l10n.subscriptionRestore,
              style: AppTypography.body.copyWith(
                color: isDark ? Colors.grey[400] : Colors.grey[600],
                decoration: TextDecoration.underline,
              ),
            ),
          ).animate().fadeIn(delay: 800.ms),

          const SizedBox(height: 16),

          // Conditions
          Text(
            l10n.subscriptionTermsAndConditions,
            style: AppTypography.small.copyWith(
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ).animate().fadeIn(delay: 900.ms),

          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildHeader(bool isDark) {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primary,
            AppColors.primary.withValues(alpha: 0.6),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: const Icon(
        Icons.star,
        size: 60,
        color: Colors.white,
      ),
    );
  }

  Future<void> _handlePurchase(SubscriptionOfferEntity offer) async {
    final l10n = AppLocalizations.of(context)!;

    try {
      // Récupérer les packages
      final packages = await ref.read(subscriptionRepositoryProvider).getAvailablePackages();

      // Trouver le package correspondant à l'offre
      final package = packages.firstWhere(
        (p) => p.offerType == offer.type,
        orElse: () => throw Exception('Package introuvable'),
      );

      // Effectuer l'achat
      await ref.read(subscriptionControllerProvider.notifier).purchaseSubscription(package);

      // Invalider le provider canAccessPremium pour rafraîchir
      ref.invalidate(canAccessPremiumProvider);

      if (mounted) {
        // Afficher un message de succès
        InAppNotificationService.showSuccess(
          context,
          message: l10n.subscriptionPurchaseSuccess,
        );

        // Fermer l'écran
        GoRouter.of(context).pop();
      }
    } catch (e) {
      if (mounted) {
        InAppNotificationService.showError(
          context,
          message: l10n.subscriptionPurchaseError(e.toString()),
        );
      }
    }
  }

  Future<void> _handleRestore() async {
    final l10n = AppLocalizations.of(context)!;

    try {
      await ref.read(subscriptionControllerProvider.notifier).restorePurchases();

      // Invalider le provider canAccessPremium
      ref.invalidate(canAccessPremiumProvider);

      if (mounted) {
        InAppNotificationService.showSuccess(
          context,
          message: l10n.subscriptionRestoreSuccess,
        );

        // Fermer l'écran
        GoRouter.of(context).pop();
      }
    } catch (e) {
      if (mounted) {
        InAppNotificationService.showError(
          context,
          message: l10n.subscriptionRestoreError(e.toString()),
        );
      }
    }
  }

  Future<void> _handleActivateFreeTrial() async {
    final l10n = AppLocalizations.of(context)!;

    try {
      await ref.read(subscriptionControllerProvider.notifier).activateFreeTrial();

      if (mounted) {
        InAppNotificationService.showSuccess(
          context,
          message: l10n.freeTrialActivationSuccess,
        );

        // Rafraîchir l'écran
        setState(() {});
      }
    } catch (e) {
      if (mounted) {
        InAppNotificationService.showError(
          context,
          message: l10n.freeTrialActivationError(e.toString()),
        );
      }
    }
  }

  Widget _buildFreeTrialCard(bool isDark, AppLocalizations l10n) {
    final controllerState = ref.watch(subscriptionControllerProvider);

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primary.withValues(alpha: 0.9),
            AppColors.primary.withValues(alpha: 0.7),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          // Badge "14 jours gratuits"
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.celebration,
                  color: Colors.white,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  l10n.freeTrialDuration,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Titre
          Text(
            l10n.freeTrialTitle,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 8),

          // Description
          Text(
            l10n.freeTrialDescription,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.9),
              fontSize: 14,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 24),

          // Bouton Commencer
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: controllerState.isActivatingTrial ? null : _handleActivateFreeTrial,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: controllerState.isActivatingTrial
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                      ),
                    )
                  : Text(
                      l10n.freeTrialStartButton,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 250.ms, duration: 500.ms).scale(
          delay: 250.ms,
          duration: 500.ms,
          curve: Curves.easeOut,
        );
  }

  Widget _buildActiveTrialBanner(UserEntity user, bool isDark, AppLocalizations l10n) {
    final daysLeft = user.trialDaysLeft;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[800] : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.3),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Icône
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.timer,
              color: AppColors.primary,
              size: 24,
            ),
          ),

          const SizedBox(width: 16),

          // Texte
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.freeTrialActive,
                  style: TextStyle(
                    color: isDark ? Colors.white : Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  l10n.freeTrialDaysLeft(daysLeft),
                  style: TextStyle(
                    color: (isDark ? Colors.white : Colors.black).withValues(alpha: 0.7),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),

          // Badge jours restants
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              '$daysLeft',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 250.ms, duration: 500.ms).slideX(
          begin: -0.1,
          end: 0,
          delay: 250.ms,
          duration: 500.ms,
          curve: Curves.easeOut,
        );
  }
}

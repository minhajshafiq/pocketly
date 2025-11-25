import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocketly/core/constants/app_colors.dart';
import 'package:pocketly/core/constants/app_dimensions.dart';
import 'package:pocketly/core/constants/app_icons.dart';
import 'package:pocketly/core/constants/app_typography.dart';
import 'package:pocketly/core/widgets/app_card.dart';
import 'package:pocketly/generated/l10n/app_localizations.dart';
import 'package:pocketly/features/user/user.dart';

/// Widget affiché quand l'utilisateur n'a pas accès aux fonctionnalités premium
class PremiumLockedWidget extends ConsumerWidget {
  const PremiumLockedWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context)!;
    final userAsync = ref.watch(currentUserProvider);

    return Center(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(AppDimensions.paddingL),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icône de verrouillage avec animation
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.primary, AppColors.secondary],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.3),
                    blurRadius: 20,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Icon(AppIcons.lock, size: 60, color: Colors.white),
            ),

            SizedBox(height: AppDimensions.paddingXL),

            // Titre
            Text(
              l10n.premiumFeature,
              style: AppTypography.display.copyWith(
                fontWeight: FontWeight.bold,
                color: isDark ? AppColors.textOnDark : AppColors.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: AppDimensions.paddingM),

            // Description
            Text(
              l10n.premiumFeatureDescription,
              style: AppTypography.body.copyWith(
                color: isDark
                    ? AppColors.textSecondaryOnDark
                    : AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: AppDimensions.paddingXL),

            // Carte des avantages
            AppCard(
              padding: EdgeInsets.all(AppDimensions.paddingL),
              child: Column(
                children: [
                  Text(
                    l10n.premiumBenefits,
                    style: AppTypography.heading.copyWith(
                      fontWeight: FontWeight.bold,
                      color: isDark
                          ? AppColors.textOnDark
                          : AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: AppDimensions.paddingM),
                  _buildBenefit(
                    context,
                    AppIcons.barChart,
                    l10n.detailedStatistics,
                    isDark,
                  ),
                  SizedBox(height: AppDimensions.paddingS),
                  _buildBenefit(
                    context,
                    AppIcons.showChart,
                    l10n.advancedCharts,
                    isDark,
                  ),
                  SizedBox(height: AppDimensions.paddingS),
                  _buildBenefit(
                    context,
                    AppIcons.insights,
                    l10n.financialInsights,
                    isDark,
                  ),
                  SizedBox(height: AppDimensions.paddingS),
                  _buildBenefit(
                    context,
                    AppIcons.history,
                    l10n.unlimitedHistory,
                    isDark,
                  ),
                ],
              ),
            ),

            SizedBox(height: AppDimensions.paddingXL),

            // Boutons d'action
            userAsync.when(
              data: (user) {
                if (user == null) {
                  return const SizedBox.shrink();
                }

                // Vérifier si l'utilisateur a déjà utilisé le trial
                final hasUsedTrial = user.premiumTrialStart != null;

                return Column(
                  children: [
                    // Bouton Trial (seulement si pas encore utilisé)
                    if (!hasUsedTrial) ...[
                      _buildActionButton(
                        context,
                        label: l10n.startFreeTrial,
                        icon: AppIcons.rocketLaunch,
                        isPrimary: true,
                        onPressed: () =>
                            _handleStartTrial(context, ref, user.id),
                      ),
                      SizedBox(height: AppDimensions.paddingM),
                    ],

                    // Bouton Premium
                    _buildActionButton(
                      context,
                      label: l10n.upgradeToPremium,
                      icon: AppIcons.starRounded,
                      isPrimary: hasUsedTrial,
                      onPressed: () => _handleUpgradePremium(context, ref),
                    ),
                  ],
                );
              },
              loading: () => const CircularProgressIndicator(),
              error: (_, __) => const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }

  /// Construit un élément de la liste des avantages
  Widget _buildBenefit(
    BuildContext context,
    IconData icon,
    String text,
    bool isDark,
  ) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(AppDimensions.radiusS),
          ),
          child: Icon(icon, color: AppColors.primary, size: 24),
        ),
        SizedBox(width: AppDimensions.paddingM),
        Expanded(
          child: Text(
            text,
            style: AppTypography.body.copyWith(
              color: isDark ? AppColors.textOnDark : AppColors.textPrimary,
            ),
          ),
        ),
        Icon(AppIcons.checkCircle, color: AppColors.success, size: 20),
      ],
    );
  }

  /// Construit un bouton d'action
  Widget _buildActionButton(
    BuildContext context, {
    required String label,
    required IconData icon,
    required bool isPrimary,
    required VoidCallback onPressed,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (Platform.isIOS) {
      return CupertinoButton(
        onPressed: onPressed,
        padding: EdgeInsets.zero,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: AppDimensions.paddingM),
          decoration: BoxDecoration(
            gradient: isPrimary
                ? LinearGradient(
                    colors: [AppColors.primary, AppColors.secondary],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : null,
            color: isPrimary
                ? null
                : (isDark ? AppColors.surfaceDark : AppColors.surface),
            borderRadius: BorderRadius.circular(AppDimensions.radiusM),
            border: isPrimary
                ? null
                : Border.all(
                    color: isDark
                        ? AppColors.borderDark
                        : AppColors.borderLight,
                  ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: isPrimary
                    ? Colors.white
                    : (isDark ? AppColors.textOnDark : AppColors.textPrimary),
              ),
              SizedBox(width: AppDimensions.paddingS),
              Text(
                label,
                style: AppTypography.body.copyWith(
                  fontWeight: FontWeight.bold,
                  color: isPrimary
                      ? Colors.white
                      : (isDark ? AppColors.textOnDark : AppColors.textPrimary),
                ),
              ),
            ],
          ),
        ),
      );
    }

    // Android Material Design
    return isPrimary
        ? Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.primary, AppColors.secondary],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(AppDimensions.radiusM),
            ),
            child: ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                padding: EdgeInsets.symmetric(vertical: AppDimensions.paddingM),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, color: Colors.white),
                  SizedBox(width: AppDimensions.paddingS),
                  Text(
                    label,
                    style: AppTypography.body.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          )
        : OutlinedButton(
            onPressed: onPressed,
            style: OutlinedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: AppDimensions.paddingM),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppDimensions.radiusM),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon),
                SizedBox(width: AppDimensions.paddingS),
                Text(
                  label,
                  style: AppTypography.body.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
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

  /// Gère l'upgrade vers premium
  Future<void> _handleUpgradePremium(
    BuildContext context,
    WidgetRef ref,
  ) async {
    // TODO: Implémenter la logique d'achat in-app
    // Pour l'instant, afficher un message
    final l10n = AppLocalizations.of(context)!;
    _showInfoMessage(context, l10n.comingSoon);
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

  /// Affiche un message d'information
  void _showInfoMessage(BuildContext context, String message) {
    if (Platform.isIOS) {
      showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: Icon(AppIcons.info, color: Colors.blue, size: 48),
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
              Icon(AppIcons.info, color: Colors.white),
              SizedBox(width: AppDimensions.paddingS),
              Expanded(child: Text(message)),
            ],
          ),
          backgroundColor: AppColors.info,
        ),
      );
    }
  }
}

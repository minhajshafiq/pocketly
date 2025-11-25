import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:pocketly/core/core.dart';
import 'package:pocketly/core/constants/app_icons.dart';
import 'package:pocketly/generated/l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

/// Modal adaptative "À propos de l'app" avec design unifié iOS/Android
/// Utilise la même structure que EditBudgetRuleModal pour passer au-dessus de la bottom nav
class AboutAppModal {
  /// Affiche la modal "À propos" de manière adaptative
  /// Utilise showGeneralDialog avec useRootNavigator: true pour passer au-dessus de la bottom nav
  static Future<void> show(BuildContext context) async {
    final l10n = AppLocalizations.of(context)!;

    showGeneralDialog<void>(
        context: context,
        barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black.withValues(alpha: 0.5),
      transitionDuration: const Duration(milliseconds: 300),
      useRootNavigator: true, // Passe au-dessus de la bottom nav avec MaterialApp.router
      pageBuilder: (context, animation, secondaryAnimation) {
        return _ModalWithDrag(
          animation: animation,
          child: _UnifiedAboutModal(l10n: l10n),
      );
      },
    );
  }
}

/// Wrapper simple pour ajouter le drag-to-dismiss
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

/// Modal unifiée avec le même design sur iOS et Android
class _UnifiedAboutModal extends StatelessWidget {
  final AppLocalizations l10n;

  const _UnifiedAboutModal({required this.l10n});

  bool get _isIOS => !kIsWeb && Platform.isIOS;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final surfaceColor = isDark ? AppColors.surfaceDark : AppColors.surface;
    final textPrimaryColor = isDark
        ? AppColors.textOnDark
        : AppColors.textPrimary;
    final textSecondaryColor = isDark
        ? AppColors.textSecondaryOnDark
        : AppColors.textSecondary;

    if (_isIOS) {
      return _buildIOSContent(context, isDark, surfaceColor, textPrimaryColor, textSecondaryColor);
    }
    return _buildMaterialContent(context, isDark, surfaceColor, textPrimaryColor, textSecondaryColor);
  }

  /// Contenu iOS avec le même style que EditBudgetRuleModal
  Widget _buildIOSContent(
    BuildContext context,
    bool isDark,
    Color surfaceColor,
    Color textPrimaryColor,
    Color textSecondaryColor,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Poignée de drag pour iOS
        Container(
          margin: EdgeInsets.only(top: AppDimensions.paddingS, bottom: AppDimensions.paddingXS),
          width: 40,
          height: 4,
        decoration: BoxDecoration(
            color: textSecondaryColor.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(2),
        ),
        ),
        // Header iOS avec séparateur
        _buildIOSHeader(context, textPrimaryColor, textSecondaryColor),
        // Contenu scrollable
        Flexible(
          child: _buildContent(
            context,
            surfaceColor,
            textPrimaryColor,
            textSecondaryColor,
            true,
          ),
        ),
      ],
    );
  }

  /// Contenu Android avec SafeArea
  Widget _buildMaterialContent(
    BuildContext context,
    bool isDark,
    Color surfaceColor,
    Color textPrimaryColor,
    Color textSecondaryColor,
  ) {
    return SafeArea(
      top: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Poignée de drag pour Android
          Container(
            margin: EdgeInsets.only(top: AppDimensions.paddingS, bottom: AppDimensions.paddingXS),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: textSecondaryColor.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          // Header Android avec séparateur
          _buildMaterialHeader(context, textPrimaryColor, textSecondaryColor),
          // Contenu scrollable
          Flexible(
            child: _buildContent(
              context,
              surfaceColor,
              textPrimaryColor,
              textSecondaryColor,
              false,
            ),
          ),
        ],
      ),
    );
  }

  /// Header iOS avec séparateur (même style que EditBudgetRuleModal)
  Widget _buildIOSHeader(
    BuildContext context,
    Color textPrimaryColor,
    Color textSecondaryColor,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingL,
        vertical: AppDimensions.paddingM,
      ),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: textSecondaryColor.withValues(alpha: 0.2),
                width: 0.5,
              ),
            ),
          ),
          child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                l10n.aboutAppTitle,
                style: AppTypography.heading.copyWith(
              fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: textPrimaryColor,
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  /// Header Android avec séparateur (même style que EditBudgetRuleModal)
  Widget _buildMaterialHeader(
    BuildContext context,
    Color textPrimaryColor,
    Color textSecondaryColor,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingL,
        vertical: AppDimensions.paddingM,
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: textSecondaryColor.withValues(alpha: 0.2),
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            l10n.aboutAppTitle,
            style: AppTypography.heading.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: textPrimaryColor,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  /// Contenu unifié de la modal
  Widget _buildContent(
    BuildContext context,
    Color surfaceColor,
    Color textPrimaryColor,
    Color textSecondaryColor,
    bool isIOS,
  ) {
    final bottomPadding = isIOS ? 0.0 : MediaQuery.of(context).padding.bottom;
    
    return SingleChildScrollView(
      padding: EdgeInsets.only(
        left: AppDimensions.paddingL,
        right: AppDimensions.paddingL,
        top: AppDimensions.paddingL,
        bottom: AppDimensions.paddingL + bottomPadding,
      ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Logo/Icône de l'app avec ombre
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
              child: Image.network(
                'https://bwdqbfromrqpcphcydoq.supabase.co/storage/v1/object/public/Pocketly-files/icon.png',
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    decoration: BoxDecoration(
                      gradient: AppColors.primaryGradient,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                        color: Colors.white,
                      ),
                    ),
                  );
                },
                      errorBuilder: (context, error, stackTrace) {
                        // Fallback si l'image n'existe pas
                        return Container(
                          decoration: BoxDecoration(
                            gradient: AppColors.primaryGradient,
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Icon(
                            AppIcons.wallet,
                            color: Colors.white,
                            size: 50,
                          ),
                        );
                      },
                    ),
                  ),
                ),

          SizedBox(height: AppDimensions.paddingXL),

                // Description
                Text(
                  l10n.aboutAppDescription,
                  style: AppTypography.body.copyWith(
                    color: textSecondaryColor,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),

          SizedBox(height: AppDimensions.paddingXL * 1.5),

                // Fonctionnalités clés
                _buildFeature(
                  icon: AppIcons.barChart,
                  text: l10n.aboutFeatureWeeklyView,
                  textColor: textPrimaryColor,
                ),
          SizedBox(height: AppDimensions.paddingM),
                _buildFeature(
                  icon: AppIcons.calendarMonth,
                  text: l10n.aboutFeatureMonthlyTracking,
                  textColor: textPrimaryColor,
                ),
          SizedBox(height: AppDimensions.paddingM),
                _buildFeature(
                  icon: AppIcons.savingsRounded,
                  text: l10n.aboutFeature503020,
                  textColor: textPrimaryColor,
                ),

          SizedBox(height: AppDimensions.paddingXL * 1.5),

                // Créateur
                Text(
                  l10n.aboutCreator,
                  style: AppTypography.small.copyWith(
                    color: textSecondaryColor,
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.center,
                ),

          SizedBox(height: AppDimensions.paddingXL * 1.5),

                // Liens sociaux
                _buildSocialButton(
                  context: context,
                  icon: AppIcons.languageRounded,
                  label: l10n.visitWebsite,
                  url: 'https://www.minhajshafiq.com/',
                  textPrimaryColor: textPrimaryColor,
                  textSecondaryColor: textSecondaryColor,
                ),
          SizedBox(height: AppDimensions.paddingM),
                _buildSocialButton(
                  context: context,
            icon: LucideIcons.linkedin,
            label: 'LinkedIn',
            url: 'https://www.linkedin.com/in/minhajshafiq/',
                  textPrimaryColor: textPrimaryColor,
                  textSecondaryColor: textSecondaryColor,
                ),
          SizedBox(height: AppDimensions.paddingM),
                _buildSocialButton(
                  context: context,
            icon: LucideIcons.instagram,
            label: 'Instagram',
            url: 'https://www.instagram.com/minhajshafiq/',
                  textPrimaryColor: textPrimaryColor,
                  textSecondaryColor: textSecondaryColor,
                ),

          SizedBox(height: AppDimensions.paddingL),
        ],
      ),
      );
  }

  /// Widget pour une fonctionnalité
  Widget _buildFeature({
    required IconData icon,
    required String text,
    required Color textColor,
  }) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(AppDimensions.paddingM),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: AppColors.primary, size: 22),
        ),
        SizedBox(width: AppDimensions.paddingM),
        Expanded(
          child: Text(
            text,
            style: AppTypography.body.copyWith(color: textColor),
          ),
        ),
      ],
    );
  }

  /// Widget pour un lien social
  Widget _buildSocialButton({
    required BuildContext context,
    required IconData icon,
    required String label,
    required String url,
    required Color textPrimaryColor,
    required Color textSecondaryColor,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => _launchURL(url),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: EdgeInsets.all(AppDimensions.paddingL),
          decoration: BoxDecoration(
            color: isDark
                ? AppColors.surfaceDark.withValues(alpha: 0.5)
                : AppColors.surfaceVariant,
            border: Border.all(
              color: textSecondaryColor.withValues(alpha: 0.2),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(icon, color: AppColors.primary, size: 24),
              SizedBox(width: AppDimensions.paddingM),
              Expanded(
                child: Text(
                  label,
                  style: AppTypography.body.copyWith(
                    color: textPrimaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Icon(
                AppIcons.arrowForwardIOS,
                color: textSecondaryColor,
                size: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Lance une URL dans le navigateur externe
  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}

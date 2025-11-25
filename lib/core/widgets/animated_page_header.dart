import 'package:flutter/material.dart';
import 'package:pocketly/core/constants/app_colors.dart';
import 'package:pocketly/core/constants/app_dimensions.dart';
import 'package:pocketly/core/constants/app_icons.dart';
import 'package:pocketly/core/constants/app_typography.dart';

/// Widget d'en-tête animé générique pour toutes les pages
///
/// Ce widget écoute le scroll et s'adapte automatiquement:
/// - Le titre rétrécit de 28px à 24px
/// - Les boutons rétrécissent de 44px à 40px
/// - Les icônes rétrécissent de 22px à 20px
/// - Reste sticky en haut de la page
class AnimatedPageHeader extends StatefulWidget {
  /// Titre de la page
  final String title;

  /// ScrollController pour écouter les événements de scroll
  final ScrollController scrollController;

  /// Afficher le bouton retour (par défaut: true)
  final bool showBackButton;

  /// Widget personnalisé pour le bouton gauche (remplace le bouton retour par défaut)
  final Widget? leadingButton;

  /// Widget d'action optionnel à droite (ex: bouton de changement de vue)
  final Widget? actionButton;

  const AnimatedPageHeader({
    required this.title,
    required this.scrollController,
    this.showBackButton = true,
    this.leadingButton,
    this.actionButton,
    super.key,
  });

  @override
  State<AnimatedPageHeader> createState() => _AnimatedPageHeaderState();
}

class _AnimatedPageHeaderState extends State<AnimatedPageHeader> {
  /// Progrès du scroll entre 0.0 (pas scrollé) et 1.0 (complètement scrollé)
  double _scrollProgress = 0.0;

  /// Distance de scroll pour compléter la transition (en pixels)
  static const double _maxScrollDistance = 80.0;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_onScroll);
    super.dispose();
  }

  /// Appelé à chaque événement de scroll
  void _onScroll() {
    final currentScroll = widget.scrollController.offset.clamp(
      0.0,
      _maxScrollDistance,
    );
    final progress = (currentScroll / _maxScrollDistance).clamp(0.0, 1.0);

    if (progress != _scrollProgress) {
      setState(() {
        _scrollProgress = progress;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Interpoler les tailles en fonction du scroll
    final titleSize = _interpolate(28.0, 24.0, _scrollProgress);
    final buttonSize = _interpolate(44.0, 40.0, _scrollProgress);
    final iconSize = _interpolate(22.0, 20.0, _scrollProgress);

    return Container(
      color: theme.scaffoldBackgroundColor,
      padding: EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingM,
        vertical: AppDimensions.paddingS,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Bouton gauche personnalisé ou bouton retour par défaut
          if (widget.leadingButton != null)
            SizedBox(
              width: buttonSize,
              height: buttonSize,
              child: widget.leadingButton,
            )
          else if (widget.showBackButton)
            AnimatedContainer(
              duration: const Duration(milliseconds: 100),
              width: buttonSize,
              height: buttonSize,
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
                onPressed: () => Navigator.of(context).pop(),
                icon: Icon(
                  AppIcons.arrowBackIOS,
                  color: isDark ? AppColors.textOnDark : AppColors.textPrimary,
                  size: iconSize,
                ),
                padding: EdgeInsets.zero,
              ),
            )
          else
            // Espaceur pour garder le titre centré si pas de bouton retour
            SizedBox(width: buttonSize, height: buttonSize),

          // Titre centré avec animation de taille
          Expanded(
            child: Center(
              child: Text(
                widget.title,
                style: AppTypography.display.copyWith(
                  fontSize: titleSize,
                  fontWeight: FontWeight.bold,
                  color: isDark ? AppColors.textOnDark : AppColors.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),

          // Bouton d'action optionnel ou espaceur
          if (widget.actionButton != null)
            SizedBox(
              width: buttonSize,
              height: buttonSize,
              child: widget.actionButton,
            )
          else
            // Espaceur pour garder le titre centré si pas de bouton action
            SizedBox(width: buttonSize, height: buttonSize),
        ],
      ),
    );
  }

  /// Interpole une valeur entre min et max en fonction du progrès
  double _interpolate(double min, double max, double progress) {
    return min + (max - min) * progress;
  }
}

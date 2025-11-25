import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocketly/core/constants/app_colors.dart';
import 'package:pocketly/core/constants/app_dimensions.dart';
import 'package:pocketly/core/constants/app_icons.dart';
import 'package:pocketly/core/constants/app_typography.dart';
import 'package:pocketly/features/statistics/domain/entities/chart_data_entity.dart';
import 'package:pocketly/features/statistics/presentation/providers/statistics_providers.dart';
import 'package:pocketly/generated/l10n/app_localizations.dart';

/// Widget d'en-tête animé avec titre et bouton de changement de graphique
///
/// Ce widget écoute le scroll et s'adapte automatiquement:
/// - Le titre rétrécit de 28px à 24px
/// - Le bouton rétrécit de 44px à 40px
/// - L'icône rétrécit de 22px à 20px
/// - Reste sticky en haut de la page
/// - Les 3 éléments (retour, titre, graphique) sont alignés horizontalement
class StatisticsHeaderWidget extends ConsumerStatefulWidget {
  /// ScrollController pour écouter les événements de scroll
  final ScrollController scrollController;

  const StatisticsHeaderWidget({required this.scrollController, super.key});

  @override
  ConsumerState<StatisticsHeaderWidget> createState() =>
      _StatisticsHeaderWidgetState();
}

class _StatisticsHeaderWidgetState
    extends ConsumerState<StatisticsHeaderWidget> {
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
    final chartType = ref.watch(chartTypeProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Interpoler les tailles en fonction du scroll (grandes au départ, réduites après scroll)
    final titleSize = _interpolate(28.0, 24.0, _scrollProgress);
    final buttonSize = _interpolate(44.0, 40.0, _scrollProgress);
    final iconSize = _interpolate(22.0, 20.0, _scrollProgress);

    return Container(
      color: isDark ? AppColors.backgroundDark : AppColors.background,
      padding: EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingM,
        vertical: AppDimensions.paddingS,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Bouton retour avec animation
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
          ),

          // Titre centré avec animation de taille
          Expanded(
            child: Center(
              child: Text(
                AppLocalizations.of(context)!.yourStatistics,
                style: AppTypography.display.copyWith(
                  fontSize: titleSize,
                  fontWeight: FontWeight.bold,
                  color: isDark ? AppColors.textOnDark : AppColors.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),

          // Bouton de changement de graphique avec animation
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
              onPressed: () {
                ref.read(chartTypeProvider.notifier).toggle();
              },
              icon: Icon(
                chartType == ChartType.bar
                    ? AppIcons.barChart
                    : AppIcons.showChart,
                color: AppColors.primary,
                size: iconSize,
              ),
              padding: EdgeInsets.zero,
            ),
          ),
        ],
      ),
    );
  }

  /// Interpole une valeur entre min et max en fonction du progrès
  double _interpolate(double min, double max, double progress) {
    return min + (max - min) * progress;
  }
}

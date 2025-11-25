import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocketly/core/core.dart';
import 'package:pocketly/features/themes/presentation/providers/theme_providers.dart';
import 'package:pocketly/features/themes/domain/entities/theme_entity.dart';

/// Widget pour sélectionner le thème de l'application.
/// 
/// Affiche les options Light, Dark et System avec des icônes et descriptions.
/// Utilise la nouvelle architecture Clean Architecture avec les providers themes.
class ThemeSelector extends ConsumerWidget {
  /// Style du sélecteur
  final ThemeSelectorStyle style;
  
  /// Taille du sélecteur
  final ThemeSelectorSize size;
  
  /// Afficher les descriptions
  final bool showDescriptions;
  
  /// Afficher les icônes
  final bool showIcons;

  const ThemeSelector({
    super.key,
    this.style = ThemeSelectorStyle.card,
    this.size = ThemeSelectorSize.medium,
    this.showDescriptions = true,
    this.showIcons = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(themeProvider);
    final availableThemes = ref.watch(availableThemesProvider);

    return availableThemes.when(
      data: (themes) => _buildSelector(context, ref, currentTheme, themes),
      loading: () => _buildLoadingSelector(context),
      error: (error, stack) => _buildErrorSelector(context, error.toString()),
    );
  }

  /// Construit le sélecteur selon le style
  Widget _buildSelector(
    BuildContext context,
    WidgetRef ref,
    ThemeEntity currentTheme,
    List<ThemeEntity> themes,
  ) {
    switch (style) {
      case ThemeSelectorStyle.card:
        return _buildCardSelector(context, ref, currentTheme, themes);
      case ThemeSelectorStyle.list:
        return _buildListSelector(context, ref, currentTheme, themes);
      case ThemeSelectorStyle.buttons:
        return _buildButtonSelector(context, ref, currentTheme, themes);
    }
  }

  /// Construit le sélecteur en cartes
  Widget _buildCardSelector(
    BuildContext context,
    WidgetRef ref,
    ThemeEntity currentTheme,
    List<ThemeEntity> themes,
  ) {
    return Row(
      children: themes.map((theme) {
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(
              right: theme != themes.last ? AppDimensions.paddingS : 0,
            ),
            child: _buildThemeCard(context, ref, theme, currentTheme),
          ),
        );
      }).toList(),
    );
  }

  /// Construit le sélecteur en liste
  Widget _buildListSelector(
    BuildContext context,
    WidgetRef ref,
    ThemeEntity currentTheme,
    List<ThemeEntity> themes,
  ) {
    return Column(
      children: themes.map((theme) {
        return _buildThemeListTile(context, ref, theme, currentTheme);
      }).toList(),
    );
  }

  /// Construit le sélecteur en boutons
  Widget _buildButtonSelector(
    BuildContext context,
    WidgetRef ref,
    ThemeEntity currentTheme,
    List<ThemeEntity> themes,
  ) {
    return Row(
      children: themes.map((theme) {
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(
              right: theme != themes.last ? AppDimensions.paddingS : 0,
            ),
            child: _buildThemeButton(context, ref, theme, currentTheme),
          ),
        );
      }).toList(),
    );
  }

  /// Construit une carte de thème
  Widget _buildThemeCard(
    BuildContext context,
    WidgetRef ref,
    ThemeEntity theme,
    ThemeEntity currentTheme,
  ) {
    final isSelected = currentTheme.mode == theme.mode;
    final themeData = Theme.of(context);
    final isDark = themeData.brightness == Brightness.dark;
    
    return GestureDetector(
      onTap: () {
        // Animation de transition douce lors du changement de thème
        ref.read(themeProvider.notifier).setTheme(theme);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutCubic,
        padding: EdgeInsets.symmetric(
          vertical: AppDimensions.paddingM,
          horizontal: AppDimensions.paddingM,
        ),
        decoration: BoxDecoration(
          gradient: isSelected
              ? LinearGradient(
                  colors: [
                    AppColors.primary.withValues(alpha: 0.15),
                    AppColors.primary.withValues(alpha: 0.08),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
          color: isSelected 
              ? null
            : (isDark ? AppColors.surfaceDark : AppColors.surface),
          borderRadius: BorderRadius.circular(AppDimensions.radiusL),
          border: Border.all(
            color: isSelected 
              ? AppColors.primary 
                : (isDark ? AppColors.borderDark : AppColors.borderLight),
            width: isSelected ? 2.0 : 1.0,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.25),
                    blurRadius: 12,
                    spreadRadius: 0,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icône avec fond circulaire
              AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeOutCubic,
              padding: EdgeInsets.all(AppDimensions.paddingS),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primary.withValues(alpha: 0.2)
                    : (isDark
                        ? AppColors.textSecondaryOnDark.withValues(alpha: 0.1)
                        : AppColors.textSecondary.withValues(alpha: 0.1)),
                shape: BoxShape.circle,
              ),
                child: Icon(
                  _getThemeIcon(theme),
                  size: _getIconSize(),
                  color: isSelected 
                    ? AppColors.primary 
                    : (isDark ? AppColors.textSecondaryOnDark : AppColors.textSecondary),
                ),
              ),
            SizedBox(height: AppDimensions.paddingS),
            // Titre
                  AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeOutCubic,
              style: AppTypography.bodyBold.copyWith(
                fontSize: AppDimensions.fontSizeS,
                      color: isSelected 
                        ? AppColors.primary 
                        : (isDark ? AppColors.textOnDark : AppColors.textPrimary),
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                    ),
              textAlign: TextAlign.center,
                    child: Text(theme.displayName),
                  ),
                  if (showDescriptions) ...[
              SizedBox(height: AppDimensions.paddingXS / 2),
                    AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeOutCubic,
                      style: AppTypography.caption.copyWith(
                  fontSize: AppDimensions.fontSizeLabel,
                  color: isDark
                      ? AppColors.textSecondaryOnDark
                      : AppColors.textSecondary,
                      ),
                textAlign: TextAlign.center,
                child: Text(
                  _getThemeDescription(theme),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                    ),
                  ],
            // Indicateur de sélection
            if (isSelected) ...[
              SizedBox(height: AppDimensions.paddingXS),
              AnimatedScale(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeOutBack,
                scale: 1.0,
                child: Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                  color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  /// Construit un élément de liste de thème
  Widget _buildThemeListTile(
    BuildContext context,
    WidgetRef ref,
    ThemeEntity theme,
    ThemeEntity currentTheme,
  ) {
    final isSelected = currentTheme.mode == theme.mode;
    
    return ListTile(
      onTap: () => ref.read(themeProvider.notifier).setTheme(theme),
      leading: showIcons ? Icon(
        _getThemeIcon(theme),
        size: _getIconSize(),
        color: isSelected ? AppColors.primary : AppColors.textSecondary,
      ) : null,
      title: Text(
        theme.displayName,
        style: AppTypography.body.copyWith(
          color: isSelected ? AppColors.primary : AppColors.textPrimary,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
        ),
      ),
      subtitle: showDescriptions ? Text(
        _getThemeDescription(theme),
        style: AppTypography.caption.copyWith(
          color: AppColors.textSecondary,
        ),
      ) : null,
      trailing: isSelected ? Icon(
        AppIcons.success,
        color: AppColors.primary,
        size: _getIconSize(),
      ) : null,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusS),
      ),
    );
  }

  /// Construit un bouton de thème
  Widget _buildThemeButton(
    BuildContext context,
    WidgetRef ref,
    ThemeEntity theme,
    ThemeEntity currentTheme,
  ) {
    final isSelected = currentTheme.mode == theme.mode;
    
    return AppButton(
      text: theme.displayName,
      icon: showIcons ? _getThemeIcon(theme) : null,
      onPressed: () => ref.read(themeProvider.notifier).setTheme(theme),
      style: isSelected ? AppButtonStyle.primary : AppButtonStyle.outline,
      size: _getButtonSize(),
    );
  }

  /// Obtient l'icône du thème
  IconData _getThemeIcon(ThemeEntity theme) {
    if (theme.isLight) return Icons.light_mode_outlined;
    if (theme.isDark) return Icons.dark_mode_outlined;
    return Icons.brightness_auto_outlined;
  }

  /// Obtient la description du thème
  String _getThemeDescription(ThemeEntity theme) {
    if (theme.isLight) return 'Clair';
    if (theme.isDark) return 'Sombre';
    return 'Système';
  }

  /// Obtient la taille de l'icône selon la taille du sélecteur
  double _getIconSize() {
    switch (size) {
      case ThemeSelectorSize.small:
        return AppDimensions.iconS;
      case ThemeSelectorSize.medium:
        return AppDimensions.iconM;
      case ThemeSelectorSize.large:
        return AppDimensions.iconL;
    }
  }

  /// Obtient la taille du bouton selon la taille du sélecteur
  AppButtonSize _getButtonSize() {
    switch (size) {
      case ThemeSelectorSize.small:
        return AppButtonSize.small;
      case ThemeSelectorSize.medium:
        return AppButtonSize.medium;
      case ThemeSelectorSize.large:
        return AppButtonSize.large;
    }
  }

  /// Construit le sélecteur en mode chargement
  Widget _buildLoadingSelector(BuildContext context) {
    return Center(
      child: Column(
        children: [
          CircularProgressIndicator(),
          SizedBox(height: AppDimensions.paddingM),
          Text(
            'Loading themes...',
            style: AppTypography.body.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  /// Construit le sélecteur en mode erreur
  Widget _buildErrorSelector(BuildContext context, String error) {
    return Center(
      child: Column(
        children: [
          Icon(
            AppIcons.error,
            size: AppDimensions.iconL,
            color: AppColors.error,
          ),
          SizedBox(height: AppDimensions.paddingM),
          Text(
            'Error loading themes: $error',
            style: AppTypography.body.copyWith(
              color: AppColors.error,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

/// Styles de sélecteur de thème
enum ThemeSelectorStyle {
  card,
  list,
  buttons,
}

/// Tailles de sélecteur de thème
enum ThemeSelectorSize {
  small,
  medium,
  large,
}


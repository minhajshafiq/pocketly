import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocketly/core/constants/app_constants.dart';
import 'package:pocketly/features/themes/presentation/providers/theme_providers.dart';
import 'package:pocketly/features/themes/domain/entities/theme_entity.dart';
import 'package:pocketly/core/widgets/app_button.dart';

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
    final currentTheme = ref.watch(themeNotifierProvider);
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
    return Column(
      children: themes.map((theme) {
        return Column(
          children: [
            _buildThemeCard(context, ref, theme, currentTheme),
            if (theme != themes.last) SizedBox(height: AppDimensions.paddingM),
          ],
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
        ref.read(themeNotifierProvider.notifier).setTheme(theme);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: EdgeInsets.all(AppDimensions.paddingM),
        decoration: BoxDecoration(
          color: isSelected 
            ? AppColors.primary.withValues(alpha: 0.1)
            : (isDark ? AppColors.surfaceDark : AppColors.surface),
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
          border: Border.all(
            color: isSelected 
              ? AppColors.primary 
              : (isDark ? AppColors.grey700 : AppColors.borderLight),
            width: isSelected ? 2.0 : 1.0,
          ),
        ),
        child: Row(
          children: [
            if (showIcons) ...[
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                child: Icon(
                  _getThemeIcon(theme),
                  size: _getIconSize(),
                  color: isSelected 
                    ? AppColors.primary 
                    : (isDark ? AppColors.textSecondaryOnDark : AppColors.textSecondary),
                ),
              ),
              SizedBox(width: AppDimensions.paddingM),
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    style: AppTypography.title.copyWith(
                      color: isSelected 
                        ? AppColors.primary 
                        : (isDark ? AppColors.textOnDark : AppColors.textPrimary),
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                    ),
                    child: Text(theme.displayName),
                  ),
                  if (showDescriptions) ...[
                    SizedBox(height: AppDimensions.paddingXS),
                    AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      style: AppTypography.caption.copyWith(
                        color: isDark ? AppColors.textSecondaryOnDark : AppColors.textSecondary,
                      ),
                      child: Text(_getThemeDescription(theme)),
                    ),
                  ],
                ],
              ),
            ),
            if (isSelected)
              AnimatedScale(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                scale: 1.0,
                child: Icon(
                  AppIcons.success,
                  color: AppColors.primary,
                  size: _getIconSize(),
                ),
              ),
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
      onTap: () => ref.read(themeNotifierProvider.notifier).setTheme(theme),
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
      onPressed: () => ref.read(themeNotifierProvider.notifier).setTheme(theme),
      style: isSelected ? AppButtonStyle.primary : AppButtonStyle.outline,
      size: _getButtonSize(),
    );
  }

  /// Obtient l'icône du thème
  IconData _getThemeIcon(ThemeEntity theme) {
    if (theme.isLight) return AppIcons.add; // Utiliser un icône approprié pour le mode clair
    if (theme.isDark) return AppIcons.add; // Utiliser un icône approprié pour le mode sombre
    return AppIcons.settings; // Utiliser un icône approprié pour le mode système
  }

  /// Obtient la description du thème
  String _getThemeDescription(ThemeEntity theme) {
    if (theme.isLight) return 'Always use light theme';
    if (theme.isDark) return 'Always use dark theme';
    return 'Follow system settings';
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

/// Widget compact pour basculer rapidement entre Light et Dark
class ThemeToggleButton extends ConsumerWidget {
  /// Taille du bouton
  final ThemeToggleSize size;
  
  /// Afficher le label
  final bool showLabel;
  
  /// Afficher l'icône
  final bool showIcon;

  const ThemeToggleButton({
    super.key,
    this.size = ThemeToggleSize.medium,
    this.showLabel = true,
    this.showIcon = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(themeNotifierProvider);

    return AppButton(
      text: showLabel ? 'Theme' : '',
      icon: showIcon ? _getToggleIcon(currentTheme) : null,
      onPressed: () => ref.read(themeNotifierProvider.notifier).toggleTheme(),
      style: AppButtonStyle.secondary,
      tooltip: 'Toggle theme',
    );
  }

  /// Obtient l'icône de basculement selon le thème actuel
  IconData _getToggleIcon(ThemeEntity theme) {
    if (theme.isSystem) {
      return AppIcons.settings;
    }
    return theme.isLight ? AppIcons.add : AppIcons.add; // Utiliser des icônes appropriés
  }
}

/// Tailles de bouton de basculement
enum ThemeToggleSize {
  small,
  medium,
  large,
}

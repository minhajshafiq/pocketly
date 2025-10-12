import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocketly/core/constants/app_constants.dart';
import 'package:pocketly/core/providers/theme_provider.dart';
import 'package:pocketly/core/widgets/app_button.dart';

/// Widget pour sélectionner le thème de l'application.
/// 
/// Affiche les options Light, Dark et System avec des icônes et descriptions.
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
    final themeInfo = ref.watch(themeInfoProvider);

    switch (style) {
      case ThemeSelectorStyle.card:
        return _buildCardSelector(context, ref, themeInfo);
      case ThemeSelectorStyle.list:
        return _buildListSelector(context, ref, themeInfo);
      case ThemeSelectorStyle.buttons:
        return _buildButtonSelector(context, ref, themeInfo);
    }
  }

  /// Construit le sélecteur en cartes
  Widget _buildCardSelector(
    BuildContext context,
    WidgetRef ref,
    ThemeInfo themeInfo,
  ) {
    return Column(
      children: [
        _buildThemeCard(
          context,
          ref,
          ThemeMode.light,
          'Light Mode',
          'Always use light theme',
          Icons.light_mode,
          themeInfo,
        ),
        SizedBox(height: AppDimensions.paddingM),
        _buildThemeCard(
          context,
          ref,
          ThemeMode.dark,
          'Dark Mode',
          'Always use dark theme',
          Icons.dark_mode,
          themeInfo,
        ),
        SizedBox(height: AppDimensions.paddingM),
        _buildThemeCard(
          context,
          ref,
          ThemeMode.system,
          'System Mode',
          'Follow system settings',
          Icons.brightness_auto,
          themeInfo,
        ),
      ],
    );
  }

  /// Construit le sélecteur en liste
  Widget _buildListSelector(
    BuildContext context,
    WidgetRef ref,
    ThemeInfo themeInfo,
  ) {
    return Column(
      children: [
        _buildThemeListTile(
          context,
          ref,
          ThemeMode.light,
          'Light Mode',
          'Always use light theme',
          Icons.light_mode,
          themeInfo,
        ),
        _buildThemeListTile(
          context,
          ref,
          ThemeMode.dark,
          'Dark Mode',
          'Always use dark theme',
          Icons.dark_mode,
          themeInfo,
        ),
        _buildThemeListTile(
          context,
          ref,
          ThemeMode.system,
          'System Mode',
          'Follow system settings',
          Icons.brightness_auto,
          themeInfo,
        ),
      ],
    );
  }

  /// Construit le sélecteur en boutons
  Widget _buildButtonSelector(
    BuildContext context,
    WidgetRef ref,
    ThemeInfo themeInfo,
  ) {
    return Row(
      children: [
        Expanded(
          child: _buildThemeButton(
            context,
            ref,
            ThemeMode.light,
            'Light',
            Icons.light_mode,
            themeInfo,
          ),
        ),
        SizedBox(width: AppDimensions.paddingS),
        Expanded(
          child: _buildThemeButton(
            context,
            ref,
            ThemeMode.dark,
            'Dark',
            Icons.dark_mode,
            themeInfo,
          ),
        ),
        SizedBox(width: AppDimensions.paddingS),
        Expanded(
          child: _buildThemeButton(
            context,
            ref,
            ThemeMode.system,
            'System',
            Icons.brightness_auto,
            themeInfo,
          ),
        ),
      ],
    );
  }

  /// Construit une carte de thème
  Widget _buildThemeCard(
    BuildContext context,
    WidgetRef ref,
    ThemeMode mode,
    String title,
    String description,
    IconData icon,
    ThemeInfo themeInfo,
  ) {
    final isSelected = themeInfo.mode == mode;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    return GestureDetector(
      onTap: () {
        // Animation de transition douce lors du changement de thème
        ref.read(themeModeProvider.notifier).setThemeMode(mode);
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
                  icon,
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
                    child: Text(title),
                  ),
                  if (showDescriptions) ...[
                    SizedBox(height: AppDimensions.paddingXS),
                    AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      style: AppTypography.caption.copyWith(
                        color: isDark ? AppColors.textSecondaryOnDark : AppColors.textSecondary,
                      ),
                      child: Text(description),
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
                  Icons.check_circle,
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
    ThemeMode mode,
    String title,
    String description,
    IconData icon,
    ThemeInfo themeInfo,
  ) {
    final isSelected = themeInfo.mode == mode;
    
    return ListTile(
      onTap: () => ref.read(themeModeProvider.notifier).setThemeMode(mode),
      leading: showIcons ? Icon(
        icon,
        size: _getIconSize(),
        color: isSelected ? AppColors.primary : AppColors.textSecondary,
      ) : null,
      title: Text(
        title,
        style: AppTypography.body.copyWith(
          color: isSelected ? AppColors.primary : AppColors.textPrimary,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
        ),
      ),
      subtitle: showDescriptions ? Text(
        description,
        style: AppTypography.caption.copyWith(
          color: AppColors.textSecondary,
        ),
      ) : null,
      trailing: isSelected ? Icon(
        Icons.check_circle,
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
    ThemeMode mode,
    String title,
    IconData icon,
    ThemeInfo themeInfo,
  ) {
    final isSelected = themeInfo.mode == mode;
    
    return AppButton(
      text: title,
      icon: showIcons ? icon : null,
      onPressed: () => ref.read(themeModeProvider.notifier).setThemeMode(mode),
      style: isSelected ? AppButtonStyle.primary : AppButtonStyle.outline,
      size: _getButtonSize(),
    );
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
    final themeInfo = ref.watch(themeInfoProvider);

    return AppButton(
      text: 'Theme',
      icon: _getToggleIcon(themeInfo),
      onPressed: () => ref.read(themeModeProvider.notifier).toggleTheme(),
      style: AppButtonStyle.secondary,
      tooltip: 'Toggle theme',
    );
  }

  /// Obtient l'icône de basculement selon le thème actuel
  IconData _getToggleIcon(ThemeInfo themeInfo) {
    if (themeInfo.isSystem) {
      return Icons.brightness_auto;
    }
    return themeInfo.isLight ? Icons.dark_mode : Icons.light_mode;
  }
}

/// Tailles de bouton de basculement
enum ThemeToggleSize {
  small,
  medium,
  large,
}
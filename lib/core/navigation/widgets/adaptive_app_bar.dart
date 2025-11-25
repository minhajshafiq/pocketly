import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:pocketly/core/constants/app_colors.dart';
import 'package:pocketly/core/constants/app_typography.dart';
import 'package:pocketly/core/navigation/models/app_bar_config.dart';

/// AppBar adaptative qui s'affiche en Cupertino sur iOS et Material sur Android.
///
/// Usage:
/// ```dart
/// Scaffold(
///   appBar: AdaptiveAppBar(
///     title: 'Mon Écran',
///     actions: [IconButton(...)],
///   ),
/// )
/// ```
class AdaptiveAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// Configuration de l'AppBar
  final AppBarConfig config;

  /// Titre simple (raccourci pour config.title)
  final String? title;

  /// Actions (raccourci pour config.actions)
  final List<Widget>? actions;

  /// Leading widget (raccourci pour config.leading)
  final Widget? leading;

  /// Afficher automatiquement le bouton retour
  final bool automaticallyImplyLeading;

  const AdaptiveAppBar({
    super.key,
    this.config = const AppBarConfig.visible(),
    this.title,
    this.actions,
    this.leading,
    this.automaticallyImplyLeading = true,
  });

  /// Constructeur simplifié avec juste un titre
  const AdaptiveAppBar.simple({
    super.key,
    required String title,
    List<Widget>? actions,
  }) : config = const AppBarConfig.visible(),
       title = title,
       actions = actions,
       leading = null,
       automaticallyImplyLeading = true;

  /// Constructeur pour AppBar transparente
  const AdaptiveAppBar.transparent({
    super.key,
    String? title,
    List<Widget>? actions,
  }) : config = const AppBarConfig.transparent(),
       title = title,
       actions = actions,
       leading = null,
       automaticallyImplyLeading = true;

  bool get _isIOS => !kIsWeb && Platform.isIOS;

  @override
  Widget build(BuildContext context) {
    // Utiliser les valeurs du constructeur si fournies, sinon celles du config
    final effectiveTitle = title ?? config.title;
    final effectiveTitleWidget = config.titleWidget;
    final effectiveActions = actions ?? config.actions;
    final effectiveLeading = leading ?? config.leading;
    final effectiveAutomaticallyImplyLeading =
        automaticallyImplyLeading && config.automaticallyImplyLeading;

    // Ne pas afficher si config.show = false
    if (!config.show) {
      return const SizedBox.shrink();
    }

    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Couleurs par défaut
    final backgroundColor = config.transparent
        ? Colors.transparent
        : config.backgroundColor ??
              (isDark ? AppColors.surfaceDark : AppColors.surface);

    final foregroundColor =
        config.foregroundColor ??
        (isDark ? AppColors.textOnDark : AppColors.textPrimary);

    if (_isIOS) {
      return _buildIOSAppBar(
        context,
        effectiveTitle,
        effectiveTitleWidget,
        effectiveActions,
        effectiveLeading,
        effectiveAutomaticallyImplyLeading,
        backgroundColor,
        foregroundColor,
      );
    }

    return _buildAndroidAppBar(
      context,
      effectiveTitle,
      effectiveTitleWidget,
      effectiveActions,
      effectiveLeading,
      effectiveAutomaticallyImplyLeading,
      backgroundColor,
      foregroundColor,
    );
  }

  /// Construit l'AppBar iOS (Cupertino)
  Widget _buildIOSAppBar(
    BuildContext context,
    String? title,
    Widget? titleWidget,
    List<Widget>? actions,
    Widget? leading,
    bool automaticallyImplyLeading,
    Color backgroundColor,
    Color foregroundColor,
  ) {
    return CupertinoNavigationBar(
      middle:
          titleWidget ??
          (title != null
              ? Text(
                  title,
                  style: AppTypography.title.copyWith(
                    color: foregroundColor,
                    fontWeight: FontWeight.w600,
                  ),
                )
              : null),
      trailing: actions != null && actions.isNotEmpty
          ? Row(mainAxisSize: MainAxisSize.min, children: actions)
          : null,
      leading: leading,
      automaticallyImplyLeading: automaticallyImplyLeading,
      backgroundColor: config.transparent ? null : backgroundColor,
      border: config.transparent
          ? null
          : Border(
              bottom: BorderSide(
                color: Theme.of(context).brightness == Brightness.dark
                    ? AppColors.borderDark
                    : AppColors.borderLight,
                width: 0.5,
              ),
            ),
    );
  }

  /// Construit l'AppBar Android (Material)
  Widget _buildAndroidAppBar(
    BuildContext context,
    String? title,
    Widget? titleWidget,
    List<Widget>? actions,
    Widget? leading,
    bool automaticallyImplyLeading,
    Color backgroundColor,
    Color foregroundColor,
  ) {
    return AppBar(
      title:
          titleWidget ??
          (title != null
              ? Text(
                  title,
                  style: AppTypography.title.copyWith(
                    color: foregroundColor,
                    fontWeight: FontWeight.w600,
                  ),
                )
              : null),
      actions: actions,
      leading: leading,
      automaticallyImplyLeading: automaticallyImplyLeading,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      elevation: config.transparent ? 0 : (config.elevation ?? 0),
      centerTitle: config.centerTitle,
      bottom: config.bottom,
      toolbarHeight: 64.0,
    );
  }

  @override
  Size get preferredSize {
    // Hauteur par défaut de l'AppBar
    double height = _isIOS ? 44.0 : 64.0;

    // Ajouter la hauteur du bottom widget si présent
    if (config.bottom != null) {
      height += config.bottom!.preferredSize.height;
    }

    return Size.fromHeight(height);
  }
}

/// Extension pour faciliter la création d'AppBar
extension AppBarConfigExtension on BuildContext {
  /// Crée une AppBar adaptative basique
  PreferredSizeWidget adaptiveAppBar({String? title, List<Widget>? actions}) {
    return AdaptiveAppBar(title: title, actions: actions);
  }
}

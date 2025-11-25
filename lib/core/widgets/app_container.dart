import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:pocketly/core/constants/app_colors.dart';
import 'package:pocketly/core/constants/app_dimensions.dart';

/// Widget de conteneur adaptatif respectant les HIG et Material Design.
///
/// Ce widget fournit un conteneur avec élévation qui s'adapte automatiquement
/// aux plateformes iOS et Android en respectant leurs guidelines respectives.
class AppContainer extends StatelessWidget {
  /// Contenu du conteneur
  final Widget child;

  /// Padding interne du conteneur
  final EdgeInsetsGeometry? padding;

  /// Marge externe du conteneur
  final EdgeInsetsGeometry? margin;

  /// Couleur de fond du conteneur
  final Color? backgroundColor;

  /// Élévation du conteneur (Material Design)
  final double elevation;

  /// Indique si le conteneur doit avoir des coins arrondis
  final bool rounded;

  /// Rayon de bordure personnalisé
  final BorderRadius? borderRadius;

  /// Couleur de bordure
  final Color? borderColor;

  /// Épaisseur de la bordure
  final double borderWidth;

  /// Callback appelé lors du tap sur le conteneur
  final VoidCallback? onTap;

  /// Indique si le conteneur est cliquable
  final bool isClickable;

  /// Animation de tap (Material Design)
  final bool enableTapAnimation;

  /// Dégradé de fond
  final Gradient? gradient;

  const AppContainer({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.backgroundColor,
    this.elevation = 2.0,
    this.rounded = true,
    this.borderRadius,
    this.borderColor,
    this.borderWidth = 0.0,
    this.onTap,
    this.isClickable = false,
    this.enableTapAnimation = true,
    this.gradient,
  });

  /// Factory pour créer un conteneur avec élévation spécifique
  factory AppContainer.elevated({
    Key? key,
    required Widget child,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    Color? backgroundColor,
    double elevation = 2.0,
    VoidCallback? onTap,
  }) {
    return AppContainer(
      key: key,
      padding: padding,
      margin: margin,
      backgroundColor: backgroundColor,
      elevation: elevation,
      onTap: onTap,
      isClickable: onTap != null,
      child: child,
    );
  }

  /// Factory pour créer un conteneur de carte (Material Design)
  factory AppContainer.card({
    Key? key,
    required Widget child,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    Color? backgroundColor,
    double elevation = 4.0,
    VoidCallback? onTap,
  }) {
    return AppContainer(
      key: key,
      padding: padding,
      margin: margin,
      backgroundColor: backgroundColor,
      elevation: elevation,
      rounded: true,
      onTap: onTap,
      isClickable: onTap != null,
      child: child,
    );
  }

  /// Factory pour créer un conteneur iOS (Cupertino)
  factory AppContainer.cupertino({
    Key? key,
    required Widget child,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    Color? backgroundColor,
    VoidCallback? onTap,
  }) {
    return AppContainer(
      key: key,
      padding: padding,
      margin: margin,
      backgroundColor: backgroundColor,
      elevation: 0.0, // iOS n'utilise pas d'élévation
      rounded: true,
      onTap: onTap,
      isClickable: onTap != null,
      enableTapAnimation: false, // iOS utilise ses propres animations
      child: child,
    );
  }

  bool get _isIOS => !kIsWeb && Platform.isIOS;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Couleurs adaptatives
    final defaultBackgroundColor =
        backgroundColor ?? (isDark ? AppColors.surfaceDark : AppColors.surface);

    // Padding par défaut
    final defaultPadding = padding ?? EdgeInsets.all(AppDimensions.paddingL);

    // Border radius adaptatif
    final defaultBorderRadius =
        borderRadius ??
        (rounded
            ? BorderRadius.circular(AppDimensions.radiusM)
            : BorderRadius.zero);

    if (_isIOS) {
      return _buildIOSContainer(
        context,
        defaultBackgroundColor,
        defaultPadding,
        defaultBorderRadius,
        isDark,
      );
    }
    return _buildAndroidContainer(
      context,
      defaultBackgroundColor,
      defaultPadding,
      defaultBorderRadius,
      isDark,
    );
  }

  Widget _buildIOSContainer(
    BuildContext context,
    Color backgroundColor,
    EdgeInsetsGeometry padding,
    BorderRadius borderRadius,
    bool isDark,
  ) {
    return Container(
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: gradient != null ? null : backgroundColor,
        gradient: gradient,
        borderRadius: borderRadius,
        border: borderColor != null
            ? Border.all(color: borderColor!, width: borderWidth)
            : null,
        // iOS utilise des ombres subtiles au lieu d'élévation
        boxShadow: elevation > 0
            ? [
                BoxShadow(
                  color: isDark
                      ? Colors.black.withValues(alpha: 0.3)
                      : Colors.black.withValues(alpha: 0.1),
                  blurRadius: elevation * 2,
                  offset: Offset(0, elevation),
                ),
              ]
            : null,
      ),
      child: isClickable && onTap != null
          ? CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: onTap,
              child: child,
            )
          : child,
    );
  }

  Widget _buildAndroidContainer(
    BuildContext context,
    Color backgroundColor,
    EdgeInsetsGeometry padding,
    BorderRadius borderRadius,
    bool isDark,
  ) {
    // Utilise Material pour l'élévation et les animations
    return Material(
      color: gradient != null ? null : backgroundColor,
      elevation: elevation,
      borderRadius: borderRadius,
      shadowColor: isDark ? Colors.black : Colors.grey,
      child: Container(
        margin: margin,
        padding: padding,
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: borderRadius,
          border: borderColor != null
              ? Border.all(color: borderColor!, width: borderWidth)
              : null,
        ),
        child: isClickable && onTap != null
            ? InkWell(
                onTap: enableTapAnimation ? onTap : null,
                borderRadius: borderRadius,
                child: child,
              )
            : child,
      ),
    );
  }
}

/// Extension pour faciliter l'utilisation d'AppContainer
extension AppContainerExtension on Widget {
  /// Enveloppe le widget dans un AppContainer avec élévation
  Widget inAppContainer({
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    Color? backgroundColor,
    double elevation = 2.0,
    VoidCallback? onTap,
  }) {
    return AppContainer(
      padding: padding,
      margin: margin,
      backgroundColor: backgroundColor,
      elevation: elevation,
      onTap: onTap,
      isClickable: onTap != null,
      child: this,
    );
  }

  /// Enveloppe le widget dans un AppContainer de carte
  Widget inAppCard({
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    Color? backgroundColor,
    double elevation = 4.0,
    VoidCallback? onTap,
  }) {
    return AppContainer.card(
      padding: padding,
      margin: margin,
      backgroundColor: backgroundColor,
      elevation: elevation,
      onTap: onTap,
      child: this,
    );
  }

  /// Enveloppe le widget dans un AppContainer iOS
  Widget inAppContainerIOS({
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    Color? backgroundColor,
    VoidCallback? onTap,
  }) {
    return AppContainer.cupertino(
      padding: padding,
      margin: margin,
      backgroundColor: backgroundColor,
      onTap: onTap,
      child: this,
    );
  }
}

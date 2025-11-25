import 'dart:io' show Platform;
import 'package:flutter/material.dart';

/// Widget SafeArea adaptatif qui s'ajuste automatiquement selon la plateforme
///
/// - iOS : Utilise la barre gestuelle native (bottom: false)
/// - Android : Respecte les boutons de navigation système (bottom: true)
class PlatformSafeArea extends StatelessWidget {
  final Widget child;
  final bool top;
  final bool left;
  final bool right;
  final bool? bottom; // null = auto, true = force, false = désactiver
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;

  const PlatformSafeArea({
    super.key,
    required this.child,
    this.top = true,
    this.left = true,
    this.right = true,
    this.bottom, // null = auto selon la plateforme
    this.padding,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final isIOS = Platform.isIOS;

    // Logique adaptative pour le bottom
    final bottomSafeArea = bottom ?? !isIOS; // iOS: false, Android: true

    Widget content = SafeArea(
      top: top,
      left: left,
      right: right,
      bottom: bottomSafeArea,
      child: child,
    );

    // Ajouter le padding si spécifié
    if (padding != null) {
      content = Padding(padding: padding!, child: content);
    }

    // Ajouter le background si spécifié
    if (backgroundColor != null) {
      content = Container(color: backgroundColor, child: content);
    }

    return content;
  }
}

/// Extension pour faciliter l'utilisation
extension PlatformSafeAreaExtension on Widget {
  /// Wrapper simple pour PlatformSafeArea
  Widget platformSafeArea({
    bool top = true,
    bool left = true,
    bool right = true,
    bool? bottom,
    EdgeInsetsGeometry? padding,
    Color? backgroundColor,
  }) {
    return PlatformSafeArea(
      top: top,
      left: left,
      right: right,
      bottom: bottom,
      padding: padding,
      backgroundColor: backgroundColor,
      child: this,
    );
  }
}

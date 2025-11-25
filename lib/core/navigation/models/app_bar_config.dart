import 'package:flutter/material.dart';

/// Configuration pour l'AppBar adaptative.
class AppBarConfig {
  /// Titre de l'AppBar
  final String? title;

  /// Widget de titre personnalisé
  final Widget? titleWidget;

  /// Actions à afficher dans l'AppBar
  final List<Widget>? actions;

  /// Widget de leading personnalisé
  final Widget? leading;

  /// Afficher le bouton retour automatique
  final bool automaticallyImplyLeading;

  /// Afficher l'AppBar (false = masquer complètement)
  final bool show;

  /// Élévation de l'AppBar (Android)
  final double? elevation;

  /// Couleur de fond personnalisée
  final Color? backgroundColor;

  /// Couleur du texte/icônes
  final Color? foregroundColor;

  /// Centrer le titre (iOS par défaut, optionnel sur Android)
  final bool? centerTitle;

  /// Bottom widget (ex: TabBar)
  final PreferredSizeWidget? bottom;

  /// Rendre l'AppBar transparente
  final bool transparent;

  const AppBarConfig({
    this.title,
    this.titleWidget,
    this.actions,
    this.leading,
    this.automaticallyImplyLeading = true,
    this.show = true,
    this.elevation,
    this.backgroundColor,
    this.foregroundColor,
    this.centerTitle,
    this.bottom,
    this.transparent = false,
  });

  /// Configuration par défaut (AppBar visible avec titre)
  const AppBarConfig.visible({
    String? title,
    Widget? titleWidget,
    List<Widget>? actions,
  }) : this(
         title: title,
         titleWidget: titleWidget,
         actions: actions,
         show: true,
       );

  /// Configuration sans AppBar
  const AppBarConfig.hidden() : this(show: false);

  /// Configuration transparente (pour overlay sur contenu)
  const AppBarConfig.transparent({
    String? title,
    Widget? titleWidget,
    List<Widget>? actions,
  }) : this(
         title: title,
         titleWidget: titleWidget,
         actions: actions,
         transparent: true,
         elevation: 0,
       );

  /// Crée une copie avec des valeurs modifiées
  AppBarConfig copyWith({
    String? title,
    Widget? titleWidget,
    List<Widget>? actions,
    Widget? leading,
    bool? automaticallyImplyLeading,
    bool? show,
    double? elevation,
    Color? backgroundColor,
    Color? foregroundColor,
    bool? centerTitle,
    PreferredSizeWidget? bottom,
    bool? transparent,
  }) {
    return AppBarConfig(
      title: title ?? this.title,
      titleWidget: titleWidget ?? this.titleWidget,
      actions: actions ?? this.actions,
      leading: leading ?? this.leading,
      automaticallyImplyLeading:
          automaticallyImplyLeading ?? this.automaticallyImplyLeading,
      show: show ?? this.show,
      elevation: elevation ?? this.elevation,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      foregroundColor: foregroundColor ?? this.foregroundColor,
      centerTitle: centerTitle ?? this.centerTitle,
      bottom: bottom ?? this.bottom,
      transparent: transparent ?? this.transparent,
    );
  }
}

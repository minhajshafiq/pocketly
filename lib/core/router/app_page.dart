import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Page adaptative qui gère automatiquement les transitions selon la plateforme.
/// 
/// - Sur iOS : Utilise CupertinoPage avec swipe back natif
/// - Sur Android : Utilise MaterialPage avec Material Design 3
/// 
/// Utilise les pages natives de Flutter pour garantir le bon fonctionnement
/// des gestes natifs (swipe back iOS, back button Android, scroll, etc.)
class AppPage<T> extends Page<T> {
  /// Widget enfant de la page
  final Widget child;
  
  /// Type de transition à utiliser
  final AppPageTransitionType transitionType;

  const AppPage({
    required this.child,
    super.key,
    super.name,
    super.arguments,
    super.restorationId,
    this.transitionType = AppPageTransitionType.adaptive,
  });

  @override
  Route<T> createRoute(BuildContext context) {
    // Détection automatique de la plateforme pour le type "adaptive"
    final effectiveType = transitionType == AppPageTransitionType.adaptive
        ? _getAdaptiveTransitionType()
        : transitionType;

    // Utiliser les routes natives pour préserver les gestes
    if (effectiveType == AppPageTransitionType.cupertino) {
      return CupertinoPageRoute<T>(
        settings: this,
        builder: (context) => child,
      );
    } else {
      // MaterialPageRoute pour Android avec gestes natifs
      return MaterialPageRoute<T>(
        settings: this,
        builder: (context) => child,
      );
    }
  }

  /// Détermine le type de transition selon la plateforme
  static AppPageTransitionType _getAdaptiveTransitionType() {
    if (Platform.isIOS) {
      return AppPageTransitionType.cupertino;
    } else {
      return AppPageTransitionType.material;
    }
  }

  /// Factory pour créer une page avec transition iOS (Cupertino)
  factory AppPage.cupertino({
    required Widget child,
    LocalKey? key,
    String? name,
    Object? arguments,
    String? restorationId,
  }) {
    return AppPage(
      key: key,
      name: name,
      arguments: arguments,
      restorationId: restorationId,
      transitionType: AppPageTransitionType.cupertino,
      child: child,
    );
  }

  /// Factory pour créer une page avec transition Android (Material)
  factory AppPage.material({
    required Widget child,
    LocalKey? key,
    String? name,
    Object? arguments,
    String? restorationId,
  }) {
    return AppPage(
      key: key,
      name: name,
      arguments: arguments,
      restorationId: restorationId,
      transitionType: AppPageTransitionType.material,
      child: child,
    );
  }

  /// Factory pour créer une page adaptative (détection automatique de la plateforme)
  factory AppPage.adaptive({
    required Widget child,
    LocalKey? key,
    String? name,
    Object? arguments,
    String? restorationId,
  }) {
    return AppPage(
      key: key,
      name: name,
      arguments: arguments,
      restorationId: restorationId,
      transitionType: AppPageTransitionType.adaptive,
      child: child,
    );
  }
}

/// Types de transitions disponibles pour les pages
enum AppPageTransitionType {
  /// Détection automatique selon la plateforme
  adaptive,
  
  /// Transition iOS native (swipe back activé)
  cupertino,
  
  /// Transition Material (Android)
  material,
}


import 'package:flutter/material.dart';

/// Modèle représentant un élément de navigation dans la bottom nav bar.
class NavigationItem {
  /// Label affiché dans la navigation
  final String label;

  /// Icône de l'élément
  final IconData icon;

  /// Icône sélectionnée (optionnel)
  final IconData? selectedIcon;

  /// Route de destination
  final String route;

  /// Badge à afficher (optionnel)
  final String? badge;

  /// Indique si cet élément nécessite une authentification
  final bool requiresAuth;

  /// Indique si c'est un bouton central (FAB-style)
  final bool isCenterButton;

  const NavigationItem({
    required this.label,
    required this.icon,
    this.selectedIcon,
    required this.route,
    this.badge,
    this.requiresAuth = true,
    this.isCenterButton = false,
  });

  /// Crée une copie avec des valeurs modifiées
  NavigationItem copyWith({
    String? label,
    IconData? icon,
    IconData? selectedIcon,
    String? route,
    String? badge,
    bool? requiresAuth,
    bool? isCenterButton,
  }) {
    return NavigationItem(
      label: label ?? this.label,
      icon: icon ?? this.icon,
      selectedIcon: selectedIcon ?? this.selectedIcon,
      route: route ?? this.route,
      badge: badge ?? this.badge,
      requiresAuth: requiresAuth ?? this.requiresAuth,
      isCenterButton: isCenterButton ?? this.isCenterButton,
    );
  }
}

/// Configuration de la barre de navigation principale
class NavigationConfig {
  /// Liste des éléments de navigation
  final List<NavigationItem> items;

  /// Index de l'élément sélectionné
  final int selectedIndex;

  const NavigationConfig({required this.items, this.selectedIndex = 0});

  /// Récupère l'élément actuellement sélectionné
  NavigationItem get currentItem => items[selectedIndex];

  /// Crée une copie avec des valeurs modifiées
  NavigationConfig copyWith({List<NavigationItem>? items, int? selectedIndex}) {
    return NavigationConfig(
      items: items ?? this.items,
      selectedIndex: selectedIndex ?? this.selectedIndex,
    );
  }
}

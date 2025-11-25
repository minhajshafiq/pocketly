import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pocketly/core/constants/app_icons.dart';
import 'package:pocketly/core/navigation/models/navigation_item.dart';
import 'package:pocketly/core/navigation/models/app_bar_config.dart';
import 'package:pocketly/core/router/app_route_paths.dart';

part 'navigation_provider.g.dart';

/// Provider pour la configuration de la navigation principale
@riverpod
class NavigationController extends _$NavigationController {
  @override
  NavigationConfig build() {
    return NavigationConfig(items: _defaultNavigationItems, selectedIndex: 0);
  }

  /// Change l'index sélectionné
  void setSelectedIndex(int index) {
    if (index >= 0 && index < state.items.length) {
      state = state.copyWith(selectedIndex: index);
    }
  }

  /// Met à jour le badge d'un élément
  void updateBadge(int index, String? badge) {
    if (index >= 0 && index < state.items.length) {
      final updatedItems = List<NavigationItem>.from(state.items);
      updatedItems[index] = updatedItems[index].copyWith(badge: badge);
      state = state.copyWith(items: updatedItems);
    }
  }

  /// Trouve l'index correspondant à une route
  int findIndexForRoute(String route) {
    final index = state.items.indexWhere((item) => item.route == route);
    return index != -1 ? index : 0;
  }

  /// Items de navigation par défaut
  static final List<NavigationItem> _defaultNavigationItems = [
    NavigationItem(
      label: 'Home',
      icon: AppIcons.home,
      selectedIcon: AppIcons.home,
      route: AppRoutePaths.home,
    ),
    NavigationItem(
      label: 'Transactions',
      icon: AppIcons.transactions,
      selectedIcon: AppIcons.transactions,
      route: AppRoutePaths.transactions,
    ),
    // Bouton central pour ajouter une transaction
    NavigationItem(
      label: 'Add',
      icon: AppIcons.add,
      route: AppRoutePaths.addTransactionAmount,
      isCenterButton: true,
    ),
    NavigationItem(
      label: 'Pockets',
      icon: AppIcons.wallet,
      selectedIcon: AppIcons.wallet,
      route: AppRoutePaths.pockets,
    ),
    NavigationItem(
      label: 'Settings',
      icon: AppIcons.settings,
      selectedIcon: AppIcons.settings,
      route: AppRoutePaths.settings,
    ),
  ];
}

/// Provider pour la configuration de l'AppBar actuelle
@riverpod
class AppBarController extends _$AppBarController {
  @override
  AppBarConfig build() {
    return const AppBarConfig.visible();
  }

  /// Met à jour la configuration de l'AppBar
  void updateConfig(AppBarConfig config) {
    state = config;
  }

  /// Masque l'AppBar
  void hide() {
    state = const AppBarConfig.hidden();
  }

  /// Affiche l'AppBar avec un titre
  void show({String? title, List<Widget>? actions}) {
    state = AppBarConfig.visible(title: title, actions: actions);
  }

  /// Réinitialise à la configuration par défaut
  void reset() {
    state = const AppBarConfig.visible();
  }
}

/// Provider pour déterminer si la bottom nav doit être affichée
@riverpod
bool showBottomNavigation(Ref ref, String currentRoute) {
  // Routes qui doivent afficher la bottom navigation
  final routesWithBottomNav = [
    AppRoutePaths.home,
    AppRoutePaths.transactions,
    AppRoutePaths.pockets,
    AppRoutePaths.settings,
  ];

  return routesWithBottomNav.contains(currentRoute);
}

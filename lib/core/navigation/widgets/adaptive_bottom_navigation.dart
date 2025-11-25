import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pocketly/core/constants/app_colors.dart';
import 'package:pocketly/core/navigation/models/navigation_item.dart';
import 'package:pocketly/core/navigation/providers/navigation_provider.dart';

/// Callback appelé lors du changement d'onglet
typedef NavigationTapCallback = void Function(int index, String route);

/// Barre de navigation inférieure adaptative (iOS/Android).
///
/// S'affiche en style "floating" sur iOS avec effet glassmorphism
/// et en style Material Design sur Android.
///
/// Usage:
/// ```dart
/// Scaffold(
///   bottomNavigationBar: const AdaptiveBottomNavigation(),
///   body: MyContent(),
/// )
/// ```
class AdaptiveBottomNavigation extends ConsumerWidget {
  /// Callback appelé lors du changement d'onglet
  final NavigationTapCallback? onTap;

  /// Callback pour l'action du bouton central
  /// Si null, aucune action ne sera exécutée
  final VoidCallback? onCenterButtonTap;

  const AdaptiveBottomNavigation({
    super.key,
    this.onTap,
    this.onCenterButtonTap,
  });

  bool get _isIOS => !kIsWeb && Platform.isIOS;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navigationConfig = ref.watch(navigationControllerProvider);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    if (_isIOS) {
      return _buildIOSBottomNav(
        context,
        ref,
        navigationConfig,
        isDark,
      );
    }

    return _buildAndroidBottomNav(
      context,
      ref,
      navigationConfig,
      isDark,
    );
  }

  /// Construit la bottom nav iOS (Cupertino)
  /// Style: Barre rectangulaire similaire à Android
  Widget _buildIOSBottomNav(
    BuildContext context,
    WidgetRef ref,
    NavigationConfig config,
    bool isDark,
  ) {
    final backgroundColor = isDark
        ? AppColors.surfaceDark.withValues(alpha: 0.95)
        : Colors.white.withValues(alpha: 0.95);
    final borderColor = isDark ? AppColors.borderDark : AppColors.borderLight;

    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.circular(16),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          decoration: BoxDecoration(
            color: backgroundColor,
            border: Border(
              top: BorderSide(
                color: borderColor.withValues(alpha: 0.3),
                width: 0.5,
              ),
            ),
          ),
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).padding.bottom,
          ),
          height: 56 + MediaQuery.of(context).padding.bottom,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: _buildIOSNavigationItems(context, ref, config),
          ),
        ),
      ),
    );
  }

  /// Construit les items de navigation iOS
  List<Widget> _buildIOSNavigationItems(
    BuildContext context,
    WidgetRef ref,
    NavigationConfig config,
  ) {
    final items = <Widget>[];

    // Construire les items dans l'ordre
    for (int i = 0; i < config.items.length; i++) {
      final item = config.items[i];
      final isActive = i == config.selectedIndex;

      if (item.isCenterButton) {
        items.add(_buildCenterButton(context, ref, i, item, config));
      } else {
        items.add(_buildRegularItem(context, ref, i, item, isActive));
      }
    }

    return items;
  }

  /// Construit un item de navigation régulier iOS
  Widget _buildRegularItem(
    BuildContext context,
    WidgetRef ref,
    int index,
    NavigationItem item,
    bool isActive,
  ) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        _handleTap(context, ref, index);
      },
      child: Container(
        width: 44,
        height: 44,
        decoration: isActive
            ? BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              )
            : null,
        child: _buildIconWithBadge(
          icon: isActive ? (item.selectedIcon ?? item.icon) : item.icon,
          badge: item.badge,
          color: isActive ? AppColors.primary : AppColors.textSecondary,
          size: 22,
        ),
      ),
    );
  }

  /// Construit le bouton central iOS
  Widget _buildCenterButton(
    BuildContext context,
    WidgetRef ref,
    int index,
    NavigationItem item,
    NavigationConfig config,
  ) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.mediumImpact();
        _handleCenterButtonTap(context, ref, index);
      },
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: AppColors.primary,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.3),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Icon(
          item.icon,
          color: Colors.white,
          size: 24,
        ),
      ),
    );
  }

  /// Construit la bottom nav Android (Material)
  /// Style: Identique à iOS avec Row et items personnalisés
  Widget _buildAndroidBottomNav(
    BuildContext context,
    WidgetRef ref,
    NavigationConfig config,
    bool isDark,
  ) {
    final backgroundColor = isDark
        ? AppColors.surfaceDark.withValues(alpha: 0.95)
        : Colors.white.withValues(alpha: 0.95);

    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(28.r),
        topRight: Radius.circular(28.r),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          boxShadow: [
            BoxShadow(
              color: isDark
                  ? Colors.black.withValues(alpha: 0.2)
                  : Colors.black.withValues(alpha: 0.04),
              blurRadius: 12,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).padding.bottom,
        ),
        height: 56 + MediaQuery.of(context).padding.bottom,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: _buildAndroidNavigationItems(context, ref, config),
        ),
      ),
    );
  }

  /// Construit les items de navigation Android (identique à iOS)
  List<Widget> _buildAndroidNavigationItems(
    BuildContext context,
    WidgetRef ref,
    NavigationConfig config,
  ) {
    final items = <Widget>[];

    // Construire les items dans l'ordre
    for (int i = 0; i < config.items.length; i++) {
      final item = config.items[i];
      final isActive = i == config.selectedIndex;

      if (item.isCenterButton) {
        items.add(_buildCenterButton(context, ref, i, item, config));
      } else {
        items.add(_buildRegularItem(context, ref, i, item, isActive));
      }
    }

    return items;
  }

  /// Construit une icône avec badge optionnel
  Widget _buildIconWithBadge({
    required IconData icon,
    String? badge,
    required Color color,
    required double size,
  }) {
    final iconWidget = Icon(icon, color: color, size: size);

    if (badge == null || badge.isEmpty) {
      return iconWidget;
    }

    return Badge(
      label: Text(
        badge,
        style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: AppColors.error,
      textColor: Colors.white,
      child: iconWidget,
    );
  }

  /// Gère le tap sur un élément de navigation
  void _handleTap(BuildContext context, WidgetRef ref, int index) {
    final config = ref.read(navigationControllerProvider);
    if (index < 0 || index >= config.items.length) {
      return;
    }

    final item = config.items[index];

    // Ne pas naviguer si c'est déjà l'onglet actif
    if (index == config.selectedIndex) {
      return;
    }

    // Mettre à jour l'état
    ref.read(navigationControllerProvider.notifier).setSelectedIndex(index);

    // Naviguer vers la route
    try {
      context.go(item.route);
    } catch (e) {
      // Gérer les erreurs de navigation silencieusement
      debugPrint('Navigation error: $e');
    }

    // Callback personnalisé
    onTap?.call(index, item.route);
  }

  /// Gère le tap sur le bouton central
  void _handleCenterButtonTap(BuildContext context, WidgetRef ref, int index) {
    final config = ref.read(navigationControllerProvider);
    if (index < 0 || index >= config.items.length) {
      return;
    }

    final item = config.items[index];

    // Exécuter le callback personnalisé si fourni
    if (onCenterButtonTap != null) {
      onCenterButtonTap!();
      onTap?.call(index, item.route);
      return;
    }

    // Sinon, naviguer vers la route par défaut
    try {
      context.push(item.route);
    } catch (e) {
      debugPrint('Navigation error: $e');
    }

    onTap?.call(index, item.route);
  }
}

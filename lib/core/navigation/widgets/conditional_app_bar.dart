import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocketly/core/navigation/models/app_bar_config.dart';
import 'package:pocketly/core/navigation/providers/navigation_provider.dart';
import 'package:pocketly/core/navigation/widgets/adaptive_app_bar.dart';

/// AppBar qui peut être contrôlée via un provider Riverpod.
///
/// Permet de changer dynamiquement l'AppBar depuis n'importe où
/// dans l'application via le AppBarController.
///
/// Usage:
/// ```dart
/// Scaffold(
///   appBar: ConditionalAppBar(),
///   body: MyContent(),
/// )
///
/// // Ailleurs dans le code:
/// ref.read(appBarControllerProvider.notifier).show(
///   title: 'Nouveau Titre',
/// );
/// ```
class ConditionalAppBar extends ConsumerWidget implements PreferredSizeWidget {
  /// Configuration de fallback si aucune n'est définie dans le provider
  final AppBarConfig? fallbackConfig;

  /// Titre de fallback
  final String? fallbackTitle;

  /// Actions de fallback
  final List<Widget>? fallbackActions;

  const ConditionalAppBar({
    super.key,
    this.fallbackConfig,
    this.fallbackTitle,
    this.fallbackActions,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(appBarControllerProvider);

    // Si l'AppBar ne doit pas être affichée
    if (!config.show) {
      return const SizedBox.shrink();
    }

    // Utiliser la config du provider ou le fallback
    final effectiveConfig = _mergeConfigs(config);

    return AdaptiveAppBar(config: effectiveConfig);
  }

  /// Fusionne la config du provider avec le fallback
  AppBarConfig _mergeConfigs(AppBarConfig providerConfig) {
    if (fallbackConfig == null &&
        fallbackTitle == null &&
        fallbackActions == null) {
      return providerConfig;
    }

    return AppBarConfig(
      title: providerConfig.title ?? fallbackTitle ?? fallbackConfig?.title,
      titleWidget: providerConfig.titleWidget ?? fallbackConfig?.titleWidget,
      actions:
          providerConfig.actions ?? fallbackActions ?? fallbackConfig?.actions,
      leading: providerConfig.leading ?? fallbackConfig?.leading,
      automaticallyImplyLeading: providerConfig.automaticallyImplyLeading,
      show: providerConfig.show,
      elevation: providerConfig.elevation ?? fallbackConfig?.elevation,
      backgroundColor:
          providerConfig.backgroundColor ?? fallbackConfig?.backgroundColor,
      foregroundColor:
          providerConfig.foregroundColor ?? fallbackConfig?.foregroundColor,
      centerTitle: providerConfig.centerTitle ?? fallbackConfig?.centerTitle,
      bottom: providerConfig.bottom ?? fallbackConfig?.bottom,
      transparent: providerConfig.transparent,
    );
  }

  @override
  Size get preferredSize {
    // Hauteur standard de l'AppBar
    return const Size.fromHeight(56.0);
  }
}

/// Mixin pour faciliter le contrôle de l'AppBar depuis un StatefulWidget.
///
/// Usage:
/// ```dart
/// class MyScreen extends StatefulWidget with AppBarControlMixin {
///   @override
///   void initState() {
///     super.initState();
///     updateAppBar(context, title: 'Mon Écran');
///   }
/// }
/// ```
mixin AppBarControlMixin {
  /// Met à jour l'AppBar via le provider
  void updateAppBar(
    BuildContext context, {
    String? title,
    List<Widget>? actions,
    Widget? leading,
  }) {
    // Note: Nécessite un ProviderScope parent
    // Pas implémenté ici car nécessite accès au WidgetRef
  }

  /// Masque l'AppBar
  void hideAppBar(BuildContext context) {
    // Note: Nécessite un ProviderScope parent
  }

  /// Affiche l'AppBar
  void showAppBar(BuildContext context, {String? title}) {
    // Note: Nécessite un ProviderScope parent
  }
}

/// Extension pour faciliter le contrôle de l'AppBar depuis un ConsumerWidget.
extension AppBarControlExtension on WidgetRef {
  /// Met à jour l'AppBar
  void updateAppBar({
    String? title,
    List<Widget>? actions,
    Widget? titleWidget,
    bool? show,
  }) {
    final controller = read(appBarControllerProvider.notifier);

    if (show == false) {
      controller.hide();
      return;
    }

    controller.updateConfig(
      AppBarConfig(
        title: title,
        titleWidget: titleWidget,
        actions: actions,
        show: show ?? true,
      ),
    );
  }

  /// Masque l'AppBar
  void hideAppBar() {
    read(appBarControllerProvider.notifier).hide();
  }

  /// Affiche l'AppBar avec un titre
  void showAppBar({String? title, List<Widget>? actions}) {
    read(
      appBarControllerProvider.notifier,
    ).show(title: title, actions: actions);
  }

  /// Réinitialise l'AppBar
  void resetAppBar() {
    read(appBarControllerProvider.notifier).reset();
  }
}

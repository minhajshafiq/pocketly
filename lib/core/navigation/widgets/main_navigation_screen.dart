import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pocketly/core/navigation/widgets/adaptive_bottom_navigation.dart';
import 'package:pocketly/core/navigation/providers/navigation_provider.dart';
import 'package:pocketly/core/router/app_route_paths.dart';
import 'package:pocketly/features/transactions/presentation/widgets/transaction_type_modal.dart';

/// Écran principal avec navigation bottom bar.
///
/// Utilise GoRouter avec ShellRoute pour maintenir l'état
/// entre les changements d'onglets.
///
/// Usage dans le router:
/// ```dart
/// ShellRoute(
///   builder: (context, state, child) {
///     return MainNavigationScreen(child: child);
///   },
///   routes: [...],
/// )
/// ```
class MainNavigationScreen extends ConsumerWidget {
  /// Enfant à afficher (page courante)
  final Widget child;

  const MainNavigationScreen({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentRoute = GoRouterState.of(context).matchedLocation;
    final showNav = ref.watch(showBottomNavigationProvider(currentRoute));

    // Synchroniser l'index avec la route actuelle
    _syncNavigationIndex(ref, currentRoute);

    if (!showNav) {
      // Pages sans bottom nav (ex: détails, paramètres)
      return child;
    }

    // Sur iOS : Stack flottant avec navbar au-dessus du contenu
    // Sur Android : Scaffold classique avec bottomNavigationBar
    if (Platform.isIOS) {
      final bottomPadding = MediaQuery.of(context).padding.bottom;
      return Scaffold(
        body: Stack(
          children: [
            // Contenu avec padding bottom pour ne pas être caché par la navbar
            Positioned.fill(
              child: Padding(
                padding: EdgeInsets.only(bottom: 56 + bottomPadding),
                child: child,
              ),
            ),
            // Navbar flottante en bas
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: AdaptiveBottomNavigation(
                onCenterButtonTap: () => _handleCenterButtonTap(context),
              ),
            ),
          ],
        ),
      );
    }

    // Pages avec bottom nav (Android)
    return Scaffold(
      body: child,
      bottomNavigationBar: AdaptiveBottomNavigation(
        onCenterButtonTap: () => _handleCenterButtonTap(context),
      ),
    );
  }

  /// Synchronise l'index de navigation avec la route actuelle
  void _syncNavigationIndex(WidgetRef ref, String currentRoute) {
    final controller = ref.read(navigationControllerProvider.notifier);
    final newIndex = controller.findIndexForRoute(currentRoute);
    final currentIndex = ref.read(navigationControllerProvider).selectedIndex;

    if (newIndex != currentIndex) {
      // Utiliser post frame pour éviter les modifications pendant le build
      WidgetsBinding.instance.addPostFrameCallback((_) {
        controller.setSelectedIndex(newIndex);
      });
    }
  }

  /// Gère le tap sur le bouton central selon la page active
  void _handleCenterButtonTap(BuildContext context) {
    final currentRoute = GoRouterState.of(context).matchedLocation;

    // Action contextuelle selon la page active
    switch (currentRoute) {
      case AppRoutePaths.pockets:
        // Sur la page Pockets → Créer un nouveau pocket
        context.push(AppRoutePaths.createPocket);
        break;

      case AppRoutePaths.home:
      case AppRoutePaths.transactions:
      default:
        // Sur les autres pages → Afficher le modal de type de transaction
        showTransactionTypeModal(context);
        break;
    }
  }
}

/// Widget pour wrapper des écrans individuels avec AppBar conditionnelle.
///
/// Usage:
/// ```dart
/// NavigationScreenWrapper(
///   title: 'Mon Écran',
///   showAppBar: true,
///   child: MyContent(),
/// )
/// ```
class NavigationScreenWrapper extends StatelessWidget {
  /// Contenu de l'écran
  final Widget child;

  /// Titre de l'AppBar
  final String? title;

  /// Afficher l'AppBar
  final bool showAppBar;

  /// Actions de l'AppBar
  final List<Widget>? actions;

  /// Widget de titre personnalisé
  final Widget? titleWidget;

  /// Afficher le bouton retour
  final bool automaticallyImplyLeading;

  /// Couleur de fond
  final Color? backgroundColor;

  /// Padding autour du contenu
  final EdgeInsets? padding;

  /// Utiliser SafeArea
  final bool useSafeArea;

  /// Utiliser SingleChildScrollView
  final bool scrollable;

  const NavigationScreenWrapper({
    super.key,
    required this.child,
    this.title,
    this.showAppBar = true,
    this.actions,
    this.titleWidget,
    this.automaticallyImplyLeading = true,
    this.backgroundColor,
    this.padding,
    this.useSafeArea = true,
    this.scrollable = false,
  });

  @override
  Widget build(BuildContext context) {
    Widget content = child;

    // Appliquer padding si défini
    if (padding != null) {
      content = Padding(padding: padding!, child: content);
    }

    // Rendre scrollable si demandé
    if (scrollable) {
      content = SingleChildScrollView(child: content);
    }

    // Appliquer SafeArea si demandé
    if (useSafeArea) {
      content = SafeArea(child: content);
    }

    // Pas besoin de Scaffold ici car MainNavigationScreen le fournit
    return content;
  }
}

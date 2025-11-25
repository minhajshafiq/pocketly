// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'navigation_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider pour la configuration de la navigation principale

@ProviderFor(NavigationController)
const navigationControllerProvider = NavigationControllerProvider._();

/// Provider pour la configuration de la navigation principale
final class NavigationControllerProvider
    extends $NotifierProvider<NavigationController, NavigationConfig> {
  /// Provider pour la configuration de la navigation principale
  const NavigationControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'navigationControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$navigationControllerHash();

  @$internal
  @override
  NavigationController create() => NavigationController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NavigationConfig value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NavigationConfig>(value),
    );
  }
}

String _$navigationControllerHash() =>
    r'1da23e5a4fce88fe8b2fd06f9867dd863a4a2629';

/// Provider pour la configuration de la navigation principale

abstract class _$NavigationController extends $Notifier<NavigationConfig> {
  NavigationConfig build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<NavigationConfig, NavigationConfig>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<NavigationConfig, NavigationConfig>,
              NavigationConfig,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

/// Provider pour la configuration de l'AppBar actuelle

@ProviderFor(AppBarController)
const appBarControllerProvider = AppBarControllerProvider._();

/// Provider pour la configuration de l'AppBar actuelle
final class AppBarControllerProvider
    extends $NotifierProvider<AppBarController, AppBarConfig> {
  /// Provider pour la configuration de l'AppBar actuelle
  const AppBarControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appBarControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appBarControllerHash();

  @$internal
  @override
  AppBarController create() => AppBarController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppBarConfig value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppBarConfig>(value),
    );
  }
}

String _$appBarControllerHash() => r'91872aa9cce197c85819094db771ae979d500663';

/// Provider pour la configuration de l'AppBar actuelle

abstract class _$AppBarController extends $Notifier<AppBarConfig> {
  AppBarConfig build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AppBarConfig, AppBarConfig>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AppBarConfig, AppBarConfig>,
              AppBarConfig,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

/// Provider pour déterminer si la bottom nav doit être affichée

@ProviderFor(showBottomNavigation)
const showBottomNavigationProvider = ShowBottomNavigationFamily._();

/// Provider pour déterminer si la bottom nav doit être affichée

final class ShowBottomNavigationProvider
    extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  /// Provider pour déterminer si la bottom nav doit être affichée
  const ShowBottomNavigationProvider._({
    required ShowBottomNavigationFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'showBottomNavigationProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$showBottomNavigationHash();

  @override
  String toString() {
    return r'showBottomNavigationProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    final argument = this.argument as String;
    return showBottomNavigation(ref, argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is ShowBottomNavigationProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$showBottomNavigationHash() =>
    r'dc61b6109f934288c6be0010feed8f8d210f04ea';

/// Provider pour déterminer si la bottom nav doit être affichée

final class ShowBottomNavigationFamily extends $Family
    with $FunctionalFamilyOverride<bool, String> {
  const ShowBottomNavigationFamily._()
    : super(
        retry: null,
        name: r'showBottomNavigationProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Provider pour déterminer si la bottom nav doit être affichée

  ShowBottomNavigationProvider call(String currentRoute) =>
      ShowBottomNavigationProvider._(argument: currentRoute, from: this);

  @override
  String toString() => r'showBottomNavigationProvider';
}

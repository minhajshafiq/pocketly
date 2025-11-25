// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Notifier pour la gestion du thème

@ProviderFor(ThemeNotifier)
const themeProvider = ThemeNotifierProvider._();

/// Notifier pour la gestion du thème
final class ThemeNotifierProvider
    extends $NotifierProvider<ThemeNotifier, ThemeEntity> {
  /// Notifier pour la gestion du thème
  const ThemeNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'themeProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$themeNotifierHash();

  @$internal
  @override
  ThemeNotifier create() => ThemeNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ThemeEntity value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ThemeEntity>(value),
    );
  }
}

String _$themeNotifierHash() => r'df10daf900b61a645954ad8aa5564d7179d57b98';

/// Notifier pour la gestion du thème

abstract class _$ThemeNotifier extends $Notifier<ThemeEntity> {
  ThemeEntity build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<ThemeEntity, ThemeEntity>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ThemeEntity, ThemeEntity>,
              ThemeEntity,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

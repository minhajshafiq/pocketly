// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'locale_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider pour SharedPreferences

@ProviderFor(localeSharedPreferences)
const localeSharedPreferencesProvider = LocaleSharedPreferencesProvider._();

/// Provider pour SharedPreferences

final class LocaleSharedPreferencesProvider
    extends
        $FunctionalProvider<
          AsyncValue<SharedPreferences>,
          SharedPreferences,
          FutureOr<SharedPreferences>
        >
    with
        $FutureModifier<SharedPreferences>,
        $FutureProvider<SharedPreferences> {
  /// Provider pour SharedPreferences
  const LocaleSharedPreferencesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'localeSharedPreferencesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$localeSharedPreferencesHash();

  @$internal
  @override
  $FutureProviderElement<SharedPreferences> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<SharedPreferences> create(Ref ref) {
    return localeSharedPreferences(ref);
  }
}

String _$localeSharedPreferencesHash() =>
    r'2af899b6d922b347cc5d7426e571e405a1eac844';

/// Provider pour le datasource local

@ProviderFor(localeLocalDataSource)
const localeLocalDataSourceProvider = LocaleLocalDataSourceProvider._();

/// Provider pour le datasource local

final class LocaleLocalDataSourceProvider
    extends
        $FunctionalProvider<
          LocaleLocalDataSource,
          LocaleLocalDataSource,
          LocaleLocalDataSource
        >
    with $Provider<LocaleLocalDataSource> {
  /// Provider pour le datasource local
  const LocaleLocalDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'localeLocalDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$localeLocalDataSourceHash();

  @$internal
  @override
  $ProviderElement<LocaleLocalDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  LocaleLocalDataSource create(Ref ref) {
    return localeLocalDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LocaleLocalDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LocaleLocalDataSource>(value),
    );
  }
}

String _$localeLocalDataSourceHash() =>
    r'7330a87b2b4cc7d5c6ee52b5f0d1c6975d68926e';

/// Provider pour le repository

@ProviderFor(localeRepository)
const localeRepositoryProvider = LocaleRepositoryProvider._();

/// Provider pour le repository

final class LocaleRepositoryProvider
    extends
        $FunctionalProvider<
          LocaleRepository,
          LocaleRepository,
          LocaleRepository
        >
    with $Provider<LocaleRepository> {
  /// Provider pour le repository
  const LocaleRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'localeRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$localeRepositoryHash();

  @$internal
  @override
  $ProviderElement<LocaleRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  LocaleRepository create(Ref ref) {
    return localeRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LocaleRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LocaleRepository>(value),
    );
  }
}

String _$localeRepositoryHash() => r'80986d705728a15386b69e91df6a45907cb5ff21';

/// Provider pour la locale courante
///
/// Gère la locale de l'application avec persistance locale.
/// Si aucune locale n'est sauvegardée, utilise la locale du système.

@ProviderFor(CurrentLocale)
const currentLocaleProvider = CurrentLocaleProvider._();

/// Provider pour la locale courante
///
/// Gère la locale de l'application avec persistance locale.
/// Si aucune locale n'est sauvegardée, utilise la locale du système.
final class CurrentLocaleProvider
    extends $AsyncNotifierProvider<CurrentLocale, Locale> {
  /// Provider pour la locale courante
  ///
  /// Gère la locale de l'application avec persistance locale.
  /// Si aucune locale n'est sauvegardée, utilise la locale du système.
  const CurrentLocaleProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentLocaleProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentLocaleHash();

  @$internal
  @override
  CurrentLocale create() => CurrentLocale();
}

String _$currentLocaleHash() => r'2f4e81733331c381de1bf36947fb3cf9e6fe13aa';

/// Provider pour la locale courante
///
/// Gère la locale de l'application avec persistance locale.
/// Si aucune locale n'est sauvegardée, utilise la locale du système.

abstract class _$CurrentLocale extends $AsyncNotifier<Locale> {
  FutureOr<Locale> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<Locale>, Locale>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<Locale>, Locale>,
              AsyncValue<Locale>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

/// Provider pour obtenir l'AppLocaleEntity actuelle

@ProviderFor(currentAppLocale)
const currentAppLocaleProvider = CurrentAppLocaleProvider._();

/// Provider pour obtenir l'AppLocaleEntity actuelle

final class CurrentAppLocaleProvider
    extends
        $FunctionalProvider<
          AsyncValue<AppLocaleEntity>,
          AppLocaleEntity,
          FutureOr<AppLocaleEntity>
        >
    with $FutureModifier<AppLocaleEntity>, $FutureProvider<AppLocaleEntity> {
  /// Provider pour obtenir l'AppLocaleEntity actuelle
  const CurrentAppLocaleProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentAppLocaleProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentAppLocaleHash();

  @$internal
  @override
  $FutureProviderElement<AppLocaleEntity> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<AppLocaleEntity> create(Ref ref) {
    return currentAppLocale(ref);
  }
}

String _$currentAppLocaleHash() => r'53b991eaa948ef31b6d8613df4f359d02c621f88';

/// Provider pour la liste de toutes les locales supportées

@ProviderFor(supportedAppLocales)
const supportedAppLocalesProvider = SupportedAppLocalesProvider._();

/// Provider pour la liste de toutes les locales supportées

final class SupportedAppLocalesProvider
    extends
        $FunctionalProvider<
          List<AppLocaleEntity>,
          List<AppLocaleEntity>,
          List<AppLocaleEntity>
        >
    with $Provider<List<AppLocaleEntity>> {
  /// Provider pour la liste de toutes les locales supportées
  const SupportedAppLocalesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'supportedAppLocalesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$supportedAppLocalesHash();

  @$internal
  @override
  $ProviderElement<List<AppLocaleEntity>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  List<AppLocaleEntity> create(Ref ref) {
    return supportedAppLocales(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<AppLocaleEntity> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<AppLocaleEntity>>(value),
    );
  }
}

String _$supportedAppLocalesHash() =>
    r'804b020b0cd6728f651357d663237d4cc41b9a9b';

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider pour SharedPreferences

@ProviderFor(settingsSharedPreferences)
const settingsSharedPreferencesProvider = SettingsSharedPreferencesProvider._();

/// Provider pour SharedPreferences

final class SettingsSharedPreferencesProvider
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
  const SettingsSharedPreferencesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'settingsSharedPreferencesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$settingsSharedPreferencesHash();

  @$internal
  @override
  $FutureProviderElement<SharedPreferences> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<SharedPreferences> create(Ref ref) {
    return settingsSharedPreferences(ref);
  }
}

String _$settingsSharedPreferencesHash() =>
    r'ce4aa9e0ac0d42e72b46fcd7aa53be1a5f62b5de';

/// Provider pour le datasource local des paramètres

@ProviderFor(settingsLocalDataSource)
const settingsLocalDataSourceProvider = SettingsLocalDataSourceProvider._();

/// Provider pour le datasource local des paramètres

final class SettingsLocalDataSourceProvider
    extends
        $FunctionalProvider<
          AsyncValue<SettingsLocalDataSource>,
          SettingsLocalDataSource,
          FutureOr<SettingsLocalDataSource>
        >
    with
        $FutureModifier<SettingsLocalDataSource>,
        $FutureProvider<SettingsLocalDataSource> {
  /// Provider pour le datasource local des paramètres
  const SettingsLocalDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'settingsLocalDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$settingsLocalDataSourceHash();

  @$internal
  @override
  $FutureProviderElement<SettingsLocalDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<SettingsLocalDataSource> create(Ref ref) {
    return settingsLocalDataSource(ref);
  }
}

String _$settingsLocalDataSourceHash() =>
    r'58dfb54128026f221ffaa5e5ab552cb9f101c670';

/// Provider pour le repository des paramètres

@ProviderFor(settingsRepository)
const settingsRepositoryProvider = SettingsRepositoryProvider._();

/// Provider pour le repository des paramètres

final class SettingsRepositoryProvider
    extends
        $FunctionalProvider<
          AsyncValue<SettingsRepository>,
          SettingsRepository,
          FutureOr<SettingsRepository>
        >
    with
        $FutureModifier<SettingsRepository>,
        $FutureProvider<SettingsRepository> {
  /// Provider pour le repository des paramètres
  const SettingsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'settingsRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$settingsRepositoryHash();

  @$internal
  @override
  $FutureProviderElement<SettingsRepository> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<SettingsRepository> create(Ref ref) {
    return settingsRepository(ref);
  }
}

String _$settingsRepositoryHash() =>
    r'f579e3a0cd2e2366374df282d1324dcf8ad19f7b';

/// Provider pour le use case GetSettings

@ProviderFor(getSettingsUseCase)
const getSettingsUseCaseProvider = GetSettingsUseCaseProvider._();

/// Provider pour le use case GetSettings

final class GetSettingsUseCaseProvider
    extends
        $FunctionalProvider<
          AsyncValue<GetSettingsUseCase>,
          GetSettingsUseCase,
          FutureOr<GetSettingsUseCase>
        >
    with
        $FutureModifier<GetSettingsUseCase>,
        $FutureProvider<GetSettingsUseCase> {
  /// Provider pour le use case GetSettings
  const GetSettingsUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getSettingsUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getSettingsUseCaseHash();

  @$internal
  @override
  $FutureProviderElement<GetSettingsUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<GetSettingsUseCase> create(Ref ref) {
    return getSettingsUseCase(ref);
  }
}

String _$getSettingsUseCaseHash() =>
    r'007d751d0ec53da89cba991d4825305cda29f3f0';

/// Provider pour le use case UpdateThemeMode

@ProviderFor(updateThemeModeUseCase)
const updateThemeModeUseCaseProvider = UpdateThemeModeUseCaseProvider._();

/// Provider pour le use case UpdateThemeMode

final class UpdateThemeModeUseCaseProvider
    extends
        $FunctionalProvider<
          AsyncValue<UpdateThemeModeUseCase>,
          UpdateThemeModeUseCase,
          FutureOr<UpdateThemeModeUseCase>
        >
    with
        $FutureModifier<UpdateThemeModeUseCase>,
        $FutureProvider<UpdateThemeModeUseCase> {
  /// Provider pour le use case UpdateThemeMode
  const UpdateThemeModeUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'updateThemeModeUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$updateThemeModeUseCaseHash();

  @$internal
  @override
  $FutureProviderElement<UpdateThemeModeUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<UpdateThemeModeUseCase> create(Ref ref) {
    return updateThemeModeUseCase(ref);
  }
}

String _$updateThemeModeUseCaseHash() =>
    r'3b64b790b91221202fd14b6b64ca3471384a4fc2';

/// Provider pour le use case ResetSettings

@ProviderFor(resetSettingsUseCase)
const resetSettingsUseCaseProvider = ResetSettingsUseCaseProvider._();

/// Provider pour le use case ResetSettings

final class ResetSettingsUseCaseProvider
    extends
        $FunctionalProvider<
          AsyncValue<ResetSettingsUseCase>,
          ResetSettingsUseCase,
          FutureOr<ResetSettingsUseCase>
        >
    with
        $FutureModifier<ResetSettingsUseCase>,
        $FutureProvider<ResetSettingsUseCase> {
  /// Provider pour le use case ResetSettings
  const ResetSettingsUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'resetSettingsUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$resetSettingsUseCaseHash();

  @$internal
  @override
  $FutureProviderElement<ResetSettingsUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<ResetSettingsUseCase> create(Ref ref) {
    return resetSettingsUseCase(ref);
  }
}

String _$resetSettingsUseCaseHash() =>
    r'8612b92e7e101d2c0d42d05105bb2a3c76213915';

/// Notifier pour la gestion des paramètres de l'application

@ProviderFor(SettingsNotifier)
const settingsProvider = SettingsNotifierProvider._();

/// Notifier pour la gestion des paramètres de l'application
final class SettingsNotifierProvider
    extends $AsyncNotifierProvider<SettingsNotifier, AppSettingsEntity> {
  /// Notifier pour la gestion des paramètres de l'application
  const SettingsNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'settingsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$settingsNotifierHash();

  @$internal
  @override
  SettingsNotifier create() => SettingsNotifier();
}

String _$settingsNotifierHash() => r'd80bef9cf97cf36ce09e6a5e312c1503672b627f';

/// Notifier pour la gestion des paramètres de l'application

abstract class _$SettingsNotifier extends $AsyncNotifier<AppSettingsEntity> {
  FutureOr<AppSettingsEntity> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<AsyncValue<AppSettingsEntity>, AppSettingsEntity>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<AppSettingsEntity>, AppSettingsEntity>,
              AsyncValue<AppSettingsEntity>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

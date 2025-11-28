// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onboarding_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider pour le datasource local onboarding
/// Utilise le provider global sharedPreferencesProvider qui est déjà initialisé dans main.dart

@ProviderFor(onboardingLocalDataSource)
const onboardingLocalDataSourceProvider = OnboardingLocalDataSourceProvider._();

/// Provider pour le datasource local onboarding
/// Utilise le provider global sharedPreferencesProvider qui est déjà initialisé dans main.dart

final class OnboardingLocalDataSourceProvider
    extends
        $FunctionalProvider<
          OnboardingLocalDataSource,
          OnboardingLocalDataSource,
          OnboardingLocalDataSource
        >
    with $Provider<OnboardingLocalDataSource> {
  /// Provider pour le datasource local onboarding
  /// Utilise le provider global sharedPreferencesProvider qui est déjà initialisé dans main.dart
  const OnboardingLocalDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'onboardingLocalDataSourceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$onboardingLocalDataSourceHash();

  @$internal
  @override
  $ProviderElement<OnboardingLocalDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  OnboardingLocalDataSource create(Ref ref) {
    return onboardingLocalDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(OnboardingLocalDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<OnboardingLocalDataSource>(value),
    );
  }
}

String _$onboardingLocalDataSourceHash() =>
    r'9af13abf2bfb5360bc757a38d269fded18eeec7f';

/// Provider pour le repository onboarding

@ProviderFor(onboardingRepository)
const onboardingRepositoryProvider = OnboardingRepositoryProvider._();

/// Provider pour le repository onboarding

final class OnboardingRepositoryProvider
    extends
        $FunctionalProvider<
          OnboardingRepository,
          OnboardingRepository,
          OnboardingRepository
        >
    with $Provider<OnboardingRepository> {
  /// Provider pour le repository onboarding
  const OnboardingRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'onboardingRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$onboardingRepositoryHash();

  @$internal
  @override
  $ProviderElement<OnboardingRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  OnboardingRepository create(Ref ref) {
    return onboardingRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(OnboardingRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<OnboardingRepository>(value),
    );
  }
}

String _$onboardingRepositoryHash() =>
    r'6e1f58b27e869530a684fca5cd4157875e8ffa98';

/// Provider pour le use case de sauvegarde d'état

@ProviderFor(saveOnboardingStateUseCase)
const saveOnboardingStateUseCaseProvider =
    SaveOnboardingStateUseCaseProvider._();

/// Provider pour le use case de sauvegarde d'état

final class SaveOnboardingStateUseCaseProvider
    extends
        $FunctionalProvider<
          SaveOnboardingStateUseCase,
          SaveOnboardingStateUseCase,
          SaveOnboardingStateUseCase
        >
    with $Provider<SaveOnboardingStateUseCase> {
  /// Provider pour le use case de sauvegarde d'état
  const SaveOnboardingStateUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'saveOnboardingStateUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$saveOnboardingStateUseCaseHash();

  @$internal
  @override
  $ProviderElement<SaveOnboardingStateUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SaveOnboardingStateUseCase create(Ref ref) {
    return saveOnboardingStateUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SaveOnboardingStateUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SaveOnboardingStateUseCase>(value),
    );
  }
}

String _$saveOnboardingStateUseCaseHash() =>
    r'3a63d7c71db0f2bab67ca8700b4fbcefcbdb5819';

/// Provider pour le use case de récupération d'état

@ProviderFor(getOnboardingStateUseCase)
const getOnboardingStateUseCaseProvider = GetOnboardingStateUseCaseProvider._();

/// Provider pour le use case de récupération d'état

final class GetOnboardingStateUseCaseProvider
    extends
        $FunctionalProvider<
          GetOnboardingStateUseCase,
          GetOnboardingStateUseCase,
          GetOnboardingStateUseCase
        >
    with $Provider<GetOnboardingStateUseCase> {
  /// Provider pour le use case de récupération d'état
  const GetOnboardingStateUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getOnboardingStateUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getOnboardingStateUseCaseHash();

  @$internal
  @override
  $ProviderElement<GetOnboardingStateUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetOnboardingStateUseCase create(Ref ref) {
    return getOnboardingStateUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetOnboardingStateUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetOnboardingStateUseCase>(value),
    );
  }
}

String _$getOnboardingStateUseCaseHash() =>
    r'bc404edda08981342be0f756dcf9fb7c1a73bda8';

/// Provider pour le use case de nettoyage d'état

@ProviderFor(clearOnboardingStateUseCase)
const clearOnboardingStateUseCaseProvider =
    ClearOnboardingStateUseCaseProvider._();

/// Provider pour le use case de nettoyage d'état

final class ClearOnboardingStateUseCaseProvider
    extends
        $FunctionalProvider<
          ClearOnboardingStateUseCase,
          ClearOnboardingStateUseCase,
          ClearOnboardingStateUseCase
        >
    with $Provider<ClearOnboardingStateUseCase> {
  /// Provider pour le use case de nettoyage d'état
  const ClearOnboardingStateUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'clearOnboardingStateUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$clearOnboardingStateUseCaseHash();

  @$internal
  @override
  $ProviderElement<ClearOnboardingStateUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ClearOnboardingStateUseCase create(Ref ref) {
    return clearOnboardingStateUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ClearOnboardingStateUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ClearOnboardingStateUseCase>(value),
    );
  }
}

String _$clearOnboardingStateUseCaseHash() =>
    r'cef830ac96d6f95cdc600f56b574a467e5da094c';

/// Provider principal pour gérer l'état de l'onboarding

@ProviderFor(OnboardingNotifier)
const onboardingProvider = OnboardingNotifierProvider._();

/// Provider principal pour gérer l'état de l'onboarding
final class OnboardingNotifierProvider
    extends $AsyncNotifierProvider<OnboardingNotifier, OnboardingStateEntity> {
  /// Provider principal pour gérer l'état de l'onboarding
  const OnboardingNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'onboardingProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$onboardingNotifierHash();

  @$internal
  @override
  OnboardingNotifier create() => OnboardingNotifier();
}

String _$onboardingNotifierHash() =>
    r'2135e40dfdbb29118a09d9cad3b84caa0ca33a23';

/// Provider principal pour gérer l'état de l'onboarding

abstract class _$OnboardingNotifier
    extends $AsyncNotifier<OnboardingStateEntity> {
  FutureOr<OnboardingStateEntity> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<AsyncValue<OnboardingStateEntity>, OnboardingStateEntity>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<OnboardingStateEntity>,
                OnboardingStateEntity
              >,
              AsyncValue<OnboardingStateEntity>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

/// Provider pour vérifier si l'onboarding est complété

@ProviderFor(hasCompletedOnboarding)
const hasCompletedOnboardingProvider = HasCompletedOnboardingProvider._();

/// Provider pour vérifier si l'onboarding est complété

final class HasCompletedOnboardingProvider
    extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  /// Provider pour vérifier si l'onboarding est complété
  const HasCompletedOnboardingProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'hasCompletedOnboardingProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$hasCompletedOnboardingHash();

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    return hasCompletedOnboarding(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$hasCompletedOnboardingHash() =>
    r'306ea2d3a79cdeac28b1d2349aaa7e9b35e73537';

/// Provider pour obtenir le revenu mensuel converti selon la fréquence

@ProviderFor(convertedMonthlyIncome)
const convertedMonthlyIncomeProvider = ConvertedMonthlyIncomeProvider._();

/// Provider pour obtenir le revenu mensuel converti selon la fréquence

final class ConvertedMonthlyIncomeProvider
    extends $FunctionalProvider<double?, double?, double?>
    with $Provider<double?> {
  /// Provider pour obtenir le revenu mensuel converti selon la fréquence
  const ConvertedMonthlyIncomeProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'convertedMonthlyIncomeProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$convertedMonthlyIncomeHash();

  @$internal
  @override
  $ProviderElement<double?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  double? create(Ref ref) {
    return convertedMonthlyIncome(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(double? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<double?>(value),
    );
  }
}

String _$convertedMonthlyIncomeHash() =>
    r'e7eb1cef21e12df73e5e115cbcbb00eb46aae3bd';

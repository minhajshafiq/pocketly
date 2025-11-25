// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currency_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider pour SharedPreferences

@ProviderFor(currencySharedPreferences)
const currencySharedPreferencesProvider = CurrencySharedPreferencesProvider._();

/// Provider pour SharedPreferences

final class CurrencySharedPreferencesProvider
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
  const CurrencySharedPreferencesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currencySharedPreferencesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currencySharedPreferencesHash();

  @$internal
  @override
  $FutureProviderElement<SharedPreferences> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<SharedPreferences> create(Ref ref) {
    return currencySharedPreferences(ref);
  }
}

String _$currencySharedPreferencesHash() =>
    r'0188d6efa4f72609045635a713513eeac83068f3';

/// Provider pour le datasource local des devises

@ProviderFor(currencyLocalDataSource)
const currencyLocalDataSourceProvider = CurrencyLocalDataSourceProvider._();

/// Provider pour le datasource local des devises

final class CurrencyLocalDataSourceProvider
    extends
        $FunctionalProvider<
          AsyncValue<CurrencyLocalDataSource>,
          CurrencyLocalDataSource,
          FutureOr<CurrencyLocalDataSource>
        >
    with
        $FutureModifier<CurrencyLocalDataSource>,
        $FutureProvider<CurrencyLocalDataSource> {
  /// Provider pour le datasource local des devises
  const CurrencyLocalDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currencyLocalDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currencyLocalDataSourceHash();

  @$internal
  @override
  $FutureProviderElement<CurrencyLocalDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<CurrencyLocalDataSource> create(Ref ref) {
    return currencyLocalDataSource(ref);
  }
}

String _$currencyLocalDataSourceHash() =>
    r'b59cf88ce3b11b8733ac5c43210febee6a82830c';

/// Provider pour le repository des devises

@ProviderFor(currencyRepository)
const currencyRepositoryProvider = CurrencyRepositoryProvider._();

/// Provider pour le repository des devises

final class CurrencyRepositoryProvider
    extends
        $FunctionalProvider<
          AsyncValue<CurrencyRepository>,
          CurrencyRepository,
          FutureOr<CurrencyRepository>
        >
    with
        $FutureModifier<CurrencyRepository>,
        $FutureProvider<CurrencyRepository> {
  /// Provider pour le repository des devises
  const CurrencyRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currencyRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currencyRepositoryHash();

  @$internal
  @override
  $FutureProviderElement<CurrencyRepository> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<CurrencyRepository> create(Ref ref) {
    return currencyRepository(ref);
  }
}

String _$currencyRepositoryHash() =>
    r'70d8ee4048c7c84df115a8ec8cb5af68752d732f';

/// Provider pour le use case GetUserCurrency

@ProviderFor(getUserCurrencyUseCase)
const getUserCurrencyUseCaseProvider = GetUserCurrencyUseCaseProvider._();

/// Provider pour le use case GetUserCurrency

final class GetUserCurrencyUseCaseProvider
    extends
        $FunctionalProvider<
          AsyncValue<GetUserCurrencyUseCase>,
          GetUserCurrencyUseCase,
          FutureOr<GetUserCurrencyUseCase>
        >
    with
        $FutureModifier<GetUserCurrencyUseCase>,
        $FutureProvider<GetUserCurrencyUseCase> {
  /// Provider pour le use case GetUserCurrency
  const GetUserCurrencyUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getUserCurrencyUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getUserCurrencyUseCaseHash();

  @$internal
  @override
  $FutureProviderElement<GetUserCurrencyUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<GetUserCurrencyUseCase> create(Ref ref) {
    return getUserCurrencyUseCase(ref);
  }
}

String _$getUserCurrencyUseCaseHash() =>
    r'0ab94c9d74b7536e03d0072970b17de57055cdd7';

/// Provider pour le use case SetUserCurrency

@ProviderFor(setUserCurrencyUseCase)
const setUserCurrencyUseCaseProvider = SetUserCurrencyUseCaseProvider._();

/// Provider pour le use case SetUserCurrency

final class SetUserCurrencyUseCaseProvider
    extends
        $FunctionalProvider<
          AsyncValue<SetUserCurrencyUseCase>,
          SetUserCurrencyUseCase,
          FutureOr<SetUserCurrencyUseCase>
        >
    with
        $FutureModifier<SetUserCurrencyUseCase>,
        $FutureProvider<SetUserCurrencyUseCase> {
  /// Provider pour le use case SetUserCurrency
  const SetUserCurrencyUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'setUserCurrencyUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$setUserCurrencyUseCaseHash();

  @$internal
  @override
  $FutureProviderElement<SetUserCurrencyUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<SetUserCurrencyUseCase> create(Ref ref) {
    return setUserCurrencyUseCase(ref);
  }
}

String _$setUserCurrencyUseCaseHash() =>
    r'c80c7a4561ca10bc4020d70978088c7a5cf75f53';

/// Provider pour le use case GetAllCurrencies

@ProviderFor(getAllCurrenciesUseCase)
const getAllCurrenciesUseCaseProvider = GetAllCurrenciesUseCaseProvider._();

/// Provider pour le use case GetAllCurrencies

final class GetAllCurrenciesUseCaseProvider
    extends
        $FunctionalProvider<
          AsyncValue<GetAllCurrenciesUseCase>,
          GetAllCurrenciesUseCase,
          FutureOr<GetAllCurrenciesUseCase>
        >
    with
        $FutureModifier<GetAllCurrenciesUseCase>,
        $FutureProvider<GetAllCurrenciesUseCase> {
  /// Provider pour le use case GetAllCurrencies
  const GetAllCurrenciesUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getAllCurrenciesUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getAllCurrenciesUseCaseHash();

  @$internal
  @override
  $FutureProviderElement<GetAllCurrenciesUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<GetAllCurrenciesUseCase> create(Ref ref) {
    return getAllCurrenciesUseCase(ref);
  }
}

String _$getAllCurrenciesUseCaseHash() =>
    r'e5fba994eb71afdd54c97200ef5571ecf3217298';

/// Provider pour les devises disponibles

@ProviderFor(availableCurrencies)
const availableCurrenciesProvider = AvailableCurrenciesProvider._();

/// Provider pour les devises disponibles

final class AvailableCurrenciesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<CurrencyEntity>>,
          List<CurrencyEntity>,
          FutureOr<List<CurrencyEntity>>
        >
    with
        $FutureModifier<List<CurrencyEntity>>,
        $FutureProvider<List<CurrencyEntity>> {
  /// Provider pour les devises disponibles
  const AvailableCurrenciesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'availableCurrenciesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$availableCurrenciesHash();

  @$internal
  @override
  $FutureProviderElement<List<CurrencyEntity>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<CurrencyEntity>> create(Ref ref) {
    return availableCurrencies(ref);
  }
}

String _$availableCurrenciesHash() =>
    r'd212750ec5cdd5f92eafee07eda121f695751b3e';

/// Notifier pour la gestion de la devise utilisateur

@ProviderFor(CurrencyNotifier)
const currencyProvider = CurrencyNotifierProvider._();

/// Notifier pour la gestion de la devise utilisateur
final class CurrencyNotifierProvider
    extends $AsyncNotifierProvider<CurrencyNotifier, CurrencyEntity> {
  /// Notifier pour la gestion de la devise utilisateur
  const CurrencyNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currencyProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currencyNotifierHash();

  @$internal
  @override
  CurrencyNotifier create() => CurrencyNotifier();
}

String _$currencyNotifierHash() => r'01b6bf3c22febfbc94fb681aaacd07931d1cc8e4';

/// Notifier pour la gestion de la devise utilisateur

abstract class _$CurrencyNotifier extends $AsyncNotifier<CurrencyEntity> {
  FutureOr<CurrencyEntity> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<CurrencyEntity>, CurrencyEntity>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<CurrencyEntity>, CurrencyEntity>,
              AsyncValue<CurrencyEntity>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

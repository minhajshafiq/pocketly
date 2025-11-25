// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider pour le use case de calcul du résumé

@ProviderFor(getHomeSummaryUseCase)
const getHomeSummaryUseCaseProvider = GetHomeSummaryUseCaseProvider._();

/// Provider pour le use case de calcul du résumé

final class GetHomeSummaryUseCaseProvider
    extends
        $FunctionalProvider<
          GetHomeSummaryUseCase,
          GetHomeSummaryUseCase,
          GetHomeSummaryUseCase
        >
    with $Provider<GetHomeSummaryUseCase> {
  /// Provider pour le use case de calcul du résumé
  const GetHomeSummaryUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getHomeSummaryUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getHomeSummaryUseCaseHash();

  @$internal
  @override
  $ProviderElement<GetHomeSummaryUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetHomeSummaryUseCase create(Ref ref) {
    return getHomeSummaryUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetHomeSummaryUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetHomeSummaryUseCase>(value),
    );
  }
}

String _$getHomeSummaryUseCaseHash() =>
    r'b007aaa20ff5dffea936b201a793e87334b8c15f';

/// Provider pour le use case de calcul des dépenses hebdomadaires

@ProviderFor(getWeeklyExpensesUseCase)
const getWeeklyExpensesUseCaseProvider = GetWeeklyExpensesUseCaseProvider._();

/// Provider pour le use case de calcul des dépenses hebdomadaires

final class GetWeeklyExpensesUseCaseProvider
    extends
        $FunctionalProvider<
          GetWeeklyExpensesUseCase,
          GetWeeklyExpensesUseCase,
          GetWeeklyExpensesUseCase
        >
    with $Provider<GetWeeklyExpensesUseCase> {
  /// Provider pour le use case de calcul des dépenses hebdomadaires
  const GetWeeklyExpensesUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getWeeklyExpensesUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getWeeklyExpensesUseCaseHash();

  @$internal
  @override
  $ProviderElement<GetWeeklyExpensesUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetWeeklyExpensesUseCase create(Ref ref) {
    return getWeeklyExpensesUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetWeeklyExpensesUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetWeeklyExpensesUseCase>(value),
    );
  }
}

String _$getWeeklyExpensesUseCaseHash() =>
    r'7b460008e987f73a3e80e1d797cf6c0480f5011a';

/// Provider pour le use case de récupération des transactions récentes

@ProviderFor(getRecentTransactionsUseCase)
const getRecentTransactionsUseCaseProvider =
    GetRecentTransactionsUseCaseProvider._();

/// Provider pour le use case de récupération des transactions récentes

final class GetRecentTransactionsUseCaseProvider
    extends
        $FunctionalProvider<
          GetRecentTransactionsUseCase,
          GetRecentTransactionsUseCase,
          GetRecentTransactionsUseCase
        >
    with $Provider<GetRecentTransactionsUseCase> {
  /// Provider pour le use case de récupération des transactions récentes
  const GetRecentTransactionsUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getRecentTransactionsUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getRecentTransactionsUseCaseHash();

  @$internal
  @override
  $ProviderElement<GetRecentTransactionsUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetRecentTransactionsUseCase create(Ref ref) {
    return getRecentTransactionsUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetRecentTransactionsUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetRecentTransactionsUseCase>(value),
    );
  }
}

String _$getRecentTransactionsUseCaseHash() =>
    r'3d478d2b3d8ec1e59db5ae9b55910bd349ed55e9';

/// Provider pour le résumé de la page d'accueil
///
/// Watch automatiquement transactionProvider pour se mettre à jour
/// instantanément quand de nouvelles transactions sont créées/modifiées/supprimées

@ProviderFor(homeSummaryController)
const homeSummaryControllerProvider = HomeSummaryControllerProvider._();

/// Provider pour le résumé de la page d'accueil
///
/// Watch automatiquement transactionProvider pour se mettre à jour
/// instantanément quand de nouvelles transactions sont créées/modifiées/supprimées

final class HomeSummaryControllerProvider
    extends
        $FunctionalProvider<
          AsyncValue<HomeSummaryEntity>,
          HomeSummaryEntity,
          FutureOr<HomeSummaryEntity>
        >
    with
        $FutureModifier<HomeSummaryEntity>,
        $FutureProvider<HomeSummaryEntity> {
  /// Provider pour le résumé de la page d'accueil
  ///
  /// Watch automatiquement transactionProvider pour se mettre à jour
  /// instantanément quand de nouvelles transactions sont créées/modifiées/supprimées
  const HomeSummaryControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'homeSummaryControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$homeSummaryControllerHash();

  @$internal
  @override
  $FutureProviderElement<HomeSummaryEntity> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<HomeSummaryEntity> create(Ref ref) {
    return homeSummaryController(ref);
  }
}

String _$homeSummaryControllerHash() =>
    r'eab1a458eb8bc40ed5d23a5531ca9e82d09a7062';

/// Provider pour les dépenses hebdomadaires
///
/// Watch automatiquement transactionProvider pour se mettre à jour
/// instantanément quand de nouvelles transactions sont créées/modifiées/supprimées

@ProviderFor(weeklyExpensesController)
const weeklyExpensesControllerProvider = WeeklyExpensesControllerProvider._();

/// Provider pour les dépenses hebdomadaires
///
/// Watch automatiquement transactionProvider pour se mettre à jour
/// instantanément quand de nouvelles transactions sont créées/modifiées/supprimées

final class WeeklyExpensesControllerProvider
    extends
        $FunctionalProvider<
          WeeklyExpensesEntity,
          WeeklyExpensesEntity,
          WeeklyExpensesEntity
        >
    with $Provider<WeeklyExpensesEntity> {
  /// Provider pour les dépenses hebdomadaires
  ///
  /// Watch automatiquement transactionProvider pour se mettre à jour
  /// instantanément quand de nouvelles transactions sont créées/modifiées/supprimées
  const WeeklyExpensesControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'weeklyExpensesControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$weeklyExpensesControllerHash();

  @$internal
  @override
  $ProviderElement<WeeklyExpensesEntity> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  WeeklyExpensesEntity create(Ref ref) {
    return weeklyExpensesController(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WeeklyExpensesEntity value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WeeklyExpensesEntity>(value),
    );
  }
}

String _$weeklyExpensesControllerHash() =>
    r'8a14236ed1786b9327cb87c8e85b4618fa503e9a';

/// Provider pour les transactions récentes
///
/// Watch automatiquement transactionProvider pour se mettre à jour
/// instantanément quand de nouvelles transactions sont créées/modifiées/supprimées

@ProviderFor(recentTransactionsController)
const recentTransactionsControllerProvider =
    RecentTransactionsControllerProvider._();

/// Provider pour les transactions récentes
///
/// Watch automatiquement transactionProvider pour se mettre à jour
/// instantanément quand de nouvelles transactions sont créées/modifiées/supprimées

final class RecentTransactionsControllerProvider
    extends
        $FunctionalProvider<
          List<TransactionEntity>,
          List<TransactionEntity>,
          List<TransactionEntity>
        >
    with $Provider<List<TransactionEntity>> {
  /// Provider pour les transactions récentes
  ///
  /// Watch automatiquement transactionProvider pour se mettre à jour
  /// instantanément quand de nouvelles transactions sont créées/modifiées/supprimées
  const RecentTransactionsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'recentTransactionsControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$recentTransactionsControllerHash();

  @$internal
  @override
  $ProviderElement<List<TransactionEntity>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  List<TransactionEntity> create(Ref ref) {
    return recentTransactionsController(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<TransactionEntity> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<TransactionEntity>>(value),
    );
  }
}

String _$recentTransactionsControllerHash() =>
    r'202bacea85525069b0e32b703b155247c0a76a49';

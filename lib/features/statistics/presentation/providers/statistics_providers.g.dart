// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'statistics_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider pour SharedPreferences (cache local)

@ProviderFor(sharedPreferences)
const sharedPreferencesProvider = SharedPreferencesProvider._();

/// Provider pour SharedPreferences (cache local)

final class SharedPreferencesProvider
    extends
        $FunctionalProvider<
          AsyncValue<SharedPreferences>,
          SharedPreferences,
          FutureOr<SharedPreferences>
        >
    with
        $FutureModifier<SharedPreferences>,
        $FutureProvider<SharedPreferences> {
  /// Provider pour SharedPreferences (cache local)
  const SharedPreferencesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sharedPreferencesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sharedPreferencesHash();

  @$internal
  @override
  $FutureProviderElement<SharedPreferences> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<SharedPreferences> create(Ref ref) {
    return sharedPreferences(ref);
  }
}

String _$sharedPreferencesHash() => r'd22b545aefe95500327f9dce52c645d746349271';

/// Provider pour le datasource distant des statistiques

@ProviderFor(statisticsRemoteDataSource)
const statisticsRemoteDataSourceProvider =
    StatisticsRemoteDataSourceProvider._();

/// Provider pour le datasource distant des statistiques

final class StatisticsRemoteDataSourceProvider
    extends
        $FunctionalProvider<
          StatisticsRemoteDataSource,
          StatisticsRemoteDataSource,
          StatisticsRemoteDataSource
        >
    with $Provider<StatisticsRemoteDataSource> {
  /// Provider pour le datasource distant des statistiques
  const StatisticsRemoteDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'statisticsRemoteDataSourceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$statisticsRemoteDataSourceHash();

  @$internal
  @override
  $ProviderElement<StatisticsRemoteDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  StatisticsRemoteDataSource create(Ref ref) {
    return statisticsRemoteDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(StatisticsRemoteDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<StatisticsRemoteDataSource>(value),
    );
  }
}

String _$statisticsRemoteDataSourceHash() =>
    r'96e55a708bf36ad0b11818d01aefb665cd378d6e';

/// Provider pour le datasource local (cache SharedPreferences)

@ProviderFor(statisticsLocalDataSource)
const statisticsLocalDataSourceProvider = StatisticsLocalDataSourceProvider._();

/// Provider pour le datasource local (cache SharedPreferences)

final class StatisticsLocalDataSourceProvider
    extends
        $FunctionalProvider<
          AsyncValue<StatisticsLocalDataSource>,
          StatisticsLocalDataSource,
          FutureOr<StatisticsLocalDataSource>
        >
    with
        $FutureModifier<StatisticsLocalDataSource>,
        $FutureProvider<StatisticsLocalDataSource> {
  /// Provider pour le datasource local (cache SharedPreferences)
  const StatisticsLocalDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'statisticsLocalDataSourceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$statisticsLocalDataSourceHash();

  @$internal
  @override
  $FutureProviderElement<StatisticsLocalDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<StatisticsLocalDataSource> create(Ref ref) {
    return statisticsLocalDataSource(ref);
  }
}

String _$statisticsLocalDataSourceHash() =>
    r'710aaea0513c0eb3c895707997a6600f1544d969';

/// Provider pour le repository des statistiques

@ProviderFor(statisticsRepository)
const statisticsRepositoryProvider = StatisticsRepositoryProvider._();

/// Provider pour le repository des statistiques

final class StatisticsRepositoryProvider
    extends
        $FunctionalProvider<
          AsyncValue<StatisticsRepository>,
          StatisticsRepository,
          FutureOr<StatisticsRepository>
        >
    with
        $FutureModifier<StatisticsRepository>,
        $FutureProvider<StatisticsRepository> {
  /// Provider pour le repository des statistiques
  const StatisticsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'statisticsRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$statisticsRepositoryHash();

  @$internal
  @override
  $FutureProviderElement<StatisticsRepository> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<StatisticsRepository> create(Ref ref) {
    return statisticsRepository(ref);
  }
}

String _$statisticsRepositoryHash() =>
    r'24c68382eac7f5a42a62935898abf53136310033';

/// Provider pour le use case de récupération du résumé

@ProviderFor(getStatisticsSummaryUseCase)
const getStatisticsSummaryUseCaseProvider =
    GetStatisticsSummaryUseCaseProvider._();

/// Provider pour le use case de récupération du résumé

final class GetStatisticsSummaryUseCaseProvider
    extends
        $FunctionalProvider<
          AsyncValue<GetStatisticsSummaryUseCase>,
          GetStatisticsSummaryUseCase,
          FutureOr<GetStatisticsSummaryUseCase>
        >
    with
        $FutureModifier<GetStatisticsSummaryUseCase>,
        $FutureProvider<GetStatisticsSummaryUseCase> {
  /// Provider pour le use case de récupération du résumé
  const GetStatisticsSummaryUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getStatisticsSummaryUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getStatisticsSummaryUseCaseHash();

  @$internal
  @override
  $FutureProviderElement<GetStatisticsSummaryUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<GetStatisticsSummaryUseCase> create(Ref ref) {
    return getStatisticsSummaryUseCase(ref);
  }
}

String _$getStatisticsSummaryUseCaseHash() =>
    r'9271c13258ab89ebc2d6f30b8f5263060a958341';

/// Provider pour le use case de récupération des données du graphique

@ProviderFor(getChartDataUseCase)
const getChartDataUseCaseProvider = GetChartDataUseCaseProvider._();

/// Provider pour le use case de récupération des données du graphique

final class GetChartDataUseCaseProvider
    extends
        $FunctionalProvider<
          AsyncValue<GetChartDataUseCase>,
          GetChartDataUseCase,
          FutureOr<GetChartDataUseCase>
        >
    with
        $FutureModifier<GetChartDataUseCase>,
        $FutureProvider<GetChartDataUseCase> {
  /// Provider pour le use case de récupération des données du graphique
  const GetChartDataUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getChartDataUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getChartDataUseCaseHash();

  @$internal
  @override
  $FutureProviderElement<GetChartDataUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<GetChartDataUseCase> create(Ref ref) {
    return getChartDataUseCase(ref);
  }
}

String _$getChartDataUseCaseHash() =>
    r'9a6069f840c84190b0d770c91faab45343e0a3c3';

/// Provider pour le use case de récupération des transactions par date

@ProviderFor(getTransactionsByDateUseCase)
const getTransactionsByDateUseCaseProvider =
    GetTransactionsByDateUseCaseProvider._();

/// Provider pour le use case de récupération des transactions par date

final class GetTransactionsByDateUseCaseProvider
    extends
        $FunctionalProvider<
          AsyncValue<GetTransactionsByDateUseCase>,
          GetTransactionsByDateUseCase,
          FutureOr<GetTransactionsByDateUseCase>
        >
    with
        $FutureModifier<GetTransactionsByDateUseCase>,
        $FutureProvider<GetTransactionsByDateUseCase> {
  /// Provider pour le use case de récupération des transactions par date
  const GetTransactionsByDateUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getTransactionsByDateUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getTransactionsByDateUseCaseHash();

  @$internal
  @override
  $FutureProviderElement<GetTransactionsByDateUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<GetTransactionsByDateUseCase> create(Ref ref) {
    return getTransactionsByDateUseCase(ref);
  }
}

String _$getTransactionsByDateUseCaseHash() =>
    r'00d1761a392ea014cd4225af60f33d82af98e496';

/// Provider pour le type de graphique sélectionné

@ProviderFor(ChartTypeNotifier)
const chartTypeProvider = ChartTypeNotifierProvider._();

/// Provider pour le type de graphique sélectionné
final class ChartTypeNotifierProvider
    extends $NotifierProvider<ChartTypeNotifier, ChartType> {
  /// Provider pour le type de graphique sélectionné
  const ChartTypeNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'chartTypeProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$chartTypeNotifierHash();

  @$internal
  @override
  ChartTypeNotifier create() => ChartTypeNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ChartType value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ChartType>(value),
    );
  }
}

String _$chartTypeNotifierHash() => r'9166d8913db59f0d90e8b4221bca4916b8d341c7';

/// Provider pour le type de graphique sélectionné

abstract class _$ChartTypeNotifier extends $Notifier<ChartType> {
  ChartType build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<ChartType, ChartType>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ChartType, ChartType>,
              ChartType,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

/// Provider pour la période sélectionnée

@ProviderFor(TimePeriodNotifier)
const timePeriodProvider = TimePeriodNotifierProvider._();

/// Provider pour la période sélectionnée
final class TimePeriodNotifierProvider
    extends $NotifierProvider<TimePeriodNotifier, TimePeriod> {
  /// Provider pour la période sélectionnée
  const TimePeriodNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'timePeriodProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$timePeriodNotifierHash();

  @$internal
  @override
  TimePeriodNotifier create() => TimePeriodNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TimePeriod value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TimePeriod>(value),
    );
  }
}

String _$timePeriodNotifierHash() =>
    r'f710bd65f4d60434f5948c9163b27122e63abedc';

/// Provider pour la période sélectionnée

abstract class _$TimePeriodNotifier extends $Notifier<TimePeriod> {
  TimePeriod build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<TimePeriod, TimePeriod>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<TimePeriod, TimePeriod>,
              TimePeriod,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

/// Provider pour la date de début actuelle

@ProviderFor(CurrentStartDateNotifier)
const currentStartDateProvider = CurrentStartDateNotifierProvider._();

/// Provider pour la date de début actuelle
final class CurrentStartDateNotifierProvider
    extends $NotifierProvider<CurrentStartDateNotifier, DateTime> {
  /// Provider pour la date de début actuelle
  const CurrentStartDateNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentStartDateProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentStartDateNotifierHash();

  @$internal
  @override
  CurrentStartDateNotifier create() => CurrentStartDateNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DateTime value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DateTime>(value),
    );
  }
}

String _$currentStartDateNotifierHash() =>
    r'24f38445af191f610eaa2e1090ce7b1c9a9d60d1';

/// Provider pour la date de début actuelle

abstract class _$CurrentStartDateNotifier extends $Notifier<DateTime> {
  DateTime build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<DateTime, DateTime>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<DateTime, DateTime>,
              DateTime,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

/// Provider pour le jour sélectionné dans le graphique

@ProviderFor(SelectedDayNotifier)
const selectedDayProvider = SelectedDayNotifierProvider._();

/// Provider pour le jour sélectionné dans le graphique
final class SelectedDayNotifierProvider
    extends $NotifierProvider<SelectedDayNotifier, DateTime?> {
  /// Provider pour le jour sélectionné dans le graphique
  const SelectedDayNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedDayProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectedDayNotifierHash();

  @$internal
  @override
  SelectedDayNotifier create() => SelectedDayNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DateTime? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DateTime?>(value),
    );
  }
}

String _$selectedDayNotifierHash() =>
    r'2977564b367b8a6f55d61476ea68b1249ddbe075';

/// Provider pour le jour sélectionné dans le graphique

abstract class _$SelectedDayNotifier extends $Notifier<DateTime?> {
  DateTime? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<DateTime?, DateTime?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<DateTime?, DateTime?>,
              DateTime?,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

/// Provider pour le résumé des statistiques
///
/// Watch automatiquement transactionProvider pour se mettre à jour
/// instantanément quand de nouvelles transactions sont créées/modifiées/supprimées

@ProviderFor(statisticsSummaryController)
const statisticsSummaryControllerProvider =
    StatisticsSummaryControllerProvider._();

/// Provider pour le résumé des statistiques
///
/// Watch automatiquement transactionProvider pour se mettre à jour
/// instantanément quand de nouvelles transactions sont créées/modifiées/supprimées

final class StatisticsSummaryControllerProvider
    extends
        $FunctionalProvider<
          AsyncValue<StatisticsSummaryEntity>,
          StatisticsSummaryEntity,
          FutureOr<StatisticsSummaryEntity>
        >
    with
        $FutureModifier<StatisticsSummaryEntity>,
        $FutureProvider<StatisticsSummaryEntity> {
  /// Provider pour le résumé des statistiques
  ///
  /// Watch automatiquement transactionProvider pour se mettre à jour
  /// instantanément quand de nouvelles transactions sont créées/modifiées/supprimées
  const StatisticsSummaryControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'statisticsSummaryControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$statisticsSummaryControllerHash();

  @$internal
  @override
  $FutureProviderElement<StatisticsSummaryEntity> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<StatisticsSummaryEntity> create(Ref ref) {
    return statisticsSummaryController(ref);
  }
}

String _$statisticsSummaryControllerHash() =>
    r'33f8581a2467b378d5d72b8b58d8341e0a340605';

/// Provider pour les données du graphique
///
/// Watch automatiquement transactionProvider pour se mettre à jour
/// instantanément quand de nouvelles transactions sont créées/modifiées/supprimées

@ProviderFor(chartDataController)
const chartDataControllerProvider = ChartDataControllerProvider._();

/// Provider pour les données du graphique
///
/// Watch automatiquement transactionProvider pour se mettre à jour
/// instantanément quand de nouvelles transactions sont créées/modifiées/supprimées

final class ChartDataControllerProvider
    extends
        $FunctionalProvider<
          AsyncValue<ChartDataEntity>,
          ChartDataEntity,
          FutureOr<ChartDataEntity>
        >
    with $FutureModifier<ChartDataEntity>, $FutureProvider<ChartDataEntity> {
  /// Provider pour les données du graphique
  ///
  /// Watch automatiquement transactionProvider pour se mettre à jour
  /// instantanément quand de nouvelles transactions sont créées/modifiées/supprimées
  const ChartDataControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'chartDataControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$chartDataControllerHash();

  @$internal
  @override
  $FutureProviderElement<ChartDataEntity> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<ChartDataEntity> create(Ref ref) {
    return chartDataController(ref);
  }
}

String _$chartDataControllerHash() =>
    r'9fa7f0d986b3fdc78cb26c71da2f4b8649173cd8';

/// Provider pour les transactions de la période
///
/// Watch automatiquement transactionProvider pour se mettre à jour
/// instantanément quand de nouvelles transactions sont créées/modifiées/supprimées

@ProviderFor(periodTransactionsController)
const periodTransactionsControllerProvider =
    PeriodTransactionsControllerProvider._();

/// Provider pour les transactions de la période
///
/// Watch automatiquement transactionProvider pour se mettre à jour
/// instantanément quand de nouvelles transactions sont créées/modifiées/supprimées

final class PeriodTransactionsControllerProvider
    extends
        $FunctionalProvider<
          List<TransactionEntity>,
          List<TransactionEntity>,
          List<TransactionEntity>
        >
    with $Provider<List<TransactionEntity>> {
  /// Provider pour les transactions de la période
  ///
  /// Watch automatiquement transactionProvider pour se mettre à jour
  /// instantanément quand de nouvelles transactions sont créées/modifiées/supprimées
  const PeriodTransactionsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'periodTransactionsControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$periodTransactionsControllerHash();

  @$internal
  @override
  $ProviderElement<List<TransactionEntity>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  List<TransactionEntity> create(Ref ref) {
    return periodTransactionsController(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<TransactionEntity> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<TransactionEntity>>(value),
    );
  }
}

String _$periodTransactionsControllerHash() =>
    r'8431863f61d43635c20cedc1eba882b02fd8cd89';

/// Provider pour les transactions filtrées par jour sélectionné

@ProviderFor(filteredDayTransactions)
const filteredDayTransactionsProvider = FilteredDayTransactionsProvider._();

/// Provider pour les transactions filtrées par jour sélectionné

final class FilteredDayTransactionsProvider
    extends
        $FunctionalProvider<
          List<TransactionEntity>,
          List<TransactionEntity>,
          List<TransactionEntity>
        >
    with $Provider<List<TransactionEntity>> {
  /// Provider pour les transactions filtrées par jour sélectionné
  const FilteredDayTransactionsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'filteredDayTransactionsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$filteredDayTransactionsHash();

  @$internal
  @override
  $ProviderElement<List<TransactionEntity>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  List<TransactionEntity> create(Ref ref) {
    return filteredDayTransactions(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<TransactionEntity> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<TransactionEntity>>(value),
    );
  }
}

String _$filteredDayTransactionsHash() =>
    r'dde239543753ed82518b49c540d921b56f7927c6';

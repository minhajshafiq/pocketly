// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_history_providers.dart';

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

/// Provider pour le datasource remote (Supabase)

@ProviderFor(transactionHistoryRemoteDataSource)
const transactionHistoryRemoteDataSourceProvider =
    TransactionHistoryRemoteDataSourceProvider._();

/// Provider pour le datasource remote (Supabase)

final class TransactionHistoryRemoteDataSourceProvider
    extends
        $FunctionalProvider<
          TransactionHistoryRemoteDataSource,
          TransactionHistoryRemoteDataSource,
          TransactionHistoryRemoteDataSource
        >
    with $Provider<TransactionHistoryRemoteDataSource> {
  /// Provider pour le datasource remote (Supabase)
  const TransactionHistoryRemoteDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'transactionHistoryRemoteDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() =>
      _$transactionHistoryRemoteDataSourceHash();

  @$internal
  @override
  $ProviderElement<TransactionHistoryRemoteDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  TransactionHistoryRemoteDataSource create(Ref ref) {
    return transactionHistoryRemoteDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TransactionHistoryRemoteDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TransactionHistoryRemoteDataSource>(
        value,
      ),
    );
  }
}

String _$transactionHistoryRemoteDataSourceHash() =>
    r'80f7cb9902a587e9410b745f2d13319255e0f013';

/// Provider pour le datasource local (cache SharedPreferences)

@ProviderFor(transactionHistoryLocalDataSource)
const transactionHistoryLocalDataSourceProvider =
    TransactionHistoryLocalDataSourceProvider._();

/// Provider pour le datasource local (cache SharedPreferences)

final class TransactionHistoryLocalDataSourceProvider
    extends
        $FunctionalProvider<
          AsyncValue<TransactionHistoryLocalDataSource>,
          TransactionHistoryLocalDataSource,
          FutureOr<TransactionHistoryLocalDataSource>
        >
    with
        $FutureModifier<TransactionHistoryLocalDataSource>,
        $FutureProvider<TransactionHistoryLocalDataSource> {
  /// Provider pour le datasource local (cache SharedPreferences)
  const TransactionHistoryLocalDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'transactionHistoryLocalDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() =>
      _$transactionHistoryLocalDataSourceHash();

  @$internal
  @override
  $FutureProviderElement<TransactionHistoryLocalDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<TransactionHistoryLocalDataSource> create(Ref ref) {
    return transactionHistoryLocalDataSource(ref);
  }
}

String _$transactionHistoryLocalDataSourceHash() =>
    r'14f5d4e7e03c547e13fdea9fc1d54fe5f4f38191';

/// Provider pour le repository

@ProviderFor(transactionHistoryRepository)
const transactionHistoryRepositoryProvider =
    TransactionHistoryRepositoryProvider._();

/// Provider pour le repository

final class TransactionHistoryRepositoryProvider
    extends
        $FunctionalProvider<
          AsyncValue<TransactionHistoryRepository>,
          TransactionHistoryRepository,
          FutureOr<TransactionHistoryRepository>
        >
    with
        $FutureModifier<TransactionHistoryRepository>,
        $FutureProvider<TransactionHistoryRepository> {
  /// Provider pour le repository
  const TransactionHistoryRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'transactionHistoryRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$transactionHistoryRepositoryHash();

  @$internal
  @override
  $FutureProviderElement<TransactionHistoryRepository> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<TransactionHistoryRepository> create(Ref ref) {
    return transactionHistoryRepository(ref);
  }
}

String _$transactionHistoryRepositoryHash() =>
    r'ceb29d6d3968583dd028284fcb6345112a5b7265';

/// Provider pour le use case de récupération par date

@ProviderFor(getTransactionsByDateUseCase)
const getTransactionsByDateUseCaseProvider =
    GetTransactionsByDateUseCaseProvider._();

/// Provider pour le use case de récupération par date

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
  /// Provider pour le use case de récupération par date
  const GetTransactionsByDateUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getTransactionsByDateUseCaseProvider',
        isAutoDispose: true,
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
    r'936a4b255ed790b674379da2fd7f468b05007c8d';

/// Provider pour le use case de récupération par période

@ProviderFor(getTransactionsByPeriodUseCase)
const getTransactionsByPeriodUseCaseProvider =
    GetTransactionsByPeriodUseCaseProvider._();

/// Provider pour le use case de récupération par période

final class GetTransactionsByPeriodUseCaseProvider
    extends
        $FunctionalProvider<
          AsyncValue<GetTransactionsByPeriodUseCase>,
          GetTransactionsByPeriodUseCase,
          FutureOr<GetTransactionsByPeriodUseCase>
        >
    with
        $FutureModifier<GetTransactionsByPeriodUseCase>,
        $FutureProvider<GetTransactionsByPeriodUseCase> {
  /// Provider pour le use case de récupération par période
  const GetTransactionsByPeriodUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getTransactionsByPeriodUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getTransactionsByPeriodUseCaseHash();

  @$internal
  @override
  $FutureProviderElement<GetTransactionsByPeriodUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<GetTransactionsByPeriodUseCase> create(Ref ref) {
    return getTransactionsByPeriodUseCase(ref);
  }
}

String _$getTransactionsByPeriodUseCaseHash() =>
    r'37a66a6e7f9ab1ad1283dbf5305f6c7acb1a7815';

/// Provider pour le use case de récupération du calendrier

@ProviderFor(getCalendarDataUseCase)
const getCalendarDataUseCaseProvider = GetCalendarDataUseCaseProvider._();

/// Provider pour le use case de récupération du calendrier

final class GetCalendarDataUseCaseProvider
    extends
        $FunctionalProvider<
          AsyncValue<GetCalendarDataUseCase>,
          GetCalendarDataUseCase,
          FutureOr<GetCalendarDataUseCase>
        >
    with
        $FutureModifier<GetCalendarDataUseCase>,
        $FutureProvider<GetCalendarDataUseCase> {
  /// Provider pour le use case de récupération du calendrier
  const GetCalendarDataUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getCalendarDataUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getCalendarDataUseCaseHash();

  @$internal
  @override
  $FutureProviderElement<GetCalendarDataUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<GetCalendarDataUseCase> create(Ref ref) {
    return getCalendarDataUseCase(ref);
  }
}

String _$getCalendarDataUseCaseHash() =>
    r'72de36345a8a927afd3b798b5f194dcc4f871dd8';

/// Provider pour le use case de résumé

@ProviderFor(getTransactionSummaryUseCase)
const getTransactionSummaryUseCaseProvider =
    GetTransactionSummaryUseCaseProvider._();

/// Provider pour le use case de résumé

final class GetTransactionSummaryUseCaseProvider
    extends
        $FunctionalProvider<
          AsyncValue<GetTransactionSummaryUseCase>,
          GetTransactionSummaryUseCase,
          FutureOr<GetTransactionSummaryUseCase>
        >
    with
        $FutureModifier<GetTransactionSummaryUseCase>,
        $FutureProvider<GetTransactionSummaryUseCase> {
  /// Provider pour le use case de résumé
  const GetTransactionSummaryUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getTransactionSummaryUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getTransactionSummaryUseCaseHash();

  @$internal
  @override
  $FutureProviderElement<GetTransactionSummaryUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<GetTransactionSummaryUseCase> create(Ref ref) {
    return getTransactionSummaryUseCase(ref);
  }
}

String _$getTransactionSummaryUseCaseHash() =>
    r'1efcb9853a73fdcdfd5e78baaca0c0ca8fda1aab';

/// Controller pour le calendrier

@ProviderFor(CalendarController)
const calendarControllerProvider = CalendarControllerProvider._();

/// Controller pour le calendrier
final class CalendarControllerProvider
    extends $NotifierProvider<CalendarController, CalendarState> {
  /// Controller pour le calendrier
  const CalendarControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'calendarControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$calendarControllerHash();

  @$internal
  @override
  CalendarController create() => CalendarController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CalendarState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CalendarState>(value),
    );
  }
}

String _$calendarControllerHash() =>
    r'c4b16df57ea8d5d771efb557fa387c8324d3f771';

/// Controller pour le calendrier

abstract class _$CalendarController extends $Notifier<CalendarState> {
  CalendarState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<CalendarState, CalendarState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<CalendarState, CalendarState>,
              CalendarState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

/// Controller pour le filtre de période

@ProviderFor(PeriodFilterController)
const periodFilterControllerProvider = PeriodFilterControllerProvider._();

/// Controller pour le filtre de période
final class PeriodFilterControllerProvider
    extends $NotifierProvider<PeriodFilterController, TransactionPeriodEntity> {
  /// Controller pour le filtre de période
  const PeriodFilterControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'periodFilterControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$periodFilterControllerHash();

  @$internal
  @override
  PeriodFilterController create() => PeriodFilterController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TransactionPeriodEntity value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TransactionPeriodEntity>(value),
    );
  }
}

String _$periodFilterControllerHash() =>
    r'aa99c6411fae7bf8ee85e21a50994bb5cb59d192';

/// Controller pour le filtre de période

abstract class _$PeriodFilterController
    extends $Notifier<TransactionPeriodEntity> {
  TransactionPeriodEntity build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<TransactionPeriodEntity, TransactionPeriodEntity>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<TransactionPeriodEntity, TransactionPeriodEntity>,
              TransactionPeriodEntity,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

/// Provider pour les transactions filtrées par période
///
/// Watch automatiquement transactionProvider pour se mettre à jour
/// instantanément quand de nouvelles transactions sont créées/modifiées/supprimées
///
/// IMPORTANT: Ce provider génère les occurrences des transactions récurrentes
/// pour la période sélectionnée avant de les filtrer

@ProviderFor(filteredTransactions)
const filteredTransactionsProvider = FilteredTransactionsProvider._();

/// Provider pour les transactions filtrées par période
///
/// Watch automatiquement transactionProvider pour se mettre à jour
/// instantanément quand de nouvelles transactions sont créées/modifiées/supprimées
///
/// IMPORTANT: Ce provider génère les occurrences des transactions récurrentes
/// pour la période sélectionnée avant de les filtrer

final class FilteredTransactionsProvider
    extends
        $FunctionalProvider<
          List<TransactionEntity>,
          List<TransactionEntity>,
          List<TransactionEntity>
        >
    with $Provider<List<TransactionEntity>> {
  /// Provider pour les transactions filtrées par période
  ///
  /// Watch automatiquement transactionProvider pour se mettre à jour
  /// instantanément quand de nouvelles transactions sont créées/modifiées/supprimées
  ///
  /// IMPORTANT: Ce provider génère les occurrences des transactions récurrentes
  /// pour la période sélectionnée avant de les filtrer
  const FilteredTransactionsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'filteredTransactionsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$filteredTransactionsHash();

  @$internal
  @override
  $ProviderElement<List<TransactionEntity>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  List<TransactionEntity> create(Ref ref) {
    return filteredTransactions(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<TransactionEntity> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<TransactionEntity>>(value),
    );
  }
}

String _$filteredTransactionsHash() =>
    r'c563a092e0df24b87f0a8afa1065a8f150044e14';

/// Provider pour le résumé de la période sélectionnée

@ProviderFor(periodSummary)
const periodSummaryProvider = PeriodSummaryProvider._();

/// Provider pour le résumé de la période sélectionnée

final class PeriodSummaryProvider
    extends
        $FunctionalProvider<
          AsyncValue<TransactionSummaryEntity>,
          TransactionSummaryEntity,
          FutureOr<TransactionSummaryEntity>
        >
    with
        $FutureModifier<TransactionSummaryEntity>,
        $FutureProvider<TransactionSummaryEntity> {
  /// Provider pour le résumé de la période sélectionnée
  const PeriodSummaryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'periodSummaryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$periodSummaryHash();

  @$internal
  @override
  $FutureProviderElement<TransactionSummaryEntity> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<TransactionSummaryEntity> create(Ref ref) {
    return periodSummary(ref);
  }
}

String _$periodSummaryHash() => r'62d833d3823a4ee14f6a347b7bb25c51f1525300';

/// Provider pour les transactions d'un jour sélectionné
///
/// Watch automatiquement transactionProvider pour se mettre à jour
/// instantanément quand de nouvelles transactions sont créées/modifiées/supprimées
///
/// IMPORTANT: Ce provider génère les occurrences des transactions récurrentes
/// pour le jour sélectionné avant de les filtrer

@ProviderFor(selectedDayTransactions)
const selectedDayTransactionsProvider = SelectedDayTransactionsProvider._();

/// Provider pour les transactions d'un jour sélectionné
///
/// Watch automatiquement transactionProvider pour se mettre à jour
/// instantanément quand de nouvelles transactions sont créées/modifiées/supprimées
///
/// IMPORTANT: Ce provider génère les occurrences des transactions récurrentes
/// pour le jour sélectionné avant de les filtrer

final class SelectedDayTransactionsProvider
    extends
        $FunctionalProvider<
          List<TransactionEntity>,
          List<TransactionEntity>,
          List<TransactionEntity>
        >
    with $Provider<List<TransactionEntity>> {
  /// Provider pour les transactions d'un jour sélectionné
  ///
  /// Watch automatiquement transactionProvider pour se mettre à jour
  /// instantanément quand de nouvelles transactions sont créées/modifiées/supprimées
  ///
  /// IMPORTANT: Ce provider génère les occurrences des transactions récurrentes
  /// pour le jour sélectionné avant de les filtrer
  const SelectedDayTransactionsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedDayTransactionsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectedDayTransactionsHash();

  @$internal
  @override
  $ProviderElement<List<TransactionEntity>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  List<TransactionEntity> create(Ref ref) {
    return selectedDayTransactions(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<TransactionEntity> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<TransactionEntity>>(value),
    );
  }
}

String _$selectedDayTransactionsHash() =>
    r'3d4ffb736ef57fc8caf7f62236f97a311bf1e4f0';

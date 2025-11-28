// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider pour SupabaseClient

@ProviderFor(supabaseClient)
const supabaseClientProvider = SupabaseClientProvider._();

/// Provider pour SupabaseClient

final class SupabaseClientProvider
    extends $FunctionalProvider<SupabaseClient, SupabaseClient, SupabaseClient>
    with $Provider<SupabaseClient> {
  /// Provider pour SupabaseClient
  const SupabaseClientProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'supabaseClientProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$supabaseClientHash();

  @$internal
  @override
  $ProviderElement<SupabaseClient> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SupabaseClient create(Ref ref) {
    return supabaseClient(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SupabaseClient value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SupabaseClient>(value),
    );
  }
}

String _$supabaseClientHash() => r'834a58d6ae4b94e36f4e04a10d8a7684b929310e';

/// Provider pour TransactionRepository

@ProviderFor(transactionRepository)
const transactionRepositoryProvider = TransactionRepositoryProvider._();

/// Provider pour TransactionRepository

final class TransactionRepositoryProvider
    extends
        $FunctionalProvider<
          TransactionRepository,
          TransactionRepository,
          TransactionRepository
        >
    with $Provider<TransactionRepository> {
  /// Provider pour TransactionRepository
  const TransactionRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'transactionRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$transactionRepositoryHash();

  @$internal
  @override
  $ProviderElement<TransactionRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  TransactionRepository create(Ref ref) {
    return transactionRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TransactionRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TransactionRepository>(value),
    );
  }
}

String _$transactionRepositoryHash() =>
    r'34d49fbf9862a989457c3241518ea6968a6a8246';

/// Provider pour les use cases

@ProviderFor(getAllTransactionsUseCase)
const getAllTransactionsUseCaseProvider = GetAllTransactionsUseCaseProvider._();

/// Provider pour les use cases

final class GetAllTransactionsUseCaseProvider
    extends
        $FunctionalProvider<
          GetAllTransactionsUseCase,
          GetAllTransactionsUseCase,
          GetAllTransactionsUseCase
        >
    with $Provider<GetAllTransactionsUseCase> {
  /// Provider pour les use cases
  const GetAllTransactionsUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getAllTransactionsUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getAllTransactionsUseCaseHash();

  @$internal
  @override
  $ProviderElement<GetAllTransactionsUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetAllTransactionsUseCase create(Ref ref) {
    return getAllTransactionsUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetAllTransactionsUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetAllTransactionsUseCase>(value),
    );
  }
}

String _$getAllTransactionsUseCaseHash() =>
    r'c576f91a751b7d8bc31db00c57ac14cca4498984';

@ProviderFor(createTransactionUseCase)
const createTransactionUseCaseProvider = CreateTransactionUseCaseProvider._();

final class CreateTransactionUseCaseProvider
    extends
        $FunctionalProvider<
          CreateTransactionUseCase,
          CreateTransactionUseCase,
          CreateTransactionUseCase
        >
    with $Provider<CreateTransactionUseCase> {
  const CreateTransactionUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'createTransactionUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$createTransactionUseCaseHash();

  @$internal
  @override
  $ProviderElement<CreateTransactionUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CreateTransactionUseCase create(Ref ref) {
    return createTransactionUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CreateTransactionUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CreateTransactionUseCase>(value),
    );
  }
}

String _$createTransactionUseCaseHash() =>
    r'26115016a7877bff62f313a51f3c3caccd5f818d';

@ProviderFor(updateTransactionUseCase)
const updateTransactionUseCaseProvider = UpdateTransactionUseCaseProvider._();

final class UpdateTransactionUseCaseProvider
    extends
        $FunctionalProvider<
          UpdateTransactionUseCase,
          UpdateTransactionUseCase,
          UpdateTransactionUseCase
        >
    with $Provider<UpdateTransactionUseCase> {
  const UpdateTransactionUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'updateTransactionUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$updateTransactionUseCaseHash();

  @$internal
  @override
  $ProviderElement<UpdateTransactionUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  UpdateTransactionUseCase create(Ref ref) {
    return updateTransactionUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UpdateTransactionUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UpdateTransactionUseCase>(value),
    );
  }
}

String _$updateTransactionUseCaseHash() =>
    r'a6d06c9bd625dfe0c817e5b96d356d0a70a1c5a3';

@ProviderFor(deleteTransactionUseCase)
const deleteTransactionUseCaseProvider = DeleteTransactionUseCaseProvider._();

final class DeleteTransactionUseCaseProvider
    extends
        $FunctionalProvider<
          DeleteTransactionUseCase,
          DeleteTransactionUseCase,
          DeleteTransactionUseCase
        >
    with $Provider<DeleteTransactionUseCase> {
  const DeleteTransactionUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'deleteTransactionUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$deleteTransactionUseCaseHash();

  @$internal
  @override
  $ProviderElement<DeleteTransactionUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DeleteTransactionUseCase create(Ref ref) {
    return deleteTransactionUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DeleteTransactionUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DeleteTransactionUseCase>(value),
    );
  }
}

String _$deleteTransactionUseCaseHash() =>
    r'ca9c3f8bc5f39cc6bc6b116e2d47ebbbd66713ce';

@ProviderFor(getTransactionsByPeriodUseCase)
const getTransactionsByPeriodUseCaseProvider =
    GetTransactionsByPeriodUseCaseProvider._();

final class GetTransactionsByPeriodUseCaseProvider
    extends
        $FunctionalProvider<
          GetTransactionsByPeriodUseCase,
          GetTransactionsByPeriodUseCase,
          GetTransactionsByPeriodUseCase
        >
    with $Provider<GetTransactionsByPeriodUseCase> {
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
  $ProviderElement<GetTransactionsByPeriodUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetTransactionsByPeriodUseCase create(Ref ref) {
    return getTransactionsByPeriodUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetTransactionsByPeriodUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetTransactionsByPeriodUseCase>(
        value,
      ),
    );
  }
}

String _$getTransactionsByPeriodUseCaseHash() =>
    r'86630c8692646cd2490645de47ace099e99bd959';

@ProviderFor(getTransactionStatsUseCase)
const getTransactionStatsUseCaseProvider =
    GetTransactionStatsUseCaseProvider._();

final class GetTransactionStatsUseCaseProvider
    extends
        $FunctionalProvider<
          GetTransactionStatsUseCase,
          GetTransactionStatsUseCase,
          GetTransactionStatsUseCase
        >
    with $Provider<GetTransactionStatsUseCase> {
  const GetTransactionStatsUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getTransactionStatsUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getTransactionStatsUseCaseHash();

  @$internal
  @override
  $ProviderElement<GetTransactionStatsUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetTransactionStatsUseCase create(Ref ref) {
    return getTransactionStatsUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetTransactionStatsUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetTransactionStatsUseCase>(value),
    );
  }
}

String _$getTransactionStatsUseCaseHash() =>
    r'95c4799903b1ab2879a3b50ac75539b7509958d6';

/// Provider pour récupérer les transactions par pocket_id

@ProviderFor(transactionsByPocket)
const transactionsByPocketProvider = TransactionsByPocketFamily._();

/// Provider pour récupérer les transactions par pocket_id

final class TransactionsByPocketProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<TransactionEntity>>,
          List<TransactionEntity>,
          FutureOr<List<TransactionEntity>>
        >
    with
        $FutureModifier<List<TransactionEntity>>,
        $FutureProvider<List<TransactionEntity>> {
  /// Provider pour récupérer les transactions par pocket_id
  const TransactionsByPocketProvider._({
    required TransactionsByPocketFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'transactionsByPocketProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$transactionsByPocketHash();

  @override
  String toString() {
    return r'transactionsByPocketProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<TransactionEntity>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<TransactionEntity>> create(Ref ref) {
    final argument = this.argument as String;
    return transactionsByPocket(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is TransactionsByPocketProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$transactionsByPocketHash() =>
    r'411687b3fcc79197f7da0793dfde5fd35d65a88a';

/// Provider pour récupérer les transactions par pocket_id

final class TransactionsByPocketFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<TransactionEntity>>, String> {
  const TransactionsByPocketFamily._()
    : super(
        retry: null,
        name: r'transactionsByPocketProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Provider pour récupérer les transactions par pocket_id

  TransactionsByPocketProvider call(String pocketId) =>
      TransactionsByPocketProvider._(argument: pocketId, from: this);

  @override
  String toString() => r'transactionsByPocketProvider';
}

/// ========================================================================
/// PROVIDER PRINCIPAL - Notifier unifié avec Freezed State
/// ========================================================================
///
/// Ce provider remplace tous les anciens providers et offre :
/// - ✅ Réactivité UI automatique via Freezed
/// - ✅ Mises à jour optimistes
/// - ✅ Gestion d'erreurs robuste
/// - ✅ Support des notifications de budget
///
/// UTILISATION:
/// ```dart
/// // Écouter les changements
/// final state = ref.watch(transactionProvider);
///
/// // Accéder aux transactions
/// final transactions = state.allTransactions;
///
/// // Vérifier l'état
/// if (state.isLoadingState) { ... }
/// if (state.hasError) { ... }
///
/// // Actions
/// ref.read(transactionProvider.notifier).createTransaction(...);
/// ref.read(transactionProvider.notifier).updateTransaction(...);
/// ref.read(transactionProvider.notifier).deleteTransaction(...);
/// ```
/// Notifier unifié pour la gestion réactive des transactions
///
/// Remplace TransactionReactiveNotifier et l'ancien TransactionNotifier

@ProviderFor(TransactionNotifier)
const transactionProvider = TransactionNotifierProvider._();

/// ========================================================================
/// PROVIDER PRINCIPAL - Notifier unifié avec Freezed State
/// ========================================================================
///
/// Ce provider remplace tous les anciens providers et offre :
/// - ✅ Réactivité UI automatique via Freezed
/// - ✅ Mises à jour optimistes
/// - ✅ Gestion d'erreurs robuste
/// - ✅ Support des notifications de budget
///
/// UTILISATION:
/// ```dart
/// // Écouter les changements
/// final state = ref.watch(transactionProvider);
///
/// // Accéder aux transactions
/// final transactions = state.allTransactions;
///
/// // Vérifier l'état
/// if (state.isLoadingState) { ... }
/// if (state.hasError) { ... }
///
/// // Actions
/// ref.read(transactionProvider.notifier).createTransaction(...);
/// ref.read(transactionProvider.notifier).updateTransaction(...);
/// ref.read(transactionProvider.notifier).deleteTransaction(...);
/// ```
/// Notifier unifié pour la gestion réactive des transactions
///
/// Remplace TransactionReactiveNotifier et l'ancien TransactionNotifier
final class TransactionNotifierProvider
    extends $NotifierProvider<TransactionNotifier, TransactionState> {
  /// ========================================================================
  /// PROVIDER PRINCIPAL - Notifier unifié avec Freezed State
  /// ========================================================================
  ///
  /// Ce provider remplace tous les anciens providers et offre :
  /// - ✅ Réactivité UI automatique via Freezed
  /// - ✅ Mises à jour optimistes
  /// - ✅ Gestion d'erreurs robuste
  /// - ✅ Support des notifications de budget
  ///
  /// UTILISATION:
  /// ```dart
  /// // Écouter les changements
  /// final state = ref.watch(transactionProvider);
  ///
  /// // Accéder aux transactions
  /// final transactions = state.allTransactions;
  ///
  /// // Vérifier l'état
  /// if (state.isLoadingState) { ... }
  /// if (state.hasError) { ... }
  ///
  /// // Actions
  /// ref.read(transactionProvider.notifier).createTransaction(...);
  /// ref.read(transactionProvider.notifier).updateTransaction(...);
  /// ref.read(transactionProvider.notifier).deleteTransaction(...);
  /// ```
  /// Notifier unifié pour la gestion réactive des transactions
  ///
  /// Remplace TransactionReactiveNotifier et l'ancien TransactionNotifier
  const TransactionNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'transactionProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$transactionNotifierHash();

  @$internal
  @override
  TransactionNotifier create() => TransactionNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TransactionState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TransactionState>(value),
    );
  }
}

String _$transactionNotifierHash() =>
    r'5f266c544a16bf1e0d1461dcd2b319a7c1c66ef7';

/// ========================================================================
/// PROVIDER PRINCIPAL - Notifier unifié avec Freezed State
/// ========================================================================
///
/// Ce provider remplace tous les anciens providers et offre :
/// - ✅ Réactivité UI automatique via Freezed
/// - ✅ Mises à jour optimistes
/// - ✅ Gestion d'erreurs robuste
/// - ✅ Support des notifications de budget
///
/// UTILISATION:
/// ```dart
/// // Écouter les changements
/// final state = ref.watch(transactionProvider);
///
/// // Accéder aux transactions
/// final transactions = state.allTransactions;
///
/// // Vérifier l'état
/// if (state.isLoadingState) { ... }
/// if (state.hasError) { ... }
///
/// // Actions
/// ref.read(transactionProvider.notifier).createTransaction(...);
/// ref.read(transactionProvider.notifier).updateTransaction(...);
/// ref.read(transactionProvider.notifier).deleteTransaction(...);
/// ```
/// Notifier unifié pour la gestion réactive des transactions
///
/// Remplace TransactionReactiveNotifier et l'ancien TransactionNotifier

abstract class _$TransactionNotifier extends $Notifier<TransactionState> {
  TransactionState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<TransactionState, TransactionState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<TransactionState, TransactionState>,
              TransactionState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

/// ========================================================================
/// PROVIDERS DÉRIVÉS - Pour des accès spécifiques aux données
/// ========================================================================
/// Provider pour les transactions filtrées par type

@ProviderFor(transactionsByType)
const transactionsByTypeProvider = TransactionsByTypeFamily._();

/// ========================================================================
/// PROVIDERS DÉRIVÉS - Pour des accès spécifiques aux données
/// ========================================================================
/// Provider pour les transactions filtrées par type

final class TransactionsByTypeProvider
    extends
        $FunctionalProvider<
          List<TransactionEntity>,
          List<TransactionEntity>,
          List<TransactionEntity>
        >
    with $Provider<List<TransactionEntity>> {
  /// ========================================================================
  /// PROVIDERS DÉRIVÉS - Pour des accès spécifiques aux données
  /// ========================================================================
  /// Provider pour les transactions filtrées par type
  const TransactionsByTypeProvider._({
    required TransactionsByTypeFamily super.from,
    required TransactionType super.argument,
  }) : super(
         retry: null,
         name: r'transactionsByTypeProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$transactionsByTypeHash();

  @override
  String toString() {
    return r'transactionsByTypeProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<List<TransactionEntity>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  List<TransactionEntity> create(Ref ref) {
    final argument = this.argument as TransactionType;
    return transactionsByType(ref, argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<TransactionEntity> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<TransactionEntity>>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is TransactionsByTypeProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$transactionsByTypeHash() =>
    r'efcbfed4a9fdee975fa5f90eae60e35c00cb4f70';

/// ========================================================================
/// PROVIDERS DÉRIVÉS - Pour des accès spécifiques aux données
/// ========================================================================
/// Provider pour les transactions filtrées par type

final class TransactionsByTypeFamily extends $Family
    with $FunctionalFamilyOverride<List<TransactionEntity>, TransactionType> {
  const TransactionsByTypeFamily._()
    : super(
        retry: null,
        name: r'transactionsByTypeProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// ========================================================================
  /// PROVIDERS DÉRIVÉS - Pour des accès spécifiques aux données
  /// ========================================================================
  /// Provider pour les transactions filtrées par type

  TransactionsByTypeProvider call(TransactionType type) =>
      TransactionsByTypeProvider._(argument: type, from: this);

  @override
  String toString() => r'transactionsByTypeProvider';
}

/// Provider pour les transactions par catégorie

@ProviderFor(transactionsByCategory)
const transactionsByCategoryProvider = TransactionsByCategoryFamily._();

/// Provider pour les transactions par catégorie

final class TransactionsByCategoryProvider
    extends
        $FunctionalProvider<
          List<TransactionEntity>,
          List<TransactionEntity>,
          List<TransactionEntity>
        >
    with $Provider<List<TransactionEntity>> {
  /// Provider pour les transactions par catégorie
  const TransactionsByCategoryProvider._({
    required TransactionsByCategoryFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'transactionsByCategoryProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$transactionsByCategoryHash();

  @override
  String toString() {
    return r'transactionsByCategoryProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<List<TransactionEntity>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  List<TransactionEntity> create(Ref ref) {
    final argument = this.argument as String;
    return transactionsByCategory(ref, argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<TransactionEntity> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<TransactionEntity>>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is TransactionsByCategoryProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$transactionsByCategoryHash() =>
    r'700074b40b8c24e1c145aed6cdbbfc1bc98c13cf';

/// Provider pour les transactions par catégorie

final class TransactionsByCategoryFamily extends $Family
    with $FunctionalFamilyOverride<List<TransactionEntity>, String> {
  const TransactionsByCategoryFamily._()
    : super(
        retry: null,
        name: r'transactionsByCategoryProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Provider pour les transactions par catégorie

  TransactionsByCategoryProvider call(String categoryId) =>
      TransactionsByCategoryProvider._(argument: categoryId, from: this);

  @override
  String toString() => r'transactionsByCategoryProvider';
}

/// Provider pour les transactions récurrentes

@ProviderFor(recurringTransactions)
const recurringTransactionsProvider = RecurringTransactionsProvider._();

/// Provider pour les transactions récurrentes

final class RecurringTransactionsProvider
    extends
        $FunctionalProvider<
          List<TransactionEntity>,
          List<TransactionEntity>,
          List<TransactionEntity>
        >
    with $Provider<List<TransactionEntity>> {
  /// Provider pour les transactions récurrentes
  const RecurringTransactionsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'recurringTransactionsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$recurringTransactionsHash();

  @$internal
  @override
  $ProviderElement<List<TransactionEntity>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  List<TransactionEntity> create(Ref ref) {
    return recurringTransactions(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<TransactionEntity> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<TransactionEntity>>(value),
    );
  }
}

String _$recurringTransactionsHash() =>
    r'513d3e2cc38db1a263831f6222a90180dcd88303';

/// Provider pour les transactions d'un mois

@ProviderFor(transactionsForMonth)
const transactionsForMonthProvider = TransactionsForMonthFamily._();

/// Provider pour les transactions d'un mois

final class TransactionsForMonthProvider
    extends
        $FunctionalProvider<
          List<TransactionEntity>,
          List<TransactionEntity>,
          List<TransactionEntity>
        >
    with $Provider<List<TransactionEntity>> {
  /// Provider pour les transactions d'un mois
  const TransactionsForMonthProvider._({
    required TransactionsForMonthFamily super.from,
    required ({int month, int year}) super.argument,
  }) : super(
         retry: null,
         name: r'transactionsForMonthProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$transactionsForMonthHash();

  @override
  String toString() {
    return r'transactionsForMonthProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<List<TransactionEntity>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  List<TransactionEntity> create(Ref ref) {
    final argument = this.argument as ({int month, int year});
    return transactionsForMonth(ref, argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<TransactionEntity> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<TransactionEntity>>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is TransactionsForMonthProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$transactionsForMonthHash() =>
    r'd28039305ad3e486ed98ca00735bd08ba5a03ecb';

/// Provider pour les transactions d'un mois

final class TransactionsForMonthFamily extends $Family
    with
        $FunctionalFamilyOverride<
          List<TransactionEntity>,
          ({int month, int year})
        > {
  const TransactionsForMonthFamily._()
    : super(
        retry: null,
        name: r'transactionsForMonthProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Provider pour les transactions d'un mois

  TransactionsForMonthProvider call(({int month, int year}) period) =>
      TransactionsForMonthProvider._(argument: period, from: this);

  @override
  String toString() => r'transactionsForMonthProvider';
}

/// Provider pour les statistiques des transactions

@ProviderFor(transactionStats)
const transactionStatsProvider = TransactionStatsProvider._();

/// Provider pour les statistiques des transactions

final class TransactionStatsProvider
    extends
        $FunctionalProvider<
          TransactionStats,
          TransactionStats,
          TransactionStats
        >
    with $Provider<TransactionStats> {
  /// Provider pour les statistiques des transactions
  const TransactionStatsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'transactionStatsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$transactionStatsHash();

  @$internal
  @override
  $ProviderElement<TransactionStats> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  TransactionStats create(Ref ref) {
    return transactionStats(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TransactionStats value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TransactionStats>(value),
    );
  }
}

String _$transactionStatsHash() => r'4350ff6d26838b7860b67fb865d303f4e047a3ce';

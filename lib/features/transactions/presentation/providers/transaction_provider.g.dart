// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
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
    r'279c2e4226b5f55a486c02b6637ad8a91c9068d9';

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

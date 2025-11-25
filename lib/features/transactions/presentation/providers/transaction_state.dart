import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/transaction_entity.dart';

part 'transaction_state.freezed.dart';

/// État pour la gestion des transactions avec Freezed
@freezed
sealed class TransactionState with _$TransactionState {
  // Ajouter un constructeur privé pour permettre les extensions
  const TransactionState._();

  const factory TransactionState({
    @Default([]) List<TransactionEntity> transactions,
    @Default(false) bool isLoading,
    @Default(false) bool isRefreshing,
    String? error,
  }) = _TransactionState;

  /// État initial
  const factory TransactionState.initial() = TransactionStateInitial;

  /// État de chargement
  const factory TransactionState.loading({
    @Default([]) List<TransactionEntity> transactions,
  }) = TransactionStateLoading;

  /// État avec données
  const factory TransactionState.loaded({
    required List<TransactionEntity> transactions,
  }) = TransactionStateLoaded;

  /// État de rafraîchissement
  const factory TransactionState.refreshing({
    required List<TransactionEntity> transactions,
  }) = TransactionStateRefreshing;

  /// État d'erreur
  const factory TransactionState.error({
    required String message,
    @Default([]) List<TransactionEntity> transactions,
  }) = TransactionStateError;

  /// Vérifie si les données sont en cours de chargement
  bool get isLoadingState => this is TransactionStateLoading;

  /// Vérifie si les données sont en cours de rafraîchissement
  bool get isRefreshingState => this is TransactionStateRefreshing;

  /// Vérifie si une erreur est présente
  bool get hasError => this is TransactionStateError;

  /// Récupère le message d'erreur s'il existe
  String? get errorMessage => map(
        (state) => null,
        initial: (_) => null,
        loading: (_) => null,
        loaded: (_) => null,
        refreshing: (_) => null,
        error: (state) => state.message,
      );

  /// Récupère les transactions peu importe l'état
  List<TransactionEntity> get allTransactions => map(
        (state) => state.transactions,
        initial: (_) => [],
        loading: (state) => state.transactions,
        loaded: (state) => state.transactions,
        refreshing: (state) => state.transactions,
        error: (state) => state.transactions,
      );

  /// Vérifie si des transactions sont disponibles
  bool get hasTransactions => allTransactions.isNotEmpty;
}

import 'package:pocketly/features/transactions/transactions.dart';

/// Use case pour récupérer les transactions récentes.
///
/// Prend une liste de transactions et retourne les N plus récentes
/// triées par date décroissante.
class GetRecentTransactionsUseCase {
  const GetRecentTransactionsUseCase();

  /// Récupère les transactions récentes
  ///
  /// [transactions] - Liste de toutes les transactions
  /// [limit] - Nombre maximum de transactions à retourner (défaut: 4)
  List<TransactionEntity> call({
    required List<TransactionEntity> transactions,
    int limit = 4,
  }) {
    // Trier les transactions par date décroissante
    final sortedTransactions = List<TransactionEntity>.from(transactions);
    sortedTransactions.sort((a, b) => b.date.compareTo(a.date));

    // Limiter le nombre de transactions
    return sortedTransactions.take(limit).toList();
  }
}

import '../repositories/transaction_repository.dart';

/// Use case pour récupérer les statistiques des transactions
class GetTransactionStatsUseCase {
  final TransactionRepository _repository;

  GetTransactionStatsUseCase(this._repository);

  /// Exécute le use case pour récupérer les statistiques
  Future<TransactionStats> call({
    DateTime? start,
    DateTime? end,
  }) async {
    return await _repository.getTransactionStats(
      start: start,
      end: end,
    );
  }
}

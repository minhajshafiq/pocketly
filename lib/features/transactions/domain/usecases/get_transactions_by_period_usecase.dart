import '../entities/transaction_entity.dart';
import '../repositories/transaction_repository.dart';

/// Use case pour récupérer les transactions par période
class GetTransactionsByPeriodUseCase {
  final TransactionRepository _repository;

  GetTransactionsByPeriodUseCase(this._repository);

  /// Exécute le use case pour récupérer les transactions entre deux dates
  Future<List<TransactionEntity>> call({
    required DateTime start,
    required DateTime end,
  }) async {
    return await _repository.getTransactionsBetween(
      start: start,
      end: end,
    );
  }

  /// Exécute le use case pour récupérer les transactions d'un mois
  Future<List<TransactionEntity>> callForMonth({
    required int year,
    required int month,
  }) async {
    return await _repository.getTransactionsForMonth(
      year: year,
      month: month,
    );
  }
}

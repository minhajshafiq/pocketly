import 'package:pocketly/features/transaction_history/domain/repositories/transaction_history_repository.dart';
import 'package:pocketly/features/transactions/transactions.dart';

/// Use case pour récupérer les transactions d'un jour spécifique
class GetTransactionsByDateUseCase {
  final TransactionHistoryRepository _repository;

  const GetTransactionsByDateUseCase(this._repository);

  /// Exécute le use case
  Future<List<TransactionEntity>> call({
    required String userId,
    required DateTime date,
  }) async {
    try {
      return await _repository.getTransactionsByDate(
        userId: userId,
        date: date,
      );
    } catch (e) {
      rethrow;
    }
  }
}

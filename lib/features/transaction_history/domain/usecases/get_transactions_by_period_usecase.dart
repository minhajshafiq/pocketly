import 'package:pocketly/features/transaction_history/domain/entities/transaction_period_entity.dart';
import 'package:pocketly/features/transaction_history/domain/repositories/transaction_history_repository.dart';
import 'package:pocketly/features/transactions/transactions.dart';

/// Use case pour récupérer les transactions d'une période
class GetTransactionsByPeriodUseCase {
  final TransactionHistoryRepository _repository;

  const GetTransactionsByPeriodUseCase(this._repository);

  /// Exécute le use case
  Future<List<TransactionEntity>> call({
    required String userId,
    required TransactionPeriodEntity period,
  }) async {
    try {
      return await _repository.getTransactionsByPeriod(
        userId: userId,
        period: period,
      );
    } catch (e) {
      rethrow;
    }
  }
}

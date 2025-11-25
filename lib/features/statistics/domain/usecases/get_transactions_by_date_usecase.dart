import 'package:pocketly/features/statistics/domain/repositories/statistics_repository.dart';
import 'package:pocketly/features/transactions/transactions.dart';

/// Use case pour récupérer les transactions par plage de dates
class GetTransactionsByDateUseCase {
  final StatisticsRepository _repository;

  const GetTransactionsByDateUseCase(this._repository);

  Future<List<TransactionEntity>> call({
    required String userId,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    try {
      return await _repository.getTransactionsByDateRange(
        userId: userId,
        startDate: startDate,
        endDate: endDate,
      );
    } catch (e) {
      rethrow;
    }
  }
}

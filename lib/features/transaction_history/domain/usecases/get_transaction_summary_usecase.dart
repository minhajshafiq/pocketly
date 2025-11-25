import 'package:pocketly/features/transaction_history/domain/entities/transaction_period_entity.dart';
import 'package:pocketly/features/transaction_history/domain/entities/transaction_summary_entity.dart';
import 'package:pocketly/features/transaction_history/domain/repositories/transaction_history_repository.dart';

/// Use case pour récupérer le résumé des transactions d'une période
class GetTransactionSummaryUseCase {
  final TransactionHistoryRepository _repository;

  const GetTransactionSummaryUseCase(this._repository);

  /// Exécute le use case pour une période
  Future<TransactionSummaryEntity> call({
    required String userId,
    required TransactionPeriodEntity period,
  }) async {
    try {
      return await _repository.getTransactionSummary(
        userId: userId,
        period: period,
      );
    } catch (e) {
      rethrow;
    }
  }

  /// Exécute le use case pour un jour spécifique
  Future<TransactionSummaryEntity> forDate({
    required String userId,
    required DateTime date,
  }) async {
    try {
      return await _repository.getDaySummary(
        userId: userId,
        date: date,
      );
    } catch (e) {
      rethrow;
    }
  }
}

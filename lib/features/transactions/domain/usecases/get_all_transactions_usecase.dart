import '../entities/transaction_entity.dart';
import '../repositories/transaction_repository.dart';

/// Use case pour récupérer toutes les transactions
class GetAllTransactionsUseCase {
  final TransactionRepository _repository;

  GetAllTransactionsUseCase(this._repository);

  /// Exécute le use case pour récupérer toutes les transactions
  Future<List<TransactionEntity>> call() async {
    return await _repository.getAllTransactions();
  }
}

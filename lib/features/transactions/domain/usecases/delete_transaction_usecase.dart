import '../repositories/transaction_repository.dart';

/// Use case pour supprimer une transaction
class DeleteTransactionUseCase {
  final TransactionRepository _repository;

  DeleteTransactionUseCase(this._repository);

  /// Exécute le use case pour supprimer une transaction
  Future<void> call(String transactionId) async {
    return await _repository.deleteTransaction(transactionId);
  }
}

import '../entities/transaction_entity.dart';
import '../repositories/transaction_repository.dart';
import 'validate_transaction_usecase.dart';

/// Use case pour mettre à jour une transaction
class UpdateTransactionUseCase {
  final TransactionRepository _repository;

  UpdateTransactionUseCase(this._repository);

  /// Exécute le use case pour mettre à jour une transaction
  Future<TransactionEntity> call(TransactionEntity transaction) async {
    // Validation des données avant mise à jour
    ValidateTransactionUseCase.validate(
      name: transaction.name,
      amount: transaction.amount,
      categoryId: transaction.categoryId,
      userId: transaction.userId,
      recurrence: transaction.recurrence,
      recurrenceEndDate: transaction.recurrenceEndDate,
      recurrenceDayOfMonth: transaction.recurrenceDayOfMonth,
    );

    return await _repository.updateTransaction(transaction);
  }

}

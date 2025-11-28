import '../entities/transaction_entity.dart';
import '../repositories/transaction_repository.dart';
import 'validate_transaction_usecase.dart';

/// Use case pour créer une transaction
class CreateTransactionUseCase {
  final TransactionRepository _repository;

  CreateTransactionUseCase(this._repository);

  /// Exécute le use case pour créer une transaction
  Future<TransactionEntity> call({
    required String name,
    required double amount,
    required DateTime date,
    required String categoryId,
    required TransactionType type,
    RecurrenceType recurrence = RecurrenceType.none,
    String? imageUrl,
    String? notes,
    required String userId,
    DateTime? recurrenceEndDate,
  }) async {
    // Validation des données d'entrée
    ValidateTransactionUseCase.validate(
      name: name,
      amount: amount,
      categoryId: categoryId,
      userId: userId,
      recurrence: recurrence,
      recurrenceEndDate: recurrenceEndDate,
    );

    // Création de la transaction
    final transaction = TransactionEntity(
      name: name,
      amount: amount,
      date: date,
      categoryId: categoryId,
      type: type,
      recurrence: recurrence,
      imageUrl: imageUrl,
      notes: notes,
      userId: userId,
      // Pour les transactions récurrentes, définir les champs de récurrence
      recurrenceStartDate: recurrence != RecurrenceType.none ? date : null,
      recurrenceEndDate: recurrence != RecurrenceType.none ? recurrenceEndDate : null,
      recurrenceDayOfMonth: recurrence != RecurrenceType.none ? date.day : null,
      isRecurrenceActive: recurrence != RecurrenceType.none, // true seulement si c'est récurrent
    );

    return await _repository.createTransaction(transaction);
  }

}

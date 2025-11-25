import 'package:pocketly/core/errors/errors.dart';
import 'package:pocketly/features/pockets/domain/entities/pocket_entity.dart';
import 'package:pocketly/features/pockets/domain/repositories/pocket_repository.dart';

/// Use case pour ajouter un montant à l'épargne d'un pocket
class AddToSavingsUseCase {
  final PocketRepository _repository;

  const AddToSavingsUseCase(this._repository);

  /// Exécute le use case
  ///
  /// [pocketId] - ID du pocket d'épargne
  /// [amount] - Montant à ajouter (doit être > 0)
  ///
  /// Lance une exception si :
  /// - Le pocket n'est pas de type savings
  /// - Le montant est négatif ou zéro
  Future<PocketEntity> call({
    required String pocketId,
    required double amount,
  }) async {
    if (amount <= 0) {
      throw ValidationError(
        field: 'amount',
        userMessage: 'Le montant doit être positif',
        technicalMessage: 'Amount must be positive: $amount',
      );
    }

    return await _repository.addToSavings(
      pocketId: pocketId,
      amount: amount,
    );
  }
}

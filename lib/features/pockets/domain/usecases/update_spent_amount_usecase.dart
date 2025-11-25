import 'package:pocketly/core/errors/errors.dart';
import 'package:pocketly/features/pockets/domain/entities/pocket_entity.dart';
import 'package:pocketly/features/pockets/domain/repositories/pocket_repository.dart';

/// Use case pour mettre à jour le montant dépensé d'un pocket de dépense
class UpdateSpentAmountUseCase {
  final PocketRepository _repository;

  const UpdateSpentAmountUseCase(this._repository);

  /// Exécute le use case
  ///
  /// [pocketId] - ID du pocket
  /// [amount] - Nouveau montant dépensé (doit être >= 0)
  ///
  /// Lance une exception si :
  /// - Le pocket est de type savings
  /// - Le montant est négatif
  Future<PocketEntity> call({
    required String pocketId,
    required double amount,
  }) async {
    if (amount < 0) {
      throw ValidationError(
        field: 'amount',
        userMessage: 'Le montant ne peut pas être négatif',
        technicalMessage: 'Amount cannot be negative: $amount',
      );
    }

    return await _repository.updateSpentAmount(
      pocketId: pocketId,
      amount: amount,
    );
  }
}

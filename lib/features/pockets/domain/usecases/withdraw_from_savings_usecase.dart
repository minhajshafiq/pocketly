import 'package:pocketly/core/errors/errors.dart';
import 'package:pocketly/features/pockets/domain/entities/pocket_entity.dart';
import 'package:pocketly/features/pockets/domain/repositories/pocket_repository.dart';

/// Use case pour retirer un montant de l'épargne d'un pocket
class WithdrawFromSavingsUseCase {
  final PocketRepository _repository;

  const WithdrawFromSavingsUseCase(this._repository);

  /// Exécute le use case
  ///
  /// [pocketId] - ID du pocket d'épargne
  /// [amount] - Montant à retirer (doit être > 0)
  ///
  /// Lance une exception si :
  /// - Le pocket n'est pas de type savings
  /// - Le montant est négatif ou zéro
  /// - Le montant à retirer est supérieur au montant épargné
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

    return await _repository.withdrawFromSavings(
      pocketId: pocketId,
      amount: amount,
    );
  }
}

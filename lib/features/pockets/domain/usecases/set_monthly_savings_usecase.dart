import 'package:pocketly/core/errors/errors.dart';
import 'package:pocketly/features/pockets/domain/entities/pocket_entity.dart';
import 'package:pocketly/features/pockets/domain/repositories/pocket_repository.dart';

/// Use case pour définir le montant d'épargne mensuelle automatique
class SetMonthlySavingsUseCase {
  final PocketRepository _repository;

  const SetMonthlySavingsUseCase(this._repository);

  /// Exécute le use case
  ///
  /// [pocketId] - ID du pocket d'épargne
  /// [amount] - Montant mensuel (null pour désactiver, >= 0 pour activer)
  ///
  /// Lance une exception si :
  /// - Le pocket n'est pas de type savings
  /// - Le montant est négatif
  Future<PocketEntity> call({
    required String pocketId,
    double? amount,
  }) async {
    if (amount != null && amount < 0) {
      throw ValidationError(
        field: 'amount',
        userMessage: 'Le montant ne peut pas être négatif',
        technicalMessage: 'Amount cannot be negative: $amount',
      );
    }

    return await _repository.setMonthlySavings(
      pocketId: pocketId,
      amount: amount,
    );
  }
}

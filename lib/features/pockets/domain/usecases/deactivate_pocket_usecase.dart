import 'package:pocketly/features/pockets/domain/entities/pocket_entity.dart';
import 'package:pocketly/features/pockets/domain/repositories/pocket_repository.dart';

/// Use case pour désactiver un pocket
class DeactivatePocketUseCase {
  final PocketRepository _repository;

  const DeactivatePocketUseCase(this._repository);

  /// Exécute le use case
  ///
  /// [pocketId] - ID du pocket à désactiver
  ///
  /// Change le statut `isActive` à `false`.
  /// Les pockets désactivés ne sont pas inclus dans les calculs de budget.
  /// Retourne le pocket mis à jour.
  Future<PocketEntity> call(String pocketId) async {
    return await _repository.deactivatePocket(pocketId);
  }
}

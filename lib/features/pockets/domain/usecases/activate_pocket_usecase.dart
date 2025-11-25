import 'package:pocketly/features/pockets/domain/entities/pocket_entity.dart';
import 'package:pocketly/features/pockets/domain/repositories/pocket_repository.dart';

/// Use case pour activer un pocket
class ActivatePocketUseCase {
  final PocketRepository _repository;

  const ActivatePocketUseCase(this._repository);

  /// Exécute le use case
  ///
  /// [pocketId] - ID du pocket à activer
  ///
  /// Change le statut `isActive` à `true`.
  /// Retourne le pocket mis à jour.
  Future<PocketEntity> call(String pocketId) async {
    return await _repository.activatePocket(pocketId);
  }
}

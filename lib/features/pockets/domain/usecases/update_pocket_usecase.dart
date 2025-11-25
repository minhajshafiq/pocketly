import 'package:pocketly/core/errors/errors.dart';
import 'package:pocketly/features/pockets/domain/entities/pocket_entity.dart';
import 'package:pocketly/features/pockets/domain/repositories/pocket_repository.dart';

/// Use case pour mettre à jour un pocket existant
class UpdatePocketUseCase {
  final PocketRepository _repository;

  const UpdatePocketUseCase(this._repository);

  /// Exécute le use case
  ///
  /// [pocket] - Le pocket à mettre à jour (doit avoir un ID)
  ///
  /// Valide le pocket avant la mise à jour.
  /// Retourne le pocket mis à jour.
  /// Lance une exception si le pocket n'existe pas ou en cas d'erreur.
  Future<PocketEntity> call(PocketEntity pocket) async {
    if (pocket.id == null) {
      throw const ValidationError(
        field: 'id',
        userMessage: 'Impossible de mettre à jour un pocket sans ID',
        technicalMessage: 'Cannot update a pocket without an ID',
      );
    }

    return await _repository.updatePocket(pocket);
  }
}

import 'package:pocketly/features/pockets/domain/entities/pocket_entity.dart';
import 'package:pocketly/features/pockets/domain/repositories/pocket_repository.dart';

/// Use case pour créer un nouveau pocket
class CreatePocketUseCase {
  final PocketRepository _repository;

  const CreatePocketUseCase(this._repository);

  /// Exécute le use case
  ///
  /// [pocket] - Le pocket à créer
  ///
  /// Valide le pocket avant la création.
  /// Retourne le pocket créé avec son ID généré.
  /// Lance une exception si la validation échoue ou en cas d'erreur.
  Future<PocketEntity> call(PocketEntity pocket) async {
    // Note: La validation est effectuée dans le repository
    return await _repository.createPocket(pocket);
  }
}

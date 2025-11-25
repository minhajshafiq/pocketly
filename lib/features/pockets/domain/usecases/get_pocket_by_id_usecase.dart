import 'package:pocketly/features/pockets/domain/entities/pocket_entity.dart';
import 'package:pocketly/features/pockets/domain/repositories/pocket_repository.dart';

/// Use case pour récupérer un pocket par son ID
class GetPocketByIdUseCase {
  final PocketRepository _repository;

  const GetPocketByIdUseCase(this._repository);

  /// Exécute le use case
  ///
  /// [pocketId] - ID du pocket à récupérer
  ///
  /// Retourne le pocket ou `null` s'il n'existe pas.
  Future<PocketEntity?> call(String pocketId) async {
    return await _repository.getPocketById(pocketId);
  }
}

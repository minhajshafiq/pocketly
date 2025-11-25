import 'package:pocketly/features/pockets/domain/entities/pocket_entity.dart';
import 'package:pocketly/features/pockets/domain/repositories/pocket_repository.dart';

/// Use case pour récupérer tous les pockets d'un utilisateur
class GetAllPocketsUseCase {
  final PocketRepository _repository;

  const GetAllPocketsUseCase(this._repository);

  /// Exécute le use case
  ///
  /// Retourne tous les pockets de l'utilisateur, triés par catégorie puis par nom.
  /// Lance une exception en cas d'erreur.
  Future<List<PocketEntity>> call(String userId) async {
    return await _repository.getAllPockets(userId);
  }
}

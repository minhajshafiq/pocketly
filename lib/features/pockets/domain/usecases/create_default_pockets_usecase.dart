import 'package:pocketly/features/pockets/domain/entities/pocket_entity.dart';
import 'package:pocketly/features/pockets/domain/repositories/pocket_repository.dart';

/// Use case pour créer les pockets par défaut pour un nouvel utilisateur
class CreateDefaultPocketsUseCase {
  final PocketRepository _repository;

  const CreateDefaultPocketsUseCase(this._repository);

  /// Exécute le use case
  ///
  /// Crée les 8 pockets par défaut pour un nouvel utilisateur :
  /// - Needs (3) : Logement, Alimentation, Transport
  /// - Wants (2) : Loisirs, Shopping
  /// - Savings (3) : Fonds d'urgence, Vacances, Projets
  ///
  /// [userId] - ID de l'utilisateur
  ///
  /// Retourne la liste des pockets créés.
  /// Lance une exception si l'utilisateur a déjà des pockets.
  Future<List<PocketEntity>> call(String userId) async {
    return await _repository.createDefaultPockets(userId);
  }
}

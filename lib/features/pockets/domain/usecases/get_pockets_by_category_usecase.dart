import 'package:pocketly/features/pockets/domain/entities/pocket_entity.dart';
import 'package:pocketly/features/pockets/domain/repositories/pocket_repository.dart';

/// Use case pour récupérer les pockets d'une catégorie spécifique
class GetPocketsByCategoryUseCase {
  final PocketRepository _repository;

  const GetPocketsByCategoryUseCase(this._repository);

  /// Exécute le use case
  ///
  /// [userId] - ID de l'utilisateur
  /// [category] - Catégorie de pockets à récupérer
  ///
  /// Retourne les pockets de la catégorie demandée.
  Future<List<PocketEntity>> call({
    required String userId,
    required PocketCategory category,
  }) async {
    return await _repository.getPocketsByCategory(
      userId: userId,
      category: category,
    );
  }
}

import 'package:pocketly/features/pockets/domain/entities/pocket_entity.dart';
import 'package:pocketly/features/pockets/domain/repositories/pocket_repository.dart';

/// Use case pour récupérer un résumé des pockets par catégorie
class GetPocketSummaryUseCase {
  final PocketRepository _repository;

  const GetPocketSummaryUseCase(this._repository);

  /// Exécute le use case
  ///
  /// Retourne un Map avec les statistiques par catégorie :
  /// - Nombre total de pockets
  /// - Nombre de pockets actifs
  /// - Budget total (needs/wants)
  /// - Montant total dépensé (needs/wants)
  /// - Montant total épargné (savings)
  /// - Montant total des objectifs (savings)
  ///
  /// [userId] - ID de l'utilisateur
  Future<Map<PocketCategory, PocketSummary>> call(String userId) async {
    return await _repository.getPocketSummary(userId);
  }
}

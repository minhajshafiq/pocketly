import 'package:pocketly/features/pockets/domain/repositories/pocket_repository.dart';

/// Use case pour supprimer un pocket
class DeletePocketUseCase {
  final PocketRepository _repository;

  const DeletePocketUseCase(this._repository);

  /// Exécute le use case
  ///
  /// [pocketId] - ID du pocket à supprimer
  ///
  /// Vérifie qu'il n'y a pas de transactions liées avant la suppression.
  /// Lance une exception si le pocket a des transactions liées ou en cas d'erreur.
  Future<void> call(String pocketId) async {
    return await _repository.deletePocket(pocketId);
  }
}

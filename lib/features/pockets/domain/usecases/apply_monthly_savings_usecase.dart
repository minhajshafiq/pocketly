import 'package:pocketly/features/pockets/domain/entities/pocket_entity.dart';
import 'package:pocketly/features/pockets/domain/repositories/pocket_repository.dart';

/// Use case pour appliquer l'épargne mensuelle automatique
class ApplyMonthlySavingsUseCase {
  final PocketRepository _repository;

  const ApplyMonthlySavingsUseCase(this._repository);

  /// Exécute le use case
  ///
  /// Cette méthode est appelée automatiquement au début de chaque mois.
  /// Elle ajoute le montant `monthlySavingsAmount` à `savedAmount` pour
  /// tous les pockets de type savings qui ont un montant mensuel défini.
  ///
  /// [userId] - ID de l'utilisateur
  ///
  /// Retourne la liste des pockets mis à jour.
  Future<List<PocketEntity>> call(String userId) async {
    return await _repository.applyMonthlySavings(userId);
  }
}

import 'package:pocketly/core/errors/common_errors.dart';
import '../repositories/user_repository.dart';

/// Use case pour supprimer un utilisateur et toutes ses données associées.
///
/// Encapsule la logique métier pour supprimer un utilisateur.
/// Suit le pattern Clean Architecture en isolant la logique métier.
///
/// ⚠️ ATTENTION : Cette opération est IRRÉVERSIBLE et supprime :
/// - Le compte utilisateur
/// - Toutes les transactions
/// - Toutes les catégories personnalisées
/// - Tous les pockets
/// - Toutes les données associées
class DeleteUserUseCase {
  const DeleteUserUseCase(this._repository);

  final UserRepository _repository;

  /// Exécute le use case pour supprimer un utilisateur et toutes ses données.
  ///
  /// [userId] - L'ID de l'utilisateur à supprimer
  ///
  /// Throws [ValidationError] si l'ID utilisateur est invalide.
  /// Throws [NetworkError] si la connexion réseau échoue.
  /// Throws [ServerError] si le serveur retourne une erreur.
  /// Throws [NotFoundError] si l'utilisateur n'existe pas.
  Future<void> call(String userId) async {
    // Validation des données métier
    _validateUserId(userId);

    return await _repository.deleteUser(userId);
  }

  /// Valide l'ID utilisateur selon les règles métier.
  void _validateUserId(String userId) {
    if (userId.isEmpty) {
      throw const ValidationError(
        field: 'userId',
        userMessage: 'L\'identifiant utilisateur ne peut pas être vide',
        technicalMessage: 'User ID cannot be empty',
      );
    }

    if (userId.length < 3) {
      throw const ValidationError(
        field: 'userId',
        userMessage: 'L\'identifiant utilisateur est invalide',
        technicalMessage: 'User ID must be at least 3 characters',
      );
    }
  }
}

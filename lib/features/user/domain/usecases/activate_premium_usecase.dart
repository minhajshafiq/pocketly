import '../entities/user_entity.dart';
import '../repositories/user_repository.dart';
import 'package:pocketly/core/errors/errors.dart';

/// Use case pour activer l'abonnement premium d'un utilisateur.
///
/// Encapsule la logique métier pour activer le premium.
/// Suit le pattern Clean Architecture en isolant la logique métier.
class ActivatePremiumUseCase {
  const ActivatePremiumUseCase(this._repository);

  final UserRepository _repository;

  /// Exécute le use case pour activer l'abonnement premium.
  ///
  /// [userId] - L'ID de l'utilisateur
  /// [expiresAt] - Date d'expiration de l'abonnement premium
  ///
  /// Retourne l'utilisateur avec le premium activé.
  ///
  /// Throws [ValidationError] si les données sont invalides.
  /// Throws [NetworkError] si la connexion réseau échoue.
  /// Throws [ServerError] si le serveur retourne une erreur.
  /// Throws [NotFoundError] si l'utilisateur n'existe pas.
  Future<UserEntity> call(String userId, DateTime expiresAt) async {
    // Validation des données métier
    _validateInputs(userId, expiresAt);

    return await _repository.activatePremium(userId, expiresAt);
  }

  /// Valide les données d'entrée selon les règles métier.
  void _validateInputs(String userId, DateTime expiresAt) {
    if (userId.isEmpty) {
      throw const ValidationError(
        field: 'userId',
        userMessage: 'User ID cannot be empty',
      );
    }

    if (userId.length < 3) {
      throw const ValidationError(
        field: 'userId',
        userMessage: 'User ID must be at least 3 characters',
      );
    }

    if (expiresAt.isBefore(DateTime.now())) {
      throw const ValidationError(
        field: 'expiresAt',
        userMessage: 'Expiration date cannot be in the past',
      );
    }

    // Vérifier que l'expiration n'est pas trop loin dans le futur (max 1 an)
    final oneYearFromNow = DateTime.now().add(const Duration(days: 365));
    if (expiresAt.isAfter(oneYearFromNow)) {
      throw const ValidationError(
        field: 'expiresAt',
        userMessage: 'Expiration date cannot be more than 1 year in the future',
      );
    }
  }
}

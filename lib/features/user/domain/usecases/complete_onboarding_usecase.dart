import '../entities/user_entity.dart';
import '../repositories/user_repository.dart';
import 'package:pocketly/core/errors/errors.dart';

/// Use case pour marquer l'onboarding comme complété.
///
/// Encapsule la logique métier pour compléter l'onboarding.
/// Suit le pattern Clean Architecture en isolant la logique métier.
class CompleteOnboardingUseCase {
  const CompleteOnboardingUseCase(this._repository);

  final UserRepository _repository;

  /// Exécute le use case pour compléter l'onboarding.
  ///
  /// [userId] - L'ID de l'utilisateur
  ///
  /// Retourne l'utilisateur avec l'onboarding complété.
  ///
  /// Throws [ValidationError] si l'ID utilisateur est invalide.
  /// Throws [NetworkError] si la connexion réseau échoue.
  /// Throws [ServerError] si le serveur retourne une erreur.
  /// Throws [NotFoundError] si l'utilisateur n'existe pas.
  Future<UserEntity> call(String userId) async {
    // Validation des données métier
    _validateUserId(userId);

    return await _repository.completeOnboarding(userId);
  }

  /// Valide l'ID utilisateur selon les règles métier.
  void _validateUserId(String userId) {
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
  }
}

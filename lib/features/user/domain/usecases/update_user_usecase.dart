import '../entities/user_entity.dart';
import '../repositories/user_repository.dart';
import 'package:pocketly/core/errors/errors.dart';

/// Use case pour mettre à jour un utilisateur.
///
/// Encapsule la logique métier pour mettre à jour un utilisateur.
/// Suit le pattern Clean Architecture en isolant la logique métier.
class UpdateUserUseCase {
  const UpdateUserUseCase(this._repository);

  final UserRepository _repository;

  /// Exécute le use case pour mettre à jour un utilisateur.
  ///
  /// [user] - L'entité utilisateur avec les nouvelles données
  ///
  /// Retourne l'utilisateur mis à jour.
  ///
  /// Throws [ValidationError] si les données utilisateur sont invalides.
  /// Throws [NetworkError] si la connexion réseau échoue.
  /// Throws [ServerError] si le serveur retourne une erreur.
  /// Throws [NotFoundError] si l'utilisateur n'existe pas.
  Future<UserEntity> call(UserEntity user) async {
    // Validation des données métier
    _validateUser(user);

    return await _repository.updateUser(user);
  }

  /// Valide les données utilisateur selon les règles métier.
  void _validateUser(UserEntity user) {
    if (user.id.isEmpty) {
      throw const ValidationError(
        field: 'id',
        userMessage: 'User ID cannot be empty',
      );
    }

    if (user.email.isEmpty) {
      throw const ValidationError(
        field: 'email',
        userMessage: 'Email cannot be empty',
      );
    }

    if (!_isValidEmail(user.email)) {
      throw const ValidationError(
        field: 'email',
        userMessage: 'Invalid email format',
      );
    }

    if (user.name != null && user.name!.trim().isEmpty) {
      throw const ValidationError(
        field: 'name',
        userMessage: 'Name cannot be empty if provided',
      );
    }
  }

  /// Valide le format de l'email.
  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }
}

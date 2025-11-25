import '../entities/user_entity.dart';
import '../repositories/user_repository.dart';
import 'package:pocketly/core/errors/errors.dart';

/// Use case pour créer un nouvel utilisateur.
///
/// Encapsule la logique métier pour créer un utilisateur.
/// Suit le pattern Clean Architecture en isolant la logique métier.
class CreateUserUseCase {
  const CreateUserUseCase(this._repository);

  final UserRepository _repository;

  /// Exécute le use case pour créer un utilisateur.
  ///
  /// [user] - L'entité utilisateur à créer
  ///
  /// Retourne l'utilisateur créé avec l'ID généré.
  ///
  /// Throws [ValidationError] si les données utilisateur sont invalides.
  /// Throws [NetworkError] si la connexion réseau échoue.
  /// Throws [ServerError] si le serveur retourne une erreur.
  Future<UserEntity> call(UserEntity user) async {
    // Validation des données métier
    _validateUser(user);

    return await _repository.createUser(user);
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
  }

  /// Valide le format de l'email.
  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }
}

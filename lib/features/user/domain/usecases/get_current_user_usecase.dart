import '../entities/user_entity.dart';
import '../repositories/user_repository.dart';

/// Use case pour récupérer l'utilisateur actuel.
///
/// Encapsule la logique métier pour récupérer l'utilisateur connecté.
/// Suit le pattern Clean Architecture en isolant la logique métier.
class GetCurrentUserUseCase {
  const GetCurrentUserUseCase(this._repository);

  final UserRepository _repository;

  /// Exécute le use case pour récupérer l'utilisateur actuel.
  ///
  /// Retourne l'utilisateur connecté ou null si aucun utilisateur n'est connecté.
  ///
  /// Throws [NetworkError] si la connexion réseau échoue.
  /// Throws [ServerError] si le serveur retourne une erreur.
  Future<UserEntity?> call() async {
    return await _repository.getCurrentUser();
  }
}

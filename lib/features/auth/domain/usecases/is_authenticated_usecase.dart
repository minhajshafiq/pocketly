import '../repositories/auth_repository.dart';

/// Use case pour vérifier si l'utilisateur est authentifié
class IsAuthenticatedUseCase {
  final AuthRepository _repository;

  const IsAuthenticatedUseCase(this._repository);

  /// Vérifie si l'utilisateur est actuellement authentifié
  Future<bool> call() async {
    return await _repository.isAuthenticated();
  }
}

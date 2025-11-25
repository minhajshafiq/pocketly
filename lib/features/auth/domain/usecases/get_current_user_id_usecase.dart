import '../repositories/auth_repository.dart';

/// Use case pour récupérer l'ID de l'utilisateur actuel
class GetCurrentUserIdUseCase {
  final AuthRepository _repository;

  const GetCurrentUserIdUseCase(this._repository);

  /// Récupère l'ID de l'utilisateur actuellement connecté
  /// Retourne null si aucun utilisateur n'est connecté
  Future<String?> call() async {
    final user = await _repository.getCurrentUser();
    return user?.id;
  }
}

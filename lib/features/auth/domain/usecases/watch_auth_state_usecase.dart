import '../entities/auth_user.dart';
import '../repositories/auth_repository.dart';

/// Use case pour surveiller les changements d'état d'authentification
class WatchAuthStateUseCase {
  final AuthRepository _repository;

  const WatchAuthStateUseCase(this._repository);

  /// Retourne un stream qui émet les changements d'état d'authentification
  /// Émet null quand l'utilisateur se déconnecte
  /// Émet AuthUser quand l'utilisateur se connecte
  Stream<AuthUser?> call() {
    return _repository.authStateChanges();
  }
}

import '../repositories/auth_repository.dart';

/// Use case pour se déconnecter.
///
/// Suit le principe de responsabilité unique (SRP).
class SignOutUseCase {
  const SignOutUseCase(this._repository);

  final AuthRepository _repository;

  Future<void> call() async {
    await _repository.signOut();
  }
}

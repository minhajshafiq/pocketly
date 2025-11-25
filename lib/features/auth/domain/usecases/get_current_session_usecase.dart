import '../entities/auth_session.dart';
import '../repositories/auth_repository.dart';

/// Use case pour obtenir la session actuelle.
///
/// Suit le principe de responsabilité unique (SRP).
class GetCurrentSessionUseCase {
  const GetCurrentSessionUseCase(this._repository);

  final AuthRepository _repository;

  Future<AuthSession?> call() async {
    return await _repository.getCurrentSession();
  }
}

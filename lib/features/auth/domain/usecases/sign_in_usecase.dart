import 'package:pocketly/core/errors/errors.dart';
import '../entities/auth_session.dart';
import '../repositories/auth_repository.dart';

/// Use case pour se connecter avec email et mot de passe.
///
/// Suit le principe de responsabilité unique (SRP).
class SignInUseCase {
  const SignInUseCase(this._repository);

  final AuthRepository _repository;

  Future<AuthSession> call({
    required String email,
    required String password,
  }) async {
    // Validation basique
    if (email.isEmpty) {
      throw const ValidationError(
        field: 'email',
        userMessage: 'Email is required',
        technicalMessage: 'Email field cannot be empty for sign in',
      );
    }
    if (password.isEmpty) {
      throw const ValidationError(
        field: 'password',
        userMessage: 'Password is required',
        technicalMessage: 'Password field cannot be empty for sign in',
      );
    }

    return await _repository.signInWithEmail(
      email: email,
      password: password,
    );
  }
}

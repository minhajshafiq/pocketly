import 'package:pocketly/core/errors/errors.dart';
import '../entities/auth_session.dart';
import '../repositories/auth_repository.dart';

/// Use case pour créer un nouveau compte utilisateur.
///
/// Suit le principe de responsabilité unique (SRP).
class SignUpUseCase {
  const SignUpUseCase(this._repository);

  final AuthRepository _repository;

  Future<AuthSession> call({
    required String email,
    required String password,
    String? name,
  }) async {
    // Validation basique
    if (email.isEmpty) {
      throw const ValidationError(
        field: 'email',
        userMessage: 'Email is required',
        technicalMessage: 'Email field cannot be empty for sign up',
      );
    }
    if (password.isEmpty) {
      throw const ValidationError(
        field: 'password',
        userMessage: 'Password is required',
        technicalMessage: 'Password field cannot be empty for sign up',
      );
    }
    if (password.length < 12) {
      throw ValidationError(
        field: 'password',
        userMessage: 'Password must be at least 12 characters',
        technicalMessage: 'Password length validation failed: ${password.length} < 12',
      );
    }

    return await _repository.signUpWithEmail(
      email: email,
      password: password,
      name: name,
    );
  }
}

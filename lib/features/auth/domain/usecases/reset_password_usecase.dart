import 'package:pocketly/core/errors/errors.dart';
import '../repositories/auth_repository.dart';

/// Use case pour réinitialiser le mot de passe.
///
/// Envoie un email de réinitialisation.
class ResetPasswordUseCase {
  const ResetPasswordUseCase(this._repository);

  final AuthRepository _repository;

  Future<void> call(String email) async {
    if (email.isEmpty) {
      throw const ValidationError(
        field: 'email',
        userMessage: 'Email is required',
        technicalMessage: 'Email field cannot be empty for password reset',
      );
    }

    await _repository.resetPassword(email);
  }
}

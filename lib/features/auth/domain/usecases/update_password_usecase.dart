import 'package:pocketly/core/errors/errors.dart';
import '../repositories/auth_repository.dart';

/// Use case pour mettre à jour le mot de passe.
///
/// Permet à l'utilisateur de changer son mot de passe après
/// avoir reçu un lien de réinitialisation par email.
class UpdatePasswordUseCase {
  const UpdatePasswordUseCase(this._repository);

  final AuthRepository _repository;

  /// Met à jour le mot de passe de l'utilisateur
  ///
  /// [newPassword] Le nouveau mot de passe (minimum 12 caractères)
  ///
  /// Throws [ValidationError] si le mot de passe est invalide
  Future<void> call(String newPassword) async {
    if (newPassword.isEmpty) {
      throw const ValidationError(
        field: 'password',
        userMessage: 'Password is required',
        technicalMessage: 'New password cannot be empty',
      );
    }

    if (newPassword.length < 12) {
      throw ValidationError(
        field: 'password',
        userMessage: 'Password must be at least 12 characters',
        technicalMessage: 'Password length validation failed: ${newPassword.length} < 12',
      );
    }

    await _repository.updatePassword(newPassword);
  }
}

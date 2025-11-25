import 'package:pocketly/core/errors/errors.dart';
import '../repositories/auth_repository.dart';

/// Use case pour mettre à jour l'email.
///
/// Permet à l'utilisateur de changer son email.
class UpdateEmailUseCase {
  const UpdateEmailUseCase(this._repository);

  final AuthRepository _repository;

  /// Met à jour l'email de l'utilisateur
  ///
  /// [newEmail] Le nouvel email
  ///
  /// Throws [ValidationError] si l'email est invalide
  Future<void> call(String newEmail) async {
    if (newEmail.isEmpty) {
      throw const ValidationError(
        field: 'email',
        userMessage: 'Email is required',
        technicalMessage: 'New email cannot be empty',
      );
    }

    // Valider le format de l'email
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    if (!emailRegex.hasMatch(newEmail)) {
      throw const ValidationError(
        field: 'email',
        userMessage: 'Invalid email format',
        technicalMessage: 'Email format validation failed',
      );
    }

    await _repository.updateEmail(newEmail);
  }
}


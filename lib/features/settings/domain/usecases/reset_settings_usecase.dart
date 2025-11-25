import 'package:pocketly/features/settings/domain/repositories/settings_repository.dart';

/// Use case pour réinitialiser les paramètres de l'application.
class ResetSettingsUseCase {
  final SettingsRepository _repository;

  ResetSettingsUseCase(this._repository);

  Future<void> call() async {
    return await _repository.resetSettings();
  }
}

import 'package:pocketly/features/settings/domain/repositories/settings_repository.dart';

/// Use case pour mettre à jour le mode du thème.
class UpdateThemeModeUseCase {
  final SettingsRepository _repository;

  UpdateThemeModeUseCase(this._repository);

  Future<void> call(String themeMode) async {
    return await _repository.updateThemeMode(themeMode);
  }
}

import 'package:pocketly/features/settings/domain/entities/app_settings_entity.dart';
import 'package:pocketly/features/settings/domain/repositories/settings_repository.dart';

/// Use case pour récupérer les paramètres de l'application.
class GetSettingsUseCase {
  final SettingsRepository _repository;

  GetSettingsUseCase(this._repository);

  Future<AppSettingsEntity> call() async {
    return await _repository.getSettings();
  }
}

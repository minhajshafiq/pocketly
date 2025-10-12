import 'package:pocketly/features/themes/domain/entities/theme_entity.dart';
import 'package:pocketly/features/themes/domain/repositories/theme_repository.dart';

/// Use case pour récupérer tous les thèmes disponibles.
/// 
/// Encapsule la logique métier pour obtenir la liste
/// des thèmes supportés par l'application.
class GetAvailableThemesUseCase {
  final ThemeRepository _repository;

  const GetAvailableThemesUseCase(this._repository);

  /// Exécute le use case et retourne tous les thèmes disponibles
  Future<List<ThemeEntity>> call() async {
    return await _repository.getAvailableThemes();
  }
}

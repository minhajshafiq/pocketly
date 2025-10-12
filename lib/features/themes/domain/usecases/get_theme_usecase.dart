import 'package:pocketly/features/themes/domain/entities/theme_entity.dart';
import 'package:pocketly/features/themes/domain/repositories/theme_repository.dart';

/// Use case pour récupérer le thème actuel.
/// 
/// Encapsule la logique métier pour obtenir le thème
/// sans dépendances d'implémentation.
class GetThemeUseCase {
  final ThemeRepository _repository;

  const GetThemeUseCase(this._repository);

  /// Exécute le use case et retourne le thème actuel
  Future<ThemeEntity> call() async {
    return await _repository.getCurrentTheme();
  }
}

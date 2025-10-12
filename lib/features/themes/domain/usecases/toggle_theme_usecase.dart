import 'package:pocketly/features/themes/domain/entities/theme_entity.dart';
import 'package:pocketly/features/themes/domain/repositories/theme_repository.dart';

/// Use case pour basculer entre thème clair et sombre.
/// 
/// Encapsule la logique métier pour le toggle de thème
/// en ignorant le mode système.
class ToggleThemeUseCase {
  final ThemeRepository _repository;

  const ToggleThemeUseCase(this._repository);

  /// Exécute le use case et bascule le thème
  /// 
  /// Bascule entre light et dark, ignore le mode system
  Future<void> call() async {
    final currentTheme = await _repository.getCurrentTheme();
    
    // Logique métier : basculer entre light et dark
    final newTheme = currentTheme.isLight 
        ? ThemeEntity.dark()
        : ThemeEntity.light();
    
    await _repository.setTheme(newTheme);
  }
}

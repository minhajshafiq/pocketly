import 'package:pocketly/features/themes/domain/entities/theme_entity.dart';

/// Repository abstrait pour la gestion des thèmes.
/// 
/// Définit le contrat pour l'accès aux données de thème
/// sans dépendances d'implémentation (Clean Architecture).
abstract class ThemeRepository {
  /// Récupère le thème actuel
  Future<ThemeEntity> getCurrentTheme();
  
  /// Sauvegarde un thème
  Future<void> setTheme(ThemeEntity theme);
  
  /// Écoute les changements de thème
  Stream<ThemeEntity> watchTheme();
  
  /// Récupère tous les thèmes disponibles
  Future<List<ThemeEntity>> getAvailableThemes();
  
  /// Réinitialise le thème aux paramètres par défaut
  Future<void> resetToDefault();
}

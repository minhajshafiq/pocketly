import 'package:pocketly/features/themes/data/models/theme_model.dart';

/// Data source abstrait pour la persistance locale des thèmes.
/// 
/// Définit le contrat pour l'accès aux données locales
/// sans dépendances d'implémentation.
abstract class ThemeLocalDataSource {
  /// Récupère le thème sauvegardé
  Future<ThemeModel?> getTheme();
  
  /// Sauvegarde un thème
  Future<void> setTheme(ThemeModel theme);
  
  /// Supprime le thème sauvegardé
  Future<void> clearTheme();
  
  /// Vérifie si un thème est sauvegardé
  Future<bool> hasTheme();
}

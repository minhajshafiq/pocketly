/// Repository pour la gestion de la locale
abstract class LocaleRepository {
  /// Récupère le code de langue sauvegardé
  Future<String?> getCurrentLocale();

  /// Sauvegarde le code de langue
  Future<void> setLocale(String languageCode);

  /// Supprime la locale sauvegardée
  Future<void> clearLocale();
}

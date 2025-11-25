import '../models/user_model.dart';

/// Interface du datasource local pour les utilisateurs.
///
/// Définit les contrats pour l'accès aux données utilisateur
/// depuis le stockage local (SharedPreferences, SQLite, etc.).
abstract class UserLocalDataSource {
  /// Récupère l'utilisateur actuel depuis le stockage local
  ///
  /// Retourne l'utilisateur stocké localement ou null si aucun utilisateur n'est stocké.
  Future<UserModel?> getCurrentUser();

  /// Sauvegarde l'utilisateur actuel dans le stockage local
  ///
  /// [user] - Le modèle utilisateur à sauvegarder
  ///
  /// Throws [LocalStorageError] si la sauvegarde échoue.
  Future<void> saveCurrentUser(UserModel user);

  /// Supprime l'utilisateur actuel du stockage local
  ///
  /// Throws [LocalStorageError] si la suppression échoue.
  Future<void> clearCurrentUser();

  /// Vérifie si un utilisateur est stocké localement
  ///
  /// Retourne true si un utilisateur est stocké, false sinon.
  Future<bool> hasCurrentUser();

  /// Récupère le token de notification push stocké localement
  ///
  /// Retourne le token stocké ou null si aucun token n'est stocké.
  Future<String?> getPushToken();

  /// Sauvegarde le token de notification push
  ///
  /// [token] - Le token à sauvegarder
  ///
  /// Throws [LocalStorageError] si la sauvegarde échoue.
  Future<void> savePushToken(String token);

  /// Supprime le token de notification push
  ///
  /// Throws [LocalStorageError] si la suppression échoue.
  Future<void> clearPushToken();
}

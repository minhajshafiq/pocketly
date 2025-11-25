import 'dart:typed_data';

/// Interface pour la gestion du stockage de fichiers.
///
/// Définit les opérations de base pour upload, suppression et récupération
/// d'URL de fichiers depuis un système de stockage (Supabase Storage).
abstract class StorageDataSource {
  /// Upload un fichier vers le stockage.
  ///
  /// [fileBytes] - Les bytes du fichier à uploader
  /// [fileName] - Le nom du fichier (ex: "profile.jpg")
  /// [bucket] - Le bucket de stockage (ex: "avatars")
  /// [path] - Le chemin complet dans le bucket (ex: "{user_id}/profile.jpg")
  ///
  /// Retourne l'URL publique du fichier uploadé.
  ///
  /// Throws [StorageError] si l'upload échoue.
  /// Throws [NetworkError] si la connexion réseau échoue.
  Future<String> uploadFile({
    required Uint8List fileBytes,
    required String fileName,
    required String bucket,
    required String path,
  });

  /// Supprime un fichier du stockage.
  ///
  /// [bucket] - Le bucket de stockage
  /// [path] - Le chemin du fichier à supprimer
  ///
  /// Throws [StorageError] si la suppression échoue.
  /// Throws [NetworkError] si la connexion réseau échoue.
  Future<void> deleteFile({required String bucket, required String path});

  /// Obtient l'URL publique d'un fichier.
  ///
  /// [bucket] - Le bucket de stockage
  /// [path] - Le chemin du fichier
  ///
  /// Retourne l'URL publique du fichier.
  String getPublicUrl({required String bucket, required String path});
}

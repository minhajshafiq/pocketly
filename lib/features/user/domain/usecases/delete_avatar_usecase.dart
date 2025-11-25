import 'package:pocketly/core/services/logger_service.dart';
import 'package:pocketly/features/user/data/datasources/storage_datasource.dart';
import 'package:pocketly/features/user/domain/entities/user_entity.dart';
import 'package:pocketly/features/user/domain/repositories/user_repository.dart';

/// Use case pour supprimer un avatar utilisateur.
///
/// Gère la suppression du fichier dans le stockage et la mise à jour
/// de l'utilisateur avec avatarUrl = null.
class DeleteAvatarUseCase {
  final UserRepository _userRepository;
  final StorageDataSource _storageDataSource;
  final LoggerService _logger;

  const DeleteAvatarUseCase({
    required UserRepository userRepository,
    required StorageDataSource storageDataSource,
    required LoggerService logger,
  }) : _userRepository = userRepository,
       _storageDataSource = storageDataSource,
       _logger = logger;

  /// Supprime l'avatar d'un utilisateur.
  ///
  /// [userId] - L'ID de l'utilisateur
  ///
  /// Retourne l'utilisateur mis à jour avec avatarUrl = null.
  ///
  /// Throws [StorageError] si la suppression échoue.
  /// Throws [NetworkError] si la connexion réseau échoue.
  Future<UserEntity> call({required String userId}) async {
    try {
      _logger.d(
        '🗑️  [DeleteAvatar] Starting avatar deletion for user: $userId',
      );

      // 1. Supprimer le fichier du stockage
      final storagePath = '$userId/profile.jpg';
      await _storageDataSource.deleteFile(bucket: 'avatars', path: storagePath);
      _logger.d('✅ [DeleteAvatar] Avatar file deleted from storage');

      // 2. Mettre à jour l'utilisateur avec avatarUrl = null
      final updatedUser = await _userRepository.updateUserAvatarUrl(
        userId: userId,
        avatarUrl: null,
      );
      _logger.d('✅ [DeleteAvatar] User avatar URL set to null');

      return updatedUser;
    } catch (e, stackTrace) {
      _logger.e(
        '❌ [DeleteAvatar] Failed to delete avatar',
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }
}

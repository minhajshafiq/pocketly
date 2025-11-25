import 'dart:io';

import 'package:pocketly/core/services/image_processing_service.dart';
import 'package:pocketly/core/services/logger_service.dart';
import 'package:pocketly/features/user/data/datasources/storage_datasource.dart';
import 'package:pocketly/features/user/domain/entities/user_entity.dart';
import 'package:pocketly/features/user/domain/repositories/user_repository.dart';

/// Use case pour uploader un avatar utilisateur.
///
/// Gère la validation, le traitement, l'upload vers le stockage et la mise à jour
/// de l'utilisateur avec la nouvelle URL d'avatar.
class UploadAvatarUseCase {
  final UserRepository _userRepository;
  final StorageDataSource _storageDataSource;
  final ImageProcessingService _imageProcessingService;
  final LoggerService _logger;

  const UploadAvatarUseCase({
    required UserRepository userRepository,
    required StorageDataSource storageDataSource,
    required ImageProcessingService imageProcessingService,
    required LoggerService logger,
  }) : _userRepository = userRepository,
       _storageDataSource = storageDataSource,
       _imageProcessingService = imageProcessingService,
       _logger = logger;

  /// Upload un avatar utilisateur.
  ///
  /// [userId] - L'ID de l'utilisateur
  /// [imageFile] - Le fichier image à uploader
  ///
  /// Retourne l'utilisateur mis à jour avec la nouvelle URL d'avatar.
  ///
  /// Throws [ValidationError] si l'image est invalide.
  /// Throws [StorageError] si l'upload échoue.
  /// Throws [NetworkError] si la connexion réseau échoue.
  Future<UserEntity> call({
    required String userId,
    required File imageFile,
  }) async {
    try {
      _logger.d('🚀 [UploadAvatar] Starting avatar upload for user: $userId');

      // 1. Valider l'image
      await _imageProcessingService.validateImage(imageFile);
      _logger.d('✅ [UploadAvatar] Image validation passed');

      // 2. Compresser et redimensionner l'image
      final compressedBytes = await _imageProcessingService
          .compressAndResizeImage(
            imageFile: imageFile,
            maxWidth: 800,
            maxHeight: 800,
            quality: 85,
            maxSizeKB: 1024,
          );
      _logger.d(
        '✅ [UploadAvatar] Image compressed: ${compressedBytes.length / 1024} KB',
      );

      // 3. Upload vers Supabase Storage
      final fileName = 'profile.jpg';
      final storagePath = '$userId/$fileName';
      final avatarUrl = await _storageDataSource.uploadFile(
        fileBytes: compressedBytes,
        fileName: fileName,
        bucket: 'avatars',
        path: storagePath,
      );
      _logger.d('✅ [UploadAvatar] Image uploaded: $avatarUrl');

      // 4. Mettre à jour l'utilisateur avec la nouvelle URL
      final updatedUser = await _userRepository.updateUserAvatarUrl(
        userId: userId,
        avatarUrl: avatarUrl,
      );
      _logger.d('✅ [UploadAvatar] User avatar updated successfully');

      return updatedUser;
    } catch (e, stackTrace) {
      _logger.e(
        '❌ [UploadAvatar] Failed to upload avatar',
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }
}

import 'dart:io';
import 'dart:typed_data';

import 'package:image/image.dart' as img;
import 'package:pocketly/core/errors/common_errors.dart';
import 'package:pocketly/core/services/logger_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'image_processing_service.g.dart';

/// Service pour le traitement d'images.
///
/// Fournit des fonctionnalités de compression, redimensionnement et validation
/// d'images avant upload vers le stockage.
class ImageProcessingService {
  final LoggerService _logger;

  const ImageProcessingService(this._logger);

  /// Compresse et redimensionne une image.
  ///
  /// [imageFile] - Le fichier image à traiter
  /// [maxWidth] - Largeur maximale (défaut: 800)
  /// [maxHeight] - Hauteur maximale (défaut: 800)
  /// [quality] - Qualité de compression 0-100 (défaut: 85)
  /// [maxSizeKB] - Taille maximale en KB (défaut: 1024)
  ///
  /// Retourne les bytes de l'image compressée en JPG.
  ///
  /// Throws [ValidationError] si l'image ne peut pas être traitée.
  Future<Uint8List> compressAndResizeImage({
    required File imageFile,
    int maxWidth = 800,
    int maxHeight = 800,
    int quality = 85,
    int maxSizeKB = 1024,
  }) async {
    try {
      _logger.d('🖼️  [ImageProcessing] Starting image processing');

      // 1. Lire l'image
      final imageBytes = await imageFile.readAsBytes();
      final originalImage = img.decodeImage(imageBytes);

      if (originalImage == null) {
        throw ValidationError(
          field: 'image',
          technicalMessage: 'Failed to decode image file',
        );
      }

      _logger.d(
        '📏 [ImageProcessing] Original size: ${originalImage.width}x${originalImage.height}',
      );

      // 2. Redimensionner si nécessaire (garder le ratio)
      img.Image processedImage = originalImage;
      if (originalImage.width > maxWidth || originalImage.height > maxHeight) {
        processedImage = img.copyResize(
          originalImage,
          width: originalImage.width > originalImage.height ? maxWidth : null,
          height: originalImage.height > originalImage.width ? maxHeight : null,
          interpolation: img.Interpolation.linear,
        );
        _logger.d(
          '✅ [ImageProcessing] Resized to: ${processedImage.width}x${processedImage.height}',
        );
      }

      // 3. Encoder en JPG avec compression
      Uint8List compressedBytes = Uint8List.fromList(
        img.encodeJpg(processedImage, quality: quality),
      );

      final compressedSizeKB = compressedBytes.length / 1024;
      _logger.d(
        '📦 [ImageProcessing] Compressed size: ${compressedSizeKB.toStringAsFixed(2)} KB',
      );

      // 4. Si encore trop grand, réduire la qualité progressivement
      int currentQuality = quality;
      while (compressedSizeKB > maxSizeKB && currentQuality > 50) {
        currentQuality -= 10;
        compressedBytes = Uint8List.fromList(
          img.encodeJpg(processedImage, quality: currentQuality),
        );
        final newSizeKB = compressedBytes.length / 1024;
        _logger.d(
          '🔄 [ImageProcessing] Re-compressing with quality $currentQuality: ${newSizeKB.toStringAsFixed(2)} KB',
        );
      }

      // 5. Vérifier la taille finale
      final finalSizeKB = compressedBytes.length / 1024;
      if (finalSizeKB > maxSizeKB) {
        _logger.w(
          '⚠️  [ImageProcessing] Final size (${finalSizeKB.toStringAsFixed(2)} KB) exceeds max ($maxSizeKB KB)',
        );
      }

      _logger.d(
        '✅ [ImageProcessing] Image processed successfully: ${finalSizeKB.toStringAsFixed(2)} KB',
      );
      return compressedBytes;
    } catch (e, stackTrace) {
      _logger.e(
        '❌ [ImageProcessing] Failed to process image',
        error: e,
        stackTrace: stackTrace,
      );
      if (e is ValidationError) {
        rethrow;
      }
      throw ValidationError(
        field: 'image',
        technicalMessage: 'Failed to compress and resize image: $e',
        stackTrace: stackTrace,
      );
    }
  }

  /// Valide une image.
  ///
  /// [imageFile] - Le fichier image à valider
  ///
  /// Retourne true si l'image est valide.
  ///
  /// Throws [ValidationError] si l'image est invalide.
  Future<bool> validateImage(File imageFile) async {
    try {
      _logger.d('🔍 [ImageProcessing] Validating image');

      // 1. Vérifier que le fichier existe
      if (!await imageFile.exists()) {
        throw ValidationError(
          field: 'image',
          technicalMessage: 'Image file does not exist',
        );
      }

      // 2. Vérifier l'extension
      final fileName = imageFile.path.toLowerCase();
      final validExtensions = ['.jpg', '.jpeg', '.png', '.gif', '.webp'];
      final hasValidExtension = validExtensions.any(
        (ext) => fileName.endsWith(ext),
      );

      if (!hasValidExtension) {
        throw ValidationError(
          field: 'image',
          technicalMessage:
              'Invalid image format. Supported: JPG, PNG, GIF, WEBP',
        );
      }

      // 3. Vérifier la taille du fichier (max 5MB)
      final fileSizeBytes = await imageFile.length();
      final fileSizeMB = fileSizeBytes / (1024 * 1024);

      if (fileSizeMB > 5) {
        throw ValidationError(
          field: 'image',
          technicalMessage:
              'Image file too large (${fileSizeMB.toStringAsFixed(2)} MB). Maximum: 5 MB',
        );
      }

      // 4. Vérifier que l'image peut être décodée
      final imageBytes = await imageFile.readAsBytes();
      final decodedImage = img.decodeImage(imageBytes);

      if (decodedImage == null) {
        throw ValidationError(
          field: 'image',
          technicalMessage: 'Invalid image file. Could not decode image.',
        );
      }

      // 5. Vérifier les dimensions (max 4000x4000)
      if (decodedImage.width > 4000 || decodedImage.height > 4000) {
        throw ValidationError(
          field: 'image',
          technicalMessage:
              'Image dimensions too large (${decodedImage.width}x${decodedImage.height}). Maximum: 4000x4000',
        );
      }

      _logger.d('✅ [ImageProcessing] Image is valid');
      return true;
    } catch (e, stackTrace) {
      _logger.e(
        '❌ [ImageProcessing] Image validation failed',
        error: e,
        stackTrace: stackTrace,
      );
      if (e is ValidationError) {
        rethrow;
      }
      throw ValidationError(
        field: 'image',
        technicalMessage: 'Image validation failed: $e',
        stackTrace: stackTrace,
      );
    }
  }
}

/// Provider pour ImageProcessingService
@riverpod
ImageProcessingService imageProcessingService(Ref ref) {
  final logger = ref.watch(loggerProvider);
  return ImageProcessingService(logger);
}

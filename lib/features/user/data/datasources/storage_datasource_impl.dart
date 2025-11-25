import 'dart:typed_data';

import 'package:pocketly/core/errors/common_errors.dart';
import 'package:pocketly/core/services/logger_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'storage_datasource.dart';

/// Implémentation de [StorageDataSource] avec Supabase Storage.
///
/// Gère l'upload, la suppression et la récupération d'URL de fichiers
/// depuis Supabase Storage.
class StorageDataSourceImpl implements StorageDataSource {
  final SupabaseClient _supabase;
  final LoggerService _logger;

  const StorageDataSourceImpl({
    required SupabaseClient supabase,
    required LoggerService logger,
  }) : _supabase = supabase,
       _logger = logger;

  @override
  Future<String> uploadFile({
    required Uint8List fileBytes,
    required String fileName,
    required String bucket,
    required String path,
  }) async {
    try {
      _logger.d('📤 [Storage] Uploading file to $bucket/$path');

      // Upload le fichier vers Supabase Storage
      await _supabase.storage
          .from(bucket)
          .uploadBinary(
            path,
            fileBytes,
            fileOptions: FileOptions(
              contentType: _getContentType(fileName),
              upsert: true, // Remplace le fichier s'il existe déjà
            ),
          );

      // Récupère l'URL publique
      final publicUrl = getPublicUrl(bucket: bucket, path: path);

      _logger.d('✅ [Storage] File uploaded successfully: $publicUrl');
      return publicUrl;
    } on StorageException catch (e, stackTrace) {
      _logger.e('❌ [Storage] Upload failed', error: e, stackTrace: stackTrace);
      throw CacheError(
        operation: 'upload_file',
        technicalMessage:
            'Failed to upload file to $bucket/$path: ${e.message}',
        stackTrace: stackTrace,
      );
    } catch (e, stackTrace) {
      _logger.e(
        '❌ [Storage] Upload failed with unexpected error',
        error: e,
        stackTrace: stackTrace,
      );
      throw NetworkError(
        technicalMessage: 'Network error during file upload: $e',
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future<void> deleteFile({
    required String bucket,
    required String path,
  }) async {
    try {
      _logger.d('🗑️ [Storage] Deleting file from $bucket/$path');

      // Supprime le fichier de Supabase Storage
      await _supabase.storage.from(bucket).remove([path]);

      _logger.d('✅ [Storage] File deleted successfully');
    } on StorageException catch (e, stackTrace) {
      _logger.e('❌ [Storage] Delete failed', error: e, stackTrace: stackTrace);
      throw CacheError(
        operation: 'delete_file',
        technicalMessage:
            'Failed to delete file from $bucket/$path: ${e.message}',
        stackTrace: stackTrace,
      );
    } catch (e, stackTrace) {
      _logger.e(
        '❌ [Storage] Delete failed with unexpected error',
        error: e,
        stackTrace: stackTrace,
      );
      throw NetworkError(
        technicalMessage: 'Network error during file deletion: $e',
        stackTrace: stackTrace,
      );
    }
  }

  @override
  String getPublicUrl({required String bucket, required String path}) {
    try {
      final publicUrl = _supabase.storage.from(bucket).getPublicUrl(path);
      _logger.d('🔗 [Storage] Generated public URL: $publicUrl');
      return publicUrl;
    } catch (e, stackTrace) {
      _logger.e(
        '❌ [Storage] Failed to generate public URL',
        error: e,
        stackTrace: stackTrace,
      );
      throw CacheError(
        operation: 'get_public_url',
        technicalMessage: 'Failed to get public URL for $bucket/$path: $e',
        stackTrace: stackTrace,
      );
    }
  }

  /// Détermine le type MIME du fichier selon son extension
  String _getContentType(String fileName) {
    final extension = fileName.split('.').last.toLowerCase();
    switch (extension) {
      case 'jpg':
      case 'jpeg':
        return 'image/jpeg';
      case 'png':
        return 'image/png';
      case 'gif':
        return 'image/gif';
      case 'webp':
        return 'image/webp';
      default:
        return 'application/octet-stream';
    }
  }
}

import 'dart:io';

import 'package:pocketly/core/config/supabase_config.dart';
import 'package:pocketly/core/services/image_processing_service.dart';
import 'package:pocketly/core/services/logger_service.dart';
import 'package:pocketly/features/user/data/datasources/storage_datasource_impl.dart';
import 'package:pocketly/features/user/domain/usecases/delete_avatar_usecase.dart';
import 'package:pocketly/features/user/domain/usecases/upload_avatar_usecase.dart';
import 'package:pocketly/features/user/presentation/providers/user_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'avatar_providers.g.dart';

// ==================== DATASOURCES ====================

/// Provider pour StorageDataSource
@riverpod
StorageDataSourceImpl storageDataSource(Ref ref) {
  final supabase = SupabaseConfig.client;
  final logger = ref.watch(loggerProvider);
  return StorageDataSourceImpl(supabase: supabase, logger: logger);
}

// ==================== USE CASES ====================

/// Provider pour UploadAvatarUseCase
@riverpod
Future<UploadAvatarUseCase> uploadAvatarUseCase(Ref ref) async {
  final userRepository = await ref.watch(userRepositoryProvider.future);
  final storageDataSource = ref.watch(storageDataSourceProvider);
  final imageProcessingService = ref.watch(imageProcessingServiceProvider);
  final logger = ref.watch(loggerProvider);

  return UploadAvatarUseCase(
    userRepository: userRepository,
    storageDataSource: storageDataSource,
    imageProcessingService: imageProcessingService,
    logger: logger,
  );
}

/// Provider pour DeleteAvatarUseCase
@riverpod
Future<DeleteAvatarUseCase> deleteAvatarUseCase(Ref ref) async {
  final userRepository = await ref.watch(userRepositoryProvider.future);
  final storageDataSource = ref.watch(storageDataSourceProvider);
  final logger = ref.watch(loggerProvider);

  return DeleteAvatarUseCase(
    userRepository: userRepository,
    storageDataSource: storageDataSource,
    logger: logger,
  );
}

// ==================== CONTROLLER ====================

/// Controller pour la gestion des avatars utilisateur.
///
/// Gère l'upload, la suppression et l'affichage des avatars.
@riverpod
class AvatarController extends _$AvatarController {
  @override
  FutureOr<void> build() {
    // État initial vide
  }

  /// Upload un avatar utilisateur.
  ///
  /// [imageFile] - Le fichier image à uploader
  ///
  /// Affiche une notification de succès ou d'erreur.
  Future<void> uploadAvatar(File imageFile) async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      try {
        // 1. Obtenir l'utilisateur actuel
        final currentUser = await ref.read(currentUserProvider.future);

        if (currentUser == null) {
          throw Exception('No user logged in');
        }

        // 2. Appeler le use case pour uploader l'avatar
        final uploadUseCase = await ref.read(
          uploadAvatarUseCaseProvider.future,
        );
        final updatedUser = await uploadUseCase(
          userId: currentUser.id,
          imageFile: imageFile,
        );

        // 3. Mettre à jour le provider utilisateur
        await ref.read(currentUserProvider.notifier).updateUser(updatedUser);

        // 4. Notification de succès sera gérée par le widget
      } catch (e) {
        // L'erreur sera gérée par le widget via AsyncValue.error
        rethrow;
      }
    });
  }

  /// Supprime l'avatar utilisateur.
  ///
  /// Affiche une notification de succès ou d'erreur.
  Future<void> deleteAvatar() async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      try {
        // 1. Obtenir l'utilisateur actuel
        final currentUser = await ref.read(currentUserProvider.future);

        if (currentUser == null) {
          throw Exception('No user logged in');
        }

        // 2. Appeler le use case pour supprimer l'avatar
        final deleteUseCase = await ref.read(
          deleteAvatarUseCaseProvider.future,
        );
        final updatedUser = await deleteUseCase(userId: currentUser.id);

        // 3. Mettre à jour le provider utilisateur
        await ref.read(currentUserProvider.notifier).updateUser(updatedUser);

        // 4. Notification de succès sera gérée par le widget
      } catch (e) {
        // L'erreur sera gérée par le widget via AsyncValue.error
        rethrow;
      }
    });
  }
}

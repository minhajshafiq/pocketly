import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pocketly/core/constants/app_icons.dart';
import 'package:pocketly/features/user/presentation/providers/avatar_providers.dart';

/// Widget pour sélectionner et uploader un avatar utilisateur.
///
/// Affiche un bouton pour ouvrir le picker d'image adaptatif (iOS/Android)
/// et gère l'upload de l'image sélectionnée.
class AvatarPickerWidget extends ConsumerWidget {
  const AvatarPickerWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final avatarState = ref.watch(avatarControllerProvider);

    return avatarState.when(
      data: (_) => _buildPickerButton(context, ref),
      loading: () => _buildLoadingState(),
      error: (error, stack) => _buildPickerButton(context, ref),
    );
  }

  Widget _buildPickerButton(BuildContext context, WidgetRef ref) {
    if (Platform.isIOS) {
      return CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: () => _showImagePicker(context, ref),
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
            color: CupertinoColors.activeBlue,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            CupertinoIcons.camera,
            color: CupertinoColors.white,
            size: 20,
          ),
        ),
      );
    }

    return IconButton(
      onPressed: () => _showImagePicker(context, ref),
      icon: Icon(AppIcons.cameraAlt),
      color: Colors.white,
      style: IconButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }

  Widget _buildLoadingState() {
    if (Platform.isIOS) {
      return Container(
        padding: const EdgeInsets.all(8),
        child: const CupertinoActivityIndicator(),
      );
    }

    return Container(
      padding: const EdgeInsets.all(8),
      child: const SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(strokeWidth: 2),
      ),
    );
  }

  /// Affiche le picker adaptatif selon la plateforme
  void _showImagePicker(BuildContext context, WidgetRef ref) {
    if (Platform.isIOS) {
      _showIOSImagePicker(context, ref);
    } else {
      _showAndroidImagePicker(context, ref);
    }
  }

  /// Affiche le picker iOS (CupertinoActionSheet)
  void _showIOSImagePicker(BuildContext context, WidgetRef ref) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        title: const Text('Choose Avatar'),
        message: const Text('Select a source for your profile picture'),
        actions: [
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
              _pickImage(ImageSource.gallery, ref);
            },
            child: const Text('Photo Library'),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
              _pickImage(ImageSource.camera, ref);
            },
            child: const Text('Take Photo'),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          onPressed: () => Navigator.pop(context),
          isDestructiveAction: true,
          child: const Text('Cancel'),
        ),
      ),
    );
  }

  /// Affiche le picker Android (ModalBottomSheet)
  void _showAndroidImagePicker(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(AppIcons.photoLibrary),
              title: const Text('Photo Library'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery, ref);
              },
            ),
            ListTile(
              leading: Icon(AppIcons.cameraAlt),
              title: const Text('Take Photo'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera, ref);
              },
            ),
          ],
        ),
      ),
    );
  }

  /// Sélectionne une image et l'upload
  Future<void> _pickImage(ImageSource source, WidgetRef ref) async {
    try {
      // Sur iOS, image_picker gère les permissions automatiquement
      // Sur Android, on vérifie rapidement les permissions uniquement pour la caméra
      if (source == ImageSource.camera && !Platform.isIOS) {
      final hasPermission = await _requestPermission(source, ref);
      if (!hasPermission) {
        return;
        }
      }

      // Sélectionner l'image immédiatement
      // image_picker gère les permissions automatiquement sur iOS
      // et pour la galerie sur Android (via les permissions déclarées dans le manifest)
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(
        source: source,
        maxWidth: 1920,
        maxHeight: 1920,
        imageQuality: 90,
      );

      if (pickedFile == null) {
        return; // L'utilisateur a annulé
      }

      // Uploader l'image
      final imageFile = File(pickedFile.path);
      await ref.read(avatarControllerProvider.notifier).uploadAvatar(imageFile);
    } catch (e) {
      // L'erreur sera gérée par AvatarController via AsyncValue.error
      // Le widget qui écoute avatarControllerProvider affichera l'erreur
    }
  }

  /// Vérifie et demande les permissions nécessaires
  Future<bool> _requestPermission(ImageSource source, WidgetRef ref) async {
    if (source == ImageSource.camera) {
      final cameraStatus = await Permission.camera.status;
      if (cameraStatus.isGranted) {
        return true;
      }
      if (cameraStatus.isDenied) {
        final result = await Permission.camera.request();
        return result.isGranted;
      }
      if (cameraStatus.isPermanentlyDenied) {
        await openAppSettings();
        return false;
      }
      return false;
    }

    // Pour la galerie photo
    if (Platform.isIOS) {
      // Sur iOS, utiliser Permission.photos
      final photosStatus = await Permission.photos.status;
      if (photosStatus.isGranted) {
        return true;
      }
      if (photosStatus.isDenied) {
        final result = await Permission.photos.request();
        return result.isGranted;
      }
      if (photosStatus.isPermanentlyDenied) {
        await openAppSettings();
        return false;
      }
      return false;
    } else {
      // Sur Android, utiliser Permission.photos (qui gère automatiquement les versions)
      final photosStatus = await Permission.photos.status;
      if (photosStatus.isGranted) {
      return true;
    }
      if (photosStatus.isDenied) {
        final result = await Permission.photos.request();
      return result.isGranted;
    }
      if (photosStatus.isPermanentlyDenied) {
      await openAppSettings();
        return false;
      }
      // Sur Android, si photos n'est pas disponible, essayer storage
      if (photosStatus.isLimited) {
        return true; // Permission limitée acceptée
      }
      // Fallback pour Android ancien
      final storageStatus = await Permission.storage.status;
      if (storageStatus.isGranted) {
        return true;
      }
      if (storageStatus.isDenied) {
        final result = await Permission.storage.request();
        return result.isGranted;
      }
      return false;
    }
  }
}

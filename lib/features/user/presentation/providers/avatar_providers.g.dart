// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'avatar_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider pour StorageDataSource

@ProviderFor(storageDataSource)
const storageDataSourceProvider = StorageDataSourceProvider._();

/// Provider pour StorageDataSource

final class StorageDataSourceProvider
    extends
        $FunctionalProvider<
          StorageDataSourceImpl,
          StorageDataSourceImpl,
          StorageDataSourceImpl
        >
    with $Provider<StorageDataSourceImpl> {
  /// Provider pour StorageDataSource
  const StorageDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'storageDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$storageDataSourceHash();

  @$internal
  @override
  $ProviderElement<StorageDataSourceImpl> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  StorageDataSourceImpl create(Ref ref) {
    return storageDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(StorageDataSourceImpl value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<StorageDataSourceImpl>(value),
    );
  }
}

String _$storageDataSourceHash() => r'ace643d6c39baf79e43a00f90bc003afc34f2161';

/// Provider pour UploadAvatarUseCase

@ProviderFor(uploadAvatarUseCase)
const uploadAvatarUseCaseProvider = UploadAvatarUseCaseProvider._();

/// Provider pour UploadAvatarUseCase

final class UploadAvatarUseCaseProvider
    extends
        $FunctionalProvider<
          AsyncValue<UploadAvatarUseCase>,
          UploadAvatarUseCase,
          FutureOr<UploadAvatarUseCase>
        >
    with
        $FutureModifier<UploadAvatarUseCase>,
        $FutureProvider<UploadAvatarUseCase> {
  /// Provider pour UploadAvatarUseCase
  const UploadAvatarUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'uploadAvatarUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$uploadAvatarUseCaseHash();

  @$internal
  @override
  $FutureProviderElement<UploadAvatarUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<UploadAvatarUseCase> create(Ref ref) {
    return uploadAvatarUseCase(ref);
  }
}

String _$uploadAvatarUseCaseHash() =>
    r'532cfb27aaae655ff4344a5439e6eeaede025afe';

/// Provider pour DeleteAvatarUseCase

@ProviderFor(deleteAvatarUseCase)
const deleteAvatarUseCaseProvider = DeleteAvatarUseCaseProvider._();

/// Provider pour DeleteAvatarUseCase

final class DeleteAvatarUseCaseProvider
    extends
        $FunctionalProvider<
          AsyncValue<DeleteAvatarUseCase>,
          DeleteAvatarUseCase,
          FutureOr<DeleteAvatarUseCase>
        >
    with
        $FutureModifier<DeleteAvatarUseCase>,
        $FutureProvider<DeleteAvatarUseCase> {
  /// Provider pour DeleteAvatarUseCase
  const DeleteAvatarUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'deleteAvatarUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$deleteAvatarUseCaseHash();

  @$internal
  @override
  $FutureProviderElement<DeleteAvatarUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<DeleteAvatarUseCase> create(Ref ref) {
    return deleteAvatarUseCase(ref);
  }
}

String _$deleteAvatarUseCaseHash() =>
    r'e7bb219584acf65a9c9389fe83f118a17a8ff7df';

/// Controller pour la gestion des avatars utilisateur.
///
/// Gère l'upload, la suppression et l'affichage des avatars.

@ProviderFor(AvatarController)
const avatarControllerProvider = AvatarControllerProvider._();

/// Controller pour la gestion des avatars utilisateur.
///
/// Gère l'upload, la suppression et l'affichage des avatars.
final class AvatarControllerProvider
    extends $AsyncNotifierProvider<AvatarController, void> {
  /// Controller pour la gestion des avatars utilisateur.
  ///
  /// Gère l'upload, la suppression et l'affichage des avatars.
  const AvatarControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'avatarControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$avatarControllerHash();

  @$internal
  @override
  AvatarController create() => AvatarController();
}

String _$avatarControllerHash() => r'b26404b0e3eef1f052ae943012a781fb0ce92a90';

/// Controller pour la gestion des avatars utilisateur.
///
/// Gère l'upload, la suppression et l'affichage des avatars.

abstract class _$AvatarController extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  void runBuild() {
    build();
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, void>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    element.handleValue(ref, null);
  }
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_processing_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider pour ImageProcessingService

@ProviderFor(imageProcessingService)
const imageProcessingServiceProvider = ImageProcessingServiceProvider._();

/// Provider pour ImageProcessingService

final class ImageProcessingServiceProvider
    extends
        $FunctionalProvider<
          ImageProcessingService,
          ImageProcessingService,
          ImageProcessingService
        >
    with $Provider<ImageProcessingService> {
  /// Provider pour ImageProcessingService
  const ImageProcessingServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'imageProcessingServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$imageProcessingServiceHash();

  @$internal
  @override
  $ProviderElement<ImageProcessingService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ImageProcessingService create(Ref ref) {
    return imageProcessingService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ImageProcessingService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ImageProcessingService>(value),
    );
  }
}

String _$imageProcessingServiceHash() =>
    r'ebc6738972f508833ba5c90a19eceba792982a5c';

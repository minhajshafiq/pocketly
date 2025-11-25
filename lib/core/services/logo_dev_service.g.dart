// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'logo_dev_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider pour LogoDevService

@ProviderFor(logoDevService)
const logoDevServiceProvider = LogoDevServiceProvider._();

/// Provider pour LogoDevService

final class LogoDevServiceProvider
    extends $FunctionalProvider<LogoDevService, LogoDevService, LogoDevService>
    with $Provider<LogoDevService> {
  /// Provider pour LogoDevService
  const LogoDevServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'logoDevServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$logoDevServiceHash();

  @$internal
  @override
  $ProviderElement<LogoDevService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  LogoDevService create(Ref ref) {
    return logoDevService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LogoDevService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LogoDevService>(value),
    );
  }
}

String _$logoDevServiceHash() => r'79df826c63a321146819586ef1174a1169144bc5';

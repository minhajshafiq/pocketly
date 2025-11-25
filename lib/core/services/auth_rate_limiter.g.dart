// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_rate_limiter.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider pour le service de rate limiting

@ProviderFor(authRateLimiter)
const authRateLimiterProvider = AuthRateLimiterProvider._();

/// Provider pour le service de rate limiting

final class AuthRateLimiterProvider
    extends
        $FunctionalProvider<AuthRateLimiter, AuthRateLimiter, AuthRateLimiter>
    with $Provider<AuthRateLimiter> {
  /// Provider pour le service de rate limiting
  const AuthRateLimiterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authRateLimiterProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authRateLimiterHash();

  @$internal
  @override
  $ProviderElement<AuthRateLimiter> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AuthRateLimiter create(Ref ref) {
    return authRateLimiter(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuthRateLimiter value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuthRateLimiter>(value),
    );
  }
}

String _$authRateLimiterHash() => r'e93cb3b04e864d78a3622e3dc38f29421b4441a0';

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider pour le datasource remote

@ProviderFor(authRemoteDataSource)
const authRemoteDataSourceProvider = AuthRemoteDataSourceProvider._();

/// Provider pour le datasource remote

final class AuthRemoteDataSourceProvider
    extends
        $FunctionalProvider<
          AuthRemoteDataSource,
          AuthRemoteDataSource,
          AuthRemoteDataSource
        >
    with $Provider<AuthRemoteDataSource> {
  /// Provider pour le datasource remote
  const AuthRemoteDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authRemoteDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authRemoteDataSourceHash();

  @$internal
  @override
  $ProviderElement<AuthRemoteDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AuthRemoteDataSource create(Ref ref) {
    return authRemoteDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuthRemoteDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuthRemoteDataSource>(value),
    );
  }
}

String _$authRemoteDataSourceHash() =>
    r'c73bfb26ad4a21c84b02168012ccc937e5dfdec6';

/// Provider pour le repository auth

@ProviderFor(AuthRepositoryProvider)
const authRepositoryProviderProvider = AuthRepositoryProviderProvider._();

/// Provider pour le repository auth
final class AuthRepositoryProviderProvider
    extends $NotifierProvider<AuthRepositoryProvider, AuthRepository> {
  /// Provider pour le repository auth
  const AuthRepositoryProviderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authRepositoryProviderProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authRepositoryProviderHash();

  @$internal
  @override
  AuthRepositoryProvider create() => AuthRepositoryProvider();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuthRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuthRepository>(value),
    );
  }
}

String _$authRepositoryProviderHash() =>
    r'638e477158344033b8382687803d6555f6c238bf';

/// Provider pour le repository auth

abstract class _$AuthRepositoryProvider extends $Notifier<AuthRepository> {
  AuthRepository build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AuthRepository, AuthRepository>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AuthRepository, AuthRepository>,
              AuthRepository,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

/// Provider pour le use case signIn

@ProviderFor(signInUseCase)
const signInUseCaseProvider = SignInUseCaseProvider._();

/// Provider pour le use case signIn

final class SignInUseCaseProvider
    extends $FunctionalProvider<SignInUseCase, SignInUseCase, SignInUseCase>
    with $Provider<SignInUseCase> {
  /// Provider pour le use case signIn
  const SignInUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'signInUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$signInUseCaseHash();

  @$internal
  @override
  $ProviderElement<SignInUseCase> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SignInUseCase create(Ref ref) {
    return signInUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SignInUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SignInUseCase>(value),
    );
  }
}

String _$signInUseCaseHash() => r'31036f1075e6abba9901a3e7536af59f8ff2a17b';

/// Provider pour le use case signUp

@ProviderFor(signUpUseCase)
const signUpUseCaseProvider = SignUpUseCaseProvider._();

/// Provider pour le use case signUp

final class SignUpUseCaseProvider
    extends $FunctionalProvider<SignUpUseCase, SignUpUseCase, SignUpUseCase>
    with $Provider<SignUpUseCase> {
  /// Provider pour le use case signUp
  const SignUpUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'signUpUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$signUpUseCaseHash();

  @$internal
  @override
  $ProviderElement<SignUpUseCase> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SignUpUseCase create(Ref ref) {
    return signUpUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SignUpUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SignUpUseCase>(value),
    );
  }
}

String _$signUpUseCaseHash() => r'4ac2ab14ee8a4ac3ffdfcea38457ac9063e160b1';

/// Provider pour le use case signOut

@ProviderFor(signOutUseCase)
const signOutUseCaseProvider = SignOutUseCaseProvider._();

/// Provider pour le use case signOut

final class SignOutUseCaseProvider
    extends $FunctionalProvider<SignOutUseCase, SignOutUseCase, SignOutUseCase>
    with $Provider<SignOutUseCase> {
  /// Provider pour le use case signOut
  const SignOutUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'signOutUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$signOutUseCaseHash();

  @$internal
  @override
  $ProviderElement<SignOutUseCase> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SignOutUseCase create(Ref ref) {
    return signOutUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SignOutUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SignOutUseCase>(value),
    );
  }
}

String _$signOutUseCaseHash() => r'f0b47a0911937b6b1e16d9a64c4c4023ce8d62e6';

/// Provider pour le use case getCurrentSession

@ProviderFor(getCurrentSessionUseCase)
const getCurrentSessionUseCaseProvider = GetCurrentSessionUseCaseProvider._();

/// Provider pour le use case getCurrentSession

final class GetCurrentSessionUseCaseProvider
    extends
        $FunctionalProvider<
          GetCurrentSessionUseCase,
          GetCurrentSessionUseCase,
          GetCurrentSessionUseCase
        >
    with $Provider<GetCurrentSessionUseCase> {
  /// Provider pour le use case getCurrentSession
  const GetCurrentSessionUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getCurrentSessionUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getCurrentSessionUseCaseHash();

  @$internal
  @override
  $ProviderElement<GetCurrentSessionUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetCurrentSessionUseCase create(Ref ref) {
    return getCurrentSessionUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetCurrentSessionUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetCurrentSessionUseCase>(value),
    );
  }
}

String _$getCurrentSessionUseCaseHash() =>
    r'0d571913ec944ec6799ae67d4fd81dacd2644062';

/// Provider pour le use case resetPassword

@ProviderFor(resetPasswordUseCase)
const resetPasswordUseCaseProvider = ResetPasswordUseCaseProvider._();

/// Provider pour le use case resetPassword

final class ResetPasswordUseCaseProvider
    extends
        $FunctionalProvider<
          ResetPasswordUseCase,
          ResetPasswordUseCase,
          ResetPasswordUseCase
        >
    with $Provider<ResetPasswordUseCase> {
  /// Provider pour le use case resetPassword
  const ResetPasswordUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'resetPasswordUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$resetPasswordUseCaseHash();

  @$internal
  @override
  $ProviderElement<ResetPasswordUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ResetPasswordUseCase create(Ref ref) {
    return resetPasswordUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ResetPasswordUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ResetPasswordUseCase>(value),
    );
  }
}

String _$resetPasswordUseCaseHash() =>
    r'7b51c130c6c00b0c7cb30acbb2fb380cdfd4f257';

/// Provider pour le use case updatePassword

@ProviderFor(updatePasswordUseCase)
const updatePasswordUseCaseProvider = UpdatePasswordUseCaseProvider._();

/// Provider pour le use case updatePassword

final class UpdatePasswordUseCaseProvider
    extends
        $FunctionalProvider<
          UpdatePasswordUseCase,
          UpdatePasswordUseCase,
          UpdatePasswordUseCase
        >
    with $Provider<UpdatePasswordUseCase> {
  /// Provider pour le use case updatePassword
  const UpdatePasswordUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'updatePasswordUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$updatePasswordUseCaseHash();

  @$internal
  @override
  $ProviderElement<UpdatePasswordUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  UpdatePasswordUseCase create(Ref ref) {
    return updatePasswordUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UpdatePasswordUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UpdatePasswordUseCase>(value),
    );
  }
}

String _$updatePasswordUseCaseHash() =>
    r'5662172d5e517b874a2fecd6fb09b758ee67faa6';

/// Provider pour le use case updateEmail

@ProviderFor(updateEmailUseCase)
const updateEmailUseCaseProvider = UpdateEmailUseCaseProvider._();

/// Provider pour le use case updateEmail

final class UpdateEmailUseCaseProvider
    extends
        $FunctionalProvider<
          UpdateEmailUseCase,
          UpdateEmailUseCase,
          UpdateEmailUseCase
        >
    with $Provider<UpdateEmailUseCase> {
  /// Provider pour le use case updateEmail
  const UpdateEmailUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'updateEmailUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$updateEmailUseCaseHash();

  @$internal
  @override
  $ProviderElement<UpdateEmailUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  UpdateEmailUseCase create(Ref ref) {
    return updateEmailUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UpdateEmailUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UpdateEmailUseCase>(value),
    );
  }
}

String _$updateEmailUseCaseHash() =>
    r'cac1e0ab7d6f2cf784a3af9fa8338f8b880e892c';

/// Provider pour le use case isAuthenticated

@ProviderFor(isAuthenticatedUseCase)
const isAuthenticatedUseCaseProvider = IsAuthenticatedUseCaseProvider._();

/// Provider pour le use case isAuthenticated

final class IsAuthenticatedUseCaseProvider
    extends
        $FunctionalProvider<
          IsAuthenticatedUseCase,
          IsAuthenticatedUseCase,
          IsAuthenticatedUseCase
        >
    with $Provider<IsAuthenticatedUseCase> {
  /// Provider pour le use case isAuthenticated
  const IsAuthenticatedUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'isAuthenticatedUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$isAuthenticatedUseCaseHash();

  @$internal
  @override
  $ProviderElement<IsAuthenticatedUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  IsAuthenticatedUseCase create(Ref ref) {
    return isAuthenticatedUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(IsAuthenticatedUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<IsAuthenticatedUseCase>(value),
    );
  }
}

String _$isAuthenticatedUseCaseHash() =>
    r'ed7a8abc0ca300bfb35db65c1447fcc0701742cd';

/// Provider pour le use case getCurrentUserId

@ProviderFor(getCurrentUserIdUseCase)
const getCurrentUserIdUseCaseProvider = GetCurrentUserIdUseCaseProvider._();

/// Provider pour le use case getCurrentUserId

final class GetCurrentUserIdUseCaseProvider
    extends
        $FunctionalProvider<
          GetCurrentUserIdUseCase,
          GetCurrentUserIdUseCase,
          GetCurrentUserIdUseCase
        >
    with $Provider<GetCurrentUserIdUseCase> {
  /// Provider pour le use case getCurrentUserId
  const GetCurrentUserIdUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getCurrentUserIdUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getCurrentUserIdUseCaseHash();

  @$internal
  @override
  $ProviderElement<GetCurrentUserIdUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetCurrentUserIdUseCase create(Ref ref) {
    return getCurrentUserIdUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetCurrentUserIdUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetCurrentUserIdUseCase>(value),
    );
  }
}

String _$getCurrentUserIdUseCaseHash() =>
    r'252ba71a35a4faba33d93c99ea70c0541339c893';

/// Provider pour le use case watchAuthState

@ProviderFor(watchAuthStateUseCase)
const watchAuthStateUseCaseProvider = WatchAuthStateUseCaseProvider._();

/// Provider pour le use case watchAuthState

final class WatchAuthStateUseCaseProvider
    extends
        $FunctionalProvider<
          WatchAuthStateUseCase,
          WatchAuthStateUseCase,
          WatchAuthStateUseCase
        >
    with $Provider<WatchAuthStateUseCase> {
  /// Provider pour le use case watchAuthState
  const WatchAuthStateUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'watchAuthStateUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$watchAuthStateUseCaseHash();

  @$internal
  @override
  $ProviderElement<WatchAuthStateUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  WatchAuthStateUseCase create(Ref ref) {
    return watchAuthStateUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WatchAuthStateUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WatchAuthStateUseCase>(value),
    );
  }
}

String _$watchAuthStateUseCaseHash() =>
    r'56f2a36bea8e99243667c845719d12e24cd1b500';

/// Notifier pour gérer l'état d'authentification

@ProviderFor(AuthNotifier)
const authProvider = AuthNotifierProvider._();

/// Notifier pour gérer l'état d'authentification
final class AuthNotifierProvider
    extends $AsyncNotifierProvider<AuthNotifier, AuthState> {
  /// Notifier pour gérer l'état d'authentification
  const AuthNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authNotifierHash();

  @$internal
  @override
  AuthNotifier create() => AuthNotifier();
}

String _$authNotifierHash() => r'f11dca79aeac4821e8d60dab2e2b83998ca1ec11';

/// Notifier pour gérer l'état d'authentification

abstract class _$AuthNotifier extends $AsyncNotifier<AuthState> {
  FutureOr<AuthState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<AuthState>, AuthState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<AuthState>, AuthState>,
              AsyncValue<AuthState>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

/// Provider pour vérifier si l'utilisateur est authentifié

@ProviderFor(isAuthenticated)
const isAuthenticatedProvider = IsAuthenticatedProvider._();

/// Provider pour vérifier si l'utilisateur est authentifié

final class IsAuthenticatedProvider
    extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  /// Provider pour vérifier si l'utilisateur est authentifié
  const IsAuthenticatedProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'isAuthenticatedProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$isAuthenticatedHash();

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    return isAuthenticated(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$isAuthenticatedHash() => r'494a4bb18e41a9e7dc235dacb621501236f8ba9c';

/// Provider pour obtenir la session actuelle

@ProviderFor(currentSession)
const currentSessionProvider = CurrentSessionProvider._();

/// Provider pour obtenir la session actuelle

final class CurrentSessionProvider
    extends $FunctionalProvider<AuthSession?, AuthSession?, AuthSession?>
    with $Provider<AuthSession?> {
  /// Provider pour obtenir la session actuelle
  const CurrentSessionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentSessionProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentSessionHash();

  @$internal
  @override
  $ProviderElement<AuthSession?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AuthSession? create(Ref ref) {
    return currentSession(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuthSession? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuthSession?>(value),
    );
  }
}

String _$currentSessionHash() => r'913ecbb966ab9f84aa2693f65558df83187f3a1c';

/// Provider pour obtenir l'ID utilisateur actuel

@ProviderFor(currentUserId)
const currentUserIdProvider = CurrentUserIdProvider._();

/// Provider pour obtenir l'ID utilisateur actuel

final class CurrentUserIdProvider
    extends $FunctionalProvider<String?, String?, String?>
    with $Provider<String?> {
  /// Provider pour obtenir l'ID utilisateur actuel
  const CurrentUserIdProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentUserIdProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentUserIdHash();

  @$internal
  @override
  $ProviderElement<String?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  String? create(Ref ref) {
    return currentUserId(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String?>(value),
    );
  }
}

String _$currentUserIdHash() => r'48a3dac274f1e2d8e91ebba16950ba9e7a504d55';

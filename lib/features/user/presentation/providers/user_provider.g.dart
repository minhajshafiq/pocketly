// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider pour le datasource remote

@ProviderFor(userRemoteDataSource)
const userRemoteDataSourceProvider = UserRemoteDataSourceProvider._();

/// Provider pour le datasource remote

final class UserRemoteDataSourceProvider
    extends
        $FunctionalProvider<
          UserRemoteDataSource,
          UserRemoteDataSource,
          UserRemoteDataSource
        >
    with $Provider<UserRemoteDataSource> {
  /// Provider pour le datasource remote
  const UserRemoteDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userRemoteDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userRemoteDataSourceHash();

  @$internal
  @override
  $ProviderElement<UserRemoteDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  UserRemoteDataSource create(Ref ref) {
    return userRemoteDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UserRemoteDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UserRemoteDataSource>(value),
    );
  }
}

String _$userRemoteDataSourceHash() =>
    r'0c4e0157bd3a538caabbfb3a0a848dc819ff64f2';

/// Provider pour le datasource local

@ProviderFor(userLocalDataSource)
const userLocalDataSourceProvider = UserLocalDataSourceProvider._();

/// Provider pour le datasource local

final class UserLocalDataSourceProvider
    extends
        $FunctionalProvider<
          UserLocalDataSource,
          UserLocalDataSource,
          UserLocalDataSource
        >
    with $Provider<UserLocalDataSource> {
  /// Provider pour le datasource local
  const UserLocalDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userLocalDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userLocalDataSourceHash();

  @$internal
  @override
  $ProviderElement<UserLocalDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  UserLocalDataSource create(Ref ref) {
    return userLocalDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UserLocalDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UserLocalDataSource>(value),
    );
  }
}

String _$userLocalDataSourceHash() =>
    r'4760eb62e07069292b9b91c29ec17e15daabf256';

/// Provider pour le repository utilisateur

@ProviderFor(userRepository)
const userRepositoryProvider = UserRepositoryProvider._();

/// Provider pour le repository utilisateur

final class UserRepositoryProvider
    extends
        $FunctionalProvider<
          AsyncValue<UserRepository>,
          UserRepository,
          FutureOr<UserRepository>
        >
    with $FutureModifier<UserRepository>, $FutureProvider<UserRepository> {
  /// Provider pour le repository utilisateur
  const UserRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userRepositoryHash();

  @$internal
  @override
  $FutureProviderElement<UserRepository> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<UserRepository> create(Ref ref) {
    return userRepository(ref);
  }
}

String _$userRepositoryHash() => r'2232afaddbb94626d2fdc9a7b29faeefec880979';

/// Provider pour le use case getCurrentUser

@ProviderFor(getCurrentUserUseCase)
const getCurrentUserUseCaseProvider = GetCurrentUserUseCaseProvider._();

/// Provider pour le use case getCurrentUser

final class GetCurrentUserUseCaseProvider
    extends
        $FunctionalProvider<
          AsyncValue<GetCurrentUserUseCase>,
          GetCurrentUserUseCase,
          FutureOr<GetCurrentUserUseCase>
        >
    with
        $FutureModifier<GetCurrentUserUseCase>,
        $FutureProvider<GetCurrentUserUseCase> {
  /// Provider pour le use case getCurrentUser
  const GetCurrentUserUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getCurrentUserUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getCurrentUserUseCaseHash();

  @$internal
  @override
  $FutureProviderElement<GetCurrentUserUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<GetCurrentUserUseCase> create(Ref ref) {
    return getCurrentUserUseCase(ref);
  }
}

String _$getCurrentUserUseCaseHash() =>
    r'bbf800020b395fce5cabee43154e06dcab78323c';

/// Provider pour le use case createUser

@ProviderFor(createUserUseCase)
const createUserUseCaseProvider = CreateUserUseCaseProvider._();

/// Provider pour le use case createUser

final class CreateUserUseCaseProvider
    extends
        $FunctionalProvider<
          AsyncValue<CreateUserUseCase>,
          CreateUserUseCase,
          FutureOr<CreateUserUseCase>
        >
    with
        $FutureModifier<CreateUserUseCase>,
        $FutureProvider<CreateUserUseCase> {
  /// Provider pour le use case createUser
  const CreateUserUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'createUserUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$createUserUseCaseHash();

  @$internal
  @override
  $FutureProviderElement<CreateUserUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<CreateUserUseCase> create(Ref ref) {
    return createUserUseCase(ref);
  }
}

String _$createUserUseCaseHash() => r'6ef7ee55f26211d6656d7b6dae6f3e1e67bc061a';

/// Provider pour le use case updateUser

@ProviderFor(updateUserUseCase)
const updateUserUseCaseProvider = UpdateUserUseCaseProvider._();

/// Provider pour le use case updateUser

final class UpdateUserUseCaseProvider
    extends
        $FunctionalProvider<
          AsyncValue<UpdateUserUseCase>,
          UpdateUserUseCase,
          FutureOr<UpdateUserUseCase>
        >
    with
        $FutureModifier<UpdateUserUseCase>,
        $FutureProvider<UpdateUserUseCase> {
  /// Provider pour le use case updateUser
  const UpdateUserUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'updateUserUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$updateUserUseCaseHash();

  @$internal
  @override
  $FutureProviderElement<UpdateUserUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<UpdateUserUseCase> create(Ref ref) {
    return updateUserUseCase(ref);
  }
}

String _$updateUserUseCaseHash() => r'7802301676e1bd03f87b4d497b2954909c30d709';

/// Provider pour le use case deleteUser

@ProviderFor(deleteUserUseCase)
const deleteUserUseCaseProvider = DeleteUserUseCaseProvider._();

/// Provider pour le use case deleteUser

final class DeleteUserUseCaseProvider
    extends
        $FunctionalProvider<
          AsyncValue<DeleteUserUseCase>,
          DeleteUserUseCase,
          FutureOr<DeleteUserUseCase>
        >
    with
        $FutureModifier<DeleteUserUseCase>,
        $FutureProvider<DeleteUserUseCase> {
  /// Provider pour le use case deleteUser
  const DeleteUserUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'deleteUserUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$deleteUserUseCaseHash();

  @$internal
  @override
  $FutureProviderElement<DeleteUserUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<DeleteUserUseCase> create(Ref ref) {
    return deleteUserUseCase(ref);
  }
}

String _$deleteUserUseCaseHash() => r'7de933f0c1aba9dcafe35251c36a3d6a78fadd3d';

/// Provider pour le use case activateTrial

@ProviderFor(activateTrialUseCase)
const activateTrialUseCaseProvider = ActivateTrialUseCaseProvider._();

/// Provider pour le use case activateTrial

final class ActivateTrialUseCaseProvider
    extends
        $FunctionalProvider<
          AsyncValue<ActivateTrialUseCase>,
          ActivateTrialUseCase,
          FutureOr<ActivateTrialUseCase>
        >
    with
        $FutureModifier<ActivateTrialUseCase>,
        $FutureProvider<ActivateTrialUseCase> {
  /// Provider pour le use case activateTrial
  const ActivateTrialUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'activateTrialUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$activateTrialUseCaseHash();

  @$internal
  @override
  $FutureProviderElement<ActivateTrialUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<ActivateTrialUseCase> create(Ref ref) {
    return activateTrialUseCase(ref);
  }
}

String _$activateTrialUseCaseHash() =>
    r'9b6ca7ac1d5501a7774347012771b8eac1ab8e8e';

/// Provider pour le use case activatePremium

@ProviderFor(activatePremiumUseCase)
const activatePremiumUseCaseProvider = ActivatePremiumUseCaseProvider._();

/// Provider pour le use case activatePremium

final class ActivatePremiumUseCaseProvider
    extends
        $FunctionalProvider<
          AsyncValue<ActivatePremiumUseCase>,
          ActivatePremiumUseCase,
          FutureOr<ActivatePremiumUseCase>
        >
    with
        $FutureModifier<ActivatePremiumUseCase>,
        $FutureProvider<ActivatePremiumUseCase> {
  /// Provider pour le use case activatePremium
  const ActivatePremiumUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'activatePremiumUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$activatePremiumUseCaseHash();

  @$internal
  @override
  $FutureProviderElement<ActivatePremiumUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<ActivatePremiumUseCase> create(Ref ref) {
    return activatePremiumUseCase(ref);
  }
}

String _$activatePremiumUseCaseHash() =>
    r'1b615c216e808fa014f037bef202b678d56cf50b';

/// Provider pour le use case completeOnboarding

@ProviderFor(completeOnboardingUseCase)
const completeOnboardingUseCaseProvider = CompleteOnboardingUseCaseProvider._();

/// Provider pour le use case completeOnboarding

final class CompleteOnboardingUseCaseProvider
    extends
        $FunctionalProvider<
          AsyncValue<CompleteOnboardingUseCase>,
          CompleteOnboardingUseCase,
          FutureOr<CompleteOnboardingUseCase>
        >
    with
        $FutureModifier<CompleteOnboardingUseCase>,
        $FutureProvider<CompleteOnboardingUseCase> {
  /// Provider pour le use case completeOnboarding
  const CompleteOnboardingUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'completeOnboardingUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$completeOnboardingUseCaseHash();

  @$internal
  @override
  $FutureProviderElement<CompleteOnboardingUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<CompleteOnboardingUseCase> create(Ref ref) {
    return completeOnboardingUseCase(ref);
  }
}

String _$completeOnboardingUseCaseHash() =>
    r'c0ef81f348cd4f530c0bf042548c057a89c5fd47';

/// Notifier pour la gestion de l'utilisateur actuel

@ProviderFor(CurrentUserNotifier)
const currentUserProvider = CurrentUserNotifierProvider._();

/// Notifier pour la gestion de l'utilisateur actuel
final class CurrentUserNotifierProvider
    extends $AsyncNotifierProvider<CurrentUserNotifier, UserEntity?> {
  /// Notifier pour la gestion de l'utilisateur actuel
  const CurrentUserNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentUserProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentUserNotifierHash();

  @$internal
  @override
  CurrentUserNotifier create() => CurrentUserNotifier();
}

String _$currentUserNotifierHash() =>
    r'25f515ba34166faccc3a57a6a31ad1fb3968a483';

/// Notifier pour la gestion de l'utilisateur actuel

abstract class _$CurrentUserNotifier extends $AsyncNotifier<UserEntity?> {
  FutureOr<UserEntity?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<UserEntity?>, UserEntity?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<UserEntity?>, UserEntity?>,
              AsyncValue<UserEntity?>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

/// Provider pour vérifier si l'utilisateur a accès au premium

@ProviderFor(CanAccessPremium)
const canAccessPremiumProvider = CanAccessPremiumProvider._();

/// Provider pour vérifier si l'utilisateur a accès au premium
final class CanAccessPremiumProvider
    extends $NotifierProvider<CanAccessPremium, bool> {
  /// Provider pour vérifier si l'utilisateur a accès au premium
  const CanAccessPremiumProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'canAccessPremiumProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$canAccessPremiumHash();

  @$internal
  @override
  CanAccessPremium create() => CanAccessPremium();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$canAccessPremiumHash() => r'e4d209e6930d79d6b9e7e67f4117eb6bb4ee1bcf';

/// Provider pour vérifier si l'utilisateur a accès au premium

abstract class _$CanAccessPremium extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<bool, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<bool, bool>,
              bool,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

/// Provider pour vérifier si l'utilisateur est en période d'essai

@ProviderFor(IsTrialActive)
const isTrialActiveProvider = IsTrialActiveProvider._();

/// Provider pour vérifier si l'utilisateur est en période d'essai
final class IsTrialActiveProvider
    extends $NotifierProvider<IsTrialActive, bool> {
  /// Provider pour vérifier si l'utilisateur est en période d'essai
  const IsTrialActiveProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'isTrialActiveProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$isTrialActiveHash();

  @$internal
  @override
  IsTrialActive create() => IsTrialActive();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$isTrialActiveHash() => r'7d23bb30b43d29a8778fe5baeb3a13297cb55473';

/// Provider pour vérifier si l'utilisateur est en période d'essai

abstract class _$IsTrialActive extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<bool, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<bool, bool>,
              bool,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

/// Provider pour obtenir le statut de l'utilisateur (free/trial/premium)

@ProviderFor(UserStatus)
const userStatusProvider = UserStatusProvider._();

/// Provider pour obtenir le statut de l'utilisateur (free/trial/premium)
final class UserStatusProvider extends $NotifierProvider<UserStatus, String> {
  /// Provider pour obtenir le statut de l'utilisateur (free/trial/premium)
  const UserStatusProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userStatusProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userStatusHash();

  @$internal
  @override
  UserStatus create() => UserStatus();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$userStatusHash() => r'80fdc13d8e1a3bd61d6d282e3a665ce6cda5bdb7';

/// Provider pour obtenir le statut de l'utilisateur (free/trial/premium)

abstract class _$UserStatus extends $Notifier<String> {
  String build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<String, String>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String, String>,
              String,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

/// Provider pour les jours restants du trial

@ProviderFor(TrialDaysLeft)
const trialDaysLeftProvider = TrialDaysLeftProvider._();

/// Provider pour les jours restants du trial
final class TrialDaysLeftProvider
    extends $NotifierProvider<TrialDaysLeft, int> {
  /// Provider pour les jours restants du trial
  const TrialDaysLeftProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'trialDaysLeftProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$trialDaysLeftHash();

  @$internal
  @override
  TrialDaysLeft create() => TrialDaysLeft();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$trialDaysLeftHash() => r'd7a2349b89bd8ada89f6e70e4b17c32a8ce4bd25';

/// Provider pour les jours restants du trial

abstract class _$TrialDaysLeft extends $Notifier<int> {
  int build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<int, int>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<int, int>,
              int,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

/// Provider pour vérifier si l'onboarding est complété

@ProviderFor(HasCompletedOnboarding)
const hasCompletedOnboardingProvider = HasCompletedOnboardingProvider._();

/// Provider pour vérifier si l'onboarding est complété
final class HasCompletedOnboardingProvider
    extends $NotifierProvider<HasCompletedOnboarding, bool> {
  /// Provider pour vérifier si l'onboarding est complété
  const HasCompletedOnboardingProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'hasCompletedOnboardingProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$hasCompletedOnboardingHash();

  @$internal
  @override
  HasCompletedOnboarding create() => HasCompletedOnboarding();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$hasCompletedOnboardingHash() =>
    r'f1996e178c8ace00b08bc67bb3a56d18f4e3aba5';

/// Provider pour vérifier si l'onboarding est complété

abstract class _$HasCompletedOnboarding extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<bool, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<bool, bool>,
              bool,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

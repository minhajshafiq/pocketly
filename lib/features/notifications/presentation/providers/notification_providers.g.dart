// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider pour FlutterLocalNotificationsPlugin

@ProviderFor(flutterLocalNotificationsPlugin)
const flutterLocalNotificationsPluginProvider =
    FlutterLocalNotificationsPluginProvider._();

/// Provider pour FlutterLocalNotificationsPlugin

final class FlutterLocalNotificationsPluginProvider
    extends
        $FunctionalProvider<
          FlutterLocalNotificationsPlugin,
          FlutterLocalNotificationsPlugin,
          FlutterLocalNotificationsPlugin
        >
    with $Provider<FlutterLocalNotificationsPlugin> {
  /// Provider pour FlutterLocalNotificationsPlugin
  const FlutterLocalNotificationsPluginProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'flutterLocalNotificationsPluginProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$flutterLocalNotificationsPluginHash();

  @$internal
  @override
  $ProviderElement<FlutterLocalNotificationsPlugin> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  FlutterLocalNotificationsPlugin create(Ref ref) {
    return flutterLocalNotificationsPlugin(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FlutterLocalNotificationsPlugin value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FlutterLocalNotificationsPlugin>(
        value,
      ),
    );
  }
}

String _$flutterLocalNotificationsPluginHash() =>
    r'5012bb087ba16f70c0b479f4f83169aed9e1b683';

/// Provider pour NotificationLocalDataSource

@ProviderFor(notificationLocalDataSource)
const notificationLocalDataSourceProvider =
    NotificationLocalDataSourceProvider._();

/// Provider pour NotificationLocalDataSource

final class NotificationLocalDataSourceProvider
    extends
        $FunctionalProvider<
          NotificationLocalDataSource,
          NotificationLocalDataSource,
          NotificationLocalDataSource
        >
    with $Provider<NotificationLocalDataSource> {
  /// Provider pour NotificationLocalDataSource
  const NotificationLocalDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationLocalDataSourceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notificationLocalDataSourceHash();

  @$internal
  @override
  $ProviderElement<NotificationLocalDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  NotificationLocalDataSource create(Ref ref) {
    return notificationLocalDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NotificationLocalDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NotificationLocalDataSource>(value),
    );
  }
}

String _$notificationLocalDataSourceHash() =>
    r'f487dd180e5d51e1ad880348b789cb506916bbbf';

/// Provider pour NotificationRepository

@ProviderFor(notificationRepository)
const notificationRepositoryProvider = NotificationRepositoryProvider._();

/// Provider pour NotificationRepository

final class NotificationRepositoryProvider
    extends
        $FunctionalProvider<
          NotificationRepository,
          NotificationRepository,
          NotificationRepository
        >
    with $Provider<NotificationRepository> {
  /// Provider pour NotificationRepository
  const NotificationRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notificationRepositoryHash();

  @$internal
  @override
  $ProviderElement<NotificationRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  NotificationRepository create(Ref ref) {
    return notificationRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NotificationRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NotificationRepository>(value),
    );
  }
}

String _$notificationRepositoryHash() =>
    r'086cb54014754524d7da5fe9f6341ddb5e0f8de3';

/// Provider pour le service de notification consolidé

@ProviderFor(notificationServiceUseCase)
const notificationServiceUseCaseProvider =
    NotificationServiceUseCaseProvider._();

/// Provider pour le service de notification consolidé

final class NotificationServiceUseCaseProvider
    extends
        $FunctionalProvider<
          NotificationService,
          NotificationService,
          NotificationService
        >
    with $Provider<NotificationService> {
  /// Provider pour le service de notification consolidé
  const NotificationServiceUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationServiceUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notificationServiceUseCaseHash();

  @$internal
  @override
  $ProviderElement<NotificationService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  NotificationService create(Ref ref) {
    return notificationServiceUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NotificationService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NotificationService>(value),
    );
  }
}

String _$notificationServiceUseCaseHash() =>
    r'a6eeaed8c3f47e3299f1dbcc0ddc83d69e52db9a';

/// Provider pour l'état des permissions de notification

@ProviderFor(notificationPermissionState)
const notificationPermissionStateProvider =
    NotificationPermissionStateProvider._();

/// Provider pour l'état des permissions de notification

final class NotificationPermissionStateProvider
    extends $FunctionalProvider<AsyncValue<bool>, bool, FutureOr<bool>>
    with $FutureModifier<bool>, $FutureProvider<bool> {
  /// Provider pour l'état des permissions de notification
  const NotificationPermissionStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationPermissionStateProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notificationPermissionStateHash();

  @$internal
  @override
  $FutureProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<bool> create(Ref ref) {
    return notificationPermissionState(ref);
  }
}

String _$notificationPermissionStateHash() =>
    r'23724dad7cc48d4a1d5d738e3977572863057a9d';

/// Contrôleur pour le service de notification

@ProviderFor(NotificationServiceController)
const notificationServiceControllerProvider =
    NotificationServiceControllerProvider._();

/// Contrôleur pour le service de notification
final class NotificationServiceControllerProvider
    extends $AsyncNotifierProvider<NotificationServiceController, bool> {
  /// Contrôleur pour le service de notification
  const NotificationServiceControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationServiceControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notificationServiceControllerHash();

  @$internal
  @override
  NotificationServiceController create() => NotificationServiceController();
}

String _$notificationServiceControllerHash() =>
    r'be2ac515b6bb095392f848d064a274020c8538a1';

/// Contrôleur pour le service de notification

abstract class _$NotificationServiceController extends $AsyncNotifier<bool> {
  FutureOr<bool> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<bool>, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<bool>, bool>,
              AsyncValue<bool>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

/// Provider pour vérifier si le service est initialisé

@ProviderFor(isNotificationServiceInitialized)
const isNotificationServiceInitializedProvider =
    IsNotificationServiceInitializedProvider._();

/// Provider pour vérifier si le service est initialisé

final class IsNotificationServiceInitializedProvider
    extends $FunctionalProvider<AsyncValue<bool>, bool, FutureOr<bool>>
    with $FutureModifier<bool>, $FutureProvider<bool> {
  /// Provider pour vérifier si le service est initialisé
  const IsNotificationServiceInitializedProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'isNotificationServiceInitializedProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$isNotificationServiceInitializedHash();

  @$internal
  @override
  $FutureProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<bool> create(Ref ref) {
    return isNotificationServiceInitialized(ref);
  }
}

String _$isNotificationServiceInitializedHash() =>
    r'b74c3730d0e9bf6ee639fe12f505a2470231d509';

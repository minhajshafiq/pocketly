// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_notifications_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider pour la liste de toutes les notifications de l'utilisateur

@ProviderFor(AppNotifications)
const appNotificationsProvider = AppNotificationsProvider._();

/// Provider pour la liste de toutes les notifications de l'utilisateur
final class AppNotificationsProvider
    extends
        $AsyncNotifierProvider<AppNotifications, List<AppNotificationEntity>> {
  /// Provider pour la liste de toutes les notifications de l'utilisateur
  const AppNotificationsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appNotificationsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appNotificationsHash();

  @$internal
  @override
  AppNotifications create() => AppNotifications();
}

String _$appNotificationsHash() => r'0d160d3c27422b72dddba7ad77bf468dfcba4d9a';

/// Provider pour la liste de toutes les notifications de l'utilisateur

abstract class _$AppNotifications
    extends $AsyncNotifier<List<AppNotificationEntity>> {
  FutureOr<List<AppNotificationEntity>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<
              AsyncValue<List<AppNotificationEntity>>,
              List<AppNotificationEntity>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<AppNotificationEntity>>,
                List<AppNotificationEntity>
              >,
              AsyncValue<List<AppNotificationEntity>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

/// Provider pour les notifications non lues

@ProviderFor(unreadNotifications)
const unreadNotificationsProvider = UnreadNotificationsProvider._();

/// Provider pour les notifications non lues

final class UnreadNotificationsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<AppNotificationEntity>>,
          List<AppNotificationEntity>,
          FutureOr<List<AppNotificationEntity>>
        >
    with
        $FutureModifier<List<AppNotificationEntity>>,
        $FutureProvider<List<AppNotificationEntity>> {
  /// Provider pour les notifications non lues
  const UnreadNotificationsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'unreadNotificationsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$unreadNotificationsHash();

  @$internal
  @override
  $FutureProviderElement<List<AppNotificationEntity>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<AppNotificationEntity>> create(Ref ref) {
    return unreadNotifications(ref);
  }
}

String _$unreadNotificationsHash() =>
    r'18508c2a3a4a0eb4803a4d98542df6c5c64eba21';

/// Provider pour les notifications lues

@ProviderFor(readNotifications)
const readNotificationsProvider = ReadNotificationsProvider._();

/// Provider pour les notifications lues

final class ReadNotificationsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<AppNotificationEntity>>,
          List<AppNotificationEntity>,
          FutureOr<List<AppNotificationEntity>>
        >
    with
        $FutureModifier<List<AppNotificationEntity>>,
        $FutureProvider<List<AppNotificationEntity>> {
  /// Provider pour les notifications lues
  const ReadNotificationsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'readNotificationsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$readNotificationsHash();

  @$internal
  @override
  $FutureProviderElement<List<AppNotificationEntity>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<AppNotificationEntity>> create(Ref ref) {
    return readNotifications(ref);
  }
}

String _$readNotificationsHash() => r'aa89bfa7f8ba7ef70d5c871764d5f76ddc797ae4';

/// Provider pour le nombre de notifications non lues

@ProviderFor(unreadNotificationsCount)
const unreadNotificationsCountProvider = UnreadNotificationsCountProvider._();

/// Provider pour le nombre de notifications non lues

final class UnreadNotificationsCountProvider
    extends $FunctionalProvider<AsyncValue<int>, int, FutureOr<int>>
    with $FutureModifier<int>, $FutureProvider<int> {
  /// Provider pour le nombre de notifications non lues
  const UnreadNotificationsCountProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'unreadNotificationsCountProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$unreadNotificationsCountHash();

  @$internal
  @override
  $FutureProviderElement<int> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<int> create(Ref ref) {
    return unreadNotificationsCount(ref);
  }
}

String _$unreadNotificationsCountHash() =>
    r'01bb3a5856ec2492b206ff0450ca347543282fa6';

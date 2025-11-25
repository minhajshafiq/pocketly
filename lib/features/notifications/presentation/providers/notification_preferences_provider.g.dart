// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_preferences_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider pour les préférences de notifications de l'utilisateur

@ProviderFor(NotificationPreferences)
const notificationPreferencesProvider = NotificationPreferencesProvider._();

/// Provider pour les préférences de notifications de l'utilisateur
final class NotificationPreferencesProvider
    extends
        $AsyncNotifierProvider<
          NotificationPreferences,
          NotificationPreferencesEntity?
        > {
  /// Provider pour les préférences de notifications de l'utilisateur
  const NotificationPreferencesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationPreferencesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notificationPreferencesHash();

  @$internal
  @override
  NotificationPreferences create() => NotificationPreferences();
}

String _$notificationPreferencesHash() =>
    r'd10b62a6b8d76b7a82c77103017418da49611cc6';

/// Provider pour les préférences de notifications de l'utilisateur

abstract class _$NotificationPreferences
    extends $AsyncNotifier<NotificationPreferencesEntity?> {
  FutureOr<NotificationPreferencesEntity?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<
              AsyncValue<NotificationPreferencesEntity?>,
              NotificationPreferencesEntity?
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<NotificationPreferencesEntity?>,
                NotificationPreferencesEntity?
              >,
              AsyncValue<NotificationPreferencesEntity?>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

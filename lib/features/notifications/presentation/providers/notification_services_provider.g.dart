// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_services_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider pour le plugin de notifications locales

@ProviderFor(notificationsPlugin)
const notificationsPluginProvider = NotificationsPluginProvider._();

/// Provider pour le plugin de notifications locales

final class NotificationsPluginProvider
    extends
        $FunctionalProvider<
          FlutterLocalNotificationsPlugin,
          FlutterLocalNotificationsPlugin,
          FlutterLocalNotificationsPlugin
        >
    with $Provider<FlutterLocalNotificationsPlugin> {
  /// Provider pour le plugin de notifications locales
  const NotificationsPluginProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationsPluginProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notificationsPluginHash();

  @$internal
  @override
  $ProviderElement<FlutterLocalNotificationsPlugin> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  FlutterLocalNotificationsPlugin create(Ref ref) {
    return notificationsPlugin(ref);
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

String _$notificationsPluginHash() =>
    r'5c47a6a26334f9f0a0f3640e1787b67e70d209de';

/// Provider pour le service de planification des notifications récurrentes

@ProviderFor(notificationScheduler)
const notificationSchedulerProvider = NotificationSchedulerProvider._();

/// Provider pour le service de planification des notifications récurrentes

final class NotificationSchedulerProvider
    extends
        $FunctionalProvider<
          NotificationSchedulerService,
          NotificationSchedulerService,
          NotificationSchedulerService
        >
    with $Provider<NotificationSchedulerService> {
  /// Provider pour le service de planification des notifications récurrentes
  const NotificationSchedulerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationSchedulerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notificationSchedulerHash();

  @$internal
  @override
  $ProviderElement<NotificationSchedulerService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  NotificationSchedulerService create(Ref ref) {
    return notificationScheduler(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NotificationSchedulerService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NotificationSchedulerService>(value),
    );
  }
}

String _$notificationSchedulerHash() =>
    r'd66e3ce70225d6c3c7747782e94462169acf62b5';

/// Provider pour le service de surveillance des budgets

@ProviderFor(budgetMonitor)
const budgetMonitorProvider = BudgetMonitorProvider._();

/// Provider pour le service de surveillance des budgets

final class BudgetMonitorProvider
    extends
        $FunctionalProvider<
          BudgetMonitorService,
          BudgetMonitorService,
          BudgetMonitorService
        >
    with $Provider<BudgetMonitorService> {
  /// Provider pour le service de surveillance des budgets
  const BudgetMonitorProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'budgetMonitorProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$budgetMonitorHash();

  @$internal
  @override
  $ProviderElement<BudgetMonitorService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  BudgetMonitorService create(Ref ref) {
    return budgetMonitor(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BudgetMonitorService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BudgetMonitorService>(value),
    );
  }
}

String _$budgetMonitorHash() => r'2a3d7692bbc7ae5b9c82e28209da91554e378046';

/// Provider pour le service de suivi des objectifs

@ProviderFor(goalTracker)
const goalTrackerProvider = GoalTrackerProvider._();

/// Provider pour le service de suivi des objectifs

final class GoalTrackerProvider
    extends
        $FunctionalProvider<
          GoalTrackerService,
          GoalTrackerService,
          GoalTrackerService
        >
    with $Provider<GoalTrackerService> {
  /// Provider pour le service de suivi des objectifs
  const GoalTrackerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'goalTrackerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$goalTrackerHash();

  @$internal
  @override
  $ProviderElement<GoalTrackerService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GoalTrackerService create(Ref ref) {
    return goalTracker(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GoalTrackerService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GoalTrackerService>(value),
    );
  }
}

String _$goalTrackerHash() => r'eb670151c97de654a13cec4e1e34b815c0c76644';

/// Provider pour initialiser les notifications récurrentes au démarrage

@ProviderFor(initializeRecurringNotifications)
const initializeRecurringNotificationsProvider =
    InitializeRecurringNotificationsProvider._();

/// Provider pour initialiser les notifications récurrentes au démarrage

final class InitializeRecurringNotificationsProvider
    extends $FunctionalProvider<AsyncValue<void>, void, FutureOr<void>>
    with $FutureModifier<void>, $FutureProvider<void> {
  /// Provider pour initialiser les notifications récurrentes au démarrage
  const InitializeRecurringNotificationsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'initializeRecurringNotificationsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$initializeRecurringNotificationsHash();

  @$internal
  @override
  $FutureProviderElement<void> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<void> create(Ref ref) {
    return initializeRecurringNotifications(ref);
  }
}

String _$initializeRecurringNotificationsHash() =>
    r'90781ca97ecc4d4390d54a5507952a456bae8b3b';

/// Provider qui écoute les changements de préférences et met à jour les notifications

@ProviderFor(NotificationPreferencesListener)
const notificationPreferencesListenerProvider =
    NotificationPreferencesListenerProvider._();

/// Provider qui écoute les changements de préférences et met à jour les notifications
final class NotificationPreferencesListenerProvider
    extends $AsyncNotifierProvider<NotificationPreferencesListener, void> {
  /// Provider qui écoute les changements de préférences et met à jour les notifications
  const NotificationPreferencesListenerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationPreferencesListenerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notificationPreferencesListenerHash();

  @$internal
  @override
  NotificationPreferencesListener create() => NotificationPreferencesListener();
}

String _$notificationPreferencesListenerHash() =>
    r'1acfe00f5017819bd9b4810b1fe2882152376669';

/// Provider qui écoute les changements de préférences et met à jour les notifications

abstract class _$NotificationPreferencesListener extends $AsyncNotifier<void> {
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

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pocketly/core/services/logger_service.dart';
import 'package:pocketly/features/notifications/domain/usecases/notification_scheduler_service.dart';
import 'package:pocketly/features/notifications/domain/usecases/budget_monitor_service.dart';
import 'package:pocketly/features/notifications/domain/usecases/goal_tracker_service.dart';
import 'package:pocketly/features/notifications/presentation/providers/notification_preferences_provider.dart';

part 'notification_services_provider.g.dart';

/// Provider pour le plugin de notifications locales
@riverpod
FlutterLocalNotificationsPlugin notificationsPlugin(Ref ref) {
  return FlutterLocalNotificationsPlugin();
}

/// Provider pour le service de planification des notifications récurrentes
@riverpod
NotificationSchedulerService notificationScheduler(Ref ref) {
  final plugin = ref.watch(notificationsPluginProvider);
  final logger = ref.watch(loggerServiceProvider);

  return NotificationSchedulerService(
    notificationsPlugin: plugin,
    logger: logger,
  );
}

/// Provider pour le service de surveillance des budgets
@riverpod
BudgetMonitorService budgetMonitor(Ref ref) {
  final plugin = ref.watch(notificationsPluginProvider);
  final logger = ref.watch(loggerServiceProvider);

  return BudgetMonitorService(
    notificationsPlugin: plugin,
    logger: logger,
  );
}

/// Provider pour le service de suivi des objectifs
@riverpod
GoalTrackerService goalTracker(Ref ref) {
  final plugin = ref.watch(notificationsPluginProvider);
  final logger = ref.watch(loggerServiceProvider);

  return GoalTrackerService(
    notificationsPlugin: plugin,
    logger: logger,
  );
}

/// Provider pour initialiser les notifications récurrentes au démarrage
@riverpod
Future<void> initializeRecurringNotifications(Ref ref) async {
  final scheduler = ref.watch(notificationSchedulerProvider);
  final preferences = await ref.watch(notificationPreferencesProvider.future);

  if (preferences != null) {
    await scheduler.scheduleRecurringNotifications(preferences);
  }
}

/// Provider qui écoute les changements de préférences et met à jour les notifications
@riverpod
class NotificationPreferencesListener extends _$NotificationPreferencesListener {
  @override
  Future<void> build() async {
    // Écouter les changements de préférences
    ref.listen(notificationPreferencesProvider, (previous, next) async {
      final scheduler = ref.read(notificationSchedulerProvider);

      next.whenData((preferences) async {
        if (preferences != null) {
          await scheduler.updateNotifications(preferences);
        }
      });
    });
  }
}

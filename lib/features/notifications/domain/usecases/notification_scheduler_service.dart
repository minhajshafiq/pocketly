import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:pocketly/features/notifications/domain/entities/notification_preferences_entity.dart';
import 'package:pocketly/core/services/logger_service.dart';

/// Service pour programmer les notifications récurrentes
/// Gère les rappels de fin de mois, résumés hebdomadaires et rapports mensuels
class NotificationSchedulerService {
  final FlutterLocalNotificationsPlugin _notificationsPlugin;
  final LoggerService _logger;

  // IDs de notification pour éviter les doublons
  static const int monthEndReminderId = 1000;
  static const int weeklySummaryId = 2000;
  static const int monthlyReportId = 3000;

  NotificationSchedulerService({
    required FlutterLocalNotificationsPlugin notificationsPlugin,
    required LoggerService logger,
  })  : _notificationsPlugin = notificationsPlugin,
        _logger = logger;

  /// Configure toutes les notifications récurrentes selon les préférences
  Future<void> scheduleRecurringNotifications(
    NotificationPreferencesEntity preferences,
  ) async {
    try {
      // Annuler toutes les notifications programmées existantes
      await cancelAllRecurringNotifications();

      // Programmer chaque type de notification si activé
      if (preferences.monthEndReminderEnabled) {
        await _scheduleMonthEndReminder();
      }

      if (preferences.weeklySummaryEnabled) {
        await _scheduleWeeklySummary();
      }

      if (preferences.monthlyReportEnabled) {
        await _scheduleMonthlyReport();
      }

      _logger.i('Notifications récurrentes programmées avec succès');
    } catch (e, stack) {
      _logger.e(
        'Erreur lors de la programmation des notifications récurrentes',
        error: e,
        stackTrace: stack,
      );
      rethrow;
    }
  }

  /// Programme le rappel de fin de mois (5 jours avant la fin du mois)
  Future<void> _scheduleMonthEndReminder() async {
    final now = DateTime.now();
    final location = tz.local;

    // Calculer la date de rappel : 5 jours avant la fin du mois
    final lastDayOfMonth = DateTime(now.year, now.month + 1, 0);
    final reminderDay = lastDayOfMonth.day - 5;

    var reminderDateTime = DateTime(
      now.year,
      now.month,
      reminderDay,
      20, // 20h00
      0,
    );

    // Si la date est déjà passée, programmer pour le mois prochain
    if (reminderDateTime.isBefore(now)) {
      final nextMonth = now.month == 12 ? 1 : now.month + 1;
      final nextYear = now.month == 12 ? now.year + 1 : now.year;
      final nextMonthLastDay = DateTime(nextYear, nextMonth + 1, 0);
      final nextReminderDay = nextMonthLastDay.day - 5;

      reminderDateTime = DateTime(
        nextYear,
        nextMonth,
        nextReminderDay,
        20,
        0,
      );
    }

    // Convertir en TZDateTime
    final reminderDate = tz.TZDateTime.from(reminderDateTime, location);

    await _notificationsPlugin.zonedSchedule(
      monthEndReminderId,
      'Rappel fin de mois',
      'Il reste 5 jours avant la fin du mois. Vérifiez vos dépenses !',
      reminderDate,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'month_end_reminder',
          'Rappels fin de mois',
          channelDescription: 'Notifications de rappel de fin de mois',
          importance: Importance.high,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.dayOfMonthAndTime,
    );

    _logger.i('Rappel de fin de mois programmé pour: $reminderDate');
  }

  /// Programme le résumé hebdomadaire (tous les dimanches à 19h)
  Future<void> _scheduleWeeklySummary() async {
    final now = DateTime.now();
    final location = tz.local;

    // Trouver le prochain dimanche à 19h
    var scheduledDateTime = DateTime(
      now.year,
      now.month,
      now.day,
      19, // 19h00
      0,
    );

    // Calculer le nombre de jours jusqu'au prochain dimanche
    final daysUntilSunday = (DateTime.sunday - now.weekday) % 7;

    if (daysUntilSunday > 0 || (daysUntilSunday == 0 && now.hour >= 19)) {
      final daysToAdd = daysUntilSunday == 0 ? 7 : daysUntilSunday;
      scheduledDateTime = scheduledDateTime.add(Duration(days: daysToAdd));
    }

    // Convertir en TZDateTime
    final scheduledDate = tz.TZDateTime.from(scheduledDateTime, location);

    await _notificationsPlugin.zonedSchedule(
      weeklySummaryId,
      'Résumé hebdomadaire',
      'Votre semaine financière en un coup d\'œil',
      scheduledDate,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'weekly_summary',
          'Résumés hebdomadaires',
          channelDescription: 'Résumés hebdomadaires de vos finances',
          importance: Importance.defaultImportance,
          priority: Priority.defaultPriority,
        ),
        iOS: DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
    );

    _logger.i('Résumé hebdomadaire programmé pour: $scheduledDate');
  }

  /// Programme le rapport mensuel (le 1er de chaque mois à 10h)
  Future<void> _scheduleMonthlyReport() async {
    final now = DateTime.now();
    final location = tz.local;

    // Programmer pour le 1er du mois prochain à 10h
    var scheduledDateTime = DateTime(
      now.year,
      now.month,
      1,
      10, // 10h00
      0,
    );

    // Si on est déjà passé le 1er ou si c'est le 1er après 10h, passer au mois suivant
    if (scheduledDateTime.isBefore(now) ||
        (now.day == 1 && now.hour >= 10)) {
      scheduledDateTime = DateTime(
        now.month == 12 ? now.year + 1 : now.year,
        now.month == 12 ? 1 : now.month + 1,
        1,
        10,
        0,
      );
    }

    // Convertir en TZDateTime
    final scheduledDate = tz.TZDateTime.from(scheduledDateTime, location);

    await _notificationsPlugin.zonedSchedule(
      monthlyReportId,
      'Rapport mensuel',
      'Votre bilan financier du mois est disponible',
      scheduledDate,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'monthly_report',
          'Rapports mensuels',
          channelDescription: 'Rapports mensuels détaillés de vos finances',
          importance: Importance.high,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.dayOfMonthAndTime,
    );

    _logger.i('Rapport mensuel programmé pour: $scheduledDate');
  }

  /// Annule toutes les notifications récurrentes
  Future<void> cancelAllRecurringNotifications() async {
    try {
      await Future.wait([
        _notificationsPlugin.cancel(monthEndReminderId),
        _notificationsPlugin.cancel(weeklySummaryId),
        _notificationsPlugin.cancel(monthlyReportId),
      ]);

      _logger.i('Toutes les notifications récurrentes ont été annulées');
    } catch (e, stack) {
      _logger.e(
        'Erreur lors de l\'annulation des notifications récurrentes',
        error: e,
        stackTrace: stack,
      );
      rethrow;
    }
  }

  /// Annule une notification spécifique
  Future<void> cancelNotification(int id) async {
    try {
      await _notificationsPlugin.cancel(id);
      _logger.i('Notification $id annulée');
    } catch (e, stack) {
      _logger.e(
        'Erreur lors de l\'annulation de la notification $id',
        error: e,
        stackTrace: stack,
      );
      rethrow;
    }
  }

  /// Met à jour les notifications selon les nouvelles préférences
  Future<void> updateNotifications(
    NotificationPreferencesEntity preferences,
  ) async {
    await scheduleRecurringNotifications(preferences);
  }
}

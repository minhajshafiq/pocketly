import 'package:flutter/material.dart' show Color;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:pocketly/core/services/logger_service.dart';
import 'package:pocketly/features/notifications/domain/entities/app_notification_entity.dart';
import 'package:pocketly/features/notifications/domain/entities/notification_preferences_entity.dart';

/// Service pour surveiller les dépassements de budget
/// Déclenche des notifications lorsqu'un budget de pocket est dépassé
class BudgetMonitorService {
  final FlutterLocalNotificationsPlugin _notificationsPlugin;
  final LoggerService _logger;

  BudgetMonitorService({
    required FlutterLocalNotificationsPlugin notificationsPlugin,
    required LoggerService logger,
  })  : _notificationsPlugin = notificationsPlugin,
        _logger = logger;

  /// Vérifie si un budget est dépassé et envoie une notification si nécessaire
  Future<void> checkBudgetExceeded({
    required String pocketId,
    required String pocketName,
    required double budget,
    required double currentAmount,
    required NotificationPreferencesEntity preferences,
  }) async {
    // Vérifier si les notifications de dépassement de budget sont activées
    if (!preferences.budgetExceededEnabled) {
      return;
    }

    // Vérifier si le budget est dépassé
    if (currentAmount <= budget) {
      return;
    }

    try {
      final excess = currentAmount - budget;
      final excessPercentage = ((excess / budget) * 100).toStringAsFixed(0);

      await _sendBudgetExceededNotification(
        pocketId: pocketId,
        pocketName: pocketName,
        excess: excess,
        excessPercentage: excessPercentage,
      );

      _logger.i(
        'Notification de dépassement de budget envoyée pour le pocket $pocketName',
      );
    } catch (e, stack) {
      _logger.e(
        'Erreur lors de l\'envoi de la notification de dépassement de budget',
        error: e,
        stackTrace: stack,
      );
      rethrow;
    }
  }

  /// Envoie une notification de dépassement de budget
  Future<void> _sendBudgetExceededNotification({
    required String pocketId,
    required String pocketName,
    required double excess,
    required String excessPercentage,
  }) async {
    // Générer un ID unique basé sur le pocket ID
    final notificationId = pocketId.hashCode;

    final androidDetails = AndroidNotificationDetails(
      'budget_exceeded',
      'Dépassements de budget',
      channelDescription:
          'Notifications de dépassement de budget des pockets',
      importance: Importance.high,
      priority: Priority.high,
      styleInformation: const BigTextStyleInformation(''),
      color: const Color(0xFFEF4444), // Rouge pour l'alerte
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
      interruptionLevel: InterruptionLevel.timeSensitive,
    );

    final notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _notificationsPlugin.show(
      notificationId,
      'Budget dépassé : $pocketName',
      'Votre budget a été dépassé de ${excess.toStringAsFixed(2)}€ (+$excessPercentage%)',
      notificationDetails,
      payload: 'budget_exceeded:$pocketId',
    );
  }

  /// Vérifie si un seuil d'alerte est atteint (par exemple 80% du budget)
  Future<void> checkBudgetWarning({
    required String pocketId,
    required String pocketName,
    required double budget,
    required double currentAmount,
    required NotificationPreferencesEntity preferences,
    double warningThreshold = 0.8, // 80% par défaut
  }) async {
    // Vérifier si les notifications de dépassement de budget sont activées
    if (!preferences.budgetExceededEnabled) {
      return;
    }

    final percentage = currentAmount / budget;

    // Vérifier si le seuil d'alerte est atteint mais pas encore dépassé
    if (percentage >= warningThreshold && percentage < 1.0) {
      try {
        await _sendBudgetWarningNotification(
          pocketId: pocketId,
          pocketName: pocketName,
          percentage: (percentage * 100).toStringAsFixed(0),
          remaining: budget - currentAmount,
        );

        _logger.i(
          'Notification d\'alerte de budget envoyée pour le pocket $pocketName',
        );
      } catch (e, stack) {
        _logger.e(
          'Erreur lors de l\'envoi de la notification d\'alerte de budget',
          error: e,
          stackTrace: stack,
        );
        rethrow;
      }
    }
  }

  /// Envoie une notification d'alerte de budget
  Future<void> _sendBudgetWarningNotification({
    required String pocketId,
    required String pocketName,
    required String percentage,
    required double remaining,
  }) async {
    // Générer un ID unique basé sur le pocket ID (différent de celui du dépassement)
    final notificationId = pocketId.hashCode + 1;

    final androidDetails = AndroidNotificationDetails(
      'budget_warning',
      'Alertes de budget',
      channelDescription: 'Notifications d\'alerte de budget des pockets',
      importance: Importance.defaultImportance,
      priority: Priority.defaultPriority,
      styleInformation: const BigTextStyleInformation(''),
      color: const Color(0xFFF59E0B), // Orange pour l'avertissement
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    final notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _notificationsPlugin.show(
      notificationId,
      'Alerte budget : $pocketName',
      'Vous avez utilisé $percentage% de votre budget. Il reste ${remaining.toStringAsFixed(2)}€',
      notificationDetails,
      payload: 'budget_warning:$pocketId',
    );
  }

  /// Crée une entité de notification pour l'historique
  AppNotificationEntity createBudgetExceededNotificationEntity({
    required String userId,
    required String pocketId,
    required String pocketName,
    required double excess,
  }) {
    return AppNotificationEntity(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      userId: userId,
      title: 'Budget dépassé',
      message:
          'Votre budget $pocketName a été dépassé de ${excess.toStringAsFixed(2)}€',
      type: AppNotificationType.budgetExceeded,
      createdAt: DateTime.now(),
      isRead: false,
      relatedEntityId: pocketId,
    );
  }
}

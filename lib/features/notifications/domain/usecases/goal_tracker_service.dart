import 'package:flutter/material.dart' show Color;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:pocketly/core/services/logger_service.dart';
import 'package:pocketly/features/notifications/domain/entities/app_notification_entity.dart';
import 'package:pocketly/features/notifications/domain/entities/notification_preferences_entity.dart';

/// Service pour suivre les objectifs d'épargne
/// Déclenche des notifications lorsqu'un objectif est atteint ou proche d'être atteint
class GoalTrackerService {
  final FlutterLocalNotificationsPlugin _notificationsPlugin;
  final LoggerService _logger;

  GoalTrackerService({
    required FlutterLocalNotificationsPlugin notificationsPlugin,
    required LoggerService logger,
  })  : _notificationsPlugin = notificationsPlugin,
        _logger = logger;

  /// Vérifie si un objectif est atteint et envoie une notification si nécessaire
  Future<void> checkGoalReached({
    required String pocketId,
    required String pocketName,
    required double goalAmount,
    required double currentAmount,
    required NotificationPreferencesEntity preferences,
  }) async {
    // Vérifier si les notifications d'objectifs atteints sont activées
    if (!preferences.goalReachedEnabled) {
      return;
    }

    // Vérifier si l'objectif est atteint
    if (currentAmount < goalAmount) {
      return;
    }

    try {
      await _sendGoalReachedNotification(
        pocketId: pocketId,
        pocketName: pocketName,
        goalAmount: goalAmount,
        currentAmount: currentAmount,
      );

      _logger.i(
        'Notification d\'objectif atteint envoyée pour le pocket $pocketName',
      );
    } catch (e, stack) {
      _logger.e(
        'Erreur lors de l\'envoi de la notification d\'objectif atteint',
        error: e,
        stackTrace: stack,
      );
      rethrow;
    }
  }

  /// Envoie une notification d'objectif atteint
  Future<void> _sendGoalReachedNotification({
    required String pocketId,
    required String pocketName,
    required double goalAmount,
    required double currentAmount,
  }) async {
    // Générer un ID unique basé sur le pocket ID
    final notificationId = pocketId.hashCode + 100;

    final androidDetails = AndroidNotificationDetails(
      'goal_reached',
      'Objectifs atteints',
      channelDescription: 'Notifications d\'objectifs d\'épargne atteints',
      importance: Importance.high,
      priority: Priority.high,
      styleInformation: const BigTextStyleInformation(''),
      color: const Color(0xFF10B981), // Vert pour le succès
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

    final excess = currentAmount - goalAmount;
    final message = excess > 0
        ? 'Félicitations ! Vous avez atteint votre objectif de ${goalAmount.toStringAsFixed(2)}€ (+${excess.toStringAsFixed(2)}€) !'
        : 'Félicitations ! Vous avez atteint votre objectif de ${goalAmount.toStringAsFixed(2)}€ !';

    await _notificationsPlugin.show(
      notificationId,
      '🎉 Objectif atteint : $pocketName',
      message,
      notificationDetails,
      payload: 'goal_reached:$pocketId',
    );
  }

  /// Vérifie si un objectif est proche d'être atteint (par exemple 90%)
  Future<void> checkGoalProgress({
    required String pocketId,
    required String pocketName,
    required double goalAmount,
    required double currentAmount,
    required NotificationPreferencesEntity preferences,
    double progressThreshold = 0.9, // 90% par défaut
  }) async {
    // Vérifier si les notifications d'objectifs sont activées
    if (!preferences.goalReachedEnabled) {
      return;
    }

    final percentage = currentAmount / goalAmount;

    // Vérifier si le seuil de progression est atteint mais pas encore l'objectif final
    if (percentage >= progressThreshold && percentage < 1.0) {
      try {
        await _sendGoalProgressNotification(
          pocketId: pocketId,
          pocketName: pocketName,
          percentage: (percentage * 100).toStringAsFixed(0),
          remaining: goalAmount - currentAmount,
        );

        _logger.i(
          'Notification de progression d\'objectif envoyée pour le pocket $pocketName',
        );
      } catch (e, stack) {
        _logger.e(
          'Erreur lors de l\'envoi de la notification de progression d\'objectif',
          error: e,
          stackTrace: stack,
        );
        rethrow;
      }
    }
  }

  /// Envoie une notification de progression vers l'objectif
  Future<void> _sendGoalProgressNotification({
    required String pocketId,
    required String pocketName,
    required String percentage,
    required double remaining,
  }) async {
    // Générer un ID unique basé sur le pocket ID (différent de celui de l'objectif atteint)
    final notificationId = pocketId.hashCode + 101;

    final androidDetails = AndroidNotificationDetails(
      'goal_progress',
      'Progression des objectifs',
      channelDescription: 'Notifications de progression des objectifs d\'épargne',
      importance: Importance.defaultImportance,
      priority: Priority.defaultPriority,
      styleInformation: const BigTextStyleInformation(''),
      color: const Color(0xFF3B82F6), // Bleu pour l'information
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
      'Presque là ! $pocketName',
      'Vous avez atteint $percentage% de votre objectif. Plus que ${remaining.toStringAsFixed(2)}€ !',
      notificationDetails,
      payload: 'goal_progress:$pocketId',
    );
  }

  /// Crée une entité de notification pour l'historique
  AppNotificationEntity createGoalReachedNotificationEntity({
    required String userId,
    required String pocketId,
    required String pocketName,
    required double goalAmount,
  }) {
    return AppNotificationEntity(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      userId: userId,
      title: 'Objectif atteint !',
      message:
          'Félicitations ! Vous avez atteint votre objectif d\'épargne $pocketName (${goalAmount.toStringAsFixed(2)}€)',
      type: AppNotificationType.goalReached,
      createdAt: DateTime.now(),
      isRead: false,
      relatedEntityId: pocketId,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:pocketly/features/notifications/domain/usecases/in_app_notification_service.dart';

/// Helper widget pour faciliter l'utilisation des notifications in-app
class NotificationHelper {
  /// Afficher une notification de succès pour les permissions
  static void showPermissionSuccess(BuildContext context) {
    InAppNotificationService.showSuccess(context);
  }

  /// Afficher une notification d'erreur pour les permissions
  static void showPermissionError(BuildContext context) {
    InAppNotificationService.showError(context);
  }

  /// Afficher une notification de succès pour l'envoi
  static void showNotificationSent(BuildContext context) {
    InAppNotificationService.showSuccess(context);
  }

  /// Afficher une notification de succès pour la planification
  static void showNotificationScheduled(BuildContext context) {
    InAppNotificationService.showInfo(context);
  }

  /// Afficher une notification de succès pour l'annulation
  static void showNotificationCancelled(BuildContext context) {
    InAppNotificationService.showInfo(context);
  }

  /// Afficher une notification d'erreur générique
  static void showGenericError(BuildContext context, String error) {
    InAppNotificationService.showError(
      context,
      message: error,
    );
  }

  /// Afficher une notification de chargement
  static void showLoading(BuildContext context, String message) {
    InAppNotificationService.showLoading(
      context,
      message: message,
    );
  }

  /// Afficher une notification avec action pour les paramètres
  static Future<bool?> showSettingsAction(BuildContext context) {
    return InAppNotificationService.showAction<bool>(
      context,
      onButtonPressed: () {
        // Ici vous pouvez ouvrir les paramètres de l'appareil
        // Le Flushbar se fermera automatiquement avec la valeur true
      },
    );
  }
}

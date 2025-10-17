import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocketly/core/errors/errors.dart';
import 'package:pocketly/features/notifications/domain/entities/notification_entity.dart';
import 'package:pocketly/features/notifications/presentation/providers/notification_providers.dart';
import 'package:pocketly/generated/l10n/app_localizations.dart';

/// Example of how to use the notification system
class NotificationExample {
  /// Schedule a reminder notification
  static Future<bool> scheduleReminderNotification({
    required WidgetRef ref,
    required BuildContext context,
    required int id,
    required String title,
    required String body,
    required DateTime scheduledDate,
  }) async {
    try {
      final notificationService = ref.read(notificationServiceProvider);
      
      // Check if we have permissions first
      final hasPermission = await ref.read(notificationPermissionStateProvider.future);
      if (!hasPermission) {
        final granted = await notificationService.requestPermissions();
        if (!granted) {
          if (context.mounted) {
            final s = AppLocalizations.of(context)!;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(s.notificationPermissionDenied)),
            );
          }
          return false;
        }
      }
      
      // Create the notification entity
      final notification = NotificationEntity(
        id: id,
        title: title,
        body: body,
        scheduledDate: scheduledDate,
      );
      
      // Schedule the notification
      final result = await notificationService.scheduleNotification(notification);
      
      if (context.mounted && result) {
        final s = AppLocalizations.of(context)!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(s.notificationScheduled)),
        );
      }
      
      return result;
    } catch (e, stackTrace) {
      // Utiliser le système d'erreur global
      ref.read(errorNotifierProvider.notifier).setError(e, stackTrace);
      
      // Afficher un message d'erreur à l'utilisateur
      if (context.mounted) {
        final s = AppLocalizations.of(context)!;
        final errorMessage = e is AppError 
          ? ErrorLocalization.getLocalizedUserMessage(e, context)
          : e.toString();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${s.error}: $errorMessage'),
            backgroundColor: Colors.red,
          ),
        );
      }
      
      return false;
    }
  }
  
  /// Show an immediate notification
  static Future<bool> showImmediateNotification({
    required WidgetRef ref,
    required BuildContext context,
    required int id,
    required String title,
    required String body,
  }) async {
    try {
      final notificationService = ref.read(notificationServiceProvider);
      
      // Check if we have permissions first
      final hasPermission = await ref.read(notificationPermissionStateProvider.future);
      if (!hasPermission) {
        final granted = await notificationService.requestPermissions();
        if (!granted) {
          if (context.mounted) {
            final s = AppLocalizations.of(context)!;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(s.notificationPermissionDenied)),
            );
          }
          return false;
        }
      }
      
      // Create the notification entity
      final notification = NotificationEntity(
        id: id,
        title: title,
        body: body,
      );
      
      // Show the notification
      return await notificationService.showNotification(notification);
    } catch (e, stackTrace) {
      // Utiliser le système d'erreur global
      ref.read(errorNotifierProvider.notifier).setError(e, stackTrace);
      
      // Afficher un message d'erreur à l'utilisateur
      if (context.mounted) {
        final s = AppLocalizations.of(context)!;
        final errorMessage = e is AppError 
          ? ErrorLocalization.getLocalizedUserMessage(e, context)
          : e.toString();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${s.error}: $errorMessage'),
            backgroundColor: Colors.red,
          ),
        );
      }
      
      return false;
    }
  }
  
  /// Cancel a specific notification
  static Future<bool> cancelNotification({
    required WidgetRef ref,
    required BuildContext context,
    required int id,
  }) async {
    try {
      final notificationService = ref.read(notificationServiceProvider);
      return await notificationService.cancelNotification(id);
    } catch (e, stackTrace) {
      // Utiliser le système d'erreur global
      ref.read(errorNotifierProvider.notifier).setError(e, stackTrace);
      
      // Afficher un message d'erreur à l'utilisateur
      if (context.mounted) {
        final s = AppLocalizations.of(context)!;
        final errorMessage = e is AppError 
          ? ErrorLocalization.getLocalizedUserMessage(e, context)
          : e.toString();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${s.error}: $errorMessage'),
            backgroundColor: Colors.red,
          ),
        );
      }
      
      return false;
    }
  }
  
  /// Cancel all notifications
  static Future<bool> cancelAllNotifications({
    required WidgetRef ref,
    required BuildContext context,
  }) async {
    try {
      final notificationService = ref.read(notificationServiceProvider);
      return await notificationService.cancelAllNotifications();
    } catch (e, stackTrace) {
      // Utiliser le système d'erreur global
      ref.read(errorNotifierProvider.notifier).setError(e, stackTrace);
      
      // Afficher un message d'erreur à l'utilisateur
      if (context.mounted) {
        final s = AppLocalizations.of(context)!;
        final errorMessage = e is AppError 
          ? ErrorLocalization.getLocalizedUserMessage(e, context)
          : e.toString();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${s.error}: $errorMessage'),
            backgroundColor: Colors.red,
          ),
        );
      }
      
      return false;
    }
  }
}
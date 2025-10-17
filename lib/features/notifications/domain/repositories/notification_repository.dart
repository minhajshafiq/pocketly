import 'package:pocketly/features/notifications/domain/entities/notification_entity.dart';

/// Interface for notification repository
abstract class NotificationRepository {
  /// Check if notification permissions are granted
  Future<bool> checkPermissions();
  
  /// Request notification permissions
  Future<bool> requestPermissions();
  
  /// Schedule a notification
  Future<bool> scheduleNotification(NotificationEntity notification);
  
  /// Show an immediate notification
  Future<bool> showNotification(NotificationEntity notification);
  
  /// Cancel a specific notification by id
  Future<bool> cancelNotification(int id);
  
  /// Cancel all scheduled notifications
  Future<bool> cancelAllNotifications();
  
  /// Get the device's timezone
  Future<String> getDeviceTimeZone();
}

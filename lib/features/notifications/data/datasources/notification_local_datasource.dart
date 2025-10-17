import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pocketly/core/errors/errors.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

/// Local data source for notifications
class NotificationLocalDataSource {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  
  NotificationLocalDataSource({
    required this.flutterLocalNotificationsPlugin,
  });
  
  /// Initialize notifications
  Future<void> initialize() async {
    // Initialize time zones
    tz.initializeTimeZones();
    
    // Gestion d'erreur pour le timezone
    try {
      final timeZoneInfo = await FlutterTimezone.getLocalTimezone();
      final String timeZone = timeZoneInfo.toString();
      tz.setLocalLocation(tz.getLocation(timeZone));
    } catch (e) {
      debugPrint('Warning: Could not get timezone, using UTC: $e');
      tz.setLocalLocation(tz.UTC);
    }
    
    // Initialize notification settings
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
        
    final DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );
    
    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _onNotificationTap,
    );
  }
  
  void _onNotificationTap(NotificationResponse response) {
    // Handle notification tap
    debugPrint('Notification tapped: ${response.payload}');
  }
  
  /// Check if notification permissions are granted
  Future<bool> checkPermissions() async {
    try {
      // For iOS, check through flutter_local_notifications
      final iosPermissions = await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.checkPermissions();
      
      // For Android, use permission_handler
      final androidStatus = await Permission.notification.status;
      
      // Return true if both platforms have permissions
      return (iosPermissions?.isEnabled ?? false) && androidStatus.isGranted;
    } catch (e) {
      debugPrint('Error checking notification permissions: $e');
      // Fallback to permission_handler only
      final status = await Permission.notification.status;
      return status.isGranted;
    }
  }
  
  /// Request notification permissions
  Future<bool> requestPermissions() async {
    try {
      // Check current status first
      final currentStatus = await Permission.notification.status;
      debugPrint('Current permission status: $currentStatus');
      
      // If already granted, return true
      if (currentStatus.isGranted) {
        return true;
      }
      
      // If permanently denied, don't throw error, just return false
      if (currentStatus.isPermanentlyDenied) {
        debugPrint('Permission permanently denied');
        return false;
      }
      
      // Request permissions
      final status = await Permission.notification.request();
      debugPrint('Permission request result: $status');
      
      if (status.isGranted) {
        // For iOS, also request through flutter_local_notifications
        final iosResult = await flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
                IOSFlutterLocalNotificationsPlugin>()
            ?.requestPermissions(
              alert: true,
              badge: true,
              sound: true,
            );
        
        debugPrint('iOS permission result: $iosResult');
        return iosResult ?? true; // Default to true if iOS check fails
      }
      
      return status.isGranted;
    } catch (e) {
      debugPrint('Error requesting permissions: $e');
      
      // Don't throw error, just return false
      return false;
    }
  }
  
  /// Schedule a notification
  Future<bool> scheduleNotification({
    required int id,
    required String title,
    required String body,
    String? payload,
    required DateTime scheduledDate,
  }) async {
    try {
      await flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        title,
        body,
        tz.TZDateTime.from(scheduledDate, tz.local),
        _notificationDetails(),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        matchDateTimeComponents: DateTimeComponents.time,
        payload: payload,
      );
      return true;
    } catch (e, stackTrace) {
      debugPrint('Error scheduling notification: $e');
      // Lancer une exception qui sera traitée par le ErrorHandler
      throw NotificationScheduleError(
        technicalMessage: 'Failed to schedule notification: $e',
        originalError: e,
        stackTrace: stackTrace,
      );
    }
  }
  
  /// Show an immediate notification
  Future<bool> showNotification({
    required int id,
    required String title,
    required String body,
    String? payload,
  }) async {
    try {
      await flutterLocalNotificationsPlugin.show(
        id,
        title,
        body,
        _notificationDetails(),
        payload: payload,
      );
      return true;
    } catch (e, stackTrace) {
      debugPrint('Error showing notification: $e');
      throw NotificationShowError(
        technicalMessage: 'Failed to show notification: $e',
        originalError: e,
        stackTrace: stackTrace,
      );
    }
  }
  
  /// Cancel a specific notification by id
  Future<bool> cancelNotification(int id) async {
    try {
      await flutterLocalNotificationsPlugin.cancel(id);
      return true;
    } catch (e, stackTrace) {
      debugPrint('Error cancelling notification: $e');
      throw NotificationCancelError(
        technicalMessage: 'Failed to cancel notification: $e',
        originalError: e,
        stackTrace: stackTrace,
      );
    }
  }
  
  /// Cancel all scheduled notifications
  Future<bool> cancelAllNotifications() async {
    try {
      await flutterLocalNotificationsPlugin.cancelAll();
      return true;
    } catch (e, stackTrace) {
      debugPrint('Error cancelling all notifications: $e');
      throw NotificationCancelError(
        technicalMessage: 'Failed to cancel all notifications: $e',
        originalError: e,
        stackTrace: stackTrace,
      );
    }
  }
  
  /// Get the device's timezone
  Future<String> getDeviceTimeZone() async {
    try {
      final timeZoneInfo = await FlutterTimezone.getLocalTimezone();
      return timeZoneInfo.toString();
    } catch (e) {
      debugPrint('Warning: Could not get timezone: $e');
      return 'UTC';
    }
  }
  
  /// Create notification details
  NotificationDetails _notificationDetails() {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'pocketly_channel',
      'Pocketly Notifications',
      channelDescription: 'Notifications from Pocketly app',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );
    
    const DarwinNotificationDetails iosNotificationDetails =
        DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );
    
    return const NotificationDetails(
      android: androidNotificationDetails,
      iOS: iosNotificationDetails,
    );
  }
}
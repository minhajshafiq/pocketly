import 'package:pocketly/features/notifications/domain/entities/notification_entity.dart';

/// Data model for notification
/// Since NotificationEntity is a sealed class, we use a factory to create entities
class NotificationModel {
  /// Convert entity to JSON
  static Map<String, dynamic> toJson(NotificationEntity entity) {
    return {
      'id': entity.id,
      'title': entity.title,
      'body': entity.body,
      'payload': entity.payload,
      'scheduledDate': entity.scheduledDate?.toIso8601String(),
    };
  }
  
  /// Create entity from JSON
  static NotificationEntity fromJson(Map<String, dynamic> json) {
    return NotificationEntity(
      id: json['id'] as int,
      title: json['title'] as String,
      body: json['body'] as String,
      payload: json['payload'] as String?,
      scheduledDate: json['scheduledDate'] != null
          ? DateTime.parse(json['scheduledDate'] as String)
          : null,
    );
  }
}

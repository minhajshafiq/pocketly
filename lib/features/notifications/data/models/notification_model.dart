import 'package:pocketly/features/notifications/domain/entities/notification_entity.dart';

/// Data model for notification
class NotificationModel extends NotificationEntity {
  const NotificationModel({
    required super.id,
    required super.title,
    required super.body,
    super.payload,
    super.scheduledDate,
  });
  
  /// Create a model from an entity
  factory NotificationModel.fromEntity(NotificationEntity entity) {
    return NotificationModel(
      id: entity.id,
      title: entity.title,
      body: entity.body,
      payload: entity.payload,
      scheduledDate: entity.scheduledDate,
    );
  }
  
  /// Convert model to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'payload': payload,
      'scheduledDate': scheduledDate?.toIso8601String(),
    };
  }
  
  /// Create model from JSON
  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'],
      title: json['title'],
      body: json['body'],
      payload: json['payload'],
      scheduledDate: json['scheduledDate'] != null
          ? DateTime.parse(json['scheduledDate'])
          : null,
    );
  }
}

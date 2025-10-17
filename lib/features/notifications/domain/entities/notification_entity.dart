import 'package:flutter/foundation.dart';

/// Entity representing a notification in the application
@immutable
class NotificationEntity {
  final int id;
  final String title;
  final String body;
  final String? payload;
  final DateTime? scheduledDate;
  
  const NotificationEntity({
    required this.id,
    required this.title,
    required this.body,
    this.payload,
    this.scheduledDate,
  });
  
  NotificationEntity copyWith({
    int? id,
    String? title,
    String? body,
    String? payload,
    DateTime? scheduledDate,
    bool clearScheduledDate = false,
  }) {
    return NotificationEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      payload: payload ?? this.payload,
      scheduledDate: clearScheduledDate ? null : scheduledDate ?? this.scheduledDate,
    );
  }
}

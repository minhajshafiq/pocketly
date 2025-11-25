import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_entity.freezed.dart';
part 'notification_entity.g.dart';

/// Entity representing a notification in the application
@freezed
sealed class NotificationEntity with _$NotificationEntity {
  const factory NotificationEntity({
    /// Unique identifier for the notification
    required int id,

    /// Title of the notification
    required String title,

    /// Body text of the notification
    required String body,

    /// Optional payload data for the notification
    @Default(null) String? payload,

    /// Optional scheduled date for the notification
    @Default(null) DateTime? scheduledDate,
  }) = _NotificationEntity;

  factory NotificationEntity.fromJson(Map<String, dynamic> json) =>
      _$NotificationEntityFromJson(json);
}

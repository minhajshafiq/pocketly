// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_notification_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AppNotificationEntity _$AppNotificationEntityFromJson(
  Map<String, dynamic> json,
) => _AppNotificationEntity(
  id: json['id'] as String,
  userId: json['userId'] as String,
  title: json['title'] as String,
  message: json['message'] as String,
  type: $enumDecode(_$AppNotificationTypeEnumMap, json['type']),
  createdAt: DateTime.parse(json['createdAt'] as String),
  isRead: json['isRead'] as bool? ?? false,
  payload: json['payload'] as String?,
  relatedEntityId: json['relatedEntityId'] as String?,
);

Map<String, dynamic> _$AppNotificationEntityToJson(
  _AppNotificationEntity instance,
) => <String, dynamic>{
  'id': instance.id,
  'userId': instance.userId,
  'title': instance.title,
  'message': instance.message,
  'type': _$AppNotificationTypeEnumMap[instance.type]!,
  'createdAt': instance.createdAt.toIso8601String(),
  'isRead': instance.isRead,
  'payload': instance.payload,
  'relatedEntityId': instance.relatedEntityId,
};

const _$AppNotificationTypeEnumMap = {
  AppNotificationType.budgetExceeded: 'budgetExceeded',
  AppNotificationType.goalReached: 'goalReached',
  AppNotificationType.monthEndReminder: 'monthEndReminder',
  AppNotificationType.weeklySummary: 'weeklySummary',
  AppNotificationType.monthlyReport: 'monthlyReport',
  AppNotificationType.general: 'general',
};

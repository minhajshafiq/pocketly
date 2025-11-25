// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_preferences_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NotificationPreferencesEntity _$NotificationPreferencesEntityFromJson(
  Map<String, dynamic> json,
) => _NotificationPreferencesEntity(
  userId: json['userId'] as String,
  budgetExceededEnabled: json['budgetExceededEnabled'] as bool? ?? true,
  goalReachedEnabled: json['goalReachedEnabled'] as bool? ?? true,
  monthEndReminderEnabled: json['monthEndReminderEnabled'] as bool? ?? true,
  weeklySummaryEnabled: json['weeklySummaryEnabled'] as bool? ?? true,
  monthlyReportEnabled: json['monthlyReportEnabled'] as bool? ?? true,
);

Map<String, dynamic> _$NotificationPreferencesEntityToJson(
  _NotificationPreferencesEntity instance,
) => <String, dynamic>{
  'userId': instance.userId,
  'budgetExceededEnabled': instance.budgetExceededEnabled,
  'goalReachedEnabled': instance.goalReachedEnabled,
  'monthEndReminderEnabled': instance.monthEndReminderEnabled,
  'weeklySummaryEnabled': instance.weeklySummaryEnabled,
  'monthlyReportEnabled': instance.monthlyReportEnabled,
};

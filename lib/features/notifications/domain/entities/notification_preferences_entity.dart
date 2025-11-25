import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_preferences_entity.freezed.dart';
part 'notification_preferences_entity.g.dart';

/// Entity représentant les préférences de notifications de l'utilisateur
@freezed
sealed class NotificationPreferencesEntity with _$NotificationPreferencesEntity {
  const factory NotificationPreferencesEntity({
    required String userId,
    @Default(true) bool budgetExceededEnabled,
    @Default(true) bool goalReachedEnabled,
    @Default(true) bool monthEndReminderEnabled,
    @Default(true) bool weeklySummaryEnabled,
    @Default(true) bool monthlyReportEnabled,
  }) = _NotificationPreferencesEntity;

  factory NotificationPreferencesEntity.fromJson(Map<String, dynamic> json) =>
      _$NotificationPreferencesEntityFromJson(json);
}

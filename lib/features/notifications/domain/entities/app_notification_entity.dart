import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_notification_entity.freezed.dart';
part 'app_notification_entity.g.dart';

/// Types de notifications dans l'application
enum AppNotificationType {
  budgetExceeded,
  goalReached,
  monthEndReminder,
  weeklySummary,
  monthlyReport,
  general;

  String getName(dynamic l10n) {
    return switch (this) {
      AppNotificationType.budgetExceeded => l10n.budgetExceededNotif,
      AppNotificationType.goalReached => l10n.goalReachedNotif,
      AppNotificationType.monthEndReminder => l10n.monthEndReminderNotif,
      AppNotificationType.weeklySummary => l10n.weeklySummaryNotif,
      AppNotificationType.monthlyReport => l10n.monthlyReportNotif,
      AppNotificationType.general => l10n.notifications,
    };
  }
}

/// Entity représentant une notification dans l'application
@freezed
sealed class AppNotificationEntity with _$AppNotificationEntity {
  const factory AppNotificationEntity({
    required String id,
    required String userId,
    required String title,
    required String message,
    required AppNotificationType type,
    required DateTime createdAt,
    @Default(false) bool isRead,
    String? payload,
    String? relatedEntityId, // ID de l'entité liée (pocket, transaction, etc.)
  }) = _AppNotificationEntity;

  factory AppNotificationEntity.fromJson(Map<String, dynamic> json) =>
      _$AppNotificationEntityFromJson(json);
}

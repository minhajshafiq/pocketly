import 'package:pocketly/core/errors/app_error.dart';

/// Erreur liée aux notifications
class NotificationError extends AppError {
  final String operation;
  final String? _userMessage;
  final String? _technicalMessage;
  @override
  final Object? originalError;
  @override
  final StackTrace? stackTrace;

  const NotificationError({
    required this.operation,
    String? userMessage,
    String? technicalMessage,
    this.originalError,
    this.stackTrace,
  })  : _userMessage = userMessage,
        _technicalMessage = technicalMessage;

  @override
  String get userMessage =>
      _userMessage ?? 'Problème avec les notifications.';

  @override
  String get technicalMessage =>
      _technicalMessage ?? 'Notification operation failed: $operation - $originalError';

  @override
  String get errorCode => 'NOTIFICATION_ERROR';

  @override
  ErrorSeverity get severity => ErrorSeverity.warning;
}

/// Erreur de permission de notification
class NotificationPermissionError extends NotificationError {
  const NotificationPermissionError({
    super.userMessage,
    super.technicalMessage,
    super.originalError,
    super.stackTrace,
  }) : super(
          operation: 'permission_request',
        );

  @override
  String get errorCode => 'NOTIFICATION_PERMISSION_DENIED';
}

/// Erreur de planification de notification
class NotificationScheduleError extends NotificationError {
  const NotificationScheduleError({
    super.userMessage,
    super.technicalMessage,
    super.originalError,
    super.stackTrace,
  }) : super(
          operation: 'schedule',
        );

  @override
  String get errorCode => 'NOTIFICATION_SCHEDULE_ERROR';
}

/// Erreur d'affichage de notification
class NotificationShowError extends NotificationError {
  const NotificationShowError({
    super.userMessage,
    super.technicalMessage,
    super.originalError,
    super.stackTrace,
  }) : super(
          operation: 'show',
        );

  @override
  String get errorCode => 'NOTIFICATION_SHOW_ERROR';
}

/// Erreur d'annulation de notification
class NotificationCancelError extends NotificationError {
  const NotificationCancelError({
    super.userMessage,
    super.technicalMessage,
    super.originalError,
    super.stackTrace,
  }) : super(
          operation: 'cancel',
        );

  @override
  String get errorCode => 'NOTIFICATION_CANCEL_ERROR';
}

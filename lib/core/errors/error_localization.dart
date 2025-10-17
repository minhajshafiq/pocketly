import 'package:flutter/material.dart';
import 'package:pocketly/core/errors/errors.dart';
import 'package:pocketly/generated/l10n/app_localizations.dart';

/// Classe utilitaire pour localiser les messages d'erreur
class ErrorLocalization {
  /// Obtient le message d'erreur localisé pour l'utilisateur
  static String getLocalizedUserMessage(AppError error, BuildContext context) {
    final s = AppLocalizations.of(context);
    
    switch (error.runtimeType) {
      case NotificationPermissionError _:
        return s?.notificationPermissionError ?? error.userMessage;
      case NotificationScheduleError _:
        return s?.notificationScheduleError ?? error.userMessage;
      case NotificationShowError _:
        return s?.notificationShowError ?? error.userMessage;
      case NotificationCancelError _:
        return s?.notificationCancelError ?? error.userMessage;
      case NetworkError _:
        return s?.error ?? error.userMessage;
      case AuthenticationError _:
        return s?.error ?? error.userMessage;
      case ValidationError _:
        return s?.error ?? error.userMessage;
      case ServerError _:
        return s?.error ?? error.userMessage;
      case NotFoundError _:
        return s?.error ?? error.userMessage;
      case PermissionError _:
        return s?.error ?? error.userMessage;
      case TimeoutError _:
        return s?.error ?? error.userMessage;
      case CacheError _:
        return s?.error ?? error.userMessage;
      case UnknownError _:
        return s?.error ?? error.userMessage;
      default:
        return error.userMessage;
    }
  }
  
  /// Obtient le titre d'erreur localisé
  static String getLocalizedErrorTitle(AppError error, BuildContext context) {
    final s = AppLocalizations.of(context);
    
    switch (error.runtimeType) {
      case NotificationPermissionError _:
      case NotificationScheduleError _:
      case NotificationShowError _:
      case NotificationCancelError _:
        return s?.notificationErrorTitle ?? 'Error';
      default:
        return s?.error ?? 'Error';
    }
  }
  
  /// Obtient l'icône d'erreur appropriée
  static IconData getErrorIcon(AppError error) {
    switch (error.severity) {
      case ErrorSeverity.info:
        return Icons.info_outline;
      case ErrorSeverity.warning:
        return Icons.warning_outlined;
      case ErrorSeverity.error:
        return Icons.error_outline;
      case ErrorSeverity.critical:
        return Icons.error_outline;
    }
  }
  
  /// Obtient la couleur d'erreur appropriée
  static Color getErrorColor(AppError error, BuildContext context) {
    final theme = Theme.of(context);
    
    switch (error.severity) {
      case ErrorSeverity.info:
        return theme.colorScheme.primary;
      case ErrorSeverity.warning:
        return Colors.orange;
      case ErrorSeverity.error:
        return theme.colorScheme.error;
      case ErrorSeverity.critical:
        return Colors.red.shade800;
    }
  }
}

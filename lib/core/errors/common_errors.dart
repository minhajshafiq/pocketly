import 'package:pocketly/core/errors/app_error.dart';

/// Erreur réseau (connexion, timeout, etc.)
class NetworkError extends AppError {
  final String? _userMessage;
  final String? _technicalMessage;
  @override
  final Object? originalError;
  @override
  final StackTrace? stackTrace;

  const NetworkError({
    String? userMessage,
    String? technicalMessage,
    this.originalError,
    this.stackTrace,
  }) : _userMessage = userMessage,
       _technicalMessage = technicalMessage;

  @override
  String get userMessage =>
      _userMessage ?? 'Problème de connexion. Vérifiez votre internet.';

  @override
  String get technicalMessage =>
      _technicalMessage ?? 'Network connection failed: $originalError';

  @override
  String get errorCode => 'NETWORK_ERROR';

  @override
  ErrorSeverity get severity => ErrorSeverity.error;
}

/// Erreur d'authentification
class AuthenticationError extends AppError {
  final String? _userMessage;
  final String? _technicalMessage;
  @override
  final Object? originalError;
  @override
  final StackTrace? stackTrace;

  const AuthenticationError({
    String? userMessage,
    String? technicalMessage,
    this.originalError,
    this.stackTrace,
  }) : _userMessage = userMessage,
       _technicalMessage = technicalMessage;

  @override
  String get userMessage =>
      _userMessage ?? 'Erreur d\'authentification. Vérifiez vos identifiants.';

  @override
  String get technicalMessage =>
      _technicalMessage ?? 'Authentication failed: $originalError';

  @override
  String get errorCode => 'AUTH_ERROR';

  @override
  ErrorSeverity get severity => ErrorSeverity.error;
}

/// Erreur de validation (formulaire, données)
class ValidationError extends AppError {
  final String field;
  final String? _userMessage;
  final String? _technicalMessage;
  @override
  final Object? originalError;
  @override
  final StackTrace? stackTrace;

  const ValidationError({
    required this.field,
    String? userMessage,
    String? technicalMessage,
    this.originalError,
    this.stackTrace,
  }) : _userMessage = userMessage,
       _technicalMessage = technicalMessage;

  @override
  String get userMessage =>
      _userMessage ?? 'Le champ "$field" contient une erreur.';

  @override
  String get technicalMessage =>
      _technicalMessage ?? 'Validation failed for field: $field';

  @override
  String get errorCode => 'VALIDATION_ERROR';

  @override
  ErrorSeverity get severity => ErrorSeverity.warning;
}

/// Erreur serveur (5xx)
class ServerError extends AppError {
  final int? statusCode;
  final String? _userMessage;
  final String? _technicalMessage;
  @override
  final Object? originalError;
  @override
  final StackTrace? stackTrace;

  const ServerError({
    this.statusCode,
    String? userMessage,
    String? technicalMessage,
    this.originalError,
    this.stackTrace,
  }) : _userMessage = userMessage,
       _technicalMessage = technicalMessage;

  @override
  String get userMessage =>
      _userMessage ?? 'Le serveur rencontre un problème. Réessayez plus tard.';

  @override
  String get technicalMessage =>
      _technicalMessage ??
      'Server error (${statusCode ?? "unknown"}): $originalError';

  @override
  String get errorCode => 'SERVER_ERROR_${statusCode ?? "UNKNOWN"}';

  @override
  ErrorSeverity get severity => ErrorSeverity.critical;
}

/// Erreur de données introuvables (404)
class NotFoundError extends AppError {
  final String resourceType;
  final String? _userMessage;
  final String? _technicalMessage;
  @override
  final Object? originalError;
  @override
  final StackTrace? stackTrace;

  const NotFoundError({
    required this.resourceType,
    String? userMessage,
    String? technicalMessage,
    this.originalError,
    this.stackTrace,
  }) : _userMessage = userMessage,
       _technicalMessage = technicalMessage;

  @override
  String get userMessage => _userMessage ?? '$resourceType introuvable.';

  @override
  String get technicalMessage =>
      _technicalMessage ?? 'Resource not found: $resourceType';

  @override
  String get errorCode => 'NOT_FOUND';

  @override
  ErrorSeverity get severity => ErrorSeverity.info;
}

/// Erreur de permission/autorisation
class PermissionError extends AppError {
  final String action;
  final String? _userMessage;
  final String? _technicalMessage;
  @override
  final Object? originalError;
  @override
  final StackTrace? stackTrace;

  const PermissionError({
    required this.action,
    String? userMessage,
    String? technicalMessage,
    this.originalError,
    this.stackTrace,
  }) : _userMessage = userMessage,
       _technicalMessage = technicalMessage;

  @override
  String get userMessage =>
      _userMessage ?? 'Vous n\'avez pas les permissions pour cette action.';

  @override
  String get technicalMessage =>
      _technicalMessage ?? 'Permission denied for action: $action';

  @override
  String get errorCode => 'PERMISSION_DENIED';

  @override
  ErrorSeverity get severity => ErrorSeverity.warning;
}

/// Erreur de timeout
class TimeoutError extends AppError {
  final Duration? timeout;
  final String? _userMessage;
  final String? _technicalMessage;
  @override
  final Object? originalError;
  @override
  final StackTrace? stackTrace;

  const TimeoutError({
    this.timeout,
    String? userMessage,
    String? technicalMessage,
    this.originalError,
    this.stackTrace,
  }) : _userMessage = userMessage,
       _technicalMessage = technicalMessage;

  @override
  String get userMessage =>
      _userMessage ?? 'L\'opération a pris trop de temps. Réessayez.';

  @override
  String get technicalMessage =>
      _technicalMessage ??
      'Operation timed out after ${timeout?.inSeconds ?? "unknown"}s';

  @override
  String get errorCode => 'TIMEOUT';

  @override
  ErrorSeverity get severity => ErrorSeverity.error;
}

/// Erreur inconnue/générique
class UnknownError extends AppError {
  final String? _userMessage;
  final String? _technicalMessage;
  @override
  final Object? originalError;
  @override
  final StackTrace? stackTrace;

  const UnknownError({
    String? userMessage,
    String? technicalMessage,
    this.originalError,
    this.stackTrace,
  }) : _userMessage = userMessage,
       _technicalMessage = technicalMessage;

  @override
  String get userMessage =>
      _userMessage ?? 'Une erreur inattendue s\'est produite.';

  @override
  String get technicalMessage =>
      _technicalMessage ?? 'Unknown error: $originalError';

  @override
  String get errorCode => 'UNKNOWN_ERROR';

  @override
  ErrorSeverity get severity => ErrorSeverity.error;
}

/// Erreur de cache/stockage local
class CacheError extends AppError {
  final String operation;
  final String? _userMessage;
  final String? _technicalMessage;
  @override
  final Object? originalError;
  @override
  final StackTrace? stackTrace;

  const CacheError({
    required this.operation,
    String? userMessage,
    String? technicalMessage,
    this.originalError,
    this.stackTrace,
  }) : _userMessage = userMessage,
       _technicalMessage = technicalMessage;

  @override
  String get userMessage =>
      _userMessage ?? 'Erreur de stockage local. Données non sauvegardées.';

  @override
  String get technicalMessage =>
      _technicalMessage ??
      'Cache operation failed: $operation - $originalError';

  @override
  String get errorCode => 'CACHE_ERROR';

  @override
  ErrorSeverity get severity => ErrorSeverity.warning;
}

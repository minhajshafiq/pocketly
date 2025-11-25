import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:pocketly/core/errors/app_error.dart';
import 'package:pocketly/core/errors/common_errors.dart';

/// Gestionnaire centralisé des erreurs.
///
/// Convertit les exceptions système/framework en AppError
/// pour une gestion cohérente dans toute l'application.
class ErrorHandler {
  /// Convertit une exception en AppError
  static AppError handleError(Object error, [StackTrace? stackTrace]) {
    // Log l'erreur en mode debug
    if (kDebugMode) {
      debugPrint('🔴 Error caught: $error');
      if (stackTrace != null) {
        debugPrint('Stack trace: $stackTrace');
      }
    }

    // Si c'est déjà une AppError, on la retourne
    if (error is AppError) {
      return error;
    }

    // Erreurs Supabase
    if (error is AuthException) {
      return _handleSupabaseAuthException(error, stackTrace);
    }

    if (error is PostgrestException) {
      return _handlePostgrestException(error, stackTrace);
    }

    // Erreurs réseau
    if (error is SocketException) {
      return NetworkError(
        technicalMessage: 'Socket exception: ${error.message}',
        originalError: error,
        stackTrace: stackTrace,
      );
    }

    if (error is HttpException) {
      return NetworkError(
        technicalMessage: 'HTTP exception: ${error.message}',
        originalError: error,
        stackTrace: stackTrace,
      );
    }

    // Erreurs de timeout
    if (error is TimeoutException) {
      return TimeoutError(
        timeout: error.duration,
        technicalMessage: 'Timeout: ${error.message}',
        originalError: error,
        stackTrace: stackTrace,
      );
    }

    // Erreurs de format/parsing
    if (error is FormatException) {
      return ValidationError(
        field: 'data',
        userMessage: 'Format de données invalide.',
        technicalMessage: 'Format exception: ${error.message}',
        originalError: error,
        stackTrace: stackTrace,
      );
    }

    // Erreur inconnue
    return UnknownError(
      technicalMessage: 'Unhandled error: ${error.toString()}',
      originalError: error,
      stackTrace: stackTrace,
    );
  }

  /// Gère les exceptions d'authentification Supabase
  static AppError _handleSupabaseAuthException(
    AuthException error,
    StackTrace? stackTrace,
  ) {
    String userMessage;
    String technicalMessage = 'Auth error: ${error.message}';

    switch (error.message) {
      case String msg when msg.contains('Invalid login credentials'):
        userMessage = 'Email ou mot de passe incorrect.';
        break;
      case String msg when msg.contains('Email not confirmed'):
        userMessage = 'Veuillez confirmer votre email.';
        break;
      case String msg when msg.contains('User already registered'):
        userMessage = 'Cet email est déjà utilisé.';
        break;
      case String msg when msg.contains('Invalid email'):
        userMessage = 'Format d\'email invalide.';
        break;
      case String msg when msg.contains('Password should be at least'):
        userMessage = 'Le mot de passe doit contenir au moins 6 caractères.';
        break;
      case String msg when msg.contains('Network request failed'):
        userMessage = 'Problème de connexion. Vérifiez votre internet.';
        break;
      case String msg when msg.contains('Token expired'):
      case String msg when msg.contains('JWT expired'):
        userMessage = 'Session expirée. Reconnectez-vous.';
        break;
      default:
        userMessage = 'Erreur d\'authentification.';
    }

    return AuthenticationError(
      userMessage: userMessage,
      technicalMessage: technicalMessage,
      originalError: error,
      stackTrace: stackTrace,
    );
  }

  /// Gère les exceptions Postgrest (base de données)
  static AppError _handlePostgrestException(
    PostgrestException error,
    StackTrace? stackTrace,
  ) {
    final code = error.code;
    final message = error.message;

    String userMessage;
    String technicalMessage = 'Database error [$code]: $message';

    // Codes HTTP standards
    if (code != null) {
      if (code.startsWith('2')) {
        // 2xx - Success (ne devrait pas arriver ici)
        userMessage = 'Opération réussie.';
      } else if (code.startsWith('4')) {
        // 4xx - Erreurs client
        if (code == '404' || code == 'PGRST116') {
          return NotFoundError(
            resourceType: 'Données',
            technicalMessage: technicalMessage,
            originalError: error,
            stackTrace: stackTrace,
          );
        } else if (code == '401' || code == '403') {
          return PermissionError(
            action: 'database_operation',
            userMessage: 'Accès non autorisé.',
            technicalMessage: technicalMessage,
            originalError: error,
            stackTrace: stackTrace,
          );
        } else {
          userMessage = 'Requête invalide.';
        }
      } else if (code.startsWith('5')) {
        // 5xx - Erreurs serveur
        return ServerError(
          statusCode: int.tryParse(code),
          technicalMessage: technicalMessage,
          originalError: error,
          stackTrace: stackTrace,
        );
      } else {
        userMessage = 'Erreur de base de données.';
      }
    } else {
      userMessage = 'Erreur de base de données.';
    }

    return UnknownError(
      userMessage: userMessage,
      technicalMessage: technicalMessage,
      originalError: error,
      stackTrace: stackTrace,
    );
  }

  /// Logs une erreur pour le monitoring (à intégrer avec Sentry/Firebase Crashlytics)
  static Future<void> logError(AppError error) async {
    if (kDebugMode) {
      debugPrint(
        '📝 Logging error: ${error.errorCode} - ${error.technicalMessage}',
      );
    }

    // TODO: Intégrer avec un service de monitoring en production
    // Exemples:
    // - Firebase Crashlytics
    // - Sentry
    // - Custom logging service

    // await FirebaseCrashlytics.instance.recordError(
    //   error.originalError ?? error,
    //   error.stackTrace,
    //   reason: error.technicalMessage,
    //   fatal: error.severity == ErrorSeverity.critical,
    // );
  }

  /// Détermine si l'erreur doit être affichée à l'utilisateur
  static bool shouldShowToUser(AppError error) {
    return error.severity.shouldShowToUser;
  }
}

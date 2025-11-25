import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'logger_service.g.dart';

/// Service de logging centralisé pour Pocketly.
///
/// Fournit une interface unifiée pour le logging à travers l'application.
/// Les logs détaillés ne sont affichés qu'en mode debug pour éviter l'exposition
/// de données sensibles en production.
class LoggerService {
  const LoggerService();

  /// Log un message d'information
  void i(String message, {Object? error, StackTrace? stackTrace}) {
    if (kDebugMode) {
      // En mode debug, afficher tous les détails
      debugPrint('[INFO] $message');
      if (error != null) {
        debugPrint('[ERROR] $error');
      }
      if (stackTrace != null) {
        debugPrint('[STACK] $stackTrace');
      }
    }
    // En production : ne rien afficher
    // TODO: Intégrer avec Firebase Crashlytics ou Sentry pour le logging distant
  }

  /// Log un message d'erreur
  void e(String message, {Object? error, StackTrace? stackTrace}) {
    if (kDebugMode) {
      // En mode debug, afficher tous les détails
      debugPrint('[ERROR] $message');
      if (error != null) {
        debugPrint('[ERROR] $error');
      }
      if (stackTrace != null) {
        debugPrint('[STACK] $stackTrace');
      }
    }
    // En production : ne rien afficher
    // TODO: Envoyer à un service de monitoring externe (Crashlytics, Sentry)
  }

  /// Log un message de debug
  void d(String message, {Object? error, StackTrace? stackTrace}) {
    // Les logs de debug ne sont jamais affichés en production
    if (kDebugMode) {
      debugPrint('[DEBUG] $message');
      if (error != null) {
        debugPrint('[ERROR] $error');
      }
      if (stackTrace != null) {
        debugPrint('[STACK] $stackTrace');
      }
    }
  }

  /// Log un message d'avertissement
  void w(String message, {Object? error, StackTrace? stackTrace}) {
    if (kDebugMode) {
      debugPrint('[WARNING] $message');
      if (error != null) {
        debugPrint('[ERROR] $error');
      }
      if (stackTrace != null) {
        debugPrint('[STACK] $stackTrace');
      }
    }
    // En production : ne rien afficher
  }
}

/// Provider pour le service de logging
@riverpod
LoggerService loggerService(Ref ref) {
  return const LoggerService();
}

/// Provider pour le logger (alias pour faciliter l'usage)
@riverpod
LoggerService logger(Ref ref) {
  return ref.watch(loggerServiceProvider);
}

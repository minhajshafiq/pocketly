import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocketly/core/errors/app_error.dart';
import 'package:pocketly/core/errors/error_handler.dart';

/// Provider global pour gérer les erreurs de l'application.
///
/// Permet de centraliser la gestion et l'affichage des erreurs
/// depuis n'importe quel provider Riverpod.
final errorNotifierProvider = NotifierProvider<ErrorNotifier, AppError?>(
  ErrorNotifier.new,
);

/// Notifier pour gérer l'état des erreurs
class ErrorNotifier extends Notifier<AppError?> {
  @override
  AppError? build() {
    return null;
  }

  /// Enregistre une nouvelle erreur
  void setError(Object error, [StackTrace? stackTrace]) {
    final appError = ErrorHandler.handleError(error, stackTrace);
    state = appError;

    // Log l'erreur pour le monitoring
    ErrorHandler.logError(appError);
  }

  /// Efface l'erreur actuelle
  void clearError() {
    state = null;
  }

  /// Vérifie si une erreur est présente
  bool get hasError => state != null;
}

/// Extension Riverpod pour faciliter la gestion des erreurs
extension ErrorHandlingExtension on Ref {
  /// Gère une erreur et la passe au ErrorNotifier
  void handleError(Object error, [StackTrace? stackTrace]) {
    read(errorNotifierProvider.notifier).setError(error, stackTrace);
  }

  /// Exécute une fonction async et gère automatiquement les erreurs
  Future<T?> guardAsync<T>(
    Future<T> Function() function, {
    bool showError = true,
  }) async {
    try {
      return await function();
    } catch (error, stackTrace) {
      if (showError) {
        handleError(error, stackTrace);
      }
      return null;
    }
  }

  /// Exécute une fonction synchrone et gère automatiquement les erreurs
  T? guard<T>(T Function() function, {bool showError = true}) {
    try {
      return function();
    } catch (error, stackTrace) {
      if (showError) {
        handleError(error, stackTrace);
      }
      return null;
    }
  }
}

/// Extension pour les AsyncValue
extension AsyncValueErrorExtension<T> on AsyncValue<T> {
  /// Convertit l'erreur AsyncValue en AppError
  AppError? get appError {
    return maybeWhen(
      error: (error, stackTrace) => ErrorHandler.handleError(error, stackTrace),
      orElse: () => null,
    );
  }

  /// Vérifie si l'erreur doit être affichée à l'utilisateur
  bool get shouldShowError {
    final error = appError;
    return error != null && ErrorHandler.shouldShowToUser(error);
  }
}

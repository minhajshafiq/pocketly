import 'package:pocketly/core/core.dart';

/// Erreur levée quand un utilisateur non-premium tente de créer une catégorie custom
class PremiumRequiredError extends AppError {
  final String? _userMessage;
  final String? _technicalMessage;
  @override
  final Object? originalError;
  @override
  final StackTrace? stackTrace;

  const PremiumRequiredError({
    String? userMessage,
    String? technicalMessage,
    this.originalError,
    this.stackTrace,
  }) : _userMessage = userMessage,
       _technicalMessage = technicalMessage;

  @override
  String get userMessage =>
      _userMessage ??
      'Passez à Premium pour créer des catégories personnalisées.';

  @override
  String get technicalMessage =>
      _technicalMessage ??
      'User attempted to create custom category without premium status';

  @override
  String get errorCode => 'PREMIUM_REQUIRED';

  @override
  ErrorSeverity get severity => ErrorSeverity.warning;
}

/// Erreur levée quand l'utilisateur n'est pas connecté
class UserNotAuthenticatedError extends AppError {
  final String? _userMessage;
  final String? _technicalMessage;
  @override
  final Object? originalError;
  @override
  final StackTrace? stackTrace;

  const UserNotAuthenticatedError({
    String? userMessage,
    String? technicalMessage,
    this.originalError,
    this.stackTrace,
  }) : _userMessage = userMessage,
       _technicalMessage = technicalMessage;

  @override
  String get userMessage =>
      _userMessage ?? 'Vous devez être connecté pour effectuer cette action.';

  @override
  String get technicalMessage =>
      _technicalMessage ??
      'User not authenticated when attempting protected operation';

  @override
  String get errorCode => 'USER_NOT_AUTHENTICATED';

  @override
  ErrorSeverity get severity => ErrorSeverity.error;
}

/// Erreur levée quand la catégorie n'appartient pas à l'utilisateur
class CategoryOwnershipError extends AppError {
  final String? _userMessage;
  final String? _technicalMessage;
  @override
  final Object? originalError;
  @override
  final StackTrace? stackTrace;

  const CategoryOwnershipError({
    String? userMessage,
    String? technicalMessage,
    this.originalError,
    this.stackTrace,
  }) : _userMessage = userMessage,
       _technicalMessage = technicalMessage;

  @override
  String get userMessage =>
      _userMessage ?? 'Vous ne pouvez modifier que vos propres catégories.';

  @override
  String get technicalMessage =>
      _technicalMessage ?? 'User attempted to modify category they do not own';

  @override
  String get errorCode => 'CATEGORY_OWNERSHIP_ERROR';

  @override
  ErrorSeverity get severity => ErrorSeverity.error;
}

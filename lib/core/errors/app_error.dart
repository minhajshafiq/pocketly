/// Classe de base abstraite pour toutes les erreurs de l'application.
/// 
/// Respecte la Clean Architecture en fournissant une interface commune
/// pour toutes les erreurs, indépendamment de leur source.
abstract class AppError implements Exception {
  /// Message d'erreur destiné à l'utilisateur (simple et compréhensible)
  String get userMessage;
  
  /// Message d'erreur technique pour le développeur/logs
  String get technicalMessage;
  
  /// Code d'erreur unique pour le tracking et le debugging
  String get errorCode;
  
  /// Niveau de sévérité de l'erreur
  ErrorSeverity get severity;
  
  /// Erreur originale (si disponible)
  Object? get originalError;
  
  /// Stack trace (si disponible)
  StackTrace? get stackTrace;

  const AppError();

  @override
  String toString() => '$errorCode: $technicalMessage';
}

/// Niveaux de sévérité des erreurs
enum ErrorSeverity {
  /// Information simple (ex: "Aucune donnée disponible")
  info,
  
  /// Avertissement (ex: "Connexion lente")
  warning,
  
  /// Erreur récupérable (ex: "Échec du chargement, réessayez")
  error,
  
  /// Erreur critique (ex: "Erreur système, contactez le support")
  critical,
}

/// Extension pour obtenir des informations sur la sévérité
extension ErrorSeverityExtension on ErrorSeverity {
  /// Icône adaptative selon la plateforme
  String get icon {
    switch (this) {
      case ErrorSeverity.info:
        return 'info';
      case ErrorSeverity.warning:
        return 'warning';
      case ErrorSeverity.error:
        return 'error';
      case ErrorSeverity.critical:
        return 'critical';
    }
  }

  /// Couleur recommandée pour l'affichage
  String get colorName {
    switch (this) {
      case ErrorSeverity.info:
        return 'blue';
      case ErrorSeverity.warning:
        return 'orange';
      case ErrorSeverity.error:
        return 'red';
      case ErrorSeverity.critical:
        return 'darkRed';
    }
  }

  /// Si l'erreur doit être affichée à l'utilisateur
  bool get shouldShowToUser {
    return this != ErrorSeverity.info;
  }
}


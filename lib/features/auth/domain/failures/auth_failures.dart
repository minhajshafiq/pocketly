/// Classe de base pour toutes les exceptions d'authentification.
/// 
/// Permet une gestion d'erreur typée et facilite la traduction des messages
/// pour l'utilisateur final.
sealed class AuthFailure implements Exception {
  final String message;
  final String? code;
  final dynamic originalError;

  const AuthFailure({
    required this.message,
    this.code,
    this.originalError,
  });

  @override
  String toString() => 'AuthFailure: $message${code != null ? ' (code: $code)' : ''}';
}

/// Erreur lors de la connexion (email/mot de passe incorrect).
class SignInFailure extends AuthFailure {
  const SignInFailure({
    super.message = 'Email ou mot de passe incorrect',
    super.code,
    super.originalError,
  });
}

/// Erreur lors de l'inscription (email déjà utilisé, mot de passe faible, etc.).
class SignUpFailure extends AuthFailure {
  const SignUpFailure({
    super.message = 'Impossible de créer le compte',
    super.code,
    super.originalError,
  });
}

/// Erreur lors de la déconnexion.
class SignOutFailure extends AuthFailure {
  const SignOutFailure({
    super.message = 'Impossible de se déconnecter',
    super.code,
    super.originalError,
  });
}

/// Erreur lors de la restauration de session.
class SessionRestoreFailure extends AuthFailure {
  const SessionRestoreFailure({
    super.message = 'Impossible de restaurer la session',
    super.code,
    super.originalError,
  });
}

/// Erreur lors de la connexion OAuth (Google/Apple).
class OAuthFailure extends AuthFailure {
  final String provider;

  const OAuthFailure({
    required this.provider,
    super.message = 'Échec de la connexion OAuth',
    super.code,
    super.originalError,
  });

  @override
  String toString() => 'OAuthFailure ($provider): $message';
}

/// Erreur réseau (pas de connexion internet).
class NetworkFailure extends AuthFailure {
  const NetworkFailure({
    super.message = 'Aucune connexion Internet',
    super.code,
    super.originalError,
  });
}

/// Erreur serveur (Supabase down, timeout, etc.).
class ServerFailure extends AuthFailure {
  const ServerFailure({
    super.message = 'Erreur serveur, réessayez plus tard',
    super.code,
    super.originalError,
  });
}

/// Utilisateur non trouvé ou données manquantes.
class UserNotFoundFailure extends AuthFailure {
  const UserNotFoundFailure({
    super.message = 'Utilisateur introuvable',
    super.code,
    super.originalError,
  });
}

/// Email invalide ou mal formaté.
class InvalidEmailFailure extends AuthFailure {
  const InvalidEmailFailure({
    super.message = 'Adresse email invalide',
    super.code,
    super.originalError,
  });
}

/// Mot de passe trop faible ou ne respectant pas les critères.
class WeakPasswordFailure extends AuthFailure {
  const WeakPasswordFailure({
    super.message = 'Le mot de passe doit contenir au moins 8 caractères',
    super.code,
    super.originalError,
  });
}

/// Email déjà utilisé par un autre compte.
class EmailAlreadyInUseFailure extends AuthFailure {
  const EmailAlreadyInUseFailure({
    super.message = 'Cet email est déjà utilisé',
    super.code,
    super.originalError,
  });
}

/// Session expirée, reconnexion nécessaire.
class SessionExpiredFailure extends AuthFailure {
  const SessionExpiredFailure({
    super.message = 'Votre session a expiré, veuillez vous reconnecter',
    super.code,
    super.originalError,
  });
}

/// Erreur inconnue ou non catégorisée.
class UnknownAuthFailure extends AuthFailure {
  const UnknownAuthFailure({
    super.message = 'Une erreur inattendue s\'est produite',
    super.code,
    super.originalError,
  });
}


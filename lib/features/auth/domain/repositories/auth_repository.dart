import '../entities/auth_session.dart';
import '../entities/auth_user.dart';

/// Interface du repository d'authentification.
///
/// Définit les contrats pour les opérations d'authentification.
/// Implémenté dans la couche data.
abstract class AuthRepository {
  /// Se connecter avec email et mot de passe
  Future<AuthSession> signInWithEmail({
    required String email,
    required String password,
  });

  /// S'inscrire avec email et mot de passe
  Future<AuthSession> signUpWithEmail({
    required String email,
    required String password,
    String? name,
  });

  /// Se déconnecter
  Future<void> signOut();

  /// Obtenir la session actuelle
  Future<AuthSession?> getCurrentSession();

  /// Obtenir l'utilisateur actuel
  Future<AuthUser?> getCurrentUser();

  /// Rafraîchir la session
  Future<AuthSession> refreshSession(String refreshToken);

  /// Réinitialiser le mot de passe (envoi d'email)
  Future<void> resetPassword(String email);

  /// Mettre à jour le mot de passe
  Future<void> updatePassword(String newPassword);

  /// Mettre à jour l'email
  Future<void> updateEmail(String newEmail);

  /// Vérifier si l'utilisateur est authentifié
  Future<bool> isAuthenticated();

  /// Stream des changements d'état d'authentification
  Stream<AuthUser?> authStateChanges();
}

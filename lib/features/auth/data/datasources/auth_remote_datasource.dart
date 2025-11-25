import '../models/auth_session_model.dart';
import '../models/auth_user_model.dart';

/// Interface du datasource remote pour l'authentification.
///
/// Définit les contrats pour les appels API d'authentification via Supabase.
abstract class AuthRemoteDataSource {
  /// Se connecter avec email et mot de passe
  Future<AuthSessionModel> signInWithEmail({
    required String email,
    required String password,
  });

  /// S'inscrire avec email et mot de passe
  Future<AuthSessionModel> signUpWithEmail({
    required String email,
    required String password,
    String? name,
  });

  /// Se déconnecter
  Future<void> signOut();

  /// Obtenir la session actuelle
  Future<AuthSessionModel?> getCurrentSession();

  /// Obtenir l'utilisateur actuel
  Future<AuthUserModel?> getCurrentUser();

  /// Rafraîchir la session
  Future<AuthSessionModel> refreshSession(String refreshToken);

  /// Réinitialiser le mot de passe
  Future<void> resetPassword(String email);

  /// Mettre à jour le mot de passe
  Future<void> updatePassword(String newPassword);

  /// Mettre à jour l'email
  Future<void> updateEmail(String newEmail);

  /// Stream des changements d'état d'authentification
  Stream<AuthUserModel?> authStateChanges();
}

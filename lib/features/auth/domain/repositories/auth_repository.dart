import 'package:pocketly/features/user/domain/entities/user_entity.dart';

/// Interface définissant le contrat pour l'authentification.
/// 
/// Cette abstraction permet de découpler la logique métier de l'implémentation
/// concrète (Supabase), facilitant les tests et la maintenance.
abstract class AuthRepository {
  /// Retourne l'utilisateur actuellement authentifié.
  /// 
  /// Returns `null` si aucun utilisateur n'est connecté.
  Future<UserEntity?> getCurrentUser();

  /// Écoute les changements d'état d'authentification.
  /// 
  /// Émet un nouveau [UserEntity] à chaque changement de session.
  /// Émet `null` lorsque l'utilisateur se déconnecte.
  Stream<UserEntity?> watchAuthState();

  /// Connecte un utilisateur avec email et mot de passe.
  /// 
  /// Throws [AuthException] en cas d'erreur (email invalide, mot de passe incorrect, etc.).
  /// 
  /// Returns le [UserEntity] de l'utilisateur connecté.
  Future<UserEntity> signInWithEmailPassword({
    required String email,
    required String password,
  });

  /// Inscrit un nouvel utilisateur avec email et mot de passe.
  /// 
  /// Throws [AuthException] en cas d'erreur (email déjà utilisé, mot de passe faible, etc.).
  /// 
  /// Returns le [UserEntity] de l'utilisateur créé.
  Future<UserEntity> signUpWithEmailPassword({
    required String email,
    required String password,
    String? name,
  });

  /// Connecte un utilisateur avec Google OAuth.
  /// 
  /// Throws [AuthException] en cas d'erreur ou d'annulation.
  /// 
  /// Returns le [UserEntity] de l'utilisateur connecté.
  Future<UserEntity> signInWithGoogle();

  /// Connecte un utilisateur avec Apple OAuth.
  /// 
  /// Throws [AuthException] en cas d'erreur ou d'annulation.
  /// 
  /// Returns le [UserEntity] de l'utilisateur connecté.
  Future<UserEntity> signInWithApple();

  /// Déconnecte l'utilisateur actuel.
  /// 
  /// Throws [AuthException] en cas d'erreur.
  Future<void> signOut();

  /// Restaure la session utilisateur depuis le stockage local.
  /// 
  /// Utile au démarrage de l'application pour vérifier si une session existe.
  /// 
  /// Returns le [UserEntity] si une session valide existe, sinon `null`.
  Future<UserEntity?> restoreSession();

  /// Envoie un email de réinitialisation de mot de passe.
  /// 
  /// Throws [AuthException] en cas d'erreur (email invalide, etc.).
  Future<void> sendPasswordResetEmail(String email);

  /// Rafraîchit les données de l'utilisateur actuel depuis le serveur.
  /// 
  /// Utile après une mise à jour du profil pour synchroniser les données.
  Future<UserEntity?> refreshCurrentUser();
}


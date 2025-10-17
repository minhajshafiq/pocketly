import 'dart:async';
import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:pocketly/features/auth/domain/repositories/auth_repository.dart';
import 'package:pocketly/features/auth/domain/failures/auth_failures.dart' as auth_failures;
import 'package:pocketly/features/user/domain/entities/user_entity.dart';

/// Implémentation concrète de [AuthRepository] utilisant Supabase.
/// 
/// Cette classe gère toutes les interactions avec Supabase Auth et la table `users`.
class AuthRepositoryImpl implements AuthRepository {
  final SupabaseClient _supabase;

  AuthRepositoryImpl(this._supabase);

  @override
  Future<UserEntity?> getCurrentUser() async {
    try {
      final authUser = _supabase.auth.currentUser;
      if (authUser == null) return null;

      return await _fetchUserEntity(authUser.id);
    } catch (e) {
      throw auth_failures.UnknownAuthFailure(
        message: 'Erreur lors de la récupération de l\'utilisateur',
        originalError: e,
      );
    }
  }

  @override
  Stream<UserEntity?> watchAuthState() {
    return _supabase.auth.onAuthStateChange.asyncMap((event) async {
      final session = event.session;
      if (session == null) return null;

      try {
        return await _fetchUserEntity(session.user.id);
      } catch (e) {
        return null;
      }
    });
  }

  @override
  Future<UserEntity> signInWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _supabase.auth.signInWithPassword(
        email: email.trim(),
        password: password,
      );

      if (response.user == null) {
        throw const auth_failures.SignInFailure(message: 'Aucun utilisateur retourné');
      }

      return await _fetchUserEntity(response.user!.id);
    } on AuthException catch (e) {
      throw _mapSupabaseAuthException(e);
    } catch (e) {
      if (e is SocketException) {
        throw const auth_failures.NetworkFailure();
      }
      throw auth_failures.SignInFailure(
        message: 'Erreur lors de la connexion',
        originalError: e,
      );
    }
  }

  @override
  Future<UserEntity> signUpWithEmailPassword({
    required String email,
    required String password,
    String? name,
  }) async {
    try {
      final response = await _supabase.auth.signUp(
        email: email.trim(),
        password: password,
        data: {
          'name': name?.trim(),
        },
      );

      if (response.user == null) {
        throw const auth_failures.SignUpFailure(message: 'Aucun utilisateur retourné');
      }

      // Attendre que le trigger handle_new_user s'exécute
      // Le trigger crée automatiquement l'utilisateur avec le trial activé
      await Future.delayed(const Duration(seconds: 1));

      // Récupérer l'utilisateur depuis la base de données
      // Le trigger handle_new_user devrait l'avoir créé automatiquement
      try {
        final user = await _fetchUserEntity(response.user!.id);
        return user;
      } on auth_failures.UserNotFoundFailure {
        // Si le trigger n'a pas fonctionné, créer manuellement l'utilisateur
        final userEntity = UserEntityFactories.withTrial(
          id: response.user!.id,
          email: email.trim(),
          name: name?.trim(),
        );

        await _createUserInDatabase(userEntity);
        return userEntity;
      }
    } on AuthException catch (e) {
      throw _mapSupabaseAuthException(e);
    } catch (e) {
      if (e is SocketException) {
        throw const auth_failures.NetworkFailure();
      }
      if (e is auth_failures.AuthFailure) {
        rethrow;
      }
      throw auth_failures.SignUpFailure(
        message: 'Erreur lors de l\'inscription',
        originalError: e,
      );
    }
  }

  @override
  Future<UserEntity> signInWithGoogle() async {
    try {
      final response = await _supabase.auth.signInWithOAuth(
        OAuthProvider.google,
        redirectTo: 'io.supabase.pocketly://login-callback',
      );

      if (!response) {
        throw const auth_failures.OAuthFailure(
          provider: 'Google',
          message: 'Connexion annulée ou échouée',
        );
      }

      // Attendre que la session soit établie
      await Future.delayed(const Duration(seconds: 1));

      final user = _supabase.auth.currentUser;
      if (user == null) {
        throw const auth_failures.OAuthFailure(
          provider: 'Google',
          message: 'Aucun utilisateur après OAuth',
        );
      }

      return await _fetchOrCreateUserEntity(user);
    } on AuthException catch (e) {
      throw auth_failures.OAuthFailure(
        provider: 'Google',
        message: e.message,
        code: e.statusCode,
        originalError: e,
      );
    } catch (e) {
      if (e is SocketException) {
        throw const auth_failures.NetworkFailure();
      }
      throw auth_failures.OAuthFailure(
        provider: 'Google',
        message: 'Erreur lors de la connexion Google',
        originalError: e,
      );
    }
  }

  @override
  Future<UserEntity> signInWithApple() async {
    try {
      final response = await _supabase.auth.signInWithOAuth(
        OAuthProvider.apple,
        redirectTo: 'io.supabase.pocketly://login-callback',
      );

      if (!response) {
        throw const auth_failures.OAuthFailure(
          provider: 'Apple',
          message: 'Connexion annulée ou échouée',
        );
      }

      // Attendre que la session soit établie
      await Future.delayed(const Duration(seconds: 1));

      final user = _supabase.auth.currentUser;
      if (user == null) {
        throw const auth_failures.OAuthFailure(
          provider: 'Apple',
          message: 'Aucun utilisateur après OAuth',
        );
      }

      return await _fetchOrCreateUserEntity(user);
    } on AuthException catch (e) {
      throw auth_failures.OAuthFailure(
        provider: 'Apple',
        message: e.message,
        code: e.statusCode,
        originalError: e,
      );
    } catch (e) {
      if (e is SocketException) {
        throw const auth_failures.NetworkFailure();
      }
      throw auth_failures.OAuthFailure(
        provider: 'Apple',
        message: 'Erreur lors de la connexion Apple',
        originalError: e,
      );
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _supabase.auth.signOut();
    } on AuthException catch (e) {
      throw auth_failures.SignOutFailure(
        message: e.message,
        code: e.statusCode,
        originalError: e,
      );
    } catch (e) {
      if (e is SocketException) {
        throw const auth_failures.NetworkFailure();
      }
      throw auth_failures.SignOutFailure(
        message: 'Erreur lors de la déconnexion',
        originalError: e,
      );
    }
  }

  @override
  Future<UserEntity?> restoreSession() async {
    try {
      final session = _supabase.auth.currentSession;
      if (session == null) return null;

      // Vérifier si la session est toujours valide
      if (session.isExpired) {
        await _supabase.auth.refreshSession();
      }

      final user = _supabase.auth.currentUser;
      if (user == null) return null;

      return await _fetchUserEntity(user.id);
    } on AuthException catch (e) {
      if (e.statusCode == '401' || e.message.contains('expired')) {
        throw const auth_failures.SessionExpiredFailure();
      }
      throw auth_failures.SessionRestoreFailure(
        message: e.message,
        code: e.statusCode,
        originalError: e,
      );
    } catch (e) {
      if (e is SocketException) {
        throw const auth_failures.NetworkFailure();
      }
      throw auth_failures.SessionRestoreFailure(
        message: 'Erreur lors de la restauration de session',
        originalError: e,
      );
    }
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _supabase.auth.resetPasswordForEmail(
        email.trim(),
        redirectTo: 'io.supabase.pocketly://reset-password',
      );
    } on AuthException catch (e) {
      throw _mapSupabaseAuthException(e);
    } catch (e) {
      if (e is SocketException) {
        throw const auth_failures.NetworkFailure();
      }
      throw auth_failures.UnknownAuthFailure(
        message: 'Erreur lors de l\'envoi de l\'email',
        originalError: e,
      );
    }
  }

  @override
  Future<UserEntity?> refreshCurrentUser() async {
    try {
      final user = _supabase.auth.currentUser;
      if (user == null) return null;

      return await _fetchUserEntity(user.id);
    } catch (e) {
      throw auth_failures.UnknownAuthFailure(
        message: 'Erreur lors du rafraîchissement',
        originalError: e,
      );
    }
  }

  // ==================== HELPERS PRIVÉS ====================

  /// Récupère les données utilisateur depuis la table `users`.
  Future<UserEntity> _fetchUserEntity(String userId) async {
    try {
      final response = await _supabase
          .from('users')
          .select()
          .eq('id', userId)
          .single();

      // Convertir la réponse en UserEntity
      try {
        return UserEntity.fromJson(response);
      } catch (parseError) {
        throw auth_failures.UnknownAuthFailure(
          message: 'Erreur de parsing des données utilisateur',
          originalError: parseError,
        );
      }
    } on PostgrestException catch (e) {
      if (e.code == 'PGRST116') {
        throw const auth_failures.UserNotFoundFailure(
          message: 'Utilisateur introuvable dans la base de données',
        );
      }
      throw auth_failures.ServerFailure(
        message: 'Erreur base de données: ${e.message}',
        code: e.code,
        originalError: e,
      );
    } on auth_failures.AuthFailure {
      rethrow;
    } catch (e) {
      throw auth_failures.UnknownAuthFailure(
        message: 'Erreur lors de la récupération des données utilisateur',
        originalError: e,
      );
    }
  }

  /// Récupère ou crée l'utilisateur (utile pour OAuth).
  Future<UserEntity> _fetchOrCreateUserEntity(User authUser) async {
    try {
      return await _fetchUserEntity(authUser.id);
    } on auth_failures.UserNotFoundFailure {
      // L'utilisateur n'existe pas, le créer avec trial
      final userEntity = UserEntityFactories.withTrial(
        id: authUser.id,
        email: authUser.email!,
        name: authUser.userMetadata?['name'] as String?,
        avatarUrl: authUser.userMetadata?['avatar_url'] as String?,
      );

      await _createUserInDatabase(userEntity);
      return userEntity;
    }
  }

  /// Crée un utilisateur dans la table `users`.
  Future<void> _createUserInDatabase(UserEntity user) async {
    try {
      await _supabase.from('users').insert(user.toJson());
    } on PostgrestException catch (e) {
      if (e.code == '23505') {
        // Duplicate key, l'utilisateur existe déjà
        return;
      }
      throw auth_failures.ServerFailure(
        message: 'Erreur lors de la création du profil',
        code: e.code,
        originalError: e,
      );
    } catch (e) {
      throw auth_failures.UnknownAuthFailure(
        message: 'Erreur lors de la création du profil',
        originalError: e,
      );
    }
  }

  /// Mappe les exceptions Supabase Auth vers nos exceptions custom.
  auth_failures.AuthFailure _mapSupabaseAuthException(AuthException e) {
    final message = e.message.toLowerCase();
    final code = e.statusCode;

    // Email invalide
    if (message.contains('invalid') && message.contains('email')) {
      return auth_failures.InvalidEmailFailure(code: code, originalError: e);
    }

    // Mot de passe faible
    if (message.contains('password') && 
        (message.contains('short') || message.contains('weak'))) {
      return auth_failures.WeakPasswordFailure(code: code, originalError: e);
    }

    // Email déjà utilisé
    if (message.contains('already') && message.contains('registered')) {
      return auth_failures.EmailAlreadyInUseFailure(code: code, originalError: e);
    }

    // Identifiants incorrects
    if (message.contains('invalid') && 
        (message.contains('credentials') || message.contains('password'))) {
      return auth_failures.SignInFailure(
        message: 'Email ou mot de passe incorrect',
        code: code,
        originalError: e,
      );
    }

    // Session expirée
    if (code == '401' || message.contains('expired')) {
      return auth_failures.SessionExpiredFailure(code: code, originalError: e);
    }

    // Erreur serveur
    if (code != null && code.startsWith('5')) {
      return auth_failures.ServerFailure(code: code, originalError: e);
    }

    // Erreur inconnue
    return auth_failures.UnknownAuthFailure(
      message: e.message,
      code: code,
      originalError: e,
    );
  }
}

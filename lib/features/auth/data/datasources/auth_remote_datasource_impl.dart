import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/errors/common_errors.dart';
import '../../../../core/services/logger_service.dart';
import '../models/auth_session_model.dart';
import '../models/auth_user_model.dart';
import 'auth_remote_datasource.dart';

/// Implémentation du datasource remote pour l'authentification avec Supabase.
///
/// Gère toutes les interactions avec Supabase Auth.
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  const AuthRemoteDataSourceImpl(this._supabase);

  final SupabaseClient _supabase;
  final logger = const LoggerService();

  @override
  Future<AuthSessionModel> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.session == null) {
        throw const AuthenticationError(
          technicalMessage: 'No session returned from sign in',
        );
      }

      return AuthSessionModel.fromSupabaseSession(response.session!);
    } on AuthException catch (e) {
      throw AuthenticationError(
        technicalMessage: 'Authentication failed: ${e.message}',
        originalError: e,
      );
    } catch (e) {
      throw NetworkError(
        technicalMessage: 'Network error during sign in: $e',
        originalError: e,
      );
    }
  }

  @override
  Future<AuthSessionModel> signUpWithEmail({
    required String email,
    required String password,
    String? name,
  }) async {
    try {
      logger.d('[SignUp] Tentative d\'inscription pour: $email');

      final response = await _supabase.auth.signUp(
        email: email,
        password: password,
        data: name != null ? {'name': name} : null,
      );

      logger.d('[SignUp] Réponse reçue: session=${response.session != null}, user=${response.user != null}');

      if (response.session == null) {
        logger.e('[SignUp] Pas de session retournée');
        throw const AuthenticationError(
          technicalMessage: 'No session returned from sign up',
          userMessage: 'Erreur lors de la création du compte. Veuillez réessayer.',
        );
      }

      logger.i('[SignUp] Session créée avec succès');
      return AuthSessionModel.fromSupabaseSession(response.session!);
    } on AuthException catch (e) {
      logger.e('[SignUp] AuthException: ${e.message}', error: e);
      if (e.message.contains('already registered')) {
        throw ValidationError(
          field: 'email',
          technicalMessage: 'Email already registered',
          originalError: e,
        );
      }
      throw AuthenticationError(
        technicalMessage: 'Sign up failed: ${e.message}',
        originalError: e,
      );
    } catch (e, stackTrace) {
      logger.e('[SignUp] Erreur inattendue: $e', error: e, stackTrace: stackTrace);
      throw NetworkError(
        technicalMessage: 'Network error during sign up: $e',
        originalError: e,
      );
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _supabase.auth.signOut();
    } on AuthException catch (e) {
      throw AuthenticationError(
        technicalMessage: 'Sign out failed: ${e.message}',
        originalError: e,
      );
    } catch (e) {
      throw NetworkError(
        technicalMessage: 'Network error during sign out: $e',
        originalError: e,
      );
    }
  }

  @override
  Future<AuthSessionModel?> getCurrentSession() async {
    try {
      final session = _supabase.auth.currentSession;
      if (session == null) return null;

      return AuthSessionModel.fromSupabaseSession(session);
    } catch (e) {
      throw CacheError(
        operation: 'get_current_session',
        technicalMessage: 'Failed to get current session: $e',
        originalError: e,
      );
    }
  }

  @override
  Future<AuthUserModel?> getCurrentUser() async {
    try {
      final user = _supabase.auth.currentUser;
      if (user == null) return null;

      return AuthUserModel.fromSupabaseUser(user);
    } catch (e) {
      throw CacheError(
        operation: 'get_current_user',
        technicalMessage: 'Failed to get current user: $e',
        originalError: e,
      );
    }
  }

  @override
  Future<AuthSessionModel> refreshSession(String refreshToken) async {
    try {
      final response = await _supabase.auth.refreshSession();

      if (response.session == null) {
        throw const AuthenticationError(
          technicalMessage: 'No session returned from refresh',
        );
      }

      return AuthSessionModel.fromSupabaseSession(response.session!);
    } on AuthException catch (e) {
      throw AuthenticationError(
        technicalMessage: 'Session refresh failed: ${e.message}',
        originalError: e,
      );
    } catch (e) {
      throw NetworkError(
        technicalMessage: 'Network error during session refresh: $e',
        originalError: e,
      );
    }
  }

  @override
  Future<void> resetPassword(String email) async {
    try {
      await _supabase.auth.resetPasswordForEmail(
        email,
        redirectTo: 'pocketly://callback/reset-password',
      );
    } on AuthException catch (e) {
      throw AuthenticationError(
        technicalMessage: 'Password reset failed: ${e.message}',
        originalError: e,
      );
    } catch (e) {
      throw NetworkError(
        technicalMessage: 'Network error during password reset: $e',
        originalError: e,
      );
    }
  }

  @override
  Future<void> updatePassword(String newPassword) async {
    try {
      await _supabase.auth.updateUser(
        UserAttributes(password: newPassword),
      );
    } on AuthException catch (e) {
      throw AuthenticationError(
        technicalMessage: 'Password update failed: ${e.message}',
        originalError: e,
      );
    } catch (e) {
      throw NetworkError(
        technicalMessage: 'Network error during password update: $e',
        originalError: e,
      );
    }
  }

  @override
  Future<void> updateEmail(String newEmail) async {
    try {
      await _supabase.auth.updateUser(
        UserAttributes(email: newEmail),
      );
    } on AuthException catch (e) {
      throw AuthenticationError(
        technicalMessage: 'Email update failed: ${e.message}',
        originalError: e,
      );
    } catch (e) {
      throw NetworkError(
        technicalMessage: 'Network error during email update: $e',
        originalError: e,
      );
    }
  }

  @override
  Stream<AuthUserModel?> authStateChanges() {
    return _supabase.auth.onAuthStateChange.map((event) {
      final user = event.session?.user;
      if (user == null) return null;
      return AuthUserModel.fromSupabaseUser(user);
    });
  }
}

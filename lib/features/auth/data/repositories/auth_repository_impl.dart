import '../../domain/entities/auth_session.dart';
import '../../domain/entities/auth_user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';
import '../models/auth_session_model.dart';

/// Implémentation du repository d'authentification.
///
/// Orchestre l'accès aux données d'authentification.
class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl(this._remoteDataSource);

  final AuthRemoteDataSource _remoteDataSource;

  @override
  Future<AuthSession> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final sessionModel = await _remoteDataSource.signInWithEmail(
        email: email,
        password: password,
      );
      return sessionModel.toEntity();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<AuthSession> signUpWithEmail({
    required String email,
    required String password,
    String? name,
  }) async {
    try {
      final sessionModel = await _remoteDataSource.signUpWithEmail(
        email: email,
        password: password,
        name: name,
      );
      return sessionModel.toEntity();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _remoteDataSource.signOut();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<AuthSession?> getCurrentSession() async {
    try {
      final sessionModel = await _remoteDataSource.getCurrentSession();
      return sessionModel?.toEntity();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<AuthUser?> getCurrentUser() async {
    try {
      final userModel = await _remoteDataSource.getCurrentUser();
      return userModel?.toEntity();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<AuthSession> refreshSession(String refreshToken) async {
    try {
      final sessionModel = await _remoteDataSource.refreshSession(refreshToken);
      return sessionModel.toEntity();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> resetPassword(String email) async {
    try {
      await _remoteDataSource.resetPassword(email);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updatePassword(String newPassword) async {
    try {
      await _remoteDataSource.updatePassword(newPassword);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateEmail(String newEmail) async {
    try {
      await _remoteDataSource.updateEmail(newEmail);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> isAuthenticated() async {
    try {
      final session = await getCurrentSession();
      return session != null && !session.isExpired;
    } catch (e) {
      return false;
    }
  }

  @override
  Stream<AuthUser?> authStateChanges() {
    return _remoteDataSource.authStateChanges().map(
      (userModel) => userModel?.toEntity(),
    );
  }
}

import 'package:freezed_annotation/freezed_annotation.dart';
import 'auth_session.dart';

part 'auth_state.freezed.dart';

/// État d'authentification de l'application.
///
/// Utilise Freezed pour un pattern d'état typé et immutable.
@freezed
sealed class AuthState with _$AuthState {
  /// État initial - pas encore vérifié
  const factory AuthState.initial() = AuthInitial;

  /// Chargement en cours
  const factory AuthState.loading() = AuthLoading;

  /// Utilisateur authentifié avec session active
  const factory AuthState.authenticated(AuthSession session) = AuthAuthenticated;

  /// Utilisateur non authentifié
  const factory AuthState.unauthenticated() = AuthUnauthenticated;

  /// Erreur d'authentification
  const factory AuthState.error(String message) = AuthError;
}

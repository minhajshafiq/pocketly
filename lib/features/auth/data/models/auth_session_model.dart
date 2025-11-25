import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;
import '../../domain/entities/auth_session.dart';
import 'auth_user_model.dart';

part 'auth_session_model.freezed.dart';
part 'auth_session_model.g.dart';

/// Modèle de données pour AuthSession.
///
/// Utilisé pour la conversion depuis/vers Supabase Session.
@freezed
sealed class AuthSessionModel with _$AuthSessionModel {
  const factory AuthSessionModel({
    required String accessToken,
    required String refreshToken,
    required AuthUserModel user,
    required DateTime expiresAt,
    String? tokenType,
  }) = _AuthSessionModel;

  factory AuthSessionModel.fromJson(Map<String, dynamic> json) =>
      _$AuthSessionModelFromJson(json);

  /// Créer un modèle depuis une session Supabase
  factory AuthSessionModel.fromSupabaseSession(supabase.Session session) {
    return AuthSessionModel(
      accessToken: session.accessToken,
      refreshToken: session.refreshToken ?? '',
      user: AuthUserModel.fromSupabaseUser(session.user),
      expiresAt: DateTime.fromMillisecondsSinceEpoch(session.expiresAt! * 1000),
      tokenType: session.tokenType,
    );
  }
}

/// Extension pour la conversion entre AuthSessionModel et AuthSession
extension AuthSessionModelX on AuthSessionModel {
  /// Convertit le modèle en entité du domaine
  AuthSession toEntity() {
    return AuthSession(
      accessToken: accessToken,
      refreshToken: refreshToken,
      user: user.toEntity(),
      expiresAt: expiresAt,
      tokenType: tokenType,
    );
  }
}

/// Extension pour la conversion depuis AuthSession vers AuthSessionModel
extension AuthSessionToModelX on AuthSession {
  /// Convertit l'entité en modèle de données
  AuthSessionModel toModel() {
    return AuthSessionModel(
      accessToken: accessToken,
      refreshToken: refreshToken,
      user: user.toModel(),
      expiresAt: expiresAt,
      tokenType: tokenType,
    );
  }
}

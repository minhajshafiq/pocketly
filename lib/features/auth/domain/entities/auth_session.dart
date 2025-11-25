import 'package:freezed_annotation/freezed_annotation.dart';
import 'auth_user.dart';

part 'auth_session.freezed.dart';
part 'auth_session.g.dart';

/// Entité représentant une session d'authentification.
///
/// Contient l'utilisateur authentifié et les tokens d'accès.
@freezed
sealed class AuthSession with _$AuthSession {
  const factory AuthSession({
    required String accessToken,
    required String refreshToken,
    required AuthUser user,
    required DateTime expiresAt,
    String? tokenType,
  }) = _AuthSession;

  factory AuthSession.fromJson(Map<String, dynamic> json) =>
      _$AuthSessionFromJson(json);
}

/// Extension pour la logique métier de AuthSession
extension AuthSessionX on AuthSession {
  /// Vérifie si la session est expirée
  bool get isExpired => DateTime.now().isAfter(expiresAt);

  /// Vérifie si la session va expirer bientôt (moins de 1 heure)
  bool get isExpiringSoon {
    final timeUntilExpiry = expiresAt.difference(DateTime.now());
    return timeUntilExpiry.inMinutes < 60;
  }

  /// Temps restant avant expiration
  Duration get timeUntilExpiry => expiresAt.difference(DateTime.now());
}

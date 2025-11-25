import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_user.freezed.dart';
part 'auth_user.g.dart';

/// Entité représentant un utilisateur authentifié.
///
/// Contient les informations d'authentification de base de Supabase Auth.
@freezed
sealed class AuthUser with _$AuthUser {
  const factory AuthUser({
    required String id,
    required String email,
    String? phone,
    DateTime? emailConfirmedAt,
    DateTime? phoneConfirmedAt,
    DateTime? lastSignInAt,
    required DateTime createdAt,
    DateTime? updatedAt,
  }) = _AuthUser;

  factory AuthUser.fromJson(Map<String, dynamic> json) =>
      _$AuthUserFromJson(json);
}

/// Extension pour la logique métier de AuthUser
extension AuthUserX on AuthUser {
  /// Vérifie si l'email est confirmé
  bool get isEmailConfirmed => emailConfirmedAt != null;

  /// Vérifie si le téléphone est confirmé
  bool get isPhoneConfirmed => phoneConfirmedAt != null;

  /// Vérifie si l'utilisateur s'est connecté récemment (moins de 7 jours)
  bool get hasRecentLogin {
    if (lastSignInAt == null) return false;
    final daysSinceLogin = DateTime.now().difference(lastSignInAt!).inDays;
    return daysSinceLogin < 7;
  }

  /// Identifiant d'affichage (email ou téléphone)
  String get displayId => email.isNotEmpty ? email : (phone ?? id);
}

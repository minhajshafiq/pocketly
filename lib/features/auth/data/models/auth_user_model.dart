import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide AuthUser;
import '../../domain/entities/auth_user.dart' as domain;
import 'package:pocketly/features/user/user.dart';

part 'auth_user_model.freezed.dart';
part 'auth_user_model.g.dart';

/// Modèle pour les données d'authentification Supabase
@freezed
sealed class AuthUserModel with _$AuthUserModel {
  const factory AuthUserModel({
    required String id,
    required String email,
    String? name,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    @JsonKey(name: 'email_confirmed_at') DateTime? emailConfirmedAt,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
    Map<String, dynamic>? metadata,
  }) = _AuthUserModel;

  const AuthUserModel._();

  /// Factory pour créer depuis User de Supabase
  factory AuthUserModel.fromSupabaseUser(User user) {
    // Parse dates safely
    DateTime? emailConfirmedAt;
    DateTime? createdAt;
    DateTime? updatedAt;
    
    try {
      if (user.emailConfirmedAt != null) {
        emailConfirmedAt = DateTime.parse(user.emailConfirmedAt!);
      }
    } catch (e) {
      // Ignore parsing errors
    }
    
    try {
      createdAt = DateTime.parse(user.createdAt);
    } catch (e) {
      // Ignore parsing errors
    }
    
    try {
      updatedAt = DateTime.parse(user.updatedAt!);
    } catch (e) {
      // Ignore parsing errors
    }
    
    return AuthUserModel(
      id: user.id,
      email: user.email ?? '',
      name: user.userMetadata?['name'] as String?,
      avatarUrl: user.userMetadata?['avatar_url'] as String?,
      emailConfirmedAt: emailConfirmedAt,
      createdAt: createdAt,
      updatedAt: updatedAt,
      metadata: user.userMetadata,
    );
  }

  factory AuthUserModel.fromJson(Map<String, dynamic> json) =>
      _$AuthUserModelFromJson(json);

  /// Convertit vers UserEntity
  UserEntity toUserEntity() {
    return UserEntity(
      id: id,
      email: email,
      name: name,
      avatarUrl: avatarUrl,
      isPremium: false,
      premiumTrialStart: null,
      premiumTrialEnd: null,
      hasCompletedOnboarding: false,
      createdAt: createdAt ?? DateTime.now(),
      updatedAt: updatedAt ?? DateTime.now(),
    );
  }

  /// Convertit vers l'entité AuthUser du domaine
  domain.AuthUser toEntity() {
    return domain.AuthUser(
      id: id,
      email: email,
      phone: null,
      emailConfirmedAt: emailConfirmedAt,
      phoneConfirmedAt: null,
      lastSignInAt: null,
      createdAt: createdAt ?? DateTime.now(),
      updatedAt: updatedAt,
    );
  }
}

/// Extension pour convertir AuthUser vers AuthUserModel
extension AuthUserToAuthUserModelX on domain.AuthUser {
  AuthUserModel toModel() {
    return AuthUserModel(
      id: id,
      email: email,
      name: null,
      avatarUrl: null,
      emailConfirmedAt: emailConfirmedAt,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

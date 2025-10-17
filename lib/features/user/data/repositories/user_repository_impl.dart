import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:pocketly/features/user/domain/entities/user_entity.dart';
import 'package:pocketly/features/user/domain/repositories/user_repository.dart';

/// Implémentation du repository utilisateur avec Supabase.
/// 
/// Gère la persistance et la récupération des données utilisateur
/// via Supabase (auth + table users).
class UserRepositoryImpl implements UserRepository {
  final SupabaseClient _supabase;

  UserRepositoryImpl(this._supabase);

  /// Table Supabase pour les utilisateurs
  static const String _usersTable = 'users';

  @override
  Future<UserEntity?> getCurrentUser() async {
    try {
      final authUser = _supabase.auth.currentUser;
      if (authUser == null) return null;

      final response = await _supabase
          .from(_usersTable)
          .select()
          .eq('id', authUser.id)
          .maybeSingle();

      if (response == null) return null;

      return UserEntity.fromJson(response);
    } catch (e) {
      throw Exception('Erreur lors de la récupération de l\'utilisateur: $e');
    }
  }

  @override
  Stream<UserEntity?> watchCurrentUser() {
    final authUser = _supabase.auth.currentUser;
    if (authUser == null) {
      return Stream.value(null);
    }

    return _supabase
        .from(_usersTable)
        .stream(primaryKey: ['id'])
        .eq('id', authUser.id)
        .map((data) {
          if (data.isEmpty) return null;
          return UserEntity.fromJson(data.first);
        });
  }

  @override
  Future<UserEntity> updateUser(UserEntity user) async {
    try {
      final response = await _supabase
          .from(_usersTable)
          .update({
            ...user.toJson(),
            'updated_at': DateTime.now().toIso8601String(),
          })
          .eq('id', user.id)
          .select()
          .single();

      return UserEntity.fromJson(response);
    } catch (e) {
      throw Exception('Erreur lors de la mise à jour de l\'utilisateur: $e');
    }
  }

  @override
  Future<void> deleteUser(String userId) async {
    try {
      await _supabase.from(_usersTable).delete().eq('id', userId);
    } catch (e) {
      throw Exception('Erreur lors de la suppression de l\'utilisateur: $e');
    }
  }

  @override
  Future<UserEntity> activateTrial(String userId) async {
    try {
      final now = DateTime.now();
      final trialEnd = now.add(const Duration(days: 14));

      final response = await _supabase
          .from(_usersTable)
          .update({
            'premium_trial_start': now.toIso8601String(),
            'premium_trial_end': trialEnd.toIso8601String(),
            'updated_at': now.toIso8601String(),
          })
          .eq('id', userId)
          .select()
          .single();

      return UserEntity.fromJson(response);
    } catch (e) {
      throw Exception('Erreur lors de l\'activation du trial: $e');
    }
  }

  @override
  Future<UserEntity> activatePremium(String userId, DateTime expiresAt) async {
    try {
      final now = DateTime.now();

      final response = await _supabase
          .from(_usersTable)
          .update({
            'is_premium': true,
            'premium_expires_at': expiresAt.toIso8601String(),
            'updated_at': now.toIso8601String(),
          })
          .eq('id', userId)
          .select()
          .single();

      return UserEntity.fromJson(response);
    } catch (e) {
      throw Exception('Erreur lors de l\'activation du premium: $e');
    }
  }

  @override
  Future<void> updatePushToken(String userId, String token) async {
    try {
      await _supabase.from(_usersTable).update({
        'push_token': token,
        'updated_at': DateTime.now().toIso8601String(),
      }).eq('id', userId);
    } catch (e) {
      throw Exception('Erreur lors de la mise à jour du token push: $e');
    }
  }

  @override
  Future<UserEntity> completeOnboarding(String userId) async {
    try {
      final now = DateTime.now();

      final response = await _supabase
          .from(_usersTable)
          .update({
            'has_completed_onboarding': true,
            'updated_at': now.toIso8601String(),
          })
          .eq('id', userId)
          .select()
          .single();

      return UserEntity.fromJson(response);
    } catch (e) {
      throw Exception('Erreur lors de la complétion de l\'onboarding: $e');
    }
  }
}


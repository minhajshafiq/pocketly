import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/core.dart';
import '../../../../core/services/logger_service.dart';
import '../models/user_model.dart';
import 'user_remote_datasource.dart';

/// Implémentation du datasource remote pour les utilisateurs avec Supabase.
///
/// Gère l'accès aux données utilisateur depuis Supabase.
class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  const UserRemoteDataSourceImpl(this._supabase);

  final SupabaseClient _supabase;
  final logger = const LoggerService();

  @override
  Future<UserModel?> getCurrentUser() async {
    try {
      final user = _supabase.auth.currentUser;
      if (user == null) return null;

      final response = await _supabase
          .from('users')
          .select()
          .eq('id', user.id)
          .maybeSingle();

      if (response == null) return null;

      // Debug: Vérifier les valeurs récupérées depuis Supabase
      logger.d('[UserRemoteDataSource] Récupération depuis Supabase:');
      logger.d('   budget_rule_needs: ${response['budget_rule_needs']}');
      logger.d('   budget_rule_wants: ${response['budget_rule_wants']}');
      logger.d('   budget_rule_savings: ${response['budget_rule_savings']}');

      return UserModel.fromJson(response);
    } on PostgrestException catch (e) {
      throw ServerError(
        technicalMessage: 'Failed to get current user: ${e.message}',
      );
    } catch (e) {
      throw NetworkError(
        technicalMessage: 'Network error while getting current user: $e',
      );
    }
  }

  @override
  Future<UserModel> createUser(UserModel user) async {
    try {
      logger.d('[UserDataSource] Création/mise à jour utilisateur: ${user.email}');

      // Utiliser UPSERT pour gérer le cas où un trigger a déjà créé l'utilisateur
      final response = await _supabase
          .from('users')
          .upsert(
            user.toJson(),
            onConflict: 'id', // Utiliser l'ID comme clé de conflit
          )
          .select()
          .single();

      logger.i('[UserDataSource] Utilisateur créé/mis à jour avec succès');
      return UserModel.fromJson(response);
    } on PostgrestException catch (e) {
      logger.e('[UserDataSource] PostgrestException: ${e.message} (code: ${e.code})', error: e);
      throw ServerError(
        technicalMessage: 'Failed to create user: ${e.message}',
      );
    } catch (e) {
      logger.e('[UserDataSource] Erreur réseau: $e', error: e);
      throw NetworkError(
        technicalMessage: 'Network error while creating user: $e',
      );
    }
  }

  @override
  Future<UserModel> updateUser(UserModel user) async {
    try {
      final response = await _supabase
          .from('users')
          .update(user.toJson())
          .eq('id', user.id)
          .select()
          .single();

      return UserModel.fromJson(response);
    } on PostgrestException catch (e) {
      if (e.code == 'PGRST116') {
        throw NotFoundError(
          resourceType: 'User',
          technicalMessage: 'User not found',
        );
      }
      throw ServerError(
        technicalMessage: 'Failed to update user: ${e.message}',
      );
    } catch (e) {
      throw NetworkError(
        technicalMessage: 'Network error while updating user: $e',
      );
    }
  }

  @override
  Future<void> deleteUser(String userId) async {
    try {
      // Appeler la fonction PostgreSQL qui gère la suppression en cascade
      await _supabase.rpc(
        'delete_user_account',
        params: {'user_id_to_delete': userId},
      );
    } on PostgrestException catch (e) {
      if (e.message.contains('not found')) {
        throw NotFoundError(
          resourceType: 'User',
          technicalMessage: 'User not found',
        );
      }
      throw ServerError(
        technicalMessage: 'Failed to delete user: ${e.message}',
      );
    } catch (e) {
      throw NetworkError(
        technicalMessage: 'Network error while deleting user: $e',
      );
    }
  }

  @override
  Future<UserModel> activateTrial(String userId) async {
    try {
      final now = DateTime.now().toUtc();
      final trialEnd = now.add(const Duration(days: 14));

      final response = await _supabase
          .from('users')
          .update({
            'premium_trial_start': now.toIso8601String(),
            'premium_trial_end': trialEnd.toIso8601String(),
            'updated_at': now.toIso8601String(),
          })
          .eq('id', userId)
          .select()
          .single();

      return UserModel.fromJson(response);
    } on PostgrestException catch (e) {
      if (e.code == 'PGRST116') {
        throw NotFoundError(
          resourceType: 'User',
          technicalMessage: 'User not found',
        );
      }
      throw ServerError(
        technicalMessage: 'Failed to activate trial: ${e.message}',
      );
    } catch (e) {
      throw NetworkError(
        technicalMessage: 'Network error while activating trial: $e',
      );
    }
  }

  @override
  Future<UserModel> activatePremium(String userId, DateTime expiresAt) async {
    try {
      final now = DateTime.now().toUtc();

      final response = await _supabase
          .from('users')
          .update({
            'is_premium': true,
            'premium_expires_at': expiresAt.toIso8601String(),
            'updated_at': now.toIso8601String(),
          })
          .eq('id', userId)
          .select()
          .single();

      return UserModel.fromJson(response);
    } on PostgrestException catch (e) {
      if (e.code == 'PGRST116') {
        throw NotFoundError(
          resourceType: 'User',
          technicalMessage: 'User not found',
        );
      }
      throw ServerError(
        technicalMessage: 'Failed to activate premium: ${e.message}',
      );
    } catch (e) {
      throw NetworkError(
        technicalMessage: 'Network error while activating premium: $e',
      );
    }
  }

  @override
  Future<UserModel> completeOnboarding(String userId) async {
    try {
      final now = DateTime.now().toUtc();

      final response = await _supabase
          .from('users')
          .update({
            'has_completed_onboarding': true,
            'updated_at': now.toIso8601String(),
          })
          .eq('id', userId)
          .select()
          .single();

      return UserModel.fromJson(response);
    } on PostgrestException catch (e) {
      if (e.code == 'PGRST116') {
        throw NotFoundError(
          resourceType: 'User',
          technicalMessage: 'User not found',
        );
      }
      throw ServerError(
        technicalMessage: 'Failed to complete onboarding: ${e.message}',
      );
    } catch (e) {
      throw NetworkError(
        technicalMessage: 'Network error while completing onboarding: $e',
      );
    }
  }

  @override
  Future<UserModel> updatePushToken(String userId, String pushToken) async {
    try {
      final now = DateTime.now().toUtc();

      final response = await _supabase
          .from('users')
          .update({
            'push_token': pushToken,
            'updated_at': now.toIso8601String(),
          })
          .eq('id', userId)
          .select()
          .single();

      return UserModel.fromJson(response);
    } on PostgrestException catch (e) {
      if (e.code == 'PGRST116') {
        throw NotFoundError(
          resourceType: 'User',
          technicalMessage: 'User not found',
        );
      }
      throw ServerError(
        technicalMessage: 'Failed to update push token: ${e.message}',
      );
    } catch (e) {
      throw NetworkError(
        technicalMessage: 'Network error while updating push token: $e',
      );
    }
  }

  @override
  Future<UserModel> updateNotificationPreferences(
    String userId,
    bool notificationsEnabled,
  ) async {
    try {
      final now = DateTime.now().toUtc();

      final response = await _supabase
          .from('users')
          .update({
            'notifications_enabled': notificationsEnabled,
            'updated_at': now.toIso8601String(),
          })
          .eq('id', userId)
          .select()
          .single();

      return UserModel.fromJson(response);
    } on PostgrestException catch (e) {
      if (e.code == 'PGRST116') {
        throw NotFoundError(
          resourceType: 'User',
          technicalMessage: 'User not found',
        );
      }
      throw ServerError(
        technicalMessage:
            'Failed to update notification preferences: ${e.message}',
      );
    } catch (e) {
      throw NetworkError(
        technicalMessage:
            'Network error while updating notification preferences: $e',
      );
    }
  }

  @override
  Future<UserModel> updateUserAvatarUrl({
    required String userId,
    required String? avatarUrl,
  }) async {
    try {
      final now = DateTime.now().toUtc();

      final response = await _supabase
          .from('users')
          .update({
            'avatar_url': avatarUrl,
            'updated_at': now.toIso8601String(),
          })
          .eq('id', userId)
          .select()
          .single();

      return UserModel.fromJson(response);
    } on PostgrestException catch (e) {
      if (e.code == 'PGRST116') {
        throw NotFoundError(
          resourceType: 'User',
          technicalMessage: 'User not found',
        );
      }
      throw ServerError(
        technicalMessage: 'Failed to update user avatar URL: ${e.message}',
      );
    } catch (e) {
      throw NetworkError(
        technicalMessage: 'Network error while updating user avatar URL: $e',
      );
    }
  }

  @override
  Future<UserModel> updateBudgetRule({
    required String userId,
    required int needs,
    required int wants,
    required int savings,
  }) async {
    try {
      // Valider que la somme est égale à 100
      if (needs + wants + savings != 100) {
        throw ValidationError(
          field: 'budget_rule',
          technicalMessage:
              'Budget rule percentages must add up to 100 (got ${needs + wants + savings})',
        );
      }

      // Valider que chaque valeur est entre 0 et 100
      if (needs < 0 || needs > 100 || wants < 0 || wants > 100 || savings < 0 || savings > 100) {
        throw ValidationError(
          field: 'budget_rule',
          technicalMessage: 'Budget rule percentages must be between 0 and 100',
        );
      }

      final now = DateTime.now().toUtc();

      final response = await _supabase
          .from('users')
          .update({
            'budget_rule_needs': needs,
            'budget_rule_wants': wants,
            'budget_rule_savings': savings,
            'updated_at': now.toIso8601String(),
          })
          .eq('id', userId)
          .select()
          .single();

      // Debug: Vérifier la réponse de Supabase
      logger.d('[UserRemoteDataSource] Réponse Supabase après update:');
      logger.d('   budget_rule_needs: ${response['budget_rule_needs']}');
      logger.d('   budget_rule_wants: ${response['budget_rule_wants']}');
      logger.d('   budget_rule_savings: ${response['budget_rule_savings']}');

      final userModel = UserModel.fromJson(response);

      // Debug: Vérifier le modèle parsé
      logger.d('[UserRemoteDataSource] UserModel parsé:');
      logger.d('   budgetRuleNeeds: ${userModel.budgetRuleNeeds}');
      logger.d('   budgetRuleWants: ${userModel.budgetRuleWants}');
      logger.d('   budgetRuleSavings: ${userModel.budgetRuleSavings}');

      return userModel;
    } on PostgrestException catch (e) {
      if (e.code == 'PGRST116') {
        throw NotFoundError(
          resourceType: 'User',
          technicalMessage: 'User not found',
        );
      }
      // Erreur de contrainte CHECK (budget_rule_sum_check)
      if (e.code == '23514' || e.message.contains('budget_rule_sum_check')) {
        throw ValidationError(
          field: 'budget_rule',
          technicalMessage: 'Budget rule percentages must add up to 100',
        );
      }
      throw ServerError(
        technicalMessage: 'Failed to update budget rule: ${e.message}',
      );
    } catch (e) {
      if (e is ValidationError) rethrow;
      throw NetworkError(
        technicalMessage: 'Network error while updating budget rule: $e',
      );
    }
  }
}

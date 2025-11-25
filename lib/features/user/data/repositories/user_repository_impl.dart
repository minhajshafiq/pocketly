import '../../../../core/services/logger_service.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/user_remote_datasource.dart';
import '../datasources/user_local_datasource.dart';
import '../models/user_model.dart';

/// Implémentation du repository utilisateur.
///
/// Orchestre l'accès aux données entre les datasources remote et local.
/// Suit le pattern Clean Architecture en implémentant l'interface du domaine.
class UserRepositoryImpl implements UserRepository {
  const UserRepositoryImpl(this._remoteDataSource, this._localDataSource);

  final UserRemoteDataSource _remoteDataSource;
  final UserLocalDataSource _localDataSource;
  final logger = const LoggerService();

  @override
  Future<UserEntity?> getCurrentUser() async {
    try {
      // TOUJOURS récupérer depuis le remote pour avoir les données à jour
      final remoteUser = await _remoteDataSource.getCurrentUser();
      if (remoteUser != null) {
        // Sauvegarder en local pour le cache
        await _localDataSource.saveCurrentUser(remoteUser);
        return remoteUser.toEntity();
      }

      return null;
    } catch (e) {
      // En cas d'erreur réseau, essayer de récupérer depuis le cache local
      try {
        final localUser = await _localDataSource.getCurrentUser();
        return localUser?.toEntity();
      } catch (_) {
        rethrow;
      }
    }
  }

  @override
  Future<UserEntity> createUser(UserEntity user) async {
    try {
      final userModel = user.toModel();
      final createdUser = await _remoteDataSource.createUser(userModel);

      // Sauvegarder en local
      await _localDataSource.saveCurrentUser(createdUser);

      return createdUser.toEntity();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserEntity> updateUser(UserEntity user) async {
    try {
      final userModel = user.toModel();
      final updatedUser = await _remoteDataSource.updateUser(userModel);

      // Mettre à jour le stockage local
      await _localDataSource.saveCurrentUser(updatedUser);

      return updatedUser.toEntity();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteUser(String userId) async {
    try {
      await _remoteDataSource.deleteUser(userId);

      // Supprimer du stockage local
      await _localDataSource.clearCurrentUser();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserEntity> activateTrial(String userId) async {
    try {
      final updatedUser = await _remoteDataSource.activateTrial(userId);

      // Mettre à jour le stockage local
      await _localDataSource.saveCurrentUser(updatedUser);

      return updatedUser.toEntity();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserEntity> activatePremium(String userId, DateTime expiresAt) async {
    try {
      final updatedUser = await _remoteDataSource.activatePremium(
        userId,
        expiresAt,
      );

      // Mettre à jour le stockage local
      await _localDataSource.saveCurrentUser(updatedUser);

      return updatedUser.toEntity();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserEntity> completeOnboarding(String userId) async {
    try {
      final updatedUser = await _remoteDataSource.completeOnboarding(userId);

      // Mettre à jour le stockage local
      await _localDataSource.saveCurrentUser(updatedUser);

      return updatedUser.toEntity();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserEntity> updatePushToken(String userId, String pushToken) async {
    try {
      final updatedUser = await _remoteDataSource.updatePushToken(
        userId,
        pushToken,
      );

      // Sauvegarder le token localement
      await _localDataSource.savePushToken(pushToken);

      // Mettre à jour le stockage local
      await _localDataSource.saveCurrentUser(updatedUser);

      return updatedUser.toEntity();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserEntity> updateNotificationPreferences(
    String userId,
    bool notificationsEnabled,
  ) async {
    try {
      final updatedUser = await _remoteDataSource.updateNotificationPreferences(
        userId,
        notificationsEnabled,
      );

      // Mettre à jour le stockage local
      await _localDataSource.saveCurrentUser(updatedUser);

      return updatedUser.toEntity();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserEntity> updateUserAvatarUrl({
    required String userId,
    required String? avatarUrl,
  }) async {
    try {
      final updatedUser = await _remoteDataSource.updateUserAvatarUrl(
        userId: userId,
        avatarUrl: avatarUrl,
      );

      // Mettre à jour le stockage local
      await _localDataSource.saveCurrentUser(updatedUser);

      return updatedUser.toEntity();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserEntity> updateBudgetRule({
    required String userId,
    required int needs,
    required int wants,
    required int savings,
  }) async {
    try {
      final updatedUser = await _remoteDataSource.updateBudgetRule(
        userId: userId,
        needs: needs,
        wants: wants,
        savings: savings,
      );

      // Debug: Vérifier le modèle avant conversion
      logger.d('[UserRepository] UserModel avant conversion:');
      logger.d('   budgetRuleNeeds: ${updatedUser.budgetRuleNeeds}');
      logger.d('   budgetRuleWants: ${updatedUser.budgetRuleWants}');
      logger.d('   budgetRuleSavings: ${updatedUser.budgetRuleSavings}');

      // Mettre à jour le stockage local
      await _localDataSource.saveCurrentUser(updatedUser);

      final entity = updatedUser.toEntity();

      // Debug: Vérifier l'entité après conversion
      logger.d('[UserRepository] UserEntity après conversion:');
      logger.d('   budgetRuleNeeds: ${entity.budgetRuleNeeds}');
      logger.d('   budgetRuleWants: ${entity.budgetRuleWants}');
      logger.d('   budgetRuleSavings: ${entity.budgetRuleSavings}');

      return entity;
    } catch (e) {
      rethrow;
    }
  }
}

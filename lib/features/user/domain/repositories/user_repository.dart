import 'package:pocketly/features/user/domain/entities/user_entity.dart';

/// Interface du repository utilisateur.
/// 
/// Définit les opérations disponibles pour gérer les utilisateurs.
/// Respecte le principe de l'Inversion de Dépendance (Clean Architecture).
abstract class UserRepository {
  /// Récupère l'utilisateur actuellement connecté.
  /// 
  /// Retourne `null` si aucun utilisateur n'est connecté.
  Future<UserEntity?> getCurrentUser();

  /// Observe les changements de l'utilisateur actuel en temps réel.
  /// 
  /// Émet `null` si l'utilisateur se déconnecte.
  Stream<UserEntity?> watchCurrentUser();

  /// Met à jour les informations de l'utilisateur.
  /// 
  /// [user] L'utilisateur avec les nouvelles données.
  /// Retourne l'utilisateur mis à jour.
  Future<UserEntity> updateUser(UserEntity user);

  /// Supprime l'utilisateur.
  /// 
  /// [userId] L'ID de l'utilisateur à supprimer.
  Future<void> deleteUser(String userId);

  /// Active l'essai premium pour l'utilisateur.
  /// 
  /// [userId] L'ID de l'utilisateur.
  /// Retourne l'utilisateur avec le trial activé.
  Future<UserEntity> activateTrial(String userId);

  /// Active le premium pour l'utilisateur.
  /// 
  /// [userId] L'ID de l'utilisateur.
  /// [expiresAt] Date d'expiration du premium.
  /// Retourne l'utilisateur avec le premium activé.
  Future<UserEntity> activatePremium(String userId, DateTime expiresAt);

  /// Met à jour le token push de l'utilisateur.
  /// 
  /// [userId] L'ID de l'utilisateur.
  /// [token] Le nouveau token push.
  Future<void> updatePushToken(String userId, String token);

  /// Marque l'onboarding comme complété.
  /// 
  /// [userId] L'ID de l'utilisateur.
  Future<UserEntity> completeOnboarding(String userId);
}


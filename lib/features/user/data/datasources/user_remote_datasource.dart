import '../models/user_model.dart';

/// Interface du datasource remote pour les utilisateurs.
///
/// Définit les contrats pour l'accès aux données utilisateur
/// depuis une source distante (API, Supabase, etc.).
abstract class UserRemoteDataSource {
  /// Récupère l'utilisateur actuel depuis la source distante
  ///
  /// Retourne l'utilisateur connecté ou null si aucun utilisateur n'est connecté.
  ///
  /// Throws [NetworkError] si la connexion réseau échoue.
  /// Throws [ServerError] si le serveur retourne une erreur.
  Future<UserModel?> getCurrentUser();

  /// Crée un nouvel utilisateur dans la source distante
  ///
  /// [user] - Le modèle utilisateur à créer
  ///
  /// Retourne l'utilisateur créé avec l'ID généré.
  ///
  /// Throws [ValidationError] si les données utilisateur sont invalides.
  /// Throws [NetworkError] si la connexion réseau échoue.
  /// Throws [ServerError] si le serveur retourne une erreur.
  Future<UserModel> createUser(UserModel user);

  /// Met à jour un utilisateur existant dans la source distante
  ///
  /// [user] - Le modèle utilisateur avec les nouvelles données
  ///
  /// Retourne l'utilisateur mis à jour.
  ///
  /// Throws [ValidationError] si les données utilisateur sont invalides.
  /// Throws [NetworkError] si la connexion réseau échoue.
  /// Throws [ServerError] si le serveur retourne une erreur.
  /// Throws [NotFoundError] si l'utilisateur n'existe pas.
  Future<UserModel> updateUser(UserModel user);

  /// Supprime un utilisateur de la source distante
  ///
  /// [userId] - L'ID de l'utilisateur à supprimer
  ///
  /// Throws [NetworkError] si la connexion réseau échoue.
  /// Throws [ServerError] si le serveur retourne une erreur.
  /// Throws [NotFoundError] si l'utilisateur n'existe pas.
  Future<void> deleteUser(String userId);

  /// Active la période d'essai pour un utilisateur
  ///
  /// [userId] - L'ID de l'utilisateur
  ///
  /// Retourne l'utilisateur avec le trial activé.
  ///
  /// Throws [NetworkError] si la connexion réseau échoue.
  /// Throws [ServerError] si le serveur retourne une erreur.
  /// Throws [NotFoundError] si l'utilisateur n'existe pas.
  Future<UserModel> activateTrial(String userId);

  /// Active l'abonnement premium pour un utilisateur
  ///
  /// [userId] - L'ID de l'utilisateur
  /// [expiresAt] - Date d'expiration de l'abonnement premium
  ///
  /// Retourne l'utilisateur avec le premium activé.
  ///
  /// Throws [NetworkError] si la connexion réseau échoue.
  /// Throws [ServerError] si le serveur retourne une erreur.
  /// Throws [NotFoundError] si l'utilisateur n'existe pas.
  Future<UserModel> activatePremium(String userId, DateTime expiresAt);

  /// Marque l'onboarding comme complété pour un utilisateur
  ///
  /// [userId] - L'ID de l'utilisateur
  ///
  /// Retourne l'utilisateur avec l'onboarding complété.
  ///
  /// Throws [NetworkError] si la connexion réseau échoue.
  /// Throws [ServerError] si le serveur retourne une erreur.
  /// Throws [NotFoundError] si l'utilisateur n'existe pas.
  Future<UserModel> completeOnboarding(String userId);

  /// Met à jour le token de notification push
  ///
  /// [userId] - L'ID de l'utilisateur
  /// [pushToken] - Le nouveau token de notification
  ///
  /// Retourne l'utilisateur avec le token mis à jour.
  ///
  /// Throws [NetworkError] si la connexion réseau échoue.
  /// Throws [ServerError] si le serveur retourne une erreur.
  /// Throws [NotFoundError] si l'utilisateur n'existe pas.
  Future<UserModel> updatePushToken(String userId, String pushToken);

  /// Met à jour les préférences de notification
  ///
  /// [userId] - L'ID de l'utilisateur
  /// [notificationsEnabled] - État des notifications
  ///
  /// Retourne l'utilisateur avec les préférences mises à jour.
  ///
  /// Throws [NetworkError] si la connexion réseau échoue.
  /// Throws [ServerError] si le serveur retourne une erreur.
  /// Throws [NotFoundError] si l'utilisateur n'existe pas.
  Future<UserModel> updateNotificationPreferences(
    String userId,
    bool notificationsEnabled,
  );

  /// Met à jour l'URL de l'avatar utilisateur
  ///
  /// [userId] - L'ID de l'utilisateur
  /// [avatarUrl] - La nouvelle URL de l'avatar (null pour supprimer)
  ///
  /// Retourne l'utilisateur avec l'avatar mis à jour.
  ///
  /// Throws [NetworkError] si la connexion réseau échoue.
  /// Throws [ServerError] si le serveur retourne une erreur.
  /// Throws [NotFoundError] si l'utilisateur n'existe pas.
  Future<UserModel> updateUserAvatarUrl({
    required String userId,
    required String? avatarUrl,
  });

  /// Met à jour la règle budgétaire personnalisée de l'utilisateur
  ///
  /// [userId] - L'ID de l'utilisateur
  /// [needs] - Pourcentage alloué aux besoins (0-100)
  /// [wants] - Pourcentage alloué aux envies (0-100)
  /// [savings] - Pourcentage alloué à l'épargne (0-100)
  ///
  /// Retourne l'utilisateur avec la règle budgétaire mise à jour.
  ///
  /// Throws [ValidationError] si la somme n'est pas égale à 100 ou si les valeurs sont invalides.
  /// Throws [NetworkError] si la connexion réseau échoue.
  /// Throws [ServerError] si le serveur retourne une erreur.
  /// Throws [NotFoundError] si l'utilisateur n'existe pas.
  Future<UserModel> updateBudgetRule({
    required String userId,
    required int needs,
    required int wants,
    required int savings,
  });
}

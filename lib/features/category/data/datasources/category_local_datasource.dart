import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:pocketly/core/errors/errors.dart';
import 'package:pocketly/core/services/logger_service.dart';
import '../models/category_model.dart';
import '../../domain/entities/category_entity.dart';

/// Implémentation SharedPreferences de la source de données locale
class CategoryLocalDataSource {
  static const String _categoriesKey = 'categories_cache';
  static const String _cacheTimestampKey = 'categories_cache_timestamp';
  static const String _userCacheKey = 'categories_user_id';

  final SharedPreferences _prefs;
  final logger = const LoggerService();

  CategoryLocalDataSource({required SharedPreferences prefs}) : _prefs = prefs;

  /// Récupère toutes les catégories du cache local (sécurisé par utilisateur)
  Future<List<CategoryModel>> getAllCategories({String? currentUserId}) async {
    try {
      // Vérifier si l'utilisateur a changé (SÉCURITÉ CRITIQUE)
      final cachedUserId = _prefs.getString(_userCacheKey);

      if (cachedUserId != null &&
          currentUserId != null &&
          cachedUserId != currentUserId) {
        // 🔒 SÉCURITÉ : Utilisateur différent détecté !
        logger.w('[CategoryLocalDataSource] CHANGEMENT D\'UTILISATEUR DÉTECTÉ !');
        logger.w('[CategoryLocalDataSource] Utilisateur en cache: $cachedUserId');
        logger.w('[CategoryLocalDataSource] Utilisateur actuel: $currentUserId');
        logger.w('[CategoryLocalDataSource] Vidage du cache pour sécurité...');

        // Utilisateur différent, vider le cache et retourner une liste vide
        await clearCache();
        logger.i('[CategoryLocalDataSource] Cache vidé - Sécurité assurée');
        return [];
      }

      // Vérifier si l'utilisateur est connecté
      if (currentUserId == null) {
        logger.w('[CategoryLocalDataSource] Aucun utilisateur connecté - Cache ignoré');
        return [];
      }

      final categoriesJson = _prefs.getStringList(_categoriesKey);
      if (categoriesJson == null || categoriesJson.isEmpty) {
        logger.d('[CategoryLocalDataSource] Aucune donnée en cache');
        return [];
      }

      logger.d('[CategoryLocalDataSource] Cache valide pour utilisateur: $currentUserId');
      return categoriesJson
          .map((json) => CategoryModel.fromJson(jsonDecode(json)))
          .toList();
    } catch (e) {
      logger.e('[CategoryLocalDataSource] Erreur lors de la récupération du cache: $e', error: e);
      return [];
    }
  }

  /// Récupère les catégories par type du cache local
  Future<List<CategoryModel>> getCategoriesByType(
    CategoryType type, {
    String? currentUserId,
  }) async {
    try {
      final allCategories = await getAllCategories(
        currentUserId: currentUserId,
      );
      return allCategories.where((category) => category.type == type).toList();
    } catch (e) {
      return [];
    }
  }

  /// Récupère les catégories custom du cache local
  Future<List<CategoryModel>> getCustomCategories({
    String? currentUserId,
  }) async {
    try {
      final allCategories = await getAllCategories(
        currentUserId: currentUserId,
      );
      return allCategories.where((category) => category.isCustom).toList();
    } catch (e) {
      return [];
    }
  }

  /// Sauvegarde les catégories dans le cache local (sécurisé par utilisateur)
  Future<void> saveCategories(
    List<CategoryModel> categories, {
    String? userId,
  }) async {
    try {
      // Vérifier si l'utilisateur a changé (SÉCURITÉ CRITIQUE)
      final cachedUserId = _prefs.getString(_userCacheKey);

      if (cachedUserId != null && cachedUserId != userId) {
        // 🔒 SÉCURITÉ : Utilisateur différent détecté lors de la sauvegarde !
        logger.w('[CategoryLocalDataSource] CHANGEMENT D\'UTILISATEUR DÉTECTÉ LORS DE LA SAUVEGARDE !');
        logger.w('[CategoryLocalDataSource] Utilisateur en cache: $cachedUserId');
        logger.w('[CategoryLocalDataSource] Nouvel utilisateur: $userId');
        logger.w('[CategoryLocalDataSource] Vidage du cache pour sécurité...');

        // Utilisateur différent, vider le cache
        await clearCache();
        logger.i('[CategoryLocalDataSource] Cache vidé avant sauvegarde - Sécurité assurée');
      }

      // Sauvegarder l'ID utilisateur actuel
      if (userId != null) {
        await _prefs.setString(_userCacheKey, userId);
        logger.d('[CategoryLocalDataSource] ID utilisateur sauvegardé: $userId');
      }

      final categoriesJson = categories
          .map((category) => jsonEncode(category.toJson()))
          .toList();

      await _prefs.setStringList(_categoriesKey, categoriesJson);
      await updateCacheTimestamp();

      logger.i('[CategoryLocalDataSource] ${categories.length} catégories sauvegardées pour utilisateur: $userId');
    } catch (e) {
      logger.e('[CategoryLocalDataSource] Erreur lors de la sauvegarde: $e', error: e);
      throw CacheError(
        operation: 'saveAllCategories',
        userMessage: 'Erreur lors de la sauvegarde des catégories',
        technicalMessage: e.toString(),
      );
    }
  }

  /// Sauvegarde une catégorie dans le cache local
  Future<void> saveCategory(CategoryModel category, {String? userId}) async {
    try {
      // IMPORTANT: Récupérer les catégories existantes avec le userId pour éviter de perdre les données
      final allCategories = await getAllCategories(currentUserId: userId);

      // Supprimer l'ancienne version si elle existe
      allCategories.removeWhere((cat) => cat.id == category.id);

      // Ajouter la nouvelle version
      allCategories.add(category);

      // Sauvegarder avec le userId pour maintenir la sécurité
      await saveCategories(allCategories, userId: userId);
    } catch (e) {
      throw CacheError(
        operation: 'saveCategory',
        userMessage: 'Erreur lors de la sauvegarde',
        technicalMessage: e.toString(),
      );
    }
  }

  /// Supprime une catégorie du cache local
  Future<void> deleteCategory(int categoryId, {String? userId}) async {
    try {
      // IMPORTANT: Récupérer les catégories existantes avec le userId pour éviter de perdre les données
      final allCategories = await getAllCategories(currentUserId: userId);
      allCategories.removeWhere((category) => category.id == categoryId);

      // Sauvegarder avec le userId pour maintenir la sécurité
      await saveCategories(allCategories, userId: userId);
    } catch (e) {
      throw CacheError(
        operation: 'deleteCategory',
        userMessage: 'Erreur lors de la suppression',
        technicalMessage: e.toString(),
      );
    }
  }

  /// Vide le cache local
  Future<void> clearCache() async {
    try {
      await _prefs.remove(_categoriesKey);
      await _prefs.remove(_cacheTimestampKey);
      await _prefs.remove(_userCacheKey);
    } catch (e) {
      throw CacheError(
        operation: 'clearCache',
        userMessage: 'Erreur lors du nettoyage',
        technicalMessage: e.toString(),
      );
    }
  }

  /// Vérifie si le cache est à jour
  Future<bool> isCacheValid() async {
    try {
      final timestamp = _prefs.getInt(_cacheTimestampKey);
      if (timestamp == null) return false;

      final now = DateTime.now().millisecondsSinceEpoch;
      final cacheAge = now - timestamp;

      // Cache valide pendant 1 heure (3600000 ms)
      return cacheAge < 3600000;
    } catch (e) {
      return false;
    }
  }

  /// Met à jour le timestamp du cache
  Future<void> updateCacheTimestamp() async {
    try {
      final now = DateTime.now().millisecondsSinceEpoch;
      await _prefs.setInt(_cacheTimestampKey, now);
    } catch (e) {
      throw CacheError(
        operation: 'updateCacheTimestamp',
        userMessage: 'Erreur lors de la mise à jour',
        technicalMessage: e.toString(),
      );
    }
  }
}

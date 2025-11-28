import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pocketly/core/services/logger_service.dart';
import '../../domain/entities/category_entity.dart';
import '../../domain/repositories/category_repository.dart';
import '../datasources/category_local_datasource.dart';
import '../datasources/category_remote_datasource.dart';
import '../models/category_model.dart';

/// Implémentation du repository des catégories
class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryLocalDataSource _localDataSource;
  final CategoryRemoteDataSource _remoteDataSource;
  final logger = const LoggerService();

  CategoryRepositoryImpl({
    required SupabaseClient supabase,
    required SharedPreferences prefs,
  }) : _localDataSource = CategoryLocalDataSource(prefs: prefs),
       _remoteDataSource = CategoryRemoteDataSource(supabase: supabase);

  @override
  Future<List<CategoryEntity>> getAllCategories() async {
    try {
      // Récupérer l'ID utilisateur actuel
      final currentUserId = _remoteDataSource.getCurrentUserId();
      logger.d('[CategoryRepository] ID utilisateur actuel: $currentUserId');

      // 1. Essayer de récupérer depuis le cache local d'abord (Cache-First)
      final localCategories = await _localDataSource.getAllCategories(
        currentUserId: currentUserId,
      );
      logger.d('[CategoryRepository] Catégories en cache: ${localCategories.length}');

      if (localCategories.isNotEmpty) {
        logger.d('[CategoryRepository] Utilisation du cache local (Cache-First)');

        // 2. Synchroniser en arrière-plan sans bloquer l'UI
        _syncInBackground(currentUserId);

        return localCategories.map((model) => model.toEntity()).toList();
      }

      // 3. Si pas de cache, récupérer depuis le serveur (fallback)
      logger.d('[CategoryRepository] Pas de cache, récupération depuis le serveur...');
      final remoteCategories = await _remoteDataSource.getAllCategories();
      logger.d('[CategoryRepository] Catégories du serveur: ${remoteCategories.length}');

      // Log détaillé des catégories du serveur
      for (final category in remoteCategories) {
        logger.d('[CategoryRepository] - ${category.name} (${category.isCustom ? 'CUSTOM' : 'DEFAULT'}) - User: ${category.userId}');
      }

      // Sauvegarder en cache local avec l'ID utilisateur pour la sécurité
      await _localDataSource.saveCategories(
        remoteCategories,
        userId: currentUserId,
      );
      logger.d('[CategoryRepository] Catégories sauvegardées en cache');

      return remoteCategories.map((model) => model.toEntity()).toList();
    } catch (e, stackTrace) {
      logger.e('[CategoryRepository] Erreur: $e', error: e, stackTrace: stackTrace);

      // En cas d'erreur, essayer de retourner le cache même s'il est obsolète
      try {
        final fallbackCategories = await _localDataSource.getAllCategories(
          currentUserId: _remoteDataSource.getCurrentUserId(),
        );
        if (fallbackCategories.isNotEmpty) {
          logger.w('[CategoryRepository] Fallback vers le cache local');
          return fallbackCategories.map((model) => model.toEntity()).toList();
        }
      } catch (cacheError) {
        logger.e('[CategoryRepository] Cache fallback échoué: $cacheError', error: cacheError);
      }

      return [];
    }
  }

  @override
  Future<List<CategoryEntity>> getCategoriesByType(CategoryType type) async {
    try {
      // Récupérer l'ID utilisateur actuel
      final currentUserId = _remoteDataSource.getCurrentUserId();

      final localCategories = await _localDataSource.getCategoriesByType(
        type,
        currentUserId: currentUserId,
      );

      if (localCategories.isNotEmpty) {
        return localCategories.map((model) => model.toEntity()).toList();
      }

      // Si pas de cache, récupérer toutes les catégories et filtrer
      final allCategories = await getAllCategories();
      return allCategories.where((cat) => cat.type == type).toList();
    } catch (e) {
      // En cas d'erreur, retourner une liste vide
      // Les catégories par défaut sont maintenant récupérées depuis Supabase
      return [];
    }
  }

  @override
  Future<List<CategoryEntity>> getCustomCategories() async {
    try {
      // Récupérer l'ID utilisateur actuel
      final currentUserId = _remoteDataSource.getCurrentUserId();

      final localCategories = await _localDataSource.getCustomCategories(
        currentUserId: currentUserId,
      );
      return localCategories.map((model) => model.toEntity()).toList();
    } catch (e) {
      return [];
    }
  }

  @override
  Future<CategoryEntity> createCustomCategory(CategoryEntity category) async {
    try {
      final categoryModel = category.toModel();

      // Créer sur le serveur
      final createdModel = await _remoteDataSource.createCustomCategory(
        categoryModel,
      );

      // Récupérer l'ID utilisateur actuel
      final currentUserId = _remoteDataSource.getCurrentUserId();

      // Sauvegarder en cache local AVEC le userId pour préserver les catégories existantes
      await _localDataSource.saveCategory(createdModel, userId: currentUserId);

      return createdModel.toEntity();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<CategoryEntity> updateCustomCategory(CategoryEntity category) async {
    try {
      final categoryModel = category.toModel();

      // Mettre à jour sur le serveur
      final updatedModel = await _remoteDataSource.updateCustomCategory(
        categoryModel,
      );

      // Récupérer l'ID utilisateur actuel
      final currentUserId = _remoteDataSource.getCurrentUserId();

      // Mettre à jour en cache local AVEC le userId
      await _localDataSource.saveCategory(updatedModel, userId: currentUserId);

      return updatedModel.toEntity();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteCustomCategory(String categoryId) async {
    try {
      // Supprimer du serveur
      await _remoteDataSource.deleteCustomCategory(categoryId);

      // Récupérer l'ID utilisateur actuel
      final currentUserId = _remoteDataSource.getCurrentUserId();

      // Supprimer du cache local AVEC le userId
      await _localDataSource.deleteCategory(categoryId, userId: currentUserId);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<CategoryEntity?> getCategoryById(String id) async {
    try {
      // Essayer le cache local d'abord
      final localCategories = await _localDataSource.getAllCategories();
      final localCategory = localCategories
          .where((cat) => cat.id == id)
          .firstOrNull;

      if (localCategory != null) {
        return localCategory.toEntity();
      }

      // Si pas trouvé localement, chercher sur le serveur
      final remoteCategory = await _remoteDataSource.getCategoryById(id);

      if (remoteCategory != null) {
        // Sauvegarder en cache local
        await _localDataSource.saveCategory(remoteCategory);
        return remoteCategory.toEntity();
      }

      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> syncCategories() async {
    try {
      logger.d('[CategoryRepository] Synchronisation des catégories...');

      // Récupérer l'ID utilisateur actuel
      final currentUserId = _remoteDataSource.getCurrentUserId();
      logger.d('[CategoryRepository] ID utilisateur: $currentUserId');

      // Vider complètement le cache pour forcer la synchronisation
      await _localDataSource.clearCache();
      logger.d('[CategoryRepository] Cache vidé');

      // Récupérer les nouvelles catégories depuis le serveur
      final remoteCategories = await _remoteDataSource.getAllCategories();
      logger.d('[CategoryRepository] ${remoteCategories.length} catégories récupérées du serveur');

      // Sauvegarder avec le nouvel ID utilisateur
      await _localDataSource.saveCategories(
        remoteCategories,
        userId: currentUserId,
      );
      logger.i('[CategoryRepository] Catégories sauvegardées en cache');
    } catch (e, stackTrace) {
      logger.e('[CategoryRepository] Erreur lors de la synchronisation: $e', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }

  /// Synchronise les catégories en arrière-plan sans bloquer l'UI
  void _syncInBackground(String? currentUserId) {
    if (currentUserId == null) return;

    // Lancer la synchronisation en arrière-plan
    Future.microtask(() async {
      try {
        logger.d('[CategoryRepository] Synchronisation en arrière-plan...');

        // Récupérer les catégories depuis le serveur
        final remoteCategories = await _remoteDataSource.getAllCategories();

        // Mettre à jour le cache avec les nouvelles données
        await _localDataSource.saveCategories(
          remoteCategories,
          userId: currentUserId,
        );

        logger.d('[CategoryRepository] Synchronisation en arrière-plan terminée');
      } catch (e) {
        logger.w('[CategoryRepository] Erreur lors de la synchronisation en arrière-plan: $e', error: e);
        // Ne pas faire échouer l'application pour une synchronisation en arrière-plan
      }
    });
  }
}

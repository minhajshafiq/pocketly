import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:pocketly/core/errors/errors.dart';
import 'package:pocketly/core/services/logger_service.dart';
import '../models/category_model.dart';

/// Implémentation Supabase de la source de données distante
class CategoryRemoteDataSource {
  final SupabaseClient _supabase;
  final logger = const LoggerService();

  CategoryRemoteDataSource({required SupabaseClient supabase})
    : _supabase = supabase;

  /// Récupère toutes les catégories depuis Supabase
  Future<List<CategoryModel>> getAllCategories() async {
    try {
      logger.d('[CategoryRemoteDataSource] Début de la récupération des catégories...');

      // Vérifier l'utilisateur connecté
      final currentUser = _supabase.auth.currentUser;
      logger.d('[CategoryRemoteDataSource] Utilisateur connecté: ${currentUser?.id}');
      logger.d('[CategoryRemoteDataSource] Email: ${currentUser?.email}');

      // Récupérer les catégories par défaut (is_custom = false)
      logger.d('[CategoryRemoteDataSource] Récupération des catégories par défaut...');
      final defaultResponse = await _supabase
          .from('categories')
          .select('*')
          .eq('is_custom', false)
          .order('type', ascending: true)
          .order('name', ascending: true);

      logger.d('[CategoryRemoteDataSource] Catégories par défaut: ${defaultResponse.length}');

      // Récupérer les catégories custom de l'utilisateur (is_custom = true AND user_id = current_user_id)
      List<dynamic> customResponse = [];
      if (currentUser != null) {
        logger.d('[CategoryRemoteDataSource] Récupération des catégories custom...');
        customResponse = await _supabase
            .from('categories')
            .select('*')
            .eq('is_custom', true)
            .eq('user_id', currentUser.id)
            .order('created_at', ascending: false);

        logger.d('[CategoryRemoteDataSource] Catégories custom: ${customResponse.length}');
      }

      // Fusionner les deux listes
      final allCategories = [...defaultResponse, ...customResponse];
      logger.d('[CategoryRemoteDataSource] Total catégories: ${allCategories.length}');

      // Log détaillé de la réponse
      for (int i = 0; i < allCategories.length; i++) {
        final item = allCategories[i];
        logger.d('[CategoryRemoteDataSource] [$i] ${item['name']} (${item['is_custom'] ? 'CUSTOM' : 'DEFAULT'}) - User: ${item['user_id']}');
      }

      final categories = allCategories
          .map((json) => CategoryModel.fromJson(json))
          .toList();

      logger.d('[CategoryRemoteDataSource] Catégories mappées: ${categories.length}');

      return categories;
    } catch (e, stackTrace) {
      logger.e('[CategoryRemoteDataSource] Erreur: $e', error: e, stackTrace: stackTrace);
      throw NetworkError(
        userMessage: 'Erreur lors de la récupération des catégories',
        technicalMessage: 'Failed to fetch categories: $e',
      );
    }
  }

  /// Récupère les catégories custom depuis Supabase
  Future<List<CategoryModel>> getCustomCategories() async {
    try {
      final response = await _supabase
          .from('categories')
          .select('*')
          .eq('is_custom', true)
          .eq('user_id', _supabase.auth.currentUser?.id ?? '')
          .order('created_at', ascending: false);

      return response.map((json) => CategoryModel.fromJson(json)).toList();
    } catch (e) {
      throw NetworkError(
        userMessage: 'Erreur lors de la récupération',
        technicalMessage: 'Failed to fetch custom categories: $e',
      );
    }
  }

  /// Crée une catégorie custom sur Supabase
  Future<CategoryModel> createCustomCategory(CategoryModel category) async {
    try {
      final response = await _supabase
          .from('categories')
          .insert(category.toJsonForCreation())
          .select()
          .single();

      return CategoryModel.fromJson(response);
    } catch (e) {
      throw NetworkError(
        userMessage: 'Erreur lors de la création',
        technicalMessage: 'Failed to create category: $e',
      );
    }
  }

  /// Met à jour une catégorie custom sur Supabase
  Future<CategoryModel> updateCustomCategory(CategoryModel category) async {
    try {
      final response = await _supabase
          .from('categories')
          .update(category.toJson())
          .eq('id', category.id ?? '')
          .eq('is_custom', true)
          .eq('user_id', _supabase.auth.currentUser?.id ?? '')
          .select()
          .single();

      return CategoryModel.fromJson(response);
    } catch (e) {
      throw NetworkError(
        userMessage: 'Erreur lors de la mise à jour',
        technicalMessage: 'Failed to update category: $e',
      );
    }
  }

  /// Supprime une catégorie custom de Supabase
  Future<void> deleteCustomCategory(String categoryId) async {
    try {
      await _supabase
          .from('categories')
          .delete()
          .eq('id', categoryId)
          .eq('is_custom', true)
          .eq('user_id', _supabase.auth.currentUser?.id ?? '');
    } catch (e) {
      throw NetworkError(
        userMessage: 'Erreur lors de la suppression',
        technicalMessage: 'Failed to delete category: $e',
      );
    }
  }

  /// Récupère une catégorie par son ID depuis Supabase
  Future<CategoryModel?> getCategoryById(String id) async {
    try {
      final response = await _supabase
          .from('categories')
          .select('*')
          .eq('id', id)
          .maybeSingle();

      if (response == null) return null;
      return CategoryModel.fromJson(response);
    } catch (e) {
      throw NetworkError(
        userMessage: 'Erreur lors de la récupération',
        technicalMessage: 'Failed to fetch category by ID: $e',
      );
    }
  }

  /// Synchronise les catégories avec Supabase
  Future<void> syncCategories() async {
    try {
      // Synchronisation avec les catégories par défaut
      await _supabase.rpc('get_default_categories');
    } catch (e) {
      throw NetworkError(
        userMessage: 'Erreur lors de la synchronisation',
        technicalMessage: 'Failed to sync categories: $e',
      );
    }
  }

  /// Récupère l'ID de l'utilisateur actuellement connecté
  String? getCurrentUserId() {
    return _supabase.auth.currentUser?.id;
  }
}

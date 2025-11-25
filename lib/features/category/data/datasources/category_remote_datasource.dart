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

      // Utiliser la vue sécurisée user_categories qui filtre automatiquement par utilisateur
      logger.d('[CategoryRemoteDataSource] Requête sur user_categories...');
      final response = await _supabase
          .from('user_categories')
          .select('*')
          .order('is_custom', ascending: true)
          .order('type', ascending: true)
          .order('id', ascending: true);

      logger.d('[CategoryRemoteDataSource] Réponse brute: ${response.length} éléments');

      // Log détaillé de la réponse
      for (int i = 0; i < response.length; i++) {
        final item = response[i];
        logger.d('[CategoryRemoteDataSource] [$i] ${item['name']} (${item['is_custom'] ? 'CUSTOM' : 'DEFAULT'}) - User: ${item['user_id']}');
      }

      final categories = response
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
          .eq('id', category.id ?? 0)
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
  Future<void> deleteCustomCategory(int categoryId) async {
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
  Future<CategoryModel?> getCategoryById(int id) async {
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

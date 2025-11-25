import '../entities/category_entity.dart';

/// Repository interface pour la gestion des catégories
abstract class CategoryRepository {
  /// Récupère toutes les catégories (défaut + custom de l'utilisateur)
  Future<List<CategoryEntity>> getAllCategories();

  /// Récupère les catégories par type
  Future<List<CategoryEntity>> getCategoriesByType(CategoryType type);

  /// Récupère uniquement les catégories custom de l'utilisateur
  Future<List<CategoryEntity>> getCustomCategories();

  /// Crée une nouvelle catégorie custom
  Future<CategoryEntity> createCustomCategory(CategoryEntity category);

  /// Met à jour une catégorie custom
  Future<CategoryEntity> updateCustomCategory(CategoryEntity category);

  /// Supprime une catégorie custom
  Future<void> deleteCustomCategory(int categoryId);

  /// Récupère une catégorie par son ID
  Future<CategoryEntity?> getCategoryById(int id);

  /// Synchronise les catégories avec le serveur
  Future<void> syncCategories();
}

import 'package:pocketly/core/errors/errors.dart';
import '../repositories/category_repository.dart';

/// Use case pour supprimer une catégorie custom
class DeleteCustomCategoryUseCase {
  final CategoryRepository _repository;

  DeleteCustomCategoryUseCase(this._repository);

  /// Exécute le use case pour supprimer une catégorie custom
  Future<void> call(int categoryId) async {
    // Validation de l'ID
    if (categoryId <= 0) {
      throw ValidationError(
        field: 'categoryId',
        userMessage: 'L\'ID de la catégorie doit être positif',
        technicalMessage: 'Invalid category ID: $categoryId',
      );
    }

    // Vérification que la catégorie existe et est custom
    final category = await _repository.getCategoryById(categoryId);
    if (category == null) {
      throw NotFoundError(
        resourceType: 'Category',
        userMessage: 'Catégorie non trouvée',
        technicalMessage: 'Category with ID $categoryId not found',
      );
    }

    if (!category.isCustom) {
      throw const ValidationError(
        field: 'isCustom',
        userMessage: 'Seules les catégories custom peuvent être supprimées',
        technicalMessage: 'Cannot delete built-in category',
      );
    }

    return await _repository.deleteCustomCategory(categoryId);
  }
}

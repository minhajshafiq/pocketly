import 'package:pocketly/core/errors/errors.dart';
import '../repositories/category_repository.dart';

/// Use case pour supprimer une catégorie custom
class DeleteCustomCategoryUseCase {
  final CategoryRepository _repository;

  DeleteCustomCategoryUseCase(this._repository);

  /// Exécute le use case pour supprimer une catégorie custom
  Future<void> call(String categoryId) async {
    // Validation de l'ID
    if (categoryId.trim().isEmpty) {
      throw const ValidationError(
        field: 'categoryId',
        userMessage: 'L\'ID de la catégorie ne peut pas être vide',
        technicalMessage: 'Category ID is required',
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

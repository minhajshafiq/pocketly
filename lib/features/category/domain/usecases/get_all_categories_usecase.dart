import '../entities/category_entity.dart';
import '../repositories/category_repository.dart';

/// Use case pour récupérer toutes les catégories
class GetAllCategoriesUseCase {
  final CategoryRepository _repository;

  GetAllCategoriesUseCase(this._repository);

  /// Exécute le use case pour récupérer toutes les catégories
  Future<List<CategoryEntity>> call() async {
    return await _repository.getAllCategories();
  }
}

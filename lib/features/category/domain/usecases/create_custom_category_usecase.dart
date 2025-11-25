import '../entities/category_entity.dart';
import '../repositories/category_repository.dart';
import '../errors/category_errors.dart';
import 'validate_category_usecase.dart';

/// Use case pour créer une catégorie custom
class CreateCustomCategoryUseCase {
  final CategoryRepository _repository;

  CreateCustomCategoryUseCase(this._repository);

  /// Exécute le use case pour créer une catégorie custom
  ///
  /// Throws:
  /// - [PremiumRequiredError] si l'utilisateur n'est pas premium ou en trial
  /// - [ValidationError] si les données sont invalides
  /// - [ArgumentError] si les paramètres ne respectent pas les contraintes
  Future<CategoryEntity> call({
    required String name,
    required CategoryType type,
    required String iconName,
    required String color,
    required String userId,
    required bool isPremium,
  }) async {
    // Vérification premium/trial AVANT toute autre opération
    if (!isPremium) {
      throw const PremiumRequiredError(
        userMessage:
            'Passez à Premium ou activez votre période d\'essai pour créer des catégories personnalisées.',
        technicalMessage:
            'User attempted to create custom category without premium or trial status',
      );
    }

    // Validation des données d'entrée
    ValidateCategoryUseCase.validate(
      name: name,
      type: type,
      iconName: iconName,
      color: color,
      isCustom: true,
      userId: userId,
    );

    // Création de la catégorie custom
    final category = CategoryEntityFactories.createCustom(
      name: name.trim(),
      type: type,
      iconName: iconName.trim(),
      color: color.trim(),
      userId: userId,
    );

    return await _repository.createCustomCategory(category);
  }
}

import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/category_entity.dart';

part 'category_model.freezed.dart';
part 'category_model.g.dart';

/// Model pour les catégories (Freezed)
@freezed
sealed class CategoryModel with _$CategoryModel {
  const factory CategoryModel({
    String? id,
    required String name,
    required CategoryType type,
    @JsonKey(name: 'icon_name') required String iconName,
    required String color,
    @JsonKey(name: 'is_custom') @Default(false) bool isCustom,
    @JsonKey(name: 'user_id') String? userId,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _CategoryModel;

  const CategoryModel._();

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);

  /// Conversion vers JSON pour la création (sans ID)
  Map<String, dynamic> toJsonForCreation() {
    return {
      'name': name,
      'type': type.name,
      'icon_name': iconName,
      'color': color,
      'is_custom': isCustom,
      if (userId != null) 'user_id': userId,
    };
  }
}

/// Extension pour la conversion entre CategoryModel et CategoryEntity
extension CategoryModelX on CategoryModel {
  /// Convertit le modèle en entité du domaine
  CategoryEntity toEntity() {
    return CategoryEntity(
      id: id,
      name: name,
      type: type,
      iconName: iconName,
      color: color,
      isCustom: isCustom,
      userId: userId,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

/// Extension pour la conversion de CategoryEntity vers CategoryModel
extension CategoryEntityToModelX on CategoryEntity {
  /// Convertit l'entité en modèle de données
  CategoryModel toModel() {
    return CategoryModel(
      id: id,
      name: name,
      type: type,
      iconName: iconName,
      color: color,
      isCustom: isCustom,
      userId: userId,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

/// Extension pour les listes de CategoryModel
extension CategoryModelListX on List<CategoryModel> {
  /// Convertit une liste de models en entités
  List<CategoryEntity> toEntities() {
    return map((model) => model.toEntity()).toList();
  }
}

/// Extension pour les listes de CategoryEntity
extension CategoryEntityListToModelX on List<CategoryEntity> {
  /// Convertit une liste d'entités en models
  List<CategoryModel> toModels() {
    return map((entity) => entity.toModel()).toList();
  }
}

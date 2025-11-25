import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pocketly/features/pockets/domain/entities/pocket_entity.dart';

part 'pocket_model.freezed.dart';
part 'pocket_model.g.dart';

/// Modèle de données pour les pockets (couche Data)
///
/// Ce modèle gère la sérialisation/désérialisation JSON
/// et la conversion vers/depuis l'entité domain.
@freezed
sealed class PocketModel with _$PocketModel {
  
  const factory PocketModel({
    String? id,
    required String name,
    required String icon,
    required String color,
    required String category,
    @Default(0.0) double budget,
    @Default(0.0) double spent,
    @JsonKey(name: 'saved_amount') @Default(0.0) double savedAmount,
    @JsonKey(name: 'monthly_savings_amount') double? monthlySavingsAmount,
    @JsonKey(name: 'savings_goal_type') @Default('none') String savingsGoalType,
    @JsonKey(name: 'target_amount') double? targetAmount,
    @JsonKey(name: 'target_date') DateTime? targetDate,
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'is_active') @Default(true) bool isActive,
    @JsonKey(name: 'is_default') @Default(false) bool isDefault,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _PocketModel;

  /// Conversion depuis JSON
  factory PocketModel.fromJson(Map<String, dynamic> json) =>
      _$PocketModelFromJson(json);
}

// =====================================================
// 🔄 EXTENSIONS DE CONVERSION
// =====================================================

/// Extension pour convertir PocketModel vers PocketEntity
extension PocketModelX on PocketModel {
  /// Convertit le modèle en entité domain
  PocketEntity toEntity() {
    return PocketEntity(
      id: id,
      name: name,
      icon: icon,
      color: color,
      category: _parsePocketCategory(category),
      budget: budget,
      spent: spent,
      savedAmount: savedAmount,
      monthlySavingsAmount: monthlySavingsAmount,
      savingsGoalType: _parseSavingsGoalType(savingsGoalType),
      targetAmount: targetAmount,
      targetDate: targetDate,
      userId: userId,
      isActive: isActive,
      isDefault: isDefault,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  /// Parse la catégorie depuis une string
  PocketCategory _parsePocketCategory(String category) {
    return switch (category.toLowerCase()) {
      'needs' => PocketCategory.needs,
      'wants' => PocketCategory.wants,
      'savings' => PocketCategory.savings,
      _ => throw FormatException('Invalid pocket category: $category'),
    };
  }

  /// Parse le type d'objectif d'épargne depuis une string
  SavingsGoalType _parseSavingsGoalType(String type) {
    return switch (type.toLowerCase()) {
      'none' => SavingsGoalType.none,
      'fixedamount' => SavingsGoalType.fixedAmount,
      'targetdate' => SavingsGoalType.targetDate,
      _ => throw FormatException('Invalid savings goal type: $type'),
    };
  }
}

/// Extension pour convertir PocketEntity vers PocketModel
extension PocketEntityToModelX on PocketEntity {
  /// Convertit l'entité en modèle data
  PocketModel toModel() {
    return PocketModel(
      id: id,
      name: name,
      icon: icon,
      color: color,
      category: _categoryToString(category),
      budget: budget,
      spent: spent,
      savedAmount: savedAmount,
      monthlySavingsAmount: monthlySavingsAmount,
      savingsGoalType: _savingsGoalTypeToString(savingsGoalType),
      targetAmount: targetAmount,
      targetDate: targetDate,
      userId: userId,
      isActive: isActive,
      isDefault: isDefault,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  /// Convertit PocketCategory en string
  String _categoryToString(PocketCategory category) {
    return switch (category) {
      PocketCategory.needs => 'needs',
      PocketCategory.wants => 'wants',
      PocketCategory.savings => 'savings',
    };
  }

  /// Convertit SavingsGoalType en string
  String _savingsGoalTypeToString(SavingsGoalType type) {
    return switch (type) {
      SavingsGoalType.none => 'none',
      SavingsGoalType.fixedAmount => 'fixedAmount',
      SavingsGoalType.targetDate => 'targetDate',
    };
  }
}

/// Extension pour listes de modèles
extension PocketModelListX on List<PocketModel> {
  /// Convertit une liste de modèles en liste d'entités
  List<PocketEntity> toEntities() {
    return map((model) => model.toEntity()).toList();
  }
}

/// Extension pour listes d'entités
extension PocketEntityListToModelX on List<PocketEntity> {
  /// Convertit une liste d'entités en liste de modèles
  List<PocketModel> toModels() {
    return map((entity) => entity.toModel()).toList();
  }
}

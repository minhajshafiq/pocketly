import 'package:pocketly/core/errors/errors.dart';
import '../entities/category_entity.dart';

/// Use case pour valider les données d'une catégorie
class ValidateCategoryUseCase {
  /// Valide les données de la catégorie selon les contraintes du schéma SQL
  static void validate({
    required String name,
    required CategoryType type,
    required String iconName,
    required String color,
    required bool isCustom,
    String? userId,
  }) {
    // Validation du nom (non vide, max 50 caractères)
    if (name.trim().isEmpty) {
      throw const ValidationError(
        field: 'name',
        userMessage: 'Le nom ne peut pas être vide',
        technicalMessage: 'Category name is required',
      );
    }
    if (name.length > 50) {
      throw ValidationError(
        field: 'name',
        userMessage: 'Le nom ne peut pas dépasser 50 caractères',
        technicalMessage: 'Category name exceeds 50 characters: ${name.length}',
      );
    }

    // Validation de l'icône (non vide, max 30 caractères)
    if (iconName.trim().isEmpty) {
      throw const ValidationError(
        field: 'iconName',
        userMessage: 'Le nom de l\'icône ne peut pas être vide',
        technicalMessage: 'Icon name is required',
      );
    }
    if (iconName.length > 30) {
      throw ValidationError(
        field: 'iconName',
        userMessage: 'Le nom de l\'icône ne peut pas dépasser 30 caractères',
        technicalMessage: 'Icon name exceeds 30 characters: ${iconName.length}',
      );
    }

    // Validation de la couleur (format hex valide)
    if (!_isValidHexColor(color)) {
      throw ValidationError(
        field: 'color',
        userMessage: 'La couleur doit être au format hexadécimal valide (#RRGGBB)',
        technicalMessage: 'Invalid hex color format: $color',
      );
    }

    // Validation de l'ID utilisateur pour les catégories custom
    if (isCustom && (userId == null || userId.isEmpty)) {
      throw const ValidationError(
        field: 'userId',
        userMessage: 'L\'ID utilisateur est requis pour les catégories personnalisées',
        technicalMessage: 'User ID required for custom categories',
      );
    }

    // Validation des contraintes spécifiques
    _validateCategoryConstraints(name: name, type: type, isCustom: isCustom);
  }

  /// Valide les contraintes spécifiques aux catégories
  static void _validateCategoryConstraints({
    required String name,
    required CategoryType type,
    required bool isCustom,
  }) {
    // Validation des noms réservés pour les catégories par défaut
    if (!isCustom) {
      final reservedNames = _getReservedCategoryNames();
      if (reservedNames.contains(name.toLowerCase().trim())) {
        throw ValidationError(
          field: 'name',
          userMessage: 'Ce nom est réservé pour les catégories par défaut',
          technicalMessage: 'Reserved category name: $name',
        );
      }
    }

    // Validation de la longueur minimale du nom
    if (name.trim().length < 2) {
      throw ValidationError(
        field: 'name',
        userMessage: 'Le nom doit contenir au moins 2 caractères',
        technicalMessage: 'Name too short: ${name.trim().length} < 2',
      );
    }
  }

  /// Vérifie si la couleur est au format hex valide
  static bool _isValidHexColor(String color) {
    if (color.isEmpty) return false;

    // Supprime le # s'il existe
    final cleanColor = color.startsWith('#') ? color.substring(1) : color;

    // Vérifie que c'est exactement 6 caractères hexadécimaux
    if (cleanColor.length != 6) return false;

    // Vérifie que tous les caractères sont hexadécimaux
    return RegExp(r'^[0-9A-Fa-f]{6}$').hasMatch(cleanColor);
  }

  /// Retourne la liste des noms réservés pour les catégories par défaut
  static List<String> _getReservedCategoryNames() {
    return [
      'food',
      'housing',
      'transport',
      'health',
      'leisure',
      'shopping',
      'salary',
      'bonus',
      'investment',
    ];
  }
}

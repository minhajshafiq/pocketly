import 'package:freezed_annotation/freezed_annotation.dart';

part 'category_entity.freezed.dart';
part 'category_entity.g.dart';

/// Enum pour le type de catégorie
enum CategoryType { income, expense }

/// Clés des catégories par défaut pour i18n
class CategoryKeys {
  // Dépenses
  static const String food = 'food';
  static const String housing = 'housing';
  static const String transport = 'transport';
  static const String health = 'health';
  static const String leisure = 'leisure';
  static const String shopping = 'shopping';

  // Revenus
  static const String salary = 'salary';
  static const String bonus = 'bonus';
  static const String investment = 'investment';
}

/// Entité catégorie principale pour Pocketly.
@freezed
sealed class CategoryEntity with _$CategoryEntity {
  const factory CategoryEntity({
    int? id,
    required String name,
    required CategoryType type,
    @JsonKey(name: 'icon_name') required String iconName,
    required String color,
    @JsonKey(name: 'is_custom') @Default(false) bool isCustom,
    @JsonKey(name: 'user_id') String? userId,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _CategoryEntity;

  factory CategoryEntity.fromJson(Map<String, dynamic> json) =>
      _$CategoryEntityFromJson(json);
}

// ================================
// 🔍 Extensions pour logique métier
// ================================

extension CategoryEntityX on CategoryEntity {
  /// Vérifie si c'est une catégorie par défaut
  bool get isDefault => !isCustom;

  /// Vérifie si la catégorie peut être supprimée (seulement les custom)
  bool get canBeDeleted => isCustom;

  /// Obtient le nom traduit ou custom
  String getName(dynamic l10n) {
    if (isCustom) return name;

    return switch (name) {
      CategoryKeys.food => l10n.food,
      CategoryKeys.housing => l10n.housing,
      CategoryKeys.transport => l10n.transport,
      CategoryKeys.health => l10n.health,
      CategoryKeys.leisure => l10n.leisure,
      CategoryKeys.shopping => l10n.shopping,
      CategoryKeys.salary => l10n.salary,
      CategoryKeys.bonus => l10n.bonus,
      CategoryKeys.investment => l10n.investment,
      _ => name,
    };
  }

  /// Vérifie si la catégorie est récente (créée dans les 7 derniers jours)
  bool get isRecent {
    if (createdAt == null) return false;
    return DateTime.now().difference(createdAt!).inDays <= 7;
  }
}

// ================================
// 🏭 Factory methods
// ================================

class CategoryEntityFactories {
  /// Crée une catégorie custom avec des valeurs par défaut sécurisées.
  static CategoryEntity createCustom({
    required String name,
    required CategoryType type,
    required String iconName,
    required String color,
    required String userId,
  }) {
    final now = DateTime.now();
    return CategoryEntity(
      name: name,
      type: type,
      iconName: iconName,
      color: color,
      isCustom: true,
      userId: userId,
      createdAt: now,
      updatedAt: now,
    );
  }

  /// Crée une catégorie par défaut.
  ///
  /// ⚠️ DÉPRÉCIÉ : Les catégories par défaut sont maintenant
  /// récupérées depuis Supabase. Cette méthode est conservée
  /// pour compatibilité mais ne devrait plus être utilisée.
  @Deprecated('Use Supabase to fetch default categories instead')
  static CategoryEntity createDefault({
    required int id,
    required String name,
    required CategoryType type,
    required String iconName,
    required String color,
  }) {
    final now = DateTime.now();
    return CategoryEntity(
      id: id,
      name: name,
      type: type,
      iconName: iconName,
      color: color,
      isCustom: false,
      userId: null,
      createdAt: now,
      updatedAt: now,
    );
  }
}

// ================================
// 📝 NOTE IMPORTANTE
// ================================
//
// Les catégories par défaut sont maintenant stockées dans Supabase
// et récupérées via l'API. Plus besoin de les dupliquer ici.
//
// Pour récupérer les catégories par défaut :
// ```dart
// final categories = await supabase
//   .from('categories')
//   .select('*')
//   .eq('is_custom', false);
// ```
//
// Les clés i18n (CategoryKeys) sont conservées pour la traduction
// des noms des catégories par défaut.

/// Extension utilitaire pour les listes de catégories
extension CategoryListExtension on List<CategoryEntity> {
  /// Filtre par type
  List<CategoryEntity> byType(CategoryType type) =>
      where((cat) => cat.type == type).toList();

  /// Récupère uniquement les catégories custom
  List<CategoryEntity> get customOnly => where((cat) => cat.isCustom).toList();

  /// Récupère uniquement les catégories par défaut
  List<CategoryEntity> get defaultOnly =>
      where((cat) => cat.isDefault).toList();

  /// Trouve une catégorie par ID
  CategoryEntity? findById(int id) {
    try {
      return firstWhere((cat) => cat.id == id);
    } catch (e) {
      return null;
    }
  }
}

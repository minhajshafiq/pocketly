import 'package:flutter/material.dart';
import 'package:pocketly/features/themes/domain/entities/theme_entity.dart';

/// Modèle de données pour le thème.
/// 
/// Représente la structure de données pour la persistance
/// et la sérialisation des thèmes.
class ThemeModel extends ThemeEntity {
  const ThemeModel({
    required super.mode,
    required super.isDark,
    required super.isLight,
    required super.isSystem,
    required super.displayName,
    required super.iconName,
  });

  /// Factory pour créer un modèle à partir d'une entité
  factory ThemeModel.fromEntity(ThemeEntity entity) {
    return ThemeModel(
      mode: entity.mode,
      isDark: entity.isDark,
      isLight: entity.isLight,
      isSystem: entity.isSystem,
      displayName: entity.displayName,
      iconName: entity.iconName,
    );
  }

  /// Factory pour créer un modèle à partir de JSON
  factory ThemeModel.fromJson(Map<String, dynamic> json) {
    return ThemeModel(
      mode: ThemeMode.values[json['mode'] as int],
      isDark: json['isDark'] as bool,
      isLight: json['isLight'] as bool,
      isSystem: json['isSystem'] as bool,
      displayName: json['displayName'] as String,
      iconName: json['iconName'] as String,
    );
  }

  /// Convertit le modèle en JSON
  Map<String, dynamic> toJson() {
    return {
      'mode': mode.index,
      'isDark': isDark,
      'isLight': isLight,
      'isSystem': isSystem,
      'displayName': displayName,
      'iconName': iconName,
    };
  }

  /// Convertit le modèle en entité
  ThemeEntity toEntity() {
    return ThemeEntity(
      mode: mode,
      isDark: isDark,
      isLight: isLight,
      isSystem: isSystem,
      displayName: displayName,
      iconName: iconName,
    );
  }

  @override
  String toString() {
    return 'ThemeModel(mode: $mode, isDark: $isDark, isLight: $isLight, isSystem: $isSystem, displayName: $displayName, iconName: $iconName)';
  }
}

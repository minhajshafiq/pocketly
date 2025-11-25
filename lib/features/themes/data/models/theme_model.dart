import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pocketly/features/themes/domain/entities/theme_entity.dart';

part 'theme_model.freezed.dart';
part 'theme_model.g.dart';

/// Modèle de données pour le thème.
/// 
/// Représente la structure de données pour la persistance
/// et la sérialisation des thèmes.
@freezed
sealed class ThemeModel with _$ThemeModel {
  const factory ThemeModel({
    required ThemeMode mode,
    required bool isDark,
    required bool isLight,
    required bool isSystem,
    required String displayName,
    required String iconName,
  }) = _ThemeModel;

  factory ThemeModel.fromJson(Map<String, dynamic> json) =>
      _$ThemeModelFromJson(json);
}

/// Extension pour la conversion entre ThemeModel et ThemeEntity
extension ThemeModelX on ThemeModel {
  /// Convertit le modèle en entité du domaine
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
}

/// Extension pour la conversion de ThemeEntity vers ThemeModel
extension ThemeEntityToModelX on ThemeEntity {
  /// Convertit l'entité en modèle de données
  ThemeModel toModel() {
    return ThemeModel(
      mode: mode,
      isDark: isDark,
      isLight: isLight,
      isSystem: isSystem,
      displayName: displayName,
      iconName: iconName,
    );
  }
}

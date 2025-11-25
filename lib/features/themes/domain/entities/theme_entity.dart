import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'theme_entity.freezed.dart';
part 'theme_entity.g.dart';

/// Entité représentant un thème dans le domaine.
/// 
/// Cette entité encapsule les données métier du thème
/// sans dépendances externes (Clean Architecture).
@freezed
sealed class ThemeEntity with _$ThemeEntity {
  const factory ThemeEntity({
    required ThemeMode mode,
    required bool isDark,
    required bool isLight,
    required bool isSystem,
    required String displayName,
    required String iconName,
  }) = _ThemeEntity;

  /// Factory pour créer un thème clair
  factory ThemeEntity.light() {
    return const ThemeEntity(
      mode: ThemeMode.light,
      isDark: false,
      isLight: true,
      isSystem: false,
      displayName: 'Light',
      iconName: 'light_mode',
    );
  }

  /// Factory pour créer un thème sombre
  factory ThemeEntity.dark() {
    return const ThemeEntity(
      mode: ThemeMode.dark,
      isDark: true,
      isLight: false,
      isSystem: false,
      displayName: 'Dark',
      iconName: 'dark_mode',
    );
  }

  /// Factory pour créer un thème système
  factory ThemeEntity.system() {
    return const ThemeEntity(
      mode: ThemeMode.system,
      isDark: false,
      isLight: false,
      isSystem: true,
      displayName: 'System',
      iconName: 'brightness_auto',
    );
  }

  factory ThemeEntity.fromJson(Map<String, dynamic> json) =>
      _$ThemeEntityFromJson(json);
}

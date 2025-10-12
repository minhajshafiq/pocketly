import 'package:flutter/material.dart';

/// Entité représentant un thème dans le domaine.
/// 
/// Cette entité encapsule les données métier du thème
/// sans dépendances externes (Clean Architecture).
class ThemeEntity {
  /// Mode du thème (light, dark, system)
  final ThemeMode mode;
  
  /// Indique si le thème est sombre
  final bool isDark;
  
  /// Indique si le thème est clair
  final bool isLight;
  
  /// Indique si le thème suit le système
  final bool isSystem;
  
  /// Nom d'affichage du thème
  final String displayName;
  
  /// Icône associée au thème
  final String iconName;

  const ThemeEntity({
    required this.mode,
    required this.isDark,
    required this.isLight,
    required this.isSystem,
    required this.displayName,
    required this.iconName,
  });

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

  /// Crée une copie avec des valeurs modifiées
  ThemeEntity copyWith({
    ThemeMode? mode,
    bool? isDark,
    bool? isLight,
    bool? isSystem,
    String? displayName,
    String? iconName,
  }) {
    return ThemeEntity(
      mode: mode ?? this.mode,
      isDark: isDark ?? this.isDark,
      isLight: isLight ?? this.isLight,
      isSystem: isSystem ?? this.isSystem,
      displayName: displayName ?? this.displayName,
      iconName: iconName ?? this.iconName,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    
    return other is ThemeEntity &&
        other.mode == mode &&
        other.isDark == isDark &&
        other.isLight == isLight &&
        other.isSystem == isSystem &&
        other.displayName == displayName &&
        other.iconName == iconName;
  }

  @override
  int get hashCode {
    return mode.hashCode ^
        isDark.hashCode ^
        isLight.hashCode ^
        isSystem.hashCode ^
        displayName.hashCode ^
        iconName.hashCode;
  }

  @override
  String toString() {
    return 'ThemeEntity(mode: $mode, isDark: $isDark, isLight: $isLight, isSystem: $isSystem, displayName: $displayName, iconName: $iconName)';
  }
}

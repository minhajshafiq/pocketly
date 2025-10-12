import 'package:flutter/material.dart';
import 'package:pocketly/features/themes/domain/entities/theme_entity.dart';
import 'package:pocketly/features/themes/domain/repositories/theme_repository.dart';

/// Use case pour définir un thème.
/// 
/// Encapsule la logique métier pour changer le thème
/// avec validation et gestion d'erreurs.
class SetThemeUseCase {
  final ThemeRepository _repository;

  const SetThemeUseCase(this._repository);

  /// Exécute le use case et définit le thème
  /// 
  /// [theme] Le thème à définir
  /// 
  /// Throws [ArgumentError] si le thème est invalide
  Future<void> call(ThemeEntity theme) async {
    // Validation métier
    if (theme.mode.index < 0 || theme.mode.index >= ThemeMode.values.length) {
      throw ArgumentError('Invalid theme mode');
    }
    
    // Sauvegarde du thème
    await _repository.setTheme(theme);
  }
}

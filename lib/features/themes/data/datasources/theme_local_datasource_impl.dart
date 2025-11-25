import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pocketly/features/themes/data/models/theme_model.dart';
import 'package:pocketly/features/themes/data/datasources/theme_local_datasource.dart';
import 'package:pocketly/features/themes/domain/entities/theme_entity.dart';

/// Implémentation du data source local pour les thèmes.
/// 
/// Utilise SharedPreferences pour la persistance locale
/// des préférences de thème.
class ThemeLocalDataSourceImpl implements ThemeLocalDataSource {
  static const String _themeKey = 'theme_preference';
  
  final SharedPreferences _prefs;

  const ThemeLocalDataSourceImpl(this._prefs);

  @override
  Future<ThemeModel?> getTheme() async {
    try {
      // Pour simplifier, on utilise juste le mode
      final modeIndex = _prefs.getInt(_themeKey);
      if (modeIndex == null) return null;
      
      return _createThemeModelFromMode(modeIndex);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> setTheme(ThemeModel theme) async {
    await _prefs.setInt(_themeKey, theme.mode.index);
  }

  @override
  Future<void> clearTheme() async {
    await _prefs.remove(_themeKey);
  }

  @override
  Future<bool> hasTheme() async {
    return _prefs.containsKey(_themeKey);
  }

  /// Crée un modèle de thème à partir de l'index du mode
  ThemeModel _createThemeModelFromMode(int modeIndex) {
    final mode = ThemeMode.values[modeIndex];
    
    switch (mode) {
      case ThemeMode.light:
        return ThemeEntity.light().toModel();
      case ThemeMode.dark:
        return ThemeEntity.dark().toModel();
      case ThemeMode.system:
        return ThemeEntity.system().toModel();
    }
  }
}

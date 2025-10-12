import 'dart:async';
import 'package:pocketly/features/themes/domain/entities/theme_entity.dart';
import 'package:pocketly/features/themes/domain/repositories/theme_repository.dart';
import 'package:pocketly/features/themes/data/datasources/theme_local_datasource.dart';
import 'package:pocketly/features/themes/data/models/theme_model.dart';

/// Implémentation du repository de thème.
/// 
/// Conecte le domain layer avec le data layer
/// en respectant la Clean Architecture.
class ThemeRepositoryImpl implements ThemeRepository {
  final ThemeLocalDataSource _localDataSource;
  final StreamController<ThemeEntity> _themeController = StreamController<ThemeEntity>.broadcast();

  ThemeRepositoryImpl(this._localDataSource);

  @override
  Future<ThemeEntity> getCurrentTheme() async {
    try {
      final themeModel = await _localDataSource.getTheme();
      
      if (themeModel != null) {
        return themeModel.toEntity();
      }
      
      // Retourne le thème par défaut si aucun n'est sauvegardé
      return ThemeEntity.system();
    } catch (e) {
      // En cas d'erreur, retourne le thème système par défaut
      return ThemeEntity.system();
    }
  }

  @override
  Future<void> setTheme(ThemeEntity theme) async {
    try {
      final themeModel = ThemeModel.fromEntity(theme);
      await _localDataSource.setTheme(themeModel);
      
      // Notifie les listeners du changement
      _themeController.add(theme);
    } catch (e) {
      // Log l'erreur mais ne la propage pas
      // En production, utiliser un logger approprié
      // ignore: avoid_print
      print('Error setting theme: $e');
    }
  }

  @override
  Stream<ThemeEntity> watchTheme() {
    return _themeController.stream;
  }

  @override
  Future<List<ThemeEntity>> getAvailableThemes() async {
    return [
      ThemeEntity.light(),
      ThemeEntity.dark(),
      ThemeEntity.system(),
    ];
  }

  @override
  Future<void> resetToDefault() async {
    await _localDataSource.clearTheme();
    final defaultTheme = ThemeEntity.system();
    await setTheme(defaultTheme);
  }

  /// Libère les ressources
  void dispose() {
    _themeController.close();
  }
}

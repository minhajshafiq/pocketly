import 'package:pocketly/core/services/logger_service.dart';
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
  final logger = const LoggerService();

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
      final themeModel = theme.toModel();
      await _localDataSource.setTheme(themeModel);
    } catch (e) {
      // Log l'erreur mais ne la propage pas
      logger.e('Error setting theme: $e', error: e);
    }
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
}

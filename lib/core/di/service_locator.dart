import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pocketly/features/themes/data/datasources/theme_local_datasource.dart';
import 'package:pocketly/features/themes/data/datasources/theme_local_datasource_impl.dart';
import 'package:pocketly/features/themes/data/repositories/theme_repository_impl.dart';
import 'package:pocketly/features/themes/domain/repositories/theme_repository.dart';
import 'package:pocketly/features/themes/domain/usecases/get_theme_usecase.dart';
import 'package:pocketly/features/themes/domain/usecases/set_theme_usecase.dart';
import 'package:pocketly/features/themes/domain/usecases/toggle_theme_usecase.dart';
import 'package:pocketly/features/themes/domain/usecases/get_available_themes_usecase.dart';

/// Service Locator global pour la Dependency Injection avec GetIt.
/// 
/// Centralise l'enregistrement et la résolution des dépendances
/// en respectant la Clean Architecture.
final GetIt getIt = GetIt.instance;

/// Initialise toutes les dépendances de l'application.
/// 
/// Cette fonction doit être appelée au démarrage de l'application
/// avant l'utilisation de Riverpod.
Future<void> initializeDependencies() async {
  // ==================== EXTERNAL DEPENDENCIES ====================
  
  // SharedPreferences (External)
  final prefs = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(prefs);
  
  // ==================== DATA LAYER ====================
  
  // Data Sources
  getIt.registerLazySingleton<ThemeLocalDataSource>(
    () => ThemeLocalDataSourceImpl(getIt<SharedPreferences>()),
  );
  
  // Repositories
  getIt.registerLazySingleton<ThemeRepository>(
    () => ThemeRepositoryImpl(getIt<ThemeLocalDataSource>()),
  );
  
  // ==================== DOMAIN LAYER ====================
  
  // Use Cases
  getIt.registerLazySingleton<GetThemeUseCase>(
    () => GetThemeUseCase(getIt<ThemeRepository>()),
  );
  
  getIt.registerLazySingleton<SetThemeUseCase>(
    () => SetThemeUseCase(getIt<ThemeRepository>()),
  );
  
  getIt.registerLazySingleton<ToggleThemeUseCase>(
    () => ToggleThemeUseCase(getIt<ThemeRepository>()),
  );
  
  getIt.registerLazySingleton<GetAvailableThemesUseCase>(
    () => GetAvailableThemesUseCase(getIt<ThemeRepository>()),
  );
}

/// Libère toutes les dépendances enregistrées.
/// 
/// Utile pour les tests ou le redémarrage de l'application.
Future<void> resetDependencies() async {
  await getIt.reset();
}

/// Vérifie si toutes les dépendances sont enregistrées.
bool get areDependenciesInitialized => getIt.isRegistered<SharedPreferences>();

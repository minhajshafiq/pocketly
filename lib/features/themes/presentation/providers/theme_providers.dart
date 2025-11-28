import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pocketly/core/core.dart';
import 'package:pocketly/features/themes/domain/entities/theme_entity.dart';
import 'package:pocketly/features/themes/domain/repositories/theme_repository.dart';
import 'package:pocketly/features/themes/data/repositories/theme_repository_impl.dart';
import 'package:pocketly/features/themes/data/datasources/theme_local_datasource.dart';
import 'package:pocketly/features/themes/data/datasources/theme_local_datasource_impl.dart';
import 'package:pocketly/features/themes/domain/usecases/get_theme_usecase.dart';
import 'package:pocketly/features/themes/domain/usecases/set_theme_usecase.dart';
import 'package:pocketly/features/themes/domain/usecases/toggle_theme_usecase.dart';
import 'package:pocketly/features/themes/domain/usecases/get_available_themes_usecase.dart';

part 'theme_providers.g.dart';

// ==================== EXTERNAL DEPENDENCIES ====================

// ==================== DATA LAYER ====================

/// Provider pour ThemeLocalDataSource
@riverpod
ThemeLocalDataSource themeLocalDataSource(Ref ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return ThemeLocalDataSourceImpl(prefs);
}

/// Provider pour ThemeRepository
@riverpod
ThemeRepository themeRepository(Ref ref) {
  final localDataSource = ref.watch(themeLocalDataSourceProvider);
  return ThemeRepositoryImpl(localDataSource);
}

// ==================== USE CASES ====================

/// Provider pour GetThemeUseCase
@riverpod
GetThemeUseCase getThemeUseCase(Ref ref) {
  final repository = ref.watch(themeRepositoryProvider);
  return GetThemeUseCase(repository);
}

/// Provider pour SetThemeUseCase
@riverpod
SetThemeUseCase setThemeUseCase(Ref ref) {
  final repository = ref.watch(themeRepositoryProvider);
  return SetThemeUseCase(repository);
}

/// Provider pour ToggleThemeUseCase
@riverpod
ToggleThemeUseCase toggleThemeUseCase(Ref ref) {
  final repository = ref.watch(themeRepositoryProvider);
  return ToggleThemeUseCase(repository);
}

/// Provider pour GetAvailableThemesUseCase
@riverpod
GetAvailableThemesUseCase getAvailableThemesUseCase(Ref ref) {
  final repository = ref.watch(themeRepositoryProvider);
  return GetAvailableThemesUseCase(repository);
}

// ==================== STATE MANAGEMENT ====================

/// Provider pour le thème actuel
@riverpod
Future<ThemeEntity> currentTheme(Ref ref) async {
  final getThemeUseCase = ref.read(getThemeUseCaseProvider);
  return await getThemeUseCase.call();
}

/// Provider pour les thèmes disponibles
@riverpod
Future<List<ThemeEntity>> availableThemes(Ref ref) async {
  final getAvailableThemesUseCase = ref.read(getAvailableThemesUseCaseProvider);
  return await getAvailableThemesUseCase.call();
}

/// Notifier pour la gestion du thème
@riverpod
class ThemeNotifier extends _$ThemeNotifier {
  @override
  ThemeEntity build() {
    // Écouter les changements de thème
    ref.listen(currentThemeProvider, (previous, next) {
      if (next.hasValue) {
        state = next.value!;
      }
    });
    
    // Retourner le thème par défaut
    return ThemeEntity.system();
  }

  /// Définit un nouveau thème
  Future<void> setTheme(ThemeEntity theme) async {
    final setThemeUseCase = ref.read(setThemeUseCaseProvider);
    await setThemeUseCase.call(theme);
    state = theme;
  }

  /// Bascule entre thème clair et sombre
  Future<void> toggleTheme() async {
    final toggleThemeUseCase = ref.read(toggleThemeUseCaseProvider);
    await toggleThemeUseCase.call();

    // Récupère le nouveau thème
    final getThemeUseCase = ref.read(getThemeUseCaseProvider);
    final newTheme = await getThemeUseCase.call();
    state = newTheme;
  }

  /// Réinitialise au thème par défaut
  Future<void> resetToDefault() async {
    final defaultTheme = ThemeEntity.system();
    await setTheme(defaultTheme);
  }
}

// Provider généré automatiquement par @riverpod
// Utiliser: themeProvider

// ==================== HELPER PROVIDERS ====================

/// Provider pour vérifier si le thème est sombre
@riverpod
bool isDarkTheme(Ref ref) {
  final theme = ref.watch(themeProvider);
  return theme.isDark;
}

/// Provider pour vérifier si le thème est clair
@riverpod
bool isLightTheme(Ref ref) {
  final theme = ref.watch(themeProvider);
  return theme.isLight;
}

/// Provider pour vérifier si le thème suit le système
@riverpod
bool isSystemTheme(Ref ref) {
  final theme = ref.watch(themeProvider);
  return theme.isSystem;
}

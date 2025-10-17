import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pocketly/features/themes/domain/entities/theme_entity.dart';
import 'package:pocketly/features/themes/domain/repositories/theme_repository.dart';
import 'package:pocketly/features/themes/data/repositories/theme_repository_impl.dart';
import 'package:pocketly/features/themes/data/datasources/theme_local_datasource.dart';
import 'package:pocketly/features/themes/data/datasources/theme_local_datasource_impl.dart';
import 'package:pocketly/features/themes/domain/usecases/get_theme_usecase.dart';
import 'package:pocketly/features/themes/domain/usecases/set_theme_usecase.dart';
import 'package:pocketly/features/themes/domain/usecases/toggle_theme_usecase.dart';
import 'package:pocketly/features/themes/domain/usecases/get_available_themes_usecase.dart';

// ==================== EXTERNAL DEPENDENCIES ====================

/// Provider pour SharedPreferences
final sharedPreferencesProvider = FutureProvider<SharedPreferences>((ref) async {
  return await SharedPreferences.getInstance();
});

// ==================== DATA LAYER ====================

/// Provider pour ThemeLocalDataSource
final themeLocalDataSourceProvider = FutureProvider<ThemeLocalDataSource>((ref) async {
  final prefs = await ref.watch(sharedPreferencesProvider.future);
  return ThemeLocalDataSourceImpl(prefs);
});

/// Provider pour ThemeRepository
final themeRepositoryProvider = FutureProvider<ThemeRepository>((ref) async {
  final localDataSource = await ref.watch(themeLocalDataSourceProvider.future);
  return ThemeRepositoryImpl(localDataSource);
});

// ==================== USE CASES ====================

/// Provider pour GetThemeUseCase
final getThemeUseCaseProvider = FutureProvider<GetThemeUseCase>((ref) async {
  final repository = await ref.watch(themeRepositoryProvider.future);
  return GetThemeUseCase(repository);
});

/// Provider pour SetThemeUseCase
final setThemeUseCaseProvider = FutureProvider<SetThemeUseCase>((ref) async {
  final repository = await ref.watch(themeRepositoryProvider.future);
  return SetThemeUseCase(repository);
});

/// Provider pour ToggleThemeUseCase
final toggleThemeUseCaseProvider = FutureProvider<ToggleThemeUseCase>((ref) async {
  final repository = await ref.watch(themeRepositoryProvider.future);
  return ToggleThemeUseCase(repository);
});

/// Provider pour GetAvailableThemesUseCase
final getAvailableThemesUseCaseProvider = FutureProvider<GetAvailableThemesUseCase>((ref) async {
  final repository = await ref.watch(themeRepositoryProvider.future);
  return GetAvailableThemesUseCase(repository);
});

// ==================== STATE MANAGEMENT ====================

/// Provider pour le thème actuel
final currentThemeProvider = FutureProvider<ThemeEntity>((ref) async {
  final getThemeUseCase = await ref.read(getThemeUseCaseProvider.future);
  return await getThemeUseCase.call();
});

/// Provider pour les thèmes disponibles
final availableThemesProvider = FutureProvider<List<ThemeEntity>>((ref) async {
  final getAvailableThemesUseCase = await ref.read(getAvailableThemesUseCaseProvider.future);
  return await getAvailableThemesUseCase.call();
});

/// Notifier pour la gestion du thème
class ThemeNotifier extends Notifier<ThemeEntity> {
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
    final setThemeUseCase = await ref.read(setThemeUseCaseProvider.future);
    await setThemeUseCase.call(theme);
    state = theme;
  }

  /// Bascule entre thème clair et sombre
  Future<void> toggleTheme() async {
    final toggleThemeUseCase = await ref.read(toggleThemeUseCaseProvider.future);
    await toggleThemeUseCase.call();
    
    // Récupère le nouveau thème
    final getThemeUseCase = await ref.read(getThemeUseCaseProvider.future);
    final newTheme = await getThemeUseCase.call();
    state = newTheme;
  }

  /// Réinitialise au thème par défaut
  Future<void> resetToDefault() async {
    final defaultTheme = ThemeEntity.system();
    await setTheme(defaultTheme);
  }
}

/// Provider pour le notifier de thème
final themeNotifierProvider = NotifierProvider<ThemeNotifier, ThemeEntity>(() {
  return ThemeNotifier();
});

// ==================== HELPER PROVIDERS ====================

/// Provider pour vérifier si le thème est sombre
final isDarkThemeProvider = Provider<bool>((ref) {
  final theme = ref.watch(themeNotifierProvider);
  return theme.isDark;
});

/// Provider pour vérifier si le thème est clair
final isLightThemeProvider = Provider<bool>((ref) {
  final theme = ref.watch(themeNotifierProvider);
  return theme.isLight;
});

/// Provider pour vérifier si le thème suit le système
final isSystemThemeProvider = Provider<bool>((ref) {
  final theme = ref.watch(themeNotifierProvider);
  return theme.isSystem;
});

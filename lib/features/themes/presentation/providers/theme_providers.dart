import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocketly/core/di/service_locator.dart';
import 'package:pocketly/features/themes/domain/entities/theme_entity.dart';
import 'package:pocketly/features/themes/domain/usecases/get_theme_usecase.dart';
import 'package:pocketly/features/themes/domain/usecases/set_theme_usecase.dart';
import 'package:pocketly/features/themes/domain/usecases/toggle_theme_usecase.dart';
import 'package:pocketly/features/themes/domain/usecases/get_available_themes_usecase.dart';

// ==================== USE CASES PROVIDERS (GETIT) ====================

/// Provider pour GetThemeUseCase via GetIt
final getThemeUseCaseProvider = Provider<GetThemeUseCase>((ref) {
  return getIt<GetThemeUseCase>();
});

/// Provider pour SetThemeUseCase via GetIt
final setThemeUseCaseProvider = Provider<SetThemeUseCase>((ref) {
  return getIt<SetThemeUseCase>();
});

/// Provider pour ToggleThemeUseCase via GetIt
final toggleThemeUseCaseProvider = Provider<ToggleThemeUseCase>((ref) {
  return getIt<ToggleThemeUseCase>();
});

/// Provider pour GetAvailableThemesUseCase via GetIt
final getAvailableThemesUseCaseProvider = Provider<GetAvailableThemesUseCase>((ref) {
  return getIt<GetAvailableThemesUseCase>();
});

// ==================== STATE MANAGEMENT (GETIT) ====================

/// Provider pour le thème actuel via GetIt
final currentThemeProvider = FutureProvider<ThemeEntity>((ref) async {
  final getThemeUseCase = ref.read(getThemeUseCaseProvider);
  return await getThemeUseCase.call();
});

/// Provider pour les thèmes disponibles via GetIt
final availableThemesProvider = FutureProvider<List<ThemeEntity>>((ref) async {
  final getAvailableThemesUseCase = ref.read(getAvailableThemesUseCaseProvider);
  return await getAvailableThemesUseCase.call();
});

/// Notifier pour la gestion du thème via GetIt
class ThemeNotifierGetIt extends Notifier<ThemeEntity> {
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

  /// Définit un nouveau thème via GetIt
  Future<void> setTheme(ThemeEntity theme) async {
    final setThemeUseCase = ref.read(setThemeUseCaseProvider);
    await setThemeUseCase.call(theme);
    state = theme;
  }

  /// Bascule entre thème clair et sombre via GetIt
  Future<void> toggleTheme() async {
    final toggleThemeUseCase = ref.read(toggleThemeUseCaseProvider);
    await toggleThemeUseCase.call();
    
    // Récupère le nouveau thème
    final getThemeUseCase = ref.read(getThemeUseCaseProvider);
    final newTheme = await getThemeUseCase.call();
    state = newTheme;
  }

  /// Réinitialise au thème par défaut via GetIt
  Future<void> resetToDefault() async {
    final defaultTheme = ThemeEntity.system();
    await setTheme(defaultTheme);
  }
}

/// Provider pour le notifier de thème via GetIt
final themeNotifierProvider = NotifierProvider<ThemeNotifierGetIt, ThemeEntity>(() {
  return ThemeNotifierGetIt();
});

// ==================== HELPER PROVIDERS (GETIT) ====================

/// Provider pour vérifier si le thème est sombre via GetIt
final isDarkThemeProvider = Provider<bool>((ref) {
  final theme = ref.watch(themeNotifierProvider);
  return theme.isDark;
});

/// Provider pour vérifier si le thème est clair via GetIt
final isLightThemeProvider = Provider<bool>((ref) {
  final theme = ref.watch(themeNotifierProvider);
  return theme.isLight;
});

/// Provider pour vérifier si le thème suit le système via GetIt
final isSystemThemeProvider = Provider<bool>((ref) {
  final theme = ref.watch(themeNotifierProvider);
  return theme.isSystem;
});

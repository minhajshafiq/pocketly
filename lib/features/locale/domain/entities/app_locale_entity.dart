import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/material.dart';

part 'app_locale_entity.freezed.dart';
part 'app_locale_entity.g.dart';

/// Entity représentant une locale de l'application
@freezed
sealed class AppLocaleEntity with _$AppLocaleEntity {
  const factory AppLocaleEntity({
    /// Code de la langue (ex: 'en', 'fr')
    required String languageCode,

    /// Nom de la langue dans sa propre langue
    required String nativeName,

    /// Nom de la langue en anglais
    required String englishName,

    /// Code pays optionnel (ex: 'US', 'FR')
    String? countryCode,
  }) = _AppLocaleEntity;

  factory AppLocaleEntity.fromJson(Map<String, dynamic> json) =>
      _$AppLocaleEntityFromJson(json);
}

/// Extension pour convertir AppLocaleEntity en Locale Flutter
extension AppLocaleEntityX on AppLocaleEntity {
  Locale toLocale() {
    return Locale(languageCode, countryCode);
  }
}

/// Extension pour créer AppLocaleEntity depuis Locale Flutter
extension LocaleX on Locale {
  AppLocaleEntity toAppLocale() {
    // Map des locales supportées
    final supportedLocales = {
      'en': const AppLocaleEntity(
        languageCode: 'en',
        nativeName: 'English',
        englishName: 'English',
      ),
      'fr': const AppLocaleEntity(
        languageCode: 'fr',
        nativeName: 'Français',
        englishName: 'French',
      ),
    };

    return supportedLocales[languageCode] ??
        supportedLocales['en']!;
  }
}

/// Classe statique contenant les locales supportées
class SupportedLocales {
  SupportedLocales._();

  static const english = AppLocaleEntity(
    languageCode: 'en',
    nativeName: 'English',
    englishName: 'English',
  );

  static const french = AppLocaleEntity(
    languageCode: 'fr',
    nativeName: 'Français',
    englishName: 'French',
  );

  /// Liste de toutes les locales supportées
  static const List<AppLocaleEntity> all = [
    english,
    french,
  ];

  /// Récupérer une locale par son code
  static AppLocaleEntity fromLanguageCode(String code) {
    return all.firstWhere(
      (locale) => locale.languageCode == code,
      orElse: () => english,
    );
  }

  /// Récupérer la locale par défaut
  static AppLocaleEntity get defaultLocale => english;

  /// Récupérer la locale du système
  static AppLocaleEntity getSystemLocale(Locale systemLocale) {
    return all.firstWhere(
      (locale) => locale.languageCode == systemLocale.languageCode,
      orElse: () => english,
    );
  }
}

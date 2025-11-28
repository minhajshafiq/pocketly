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

  /// Liste des codes pays francophones (ISO 3166-1 alpha-2)
  /// Inclut la France, le Canada, la Belgique, la Suisse, et autres pays francophones
  static const Set<String> francophoneCountries = {
    'FR', // France
    'CA', // Canada
    'BE', // Belgique
    'CH', // Suisse
    'LU', // Luxembourg
    'MC', // Monaco
    'AD', // Andorre
    'CD', // République démocratique du Congo
    'CG', // République du Congo
    'CI', // Côte d'Ivoire
    'CM', // Cameroun
    'SN', // Sénégal
    'BF', // Burkina Faso
    'ML', // Mali
    'NE', // Niger
    'TD', // Tchad
    'GN', // Guinée
    'BJ', // Bénin
    'TG', // Togo
    'CF', // République centrafricaine
    'GA', // Gabon
    'GQ', // Guinée équatoriale
    'DJ', // Djibouti
    'KM', // Comores
    'MG', // Madagascar
    'MU', // Maurice
    'SC', // Seychelles
    'RW', // Rwanda
    'BI', // Burundi
    'HT', // Haïti
    'MQ', // Martinique
    'GP', // Guadeloupe
    'GF', // Guyane française
    'RE', // La Réunion
    'PM', // Saint-Pierre-et-Miquelon
    'YT', // Mayotte
    'NC', // Nouvelle-Calédonie
    'PF', // Polynésie française
    'WF', // Wallis-et-Futuna
    'BL', // Saint-Barthélemy
    'MF', // Saint-Martin
    'VA', // Vatican (officiellement bilingue)
  };

  /// Récupérer la locale du système en fonction de la langue et du pays
  /// 
  /// Détecte automatiquement :
  /// - Français si la langue est 'fr' OU si le pays est francophone
  /// - Anglais pour le reste
  static AppLocaleEntity getSystemLocale(Locale systemLocale) {
    // Si la langue est déjà français, retourner français
    if (systemLocale.languageCode == 'fr') {
      return french;
    }

    // Si le pays est francophone, retourner français
    if (systemLocale.countryCode != null &&
        francophoneCountries.contains(systemLocale.countryCode!.toUpperCase())) {
      return french;
    }

    // Par défaut, retourner anglais
    return english;
  }
}

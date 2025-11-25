import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_settings_entity.freezed.dart';
part 'app_settings_entity.g.dart';

/// Entity représentant les paramètres de l'application.
///
/// Note: La gestion de la langue a été déplacée vers la feature `locale`.
/// Utilisez `lib/features/locale` pour gérer la localisation.
@freezed
sealed class AppSettingsEntity with _$AppSettingsEntity {
  const factory AppSettingsEntity({
    /// Mode du thème (ex: 'light', 'dark', 'system')
    required String themeMode,

    /// Activer les notifications
    @Default(true) bool notificationsEnabled,

    /// Format de date (ex: 'dd/MM/yyyy', 'MM/dd/yyyy')
    @Default('dd/MM/yyyy') String dateFormat,
  }) = _AppSettingsEntity;

  factory AppSettingsEntity.fromJson(Map<String, dynamic> json) =>
      _$AppSettingsEntityFromJson(json);
}

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pocketly/features/notifications/domain/entities/notification_preferences_entity.dart';
import 'package:pocketly/features/user/user.dart';
import 'package:pocketly/features/auth/auth.dart';

part 'notification_preferences_provider.g.dart';

/// Provider pour les préférences de notifications de l'utilisateur
@riverpod
class NotificationPreferences extends _$NotificationPreferences {
  static const String _keyPrefix = 'notification_prefs_';

  @override
  Future<NotificationPreferencesEntity?> build() async {
    final userId = ref.watch(currentUserIdProvider);
    if (userId == null) return null;

    return _loadPreferences(userId);
  }

  /// Charge les préférences depuis SharedPreferences
  Future<NotificationPreferencesEntity> _loadPreferences(String userId) async {
    final prefs = await SharedPreferences.getInstance();

    return NotificationPreferencesEntity(
      userId: userId,
      budgetExceededEnabled: prefs.getBool('${_keyPrefix}budget_exceeded_$userId') ?? true,
      goalReachedEnabled: prefs.getBool('${_keyPrefix}goal_reached_$userId') ?? true,
      monthEndReminderEnabled: prefs.getBool('${_keyPrefix}month_end_reminder_$userId') ?? true,
      weeklySummaryEnabled: prefs.getBool('${_keyPrefix}weekly_summary_$userId') ?? true,
      monthlyReportEnabled: prefs.getBool('${_keyPrefix}monthly_report_$userId') ?? true,
    );
  }

  /// Sauvegarde les préférences dans SharedPreferences
  Future<void> _savePreferences(NotificationPreferencesEntity preferences) async {
    final prefs = await SharedPreferences.getInstance();
    final userId = preferences.userId;

    await Future.wait([
      prefs.setBool('${_keyPrefix}budget_exceeded_$userId', preferences.budgetExceededEnabled),
      prefs.setBool('${_keyPrefix}goal_reached_$userId', preferences.goalReachedEnabled),
      prefs.setBool('${_keyPrefix}month_end_reminder_$userId', preferences.monthEndReminderEnabled),
      prefs.setBool('${_keyPrefix}weekly_summary_$userId', preferences.weeklySummaryEnabled),
      prefs.setBool('${_keyPrefix}monthly_report_$userId', preferences.monthlyReportEnabled),
    ]);
  }

  /// Met à jour une préférence spécifique
  Future<void> updatePreference({
    bool? budgetExceededEnabled,
    bool? goalReachedEnabled,
    bool? monthEndReminderEnabled,
    bool? weeklySummaryEnabled,
    bool? monthlyReportEnabled,
  }) async {
    final current = state.value;
    if (current == null) return;

    final updated = NotificationPreferencesEntity(
      userId: current.userId,
      budgetExceededEnabled: budgetExceededEnabled ?? current.budgetExceededEnabled,
      goalReachedEnabled: goalReachedEnabled ?? current.goalReachedEnabled,
      monthEndReminderEnabled: monthEndReminderEnabled ?? current.monthEndReminderEnabled,
      weeklySummaryEnabled: weeklySummaryEnabled ?? current.weeklySummaryEnabled,
      monthlyReportEnabled: monthlyReportEnabled ?? current.monthlyReportEnabled,
    );

    await _savePreferences(updated);
    state = AsyncValue.data(updated);
  }

  /// Réinitialise toutes les préférences aux valeurs par défaut
  Future<void> resetToDefaults() async {
    final userId = ref.read(currentUserIdProvider);
    if (userId == null) return;

    final defaults = NotificationPreferencesEntity(userId: userId);
    await _savePreferences(defaults);
    state = AsyncValue.data(defaults);
  }
}

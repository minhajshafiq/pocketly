import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pocketly/generated/l10n/app_localizations.dart';
import 'daily_expense_entity.dart';

part 'chart_data_entity.freezed.dart';
part 'chart_data_entity.g.dart';

/// Type de graphique
enum ChartType { bar, line }

/// Période de temps
enum TimePeriod { week, month, year }

extension TimePeriodX on TimePeriod {
  String get displayName {
    switch (this) {
      case TimePeriod.week:
        return 'Semaine';
      case TimePeriod.month:
        return 'Mois';
      case TimePeriod.year:
        return 'Année';
    }
  }

  /// Retourne le nom traduit de la période
  String getName(AppLocalizations l10n) {
    switch (this) {
      case TimePeriod.week:
        return l10n.week;
      case TimePeriod.month:
        return l10n.month;
      case TimePeriod.year:
        return l10n.year;
    }
  }

  int get daysCount {
    switch (this) {
      case TimePeriod.week:
        return 7;
      case TimePeriod.month:
        return 30;
      case TimePeriod.year:
        return 365;
    }
  }
}

/// Entité représentant les données du graphique
@freezed
sealed class ChartDataEntity with _$ChartDataEntity {
  const factory ChartDataEntity({
    required List<DailyExpenseEntity> dailyExpenses,
    required TimePeriod period,
    required DateTime startDate,
    required DateTime endDate,
    required double maxExpense,
    required double totalExpense,
    required double totalIncome,
  }) = _ChartDataEntity;

  factory ChartDataEntity.fromJson(Map<String, dynamic> json) =>
      _$ChartDataEntityFromJson(json);
}

extension ChartDataEntityX on ChartDataEntity {
  /// Vérifie si des données existent
  bool get hasData => dailyExpenses.isNotEmpty && totalExpense > 0;

  /// Retourne le solde net
  double get balance => totalIncome - totalExpense;

  /// Format de la période pour affichage
  String get periodDisplay {
    switch (period) {
      case TimePeriod.week:
        // Format: "20/10 - 26/10"
        final start =
            '${startDate.day.toString().padLeft(2, '0')}/${startDate.month.toString().padLeft(2, '0')}';
        final end =
            '${endDate.day.toString().padLeft(2, '0')}/${endDate.month.toString().padLeft(2, '0')}';
        return '$start - $end';
      case TimePeriod.month:
        // Format: "Jan - Juin 2024"
        const monthNames = [
          'Jan', 'Fév', 'Mar', 'Avr', 'Mai', 'Juin',
          'Juil', 'Août', 'Sep', 'Oct', 'Nov', 'Déc'
        ];
        final startMonth = monthNames[startDate.month - 1];
        final endMonth = monthNames[endDate.month - 1];
        final endYear = endDate.year;
        return '$startMonth - $endMonth $endYear';
      case TimePeriod.year:
        // Format: "2018 - 2024"
        return '${startDate.year} - ${endDate.year}';
    }
  }
}

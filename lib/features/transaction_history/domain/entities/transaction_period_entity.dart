import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction_period_entity.freezed.dart';
part 'transaction_period_entity.g.dart';

/// Enum pour les types de période
enum PeriodType {
  today,
  week,
  month,
  year,
  custom,
}

/// Entité représentant une période de transactions
@freezed
sealed class TransactionPeriodEntity with _$TransactionPeriodEntity {
  const factory TransactionPeriodEntity({
    required PeriodType type,
    required DateTime startDate,
    required DateTime endDate,
    String? label,
  }) = _TransactionPeriodEntity;

  factory TransactionPeriodEntity.fromJson(Map<String, dynamic> json) =>
      _$TransactionPeriodEntityFromJson(json);
}

/// Extension pour obtenir des périodes prédéfinies
extension TransactionPeriodX on TransactionPeriodEntity {
  /// Période pour aujourd'hui
  static TransactionPeriodEntity today() {
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);
    final endOfDay = DateTime(now.year, now.month, now.day, 23, 59, 59);

    return TransactionPeriodEntity(
      type: PeriodType.today,
      startDate: startOfDay,
      endDate: endOfDay,
      label: 'Aujourd\'hui',
    );
  }

  /// Période pour cette semaine (lundi à dimanche)
  static TransactionPeriodEntity thisWeek() {
    final now = DateTime.now();
    final weekDay = now.weekday; // 1 = Lundi, 7 = Dimanche
    final daysFromMonday = weekDay - 1;
    final monday = now.subtract(Duration(days: daysFromMonday));
    final startOfWeek = DateTime(monday.year, monday.month, monday.day);
    final endOfWeek = startOfWeek.add(const Duration(days: 6, hours: 23, minutes: 59, seconds: 59));

    return TransactionPeriodEntity(
      type: PeriodType.week,
      startDate: startOfWeek,
      endDate: endOfWeek,
      label: 'Cette semaine',
    );
  }

  /// Période pour ce mois
  static TransactionPeriodEntity thisMonth() {
    final now = DateTime.now();
    final startOfMonth = DateTime(now.year, now.month, 1);
    final endOfMonth = DateTime(now.year, now.month + 1, 0, 23, 59, 59);

    return TransactionPeriodEntity(
      type: PeriodType.month,
      startDate: startOfMonth,
      endDate: endOfMonth,
      label: 'Ce mois',
    );
  }

  /// Période pour cette année
  static TransactionPeriodEntity thisYear() {
    final now = DateTime.now();
    final startOfYear = DateTime(now.year, 1, 1);
    final endOfYear = DateTime(now.year, 12, 31, 23, 59, 59);

    return TransactionPeriodEntity(
      type: PeriodType.year,
      startDate: startOfYear,
      endDate: endOfYear,
      label: 'Cette année',
    );
  }

  /// Période personnalisée
  static TransactionPeriodEntity custom({
    required DateTime startDate,
    required DateTime endDate,
    String? label,
  }) {
    return TransactionPeriodEntity(
      type: PeriodType.custom,
      startDate: startDate,
      endDate: endDate,
      label: label ?? 'Personnalisé',
    );
  }

  /// Vérifie si une date est dans cette période
  bool containsDate(DateTime date) {
    return date.isAfter(startDate.subtract(const Duration(seconds: 1))) &&
        date.isBefore(endDate.add(const Duration(seconds: 1)));
  }

  /// Retourne la durée en jours
  int get durationInDays {
    return endDate.difference(startDate).inDays + 1;
  }

  /// Vérifie si c'est aujourd'hui
  bool get isToday {
    final now = DateTime.now();
    final todayStart = DateTime(now.year, now.month, now.day);
    return startDate.isAtSameMomentAs(todayStart);
  }

  /// Vérifie si c'est cette semaine
  bool get isThisWeek {
    return type == PeriodType.week && containsDate(DateTime.now());
  }

  /// Vérifie si c'est ce mois
  bool get isThisMonth {
    final now = DateTime.now();
    return type == PeriodType.month &&
        startDate.year == now.year &&
        startDate.month == now.month;
  }

  /// Vérifie si c'est cette année
  bool get isThisYear {
    final now = DateTime.now();
    return type == PeriodType.year && startDate.year == now.year;
  }
}

import 'package:freezed_annotation/freezed_annotation.dart';

part 'weekly_expense_entity.freezed.dart';
part 'weekly_expense_entity.g.dart';

/// Entité représentant les dépenses d'un jour de la semaine.
@freezed
sealed class WeeklyExpenseEntity with _$WeeklyExpenseEntity {
  const factory WeeklyExpenseEntity({
    /// Jour de la semaine (1 = Lundi, 7 = Dimanche)
    required int dayOfWeek,

    /// Date du jour
    required DateTime date,

    /// Montant total des dépenses du jour
    required double amount,

    /// Nombre de transactions du jour
    @Default(0) int transactionCount,
  }) = _WeeklyExpenseEntity;

  factory WeeklyExpenseEntity.fromJson(Map<String, dynamic> json) =>
      _$WeeklyExpenseEntityFromJson(json);
}

/// Extension pour des méthodes utilitaires
extension WeeklyExpenseEntityX on WeeklyExpenseEntity {
  /// Retourne le nom du jour en français
  String get dayName {
    switch (dayOfWeek) {
      case 1:
        return 'Lun';
      case 2:
        return 'Mar';
      case 3:
        return 'Mer';
      case 4:
        return 'Jeu';
      case 5:
        return 'Ven';
      case 6:
        return 'Sam';
      case 7:
        return 'Dim';
      default:
        return '';
    }
  }

  /// Retourne le nom du jour complet
  String get fullDayName {
    switch (dayOfWeek) {
      case 1:
        return 'Lundi';
      case 2:
        return 'Mardi';
      case 3:
        return 'Mercredi';
      case 4:
        return 'Jeudi';
      case 5:
        return 'Vendredi';
      case 6:
        return 'Samedi';
      case 7:
        return 'Dimanche';
      default:
        return '';
    }
  }

  /// Indique si c'est aujourd'hui
  bool get isToday {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }
}

/// Liste des dépenses de la semaine
@freezed
sealed class WeeklyExpensesEntity with _$WeeklyExpensesEntity {
  const factory WeeklyExpensesEntity({
    /// Liste des dépenses par jour
    required List<WeeklyExpenseEntity> expenses,

    /// Total de la semaine
    required double totalWeekAmount,

    /// Date de début de la semaine
    required DateTime weekStartDate,

    /// Date de fin de la semaine
    required DateTime weekEndDate,
  }) = _WeeklyExpensesEntity;

  factory WeeklyExpensesEntity.fromJson(Map<String, dynamic> json) =>
      _$WeeklyExpensesEntityFromJson(json);
}

/// Extension pour WeeklyExpensesEntity
extension WeeklyExpensesEntityX on WeeklyExpensesEntity {
  /// Retourne le jour avec le montant maximum
  WeeklyExpenseEntity? get maxExpenseDay {
    if (expenses.isEmpty) return null;
    return expenses.reduce(
        (curr, next) => curr.amount > next.amount ? curr : next);
  }

  /// Retourne le montant moyen par jour
  double get averageDailyAmount {
    if (expenses.isEmpty) return 0;
    return totalWeekAmount / expenses.length;
  }

  /// Indique si c'est la semaine actuelle
  bool get isCurrentWeek {
    final now = DateTime.now();
    return weekStartDate.isBefore(now) && weekEndDate.isAfter(now);
  }
}

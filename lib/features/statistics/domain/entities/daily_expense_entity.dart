import 'package:freezed_annotation/freezed_annotation.dart';

part 'daily_expense_entity.freezed.dart';
part 'daily_expense_entity.g.dart';

/// Entité représentant les dépenses quotidiennes
@freezed
sealed class DailyExpenseEntity with _$DailyExpenseEntity {
  const factory DailyExpenseEntity({
    required DateTime date,
    required int dayOfWeek,
    required double income,
    required double expense,
    required int transactionCount,
  }) = _DailyExpenseEntity;

  factory DailyExpenseEntity.fromJson(Map<String, dynamic> json) =>
      _$DailyExpenseEntityFromJson(json);
}

extension DailyExpenseEntityX on DailyExpenseEntity {
  /// Retourne le solde net (income - expense)
  double get balance => income - expense;

  /// Vérifie si c'est aujourd'hui
  bool get isToday {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }
}

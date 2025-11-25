import 'package:freezed_annotation/freezed_annotation.dart';

part 'calendar_day_entity.freezed.dart';
part 'calendar_day_entity.g.dart';

/// Item de transaction minimal pour le calendrier
@freezed
sealed class CalendarTransactionItem with _$CalendarTransactionItem {
  const factory CalendarTransactionItem({
    required String? imageUrl,
    required String type, // 'expense' ou 'income'
  }) = _CalendarTransactionItem;

  factory CalendarTransactionItem.fromJson(Map<String, dynamic> json) =>
      _$CalendarTransactionItemFromJson(json);
}

/// Entité représentant un jour dans le calendrier
@freezed
sealed class CalendarDayEntity with _$CalendarDayEntity {
  const factory CalendarDayEntity({
    required DateTime date,
    required int transactionCount,
    required double totalExpense,
    required double totalIncome,
    @Default([]) List<CalendarTransactionItem> transactions,
    @Default(false) bool hasTransactions,
    @Default(false) bool isToday,
    @Default(false) bool isSelected,
    @Default(false) bool isCurrentMonth,
  }) = _CalendarDayEntity;

  factory CalendarDayEntity.fromJson(Map<String, dynamic> json) =>
      _$CalendarDayEntityFromJson(json);
}

/// Extension pour CalendarDayEntity
extension CalendarDayX on CalendarDayEntity {
  /// Crée un jour vide
  static CalendarDayEntity empty(DateTime date, {bool isCurrentMonth = true}) {
    final now = DateTime.now();
    final isToday = date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;

    return CalendarDayEntity(
      date: date,
      transactionCount: 0,
      totalExpense: 0,
      totalIncome: 0,
      hasTransactions: false,
      isToday: isToday,
      isSelected: false,
      isCurrentMonth: isCurrentMonth,
    );
  }

  /// Balance du jour (revenus - dépenses)
  double get balance => totalIncome - totalExpense;

  /// Vérifie si le jour a des dépenses
  bool get hasExpenses => totalExpense > 0;

  /// Vérifie si le jour a des revenus
  bool get hasIncomes => totalIncome > 0;

  /// Retourne le jour du mois
  int get dayOfMonth => date.day;

  /// Retourne le jour de la semaine (1 = Lundi, 7 = Dimanche)
  int get dayOfWeek => date.weekday;

  /// Retourne le nom court du jour (Lun, Mar, etc.)
  String get dayNameShort {
    switch (date.weekday) {
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

  /// Vérifie si c'est un week-end
  bool get isWeekend => date.weekday == 6 || date.weekday == 7;

  /// Retourne une icône suggérée selon les transactions
  String get suggestedIcon {
    if (!hasTransactions) return '';
    if (hasExpenses && !hasIncomes) return '💸';
    if (!hasExpenses && hasIncomes) return '💰';
    return '💱'; // Les deux
  }

  /// Retourne une couleur suggérée selon le balance
  String get suggestedColorHex {
    if (!hasTransactions) return '';
    if (balance > 0) return '#10B981'; // Vert (profit)
    if (balance < 0) return '#EF4444'; // Rouge (perte)
    return '#F59E0B'; // Orange (équilibré)
  }
}

import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction_entity.freezed.dart';
part 'transaction_entity.g.dart';

/// Enum pour la récurrence des transactions
enum RecurrenceType {
  none,
  daily,
  weekly,
  biweekly,
  monthly,
  quarterly,
  yearly;

  String getName(dynamic l10n) {
    return switch (this) {
      RecurrenceType.none => l10n.recurrenceNone,
      RecurrenceType.daily => l10n.recurrenceDaily,
      RecurrenceType.weekly => l10n.recurrenceWeekly,
      RecurrenceType.biweekly => l10n.recurrenceBiweekly,
      RecurrenceType.monthly => l10n.recurrenceMonthly,
      RecurrenceType.quarterly => l10n.recurrenceQuarterly,
      RecurrenceType.yearly => l10n.recurrenceYearly,
    };
  }

  bool get isRecurring => this != RecurrenceType.none;
}

/// Type de transaction
enum TransactionType {
  income,
  expense;
}

/// Entity pour les transactions
@freezed
sealed class TransactionEntity with _$TransactionEntity {
  const factory TransactionEntity({
    String? id,
    required String name,
    required double amount,
    required DateTime date,
    @JsonKey(name: 'category_id') required String categoryId,
    required TransactionType type,
    @Default(RecurrenceType.none) RecurrenceType recurrence,
    @JsonKey(name: 'image_url') String? imageUrl,
    String? notes,
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'pocket_id') String? pocketId,
    @JsonKey(name: 'recurrence_group_id') int? recurrenceGroupId,
    @JsonKey(name: 'recurrence_start_date') DateTime? recurrenceStartDate,
    @JsonKey(name: 'recurrence_end_date') DateTime? recurrenceEndDate,
    @JsonKey(name: 'recurrence_day_of_month') int? recurrenceDayOfMonth,
    @JsonKey(name: 'is_recurrence_active') @Default(false) bool isRecurrenceActive,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _TransactionEntity;

  const TransactionEntity._();

  /// Factory pour transaction simple
  factory TransactionEntity.simple({
    required String name,
    required double amount,
    required DateTime date,
    required String categoryId,
    required TransactionType type,
    String? imageUrl,
    String? notes,
    required String userId,
    String? pocketId,
  }) {
    return TransactionEntity(
      name: name,
      amount: amount,
      date: date,
      categoryId: categoryId,
      type: type,
      recurrence: RecurrenceType.none,
      imageUrl: imageUrl,
      notes: notes,
      userId: userId,
      pocketId: pocketId,
    );
  }

  /// Factory pour transaction récurrente
  factory TransactionEntity.recurring({
    int? recurrenceGroupId,
    required String name,
    required double amount,
    required DateTime startDate,
    required String categoryId,
    required TransactionType type,
    required RecurrenceType recurrence,
    DateTime? endDate,
    String? imageUrl,
    String? notes,
    required String userId,
    String? pocketId,
  }) {
    return TransactionEntity(
      name: name,
      amount: amount,
      date: startDate,
      categoryId: categoryId,
      type: type,
      recurrence: recurrence,
      recurrenceGroupId: recurrenceGroupId,
      recurrenceStartDate: startDate,
      recurrenceEndDate: endDate,
      recurrenceDayOfMonth: startDate.day,
      imageUrl: imageUrl,
      notes: notes,
      userId: userId,
      pocketId: pocketId,
      isRecurrenceActive: true,
    );
  }

  factory TransactionEntity.fromJson(Map<String, dynamic> json) =>
      _$TransactionEntityFromJson(json);

  // Getters
  bool get isExpense => type == TransactionType.expense;
  bool get isIncome => type == TransactionType.income;
  bool get isRecurring => recurrence != RecurrenceType.none;
  double get signedAmount => isExpense ? -amount : amount;
  double get roundedAmount => double.parse(amount.toStringAsFixed(2));

  String formatAmount({String currency = '€'}) {
    final sign = isExpense ? '-' : '+';
    return '$sign${amount.toStringAsFixed(2)} $currency';
  }

  /// Calcule la prochaine date en gérant intelligemment les jours du mois
  DateTime getNextOccurrence(DateTime currentDate) {
    if (recurrence == RecurrenceType.none) return currentDate;

    return switch (recurrence) {
      RecurrenceType.daily => currentDate.add(const Duration(days: 1)),
      RecurrenceType.weekly => currentDate.add(const Duration(days: 7)),
      RecurrenceType.biweekly => currentDate.add(const Duration(days: 14)),
      RecurrenceType.monthly => _getNextMonthOccurrence(currentDate),
      RecurrenceType.quarterly => _getNextQuarterOccurrence(currentDate),
      RecurrenceType.yearly => _getNextYearOccurrence(currentDate),
      RecurrenceType.none => currentDate,
    };
  }

  /// Gère intelligemment le mois suivant (28, 29, 30, 31 jours)
  DateTime _getNextMonthOccurrence(DateTime current) {
    final targetDay = recurrenceDayOfMonth ?? current.day;
    int nextMonth = current.month + 1;
    int nextYear = current.year;

    if (nextMonth > 12) {
      nextMonth = 1;
      nextYear++;
    }

    final lastDayOfNextMonth = DateTime(nextYear, nextMonth + 1, 0).day;
    final adjustedDay = targetDay > lastDayOfNextMonth 
        ? lastDayOfNextMonth 
        : targetDay;

    return DateTime(nextYear, nextMonth, adjustedDay);
  }

  /// Gère le trimestre suivant
  DateTime _getNextQuarterOccurrence(DateTime current) {
    final targetDay = recurrenceDayOfMonth ?? current.day;
    int nextMonth = current.month + 3;
    int nextYear = current.year;

    while (nextMonth > 12) {
      nextMonth -= 12;
      nextYear++;
    }

    final lastDayOfMonth = DateTime(nextYear, nextMonth + 1, 0).day;
    final adjustedDay = targetDay > lastDayOfMonth ? lastDayOfMonth : targetDay;

    return DateTime(nextYear, nextMonth, adjustedDay);
  }

  /// Gère l'année suivante (avec années bissextiles)
  DateTime _getNextYearOccurrence(DateTime current) {
    final targetDay = recurrenceDayOfMonth ?? current.day;
    final nextYear = current.year + 1;
    final month = current.month;

    if (month == 2 && targetDay == 29 && !_isLeapYear(nextYear)) {
      return DateTime(nextYear, month, 28);
    }

    final lastDayOfMonth = DateTime(nextYear, month + 1, 0).day;
    final adjustedDay = targetDay > lastDayOfMonth ? lastDayOfMonth : targetDay;

    return DateTime(nextYear, month, adjustedDay);
  }

  /// Vérifie si une année est bissextile
  bool _isLeapYear(int year) {
    return (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);
  }

  /// Génère toutes les occurrences pour un mois donné
  List<TransactionEntity> getOccurrencesForMonth({
    required int year,
    required int month,
  }) {
    if (recurrence == RecurrenceType.none) {
      if (date.year == year && date.month == month) {
        return [this];
      }
      return [];
    }

    final occurrences = <TransactionEntity>[];
    final monthStart = DateTime(year, month, 1);
    final monthEnd = DateTime(year, month + 1, 0, 23, 59, 59);

    DateTime currentDate = recurrenceStartDate ?? date;

    while (currentDate.isBefore(monthStart)) {
      currentDate = getNextOccurrence(currentDate);
    }

    while (currentDate.isBefore(monthEnd) || currentDate.isAtSameMomentAs(monthEnd)) {
      if (recurrenceEndDate != null && currentDate.isAfter(recurrenceEndDate!)) {
        break;
      }

      if (!isRecurrenceActive) break;

      occurrences.add(copyWith(date: currentDate));
      currentDate = getNextOccurrence(currentDate);
    }

    return occurrences;
  }

  /// Génère toutes les occurrences entre deux dates
  List<TransactionEntity> getOccurrencesBetween({
    required DateTime start,
    required DateTime end,
  }) {
    if (recurrence == RecurrenceType.none) {
      if ((date.isAfter(start) || date.isAtSameMomentAs(start)) &&
          (date.isBefore(end) || date.isAtSameMomentAs(end))) {
        return [this];
      }
      return [];
    }

    final occurrences = <TransactionEntity>[];
    DateTime currentDate = recurrenceStartDate ?? date;

    while (currentDate.isBefore(start)) {
      currentDate = getNextOccurrence(currentDate);
    }

    while (currentDate.isBefore(end) || currentDate.isAtSameMomentAs(end)) {
      if (recurrenceEndDate != null && currentDate.isAfter(recurrenceEndDate!)) {
        break;
      }

      if (!isRecurrenceActive) break;

      occurrences.add(copyWith(date: currentDate));
      currentDate = getNextOccurrence(currentDate);
    }

    return occurrences;
  }

  /// Obtient la prochaine occurrence à venir
  TransactionEntity? getNextUpcoming() {
    if (recurrence == RecurrenceType.none) return null;
    if (!isRecurrenceActive) return null;

    DateTime nextDate = getNextOccurrence(date);
    
    if (recurrenceEndDate != null && nextDate.isAfter(recurrenceEndDate!)) {
      return null;
    }

    return copyWith(date: nextDate);
  }
}

/// Extension pour les listes de transactions
extension TransactionListExtension on List<TransactionEntity> {
  List<TransactionEntity> byType(TransactionType type) =>
      where((t) => t.type == type).toList();

  List<TransactionEntity> get expenses => where((t) => t.isExpense).toList();
  List<TransactionEntity> get incomes => where((t) => t.isIncome).toList();

  List<TransactionEntity> get recurring =>
      where((t) => t.isRecurring).toList();

  List<TransactionEntity> get nonRecurring =>
      where((t) => !t.isRecurring).toList();

  /// Filtre par groupe de récurrence
  List<TransactionEntity> byRecurrenceGroup(int groupId) =>
      where((t) => t.recurrenceGroupId == groupId).toList();

  /// Génère toutes les transactions pour un mois (récurrentes + uniques)
  List<TransactionEntity> expandForMonth({
    required int year,
    required int month,
  }) {
    final expanded = <TransactionEntity>[];
    final processed = <int>{};

    for (final transaction in this) {
      if (transaction.recurrenceGroupId != null) {
        if (processed.contains(transaction.recurrenceGroupId)) continue;
        processed.add(transaction.recurrenceGroupId!);
      }

      expanded.addAll(transaction.getOccurrencesForMonth(
        year: year,
        month: month,
      ));
    }

    return expanded;
  }

  /// Génère toutes les transactions entre deux dates
  List<TransactionEntity> expandBetween({
    required DateTime start,
    required DateTime end,
  }) {
    final expanded = <TransactionEntity>[];
    final processed = <int>{};

    for (final transaction in this) {
      if (transaction.recurrenceGroupId != null) {
        if (processed.contains(transaction.recurrenceGroupId)) continue;
        processed.add(transaction.recurrenceGroupId!);
      }

      expanded.addAll(transaction.getOccurrencesBetween(
        start: start,
        end: end,
      ));
    }

    return expanded;
  }

  double get total => fold(0.0, (sum, t) => sum + t.signedAmount);
  double get totalExpenses => expenses.fold(0.0, (sum, t) => sum + t.amount);
  double get totalIncomes => incomes.fold(0.0, (sum, t) => sum + t.amount);
  double get balance => totalIncomes - totalExpenses;

  List<TransactionEntity> sortedByDate({bool ascending = false}) {
    final sorted = List<TransactionEntity>.from(this);
    sorted.sort((a, b) => ascending 
        ? a.date.compareTo(b.date) 
        : b.date.compareTo(a.date));
    return sorted;
  }

  Map<String, List<TransactionEntity>> groupByMonth() {
    final grouped = <String, List<TransactionEntity>>{};
    for (final transaction in this) {
      final key = '${transaction.date.year}-${transaction.date.month.toString().padLeft(2, '0')}';
      grouped.putIfAbsent(key, () => []).add(transaction);
    }
    return grouped;
  }

  Map<int, List<TransactionEntity>> groupByRecurrence() {
    final grouped = <int, List<TransactionEntity>>{};
    for (final transaction in this) {
      if (transaction.recurrenceGroupId != null) {
        grouped
            .putIfAbsent(transaction.recurrenceGroupId!, () => [])
            .add(transaction);
      }
    }
    return grouped;
  }
}

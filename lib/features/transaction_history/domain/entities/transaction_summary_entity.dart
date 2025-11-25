import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pocketly/features/transactions/transactions.dart';

part 'transaction_summary_entity.freezed.dart';
part 'transaction_summary_entity.g.dart';

/// Entité représentant un résumé de transactions pour une période
@freezed
sealed class TransactionSummaryEntity with _$TransactionSummaryEntity {
  const factory TransactionSummaryEntity({
    /// Liste des transactions (non sérialisée car potentiellement volumineuse)
    @JsonKey(includeFromJson: false, includeToJson: false)
    @Default([])
    List<TransactionEntity> transactions,
    required DateTime startDate,
    required DateTime endDate,
    required double totalExpense,
    required double totalIncome,
    required int expenseCount,
    required int incomeCount,
    @Default('') String periodLabel,
  }) = _TransactionSummaryEntity;

  factory TransactionSummaryEntity.fromJson(Map<String, dynamic> json) =>
      _$TransactionSummaryEntityFromJson(json);
}

/// Extension pour TransactionSummaryEntity
extension TransactionSummaryX on TransactionSummaryEntity {
  /// Crée un résumé vide
  static TransactionSummaryEntity empty({
    required DateTime startDate,
    required DateTime endDate,
    String periodLabel = '',
  }) {
    return TransactionSummaryEntity(
      transactions: [],
      startDate: startDate,
      endDate: endDate,
      totalExpense: 0,
      totalIncome: 0,
      expenseCount: 0,
      incomeCount: 0,
      periodLabel: periodLabel,
    );
  }

  /// Crée un résumé depuis une liste de transactions
  static TransactionSummaryEntity fromTransactions({
    required List<TransactionEntity> transactions,
    required DateTime startDate,
    required DateTime endDate,
    String periodLabel = '',
  }) {
    double totalExpense = 0;
    double totalIncome = 0;
    int expenseCount = 0;
    int incomeCount = 0;

    for (final transaction in transactions) {
      if (transaction.type == TransactionType.expense) {
        totalExpense += transaction.amount;
        expenseCount++;
      } else if (transaction.type == TransactionType.income) {
        totalIncome += transaction.amount;
        incomeCount++;
      }
    }

    return TransactionSummaryEntity(
      transactions: transactions,
      startDate: startDate,
      endDate: endDate,
      totalExpense: totalExpense,
      totalIncome: totalIncome,
      expenseCount: expenseCount,
      incomeCount: incomeCount,
      periodLabel: periodLabel,
    );
  }

  /// Balance (revenus - dépenses)
  double get balance => totalIncome - totalExpense;

  /// Nombre total de transactions
  int get totalCount => expenseCount + incomeCount;

  /// Vérifie si la période a des transactions
  bool get hasTransactions => totalCount > 0;

  /// Vérifie si la période a des dépenses
  bool get hasExpenses => expenseCount > 0;

  /// Vérifie si la période a des revenus
  bool get hasIncomes => incomeCount > 0;

  /// Taux d'épargne (pourcentage)
  double get savingsRate {
    if (totalIncome == 0) return 0;
    return ((totalIncome - totalExpense) / totalIncome) * 100;
  }

  /// Montant moyen des dépenses
  double get averageExpense {
    if (expenseCount == 0) return 0;
    return totalExpense / expenseCount;
  }

  /// Montant moyen des revenus
  double get averageIncome {
    if (incomeCount == 0) return 0;
    return totalIncome / incomeCount;
  }

  /// Dépenses par catégorie
  Map<int, double> get expensesByCategory {
    final Map<int, double> result = {};
    for (final transaction in transactions) {
      if (transaction.type == TransactionType.expense) {
        result[transaction.categoryId] =
            (result[transaction.categoryId] ?? 0) + transaction.amount;
      }
    }
    return result;
  }

  /// Revenus par catégorie
  Map<int, double> get incomesByCategory {
    final Map<int, double> result = {};
    for (final transaction in transactions) {
      if (transaction.type == TransactionType.income) {
        result[transaction.categoryId] =
            (result[transaction.categoryId] ?? 0) + transaction.amount;
      }
    }
    return result;
  }

  /// Transactions triées par date (plus récentes en premier)
  List<TransactionEntity> get sortedTransactions {
    final sorted = List<TransactionEntity>.from(transactions);
    sorted.sort((a, b) => b.date.compareTo(a.date));
    return sorted;
  }

  /// Transactions d'aujourd'hui
  List<TransactionEntity> get todayTransactions {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    return transactions.where((t) {
      final transactionDate = DateTime(t.date.year, t.date.month, t.date.day);
      return transactionDate.isAtSameMomentAs(today);
    }).toList();
  }

  /// Groupe les transactions par jour
  Map<DateTime, List<TransactionEntity>> get transactionsByDay {
    final Map<DateTime, List<TransactionEntity>> result = {};
    for (final transaction in transactions) {
      final date = DateTime(
        transaction.date.year,
        transaction.date.month,
        transaction.date.day,
      );
      if (!result.containsKey(date)) {
        result[date] = [];
      }
      result[date]!.add(transaction);
    }
    return result;
  }
}

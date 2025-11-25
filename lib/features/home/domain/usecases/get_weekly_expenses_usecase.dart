import 'package:pocketly/features/home/domain/entities/weekly_expense_entity.dart';
import 'package:pocketly/features/transactions/transactions.dart';

/// Use case pour calculer les dépenses hebdomadaires.
///
/// Prend une liste de transactions et calcule:
/// - Les dépenses par jour de la semaine (Lundi à Dimanche)
/// - Le total des dépenses de la semaine
/// - Les dates de début et fin de semaine
class GetWeeklyExpensesUseCase {
  const GetWeeklyExpensesUseCase();

  /// Calcule les dépenses hebdomadaires à partir des transactions
  ///
  /// [transactions] - Liste de toutes les transactions
  WeeklyExpensesEntity call({
    required List<TransactionEntity> transactions,
  }) {
    // Trouver le lundi de la semaine actuelle
    final now = DateTime.now();
    final weekDay = now.weekday; // 1 = Lundi, 7 = Dimanche
    final daysFromMonday = weekDay - 1;
    final monday = now.subtract(Duration(days: daysFromMonday));
    final weekStartDate = DateTime(monday.year, monday.month, monday.day, 0, 0, 0);
    final weekEndDate = weekStartDate.add(const Duration(days: 6, hours: 23, minutes: 59, seconds: 59));

    // Grouper les transactions par jour
    final Map<int, List<TransactionEntity>> transactionsByDay = {};
    for (int i = 1; i <= 7; i++) {
      transactionsByDay[i] = [];
    }

    double totalWeekAmount = 0;

    // Filtrer les transactions de la semaine
    final weekTransactions = transactions.where((transaction) {
      return transaction.date.isAfter(weekStartDate.subtract(const Duration(seconds: 1))) &&
          transaction.date.isBefore(weekEndDate.add(const Duration(seconds: 1)));
    }).toList();

    for (final transaction in weekTransactions) {
      final dayOfWeek = transaction.date.weekday;
      transactionsByDay[dayOfWeek]!.add(transaction);

      // Ne compter que les dépenses
      if (transaction.isExpense) {
        totalWeekAmount += transaction.amount;
      }
    }

    // Créer la liste des WeeklyExpenseEntity
    final List<WeeklyExpenseEntity> expenses = [];
    for (int i = 1; i <= 7; i++) {
      final dayDate = weekStartDate.add(Duration(days: i - 1));
      final dayTransactions = transactionsByDay[i]!;

      double dayAmount = 0;
      for (final transaction in dayTransactions) {
        if (transaction.isExpense) {
          dayAmount += transaction.amount;
        }
      }

      expenses.add(WeeklyExpenseEntity(
        dayOfWeek: i,
        date: dayDate,
        amount: dayAmount,
        transactionCount: dayTransactions.length,
      ));
    }

    return WeeklyExpensesEntity(
      expenses: expenses,
      totalWeekAmount: totalWeekAmount,
      weekStartDate: weekStartDate,
      weekEndDate: weekEndDate,
    );
  }
}

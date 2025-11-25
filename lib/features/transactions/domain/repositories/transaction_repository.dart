import '../entities/transaction_entity.dart';

/// Repository interface pour la gestion des transactions
abstract class TransactionRepository {
  /// Récupère toutes les transactions de l'utilisateur
  Future<List<TransactionEntity>> getAllTransactions();

  /// Récupère les transactions par type
  Future<List<TransactionEntity>> getTransactionsByType(TransactionType type);

  /// Récupère les transactions par catégorie
  Future<List<TransactionEntity>> getTransactionsByCategory(int categoryId);

  /// Récupère les transactions par pocket
  Future<List<TransactionEntity>> getTransactionsByPocket(String pocketId);

  /// Récupère les transactions récurrentes
  Future<List<TransactionEntity>> getRecurringTransactions();

  /// Récupère les transactions pour une période donnée
  Future<List<TransactionEntity>> getTransactionsBetween({
    required DateTime start,
    required DateTime end,
  });

  /// Récupère les transactions pour un mois donné
  Future<List<TransactionEntity>> getTransactionsForMonth({
    required int year,
    required int month,
  });

  /// Récupère une transaction par son ID
  Future<TransactionEntity?> getTransactionById(int id);

  /// Crée une nouvelle transaction
  Future<TransactionEntity> createTransaction(TransactionEntity transaction);

  /// Met à jour une transaction
  Future<TransactionEntity> updateTransaction(TransactionEntity transaction);

  /// Assigne une transaction à un pocket
  Future<TransactionEntity> assignTransactionToPocket({
    required int transactionId,
    required String pocketId,
  });

  /// Retire une transaction d'un pocket
  Future<TransactionEntity> unassignTransactionFromPocket({
    required int transactionId,
  });

  /// Supprime une transaction
  Future<void> deleteTransaction(int transactionId);

  /// Met en pause/active une récurrence
  Future<void> toggleRecurrenceActive(int transactionId, bool isActive);

  /// Génère les occurrences futures d'une transaction récurrente
  Future<List<TransactionEntity>> generateFutureOccurrences({
    required int transactionId,
    required DateTime until,
  });

  /// Synchronise les transactions avec le serveur
  Future<void> syncTransactions();

  /// Récupère les statistiques des transactions
  Future<TransactionStats> getTransactionStats({
    DateTime? start,
    DateTime? end,
  });
}

/// Statistiques des transactions
class TransactionStats {
  final double totalIncome;
  final double totalExpense;
  final double balance;
  final int transactionCount;
  final int recurringCount;
  final Map<int, double> categoryBreakdown;

  const TransactionStats({
    required this.totalIncome,
    required this.totalExpense,
    required this.balance,
    required this.transactionCount,
    required this.recurringCount,
    required this.categoryBreakdown,
  });

  factory TransactionStats.fromTransactions(List<TransactionEntity> transactions) {
    final incomes = transactions.where((t) => t.isIncome).toList();
    final expenses = transactions.where((t) => t.isExpense).toList();
    final recurring = transactions.where((t) => t.isRecurring).toList();

    final totalIncome = incomes.fold(0.0, (sum, t) => sum + t.amount);
    final totalExpense = expenses.fold(0.0, (sum, t) => sum + t.amount);
    final balance = totalIncome - totalExpense;

    final categoryBreakdown = <int, double>{};
    for (final transaction in transactions) {
      categoryBreakdown[transaction.categoryId] = 
          (categoryBreakdown[transaction.categoryId] ?? 0.0) + transaction.amount;
    }

    return TransactionStats(
      totalIncome: totalIncome,
      totalExpense: totalExpense,
      balance: balance,
      transactionCount: transactions.length,
      recurringCount: recurring.length,
      categoryBreakdown: categoryBreakdown,
    );
  }
}

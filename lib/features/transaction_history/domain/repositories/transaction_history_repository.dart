import 'package:pocketly/features/transaction_history/domain/entities/calendar_day_entity.dart';
import 'package:pocketly/features/transaction_history/domain/entities/transaction_period_entity.dart';
import 'package:pocketly/features/transaction_history/domain/entities/transaction_summary_entity.dart';
import 'package:pocketly/features/transactions/transactions.dart';

/// Repository interface pour l'historique des transactions
abstract class TransactionHistoryRepository {
  /// Récupère les transactions pour une date spécifique
  Future<List<TransactionEntity>> getTransactionsByDate({
    required String userId,
    required DateTime date,
  });

  /// Récupère les transactions pour une période
  Future<List<TransactionEntity>> getTransactionsByPeriod({
    required String userId,
    required TransactionPeriodEntity period,
  });

  /// Récupère les données du calendrier pour un mois
  Future<List<CalendarDayEntity>> getCalendarData({
    required String userId,
    required int year,
    required int month,
  });

  /// Récupère le résumé des transactions pour une période
  Future<TransactionSummaryEntity> getTransactionSummary({
    required String userId,
    required TransactionPeriodEntity period,
  });

  /// Récupère le résumé des transactions pour un jour spécifique
  Future<TransactionSummaryEntity> getDaySummary({
    required String userId,
    required DateTime date,
  });
}

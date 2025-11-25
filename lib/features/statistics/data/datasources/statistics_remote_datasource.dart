import 'package:pocketly/core/errors/common_errors.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// DataSource distant pour les statistiques
class StatisticsRemoteDataSource {
  final SupabaseClient _supabase;

  const StatisticsRemoteDataSource(this._supabase);

  /// Récupère toutes les transactions pour une période donnée
  Future<List<Map<String, dynamic>>> getTransactionsByDateRange({
    required String userId,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    try {
      final response = await _supabase
          .from('transactions')
          .select()
          .eq('user_id', userId)
          .gte('date', startDate.toIso8601String())
          .lte('date', endDate.toIso8601String())
          .order('date', ascending: false);

      return List<Map<String, dynamic>>.from(response);
    } catch (e, stackTrace) {
      throw NetworkError(
        technicalMessage: 'Failed to fetch transactions by date range: $e',
        stackTrace: stackTrace,
      );
    }
  }

  /// Calcule le total des revenus pour une période
  Future<double> calculateTotalIncome({
    required String userId,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    try {
      final transactions = await getTransactionsByDateRange(
        userId: userId,
        startDate: startDate,
        endDate: endDate,
      );

      double total = 0;
      for (final transaction in transactions) {
        if (transaction['type'] == 'income') {
          total += (transaction['amount'] as num).toDouble();
        }
      }

      return total;
    } catch (e, stackTrace) {
      throw NetworkError(
        technicalMessage: 'Failed to calculate total income: $e',
        stackTrace: stackTrace,
      );
    }
  }

  /// Calcule le total des dépenses pour une période
  Future<double> calculateTotalExpense({
    required String userId,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    try {
      final transactions = await getTransactionsByDateRange(
        userId: userId,
        startDate: startDate,
        endDate: endDate,
      );

      double total = 0;
      for (final transaction in transactions) {
        if (transaction['type'] == 'expense') {
          total += (transaction['amount'] as num).toDouble();
        }
      }

      return total;
    } catch (e, stackTrace) {
      throw NetworkError(
        technicalMessage: 'Failed to calculate total expense: $e',
        stackTrace: stackTrace,
      );
    }
  }

  /// Récupère les dépenses groupées par jour
  Future<Map<DateTime, List<Map<String, dynamic>>>> getExpensesByDay({
    required String userId,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    try {
      final transactions = await getTransactionsByDateRange(
        userId: userId,
        startDate: startDate,
        endDate: endDate,
      );

      final Map<DateTime, List<Map<String, dynamic>>> groupedByDay = {};

      for (final transaction in transactions) {
        final date = DateTime.parse(transaction['date'] as String);
        final dateOnly = DateTime(date.year, date.month, date.day);

        if (!groupedByDay.containsKey(dateOnly)) {
          groupedByDay[dateOnly] = [];
        }
        groupedByDay[dateOnly]!.add(transaction);
      }

      return groupedByDay;
    } catch (e, stackTrace) {
      throw NetworkError(
        technicalMessage: 'Failed to get expenses by day: $e',
        stackTrace: stackTrace,
      );
    }
  }
}

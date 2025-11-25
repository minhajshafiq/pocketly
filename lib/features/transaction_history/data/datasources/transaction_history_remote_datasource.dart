import 'package:pocketly/core/errors/common_errors.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// DataSource remote pour la feature Transaction History.
///
/// Responsable des requêtes réseau vers Supabase.
class TransactionHistoryRemoteDataSource {
  final SupabaseClient _supabase;

  const TransactionHistoryRemoteDataSource(this._supabase);

  /// Récupère toutes les transactions entre deux dates
  Future<List<Map<String, dynamic>>> getTransactionsBetween({
    required String userId,
    required DateTime start,
    required DateTime end,
  }) async {
    try {
      final response = await _supabase
          .from('transactions')
          .select()
          .eq('user_id', userId)
          .gte('date', start.toIso8601String())
          .lte('date', end.toIso8601String())
          .order('date', ascending: false);

      return List<Map<String, dynamic>>.from(response);
    } catch (e, stackTrace) {
      throw NetworkError(
        technicalMessage: 'Failed to fetch transactions between dates: $e',
        stackTrace: stackTrace,
      );
    }
  }

  /// Récupère toutes les transactions récurrentes actives
  Future<List<Map<String, dynamic>>> getRecurringTransactions(String userId) async {
    try {
      final response = await _supabase
          .from('transactions')
          .select()
          .eq('user_id', userId)
          .neq('recurrence', 'none')
          .order('date', ascending: false);

      return List<Map<String, dynamic>>.from(response);
    } catch (e, stackTrace) {
      throw NetworkError(
        technicalMessage: 'Failed to fetch recurring transactions: $e',
        stackTrace: stackTrace,
      );
    }
  }

  /// Récupère les transactions d'un jour spécifique
  Future<List<Map<String, dynamic>>> getTransactionsByDate({
    required String userId,
    required DateTime date,
  }) async {
    try {
      final startOfDay = DateTime(date.year, date.month, date.day);
      final endOfDay = DateTime(date.year, date.month, date.day, 23, 59, 59);

      return await getTransactionsBetween(
        userId: userId,
        start: startOfDay,
        end: endOfDay,
      );
    } catch (e, stackTrace) {
      throw NetworkError(
        technicalMessage: 'Failed to fetch transactions by date: $e',
        stackTrace: stackTrace,
      );
    }
  }

  /// Récupère les transactions d'un mois spécifique
  Future<List<Map<String, dynamic>>> getTransactionsByMonth({
    required String userId,
    required int year,
    required int month,
  }) async {
    try {
      final startOfMonth = DateTime(year, month, 1);
      final endOfMonth = DateTime(year, month + 1, 0, 23, 59, 59);

      return await getTransactionsBetween(
        userId: userId,
        start: startOfMonth,
        end: endOfMonth,
      );
    } catch (e, stackTrace) {
      throw NetworkError(
        technicalMessage: 'Failed to fetch transactions by month: $e',
        stackTrace: stackTrace,
      );
    }
  }
}

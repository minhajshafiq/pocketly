import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:pocketly/core/errors/errors.dart';
import 'package:pocketly/core/services/logger_service.dart';
import '../models/transaction_model.dart';
import '../../domain/repositories/transaction_repository.dart';
import '../../domain/entities/transaction_entity.dart';

/// Implémentation Supabase de la source de données distante pour les transactions
class TransactionRemoteDataSource {
  final SupabaseClient _supabase;
  final logger = const LoggerService();

  TransactionRemoteDataSource({required SupabaseClient supabase})
      : _supabase = supabase;

  /// Récupère toutes les transactions depuis Supabase
  Future<List<TransactionModel>> getAllTransactions() async {
    try {
      final response = await _supabase
          .from('transactions')
          .select('*')
          .eq('user_id', _supabase.auth.currentUser?.id ?? '')
          .order('date', ascending: false);

      return response
          .map((json) => TransactionModel.fromJson(json))
          .toList();
    } catch (e) {
      throw NetworkError(
        userMessage: 'Erreur lors de la récupération des transactions',
        technicalMessage: 'Failed to fetch transactions: $e',
      );
    }
  }

  /// Récupère les transactions par type depuis Supabase
  Future<List<TransactionModel>> getTransactionsByType(TransactionType type) async {
    try {
      final response = await _supabase
          .from('transactions')
          .select('*')
          .eq('user_id', _supabase.auth.currentUser?.id ?? '')
          .eq('type', type.name)
          .order('date', ascending: false);

      return response
          .map((json) => TransactionModel.fromJson(json))
          .toList();
    } catch (e) {
      throw NetworkError(
        userMessage: 'Erreur lors de la récupération des transactions',
        technicalMessage: 'Failed to fetch transactions by type: $e',
      );
    }
  }

  /// Récupère les transactions par catégorie depuis Supabase
  Future<List<TransactionModel>> getTransactionsByCategory(String categoryId) async {
    try {
      final response = await _supabase
          .from('transactions')
          .select('*')
          .eq('user_id', _supabase.auth.currentUser?.id ?? '')
          .eq('category_id', categoryId)
          .order('date', ascending: false);

      return response
          .map((json) => TransactionModel.fromJson(json))
          .toList();
    } catch (e) {
      throw NetworkError(
        userMessage: 'Erreur lors de la récupération des transactions',
        technicalMessage: 'Failed to fetch transactions by category: $e',
      );
    }
  }

  /// Récupère les transactions par pocket depuis Supabase
  Future<List<TransactionModel>> getTransactionsByPocket(String pocketId) async {
    try {
      final response = await _supabase
          .from('transactions')
          .select('*')
          .eq('user_id', _supabase.auth.currentUser?.id ?? '')
          .eq('pocket_id', pocketId)
          .order('date', ascending: false);

      return response
          .map((json) => TransactionModel.fromJson(json))
          .toList();
    } catch (e) {
      throw NetworkError(
        userMessage: 'Erreur lors de la récupération des transactions',
        technicalMessage: 'Failed to fetch transactions by pocket: $e',
      );
    }
  }

  /// Assigne une transaction à un pocket
  Future<TransactionModel> assignTransactionToPocket({
    required String transactionId,
    required String pocketId,
  }) async {
    try {
      final response = await _supabase
          .from('transactions')
          .update({'pocket_id': pocketId})
          .eq('id', transactionId)
          .eq('user_id', _supabase.auth.currentUser?.id ?? '')
          .select()
          .single();

      return TransactionModel.fromJson(response);
    } catch (e) {
      throw NetworkError(
        userMessage: 'Erreur lors de l\'assignation',
        technicalMessage: 'Failed to assign transaction to pocket: $e',
      );
    }
  }

  /// Retire une transaction d'un pocket
  Future<TransactionModel> unassignTransactionFromPocket({
    required String transactionId,
  }) async {
    try {
      final response = await _supabase
          .from('transactions')
          .update({'pocket_id': null})
          .eq('id', transactionId)
          .eq('user_id', _supabase.auth.currentUser?.id ?? '')
          .select()
          .single();

      return TransactionModel.fromJson(response);
    } catch (e) {
      throw NetworkError(
        userMessage: 'Erreur lors du retrait',
        technicalMessage: 'Failed to unassign transaction from pocket: $e',
      );
    }
  }

  /// Récupère les transactions récurrentes depuis Supabase
  Future<List<TransactionModel>> getRecurringTransactions() async {
    try {
      final response = await _supabase
          .from('transactions')
          .select('*')
          .eq('user_id', _supabase.auth.currentUser?.id ?? '')
          .neq('recurrence', 'none')
          .order('date', ascending: false);

      return response
          .map((json) => TransactionModel.fromJson(json))
          .toList();
    } catch (e) {
      throw NetworkError(
        userMessage: 'Erreur lors de la récupération',
        technicalMessage: 'Failed to fetch recurring transactions: $e',
      );
    }
  }

  /// Récupère les transactions entre deux dates depuis Supabase
  Future<List<TransactionModel>> getTransactionsBetween({
    required DateTime start,
    required DateTime end,
  }) async {
    try {
      final response = await _supabase
          .from('transactions')
          .select('*')
          .eq('user_id', _supabase.auth.currentUser?.id ?? '')
          .gte('date', start.toIso8601String())
          .lte('date', end.toIso8601String())
          .order('date', ascending: false);

      return response
          .map((json) => TransactionModel.fromJson(json))
          .toList();
    } catch (e) {
      throw NetworkError(
        userMessage: 'Erreur lors de la récupération',
        technicalMessage: 'Failed to fetch transactions by period: $e',
      );
    }
  }

  /// Récupère les transactions pour un mois donné depuis Supabase
  Future<List<TransactionModel>> getTransactionsForMonth({
    required int year,
    required int month,
  }) async {
    try {
      final startDate = DateTime(year, month, 1);
      final endDate = DateTime(year, month + 1, 0, 23, 59, 59);

      return await getTransactionsBetween(
        start: startDate,
        end: endDate,
      );
    } catch (e) {
      throw NetworkError(
        userMessage: 'Erreur lors de la récupération',
        technicalMessage: 'Failed to fetch current month transactions: $e',
      );
    }
  }

  /// Récupère une transaction par son ID depuis Supabase
  Future<TransactionModel?> getTransactionById(String id) async {
    try {
      final response = await _supabase
          .from('transactions')
          .select('*')
          .eq('id', id)
          .eq('user_id', _supabase.auth.currentUser?.id ?? '')
          .maybeSingle();

      if (response == null) return null;
      return TransactionModel.fromJson(response);
    } catch (e) {
      throw NetworkError(
        userMessage: 'Erreur lors de la récupération',
        technicalMessage: 'Failed to fetch transaction by ID: $e',
      );
    }
  }

  /// Crée une transaction sur Supabase
  Future<TransactionModel> createTransaction(TransactionModel transaction) async {
    try {
      logger.d('[TransactionRemoteDataSource] Préparation de l\'insertion...');
      // Utiliser toJsonForSupabase() qui exclut les champs gérés par la DB (id, created_at, updated_at)
      final jsonData = transaction.toJsonForSupabase();

      logger.d('[TransactionRemoteDataSource] Données JSON à insérer: $jsonData');

      final response = await _supabase
          .from('transactions')
          .insert(jsonData)
          .select()
          .single();

      logger.i('[TransactionRemoteDataSource] Réponse de Supabase: $response');

      return TransactionModel.fromJson(response);
    } catch (e, stackTrace) {
      logger.e('[TransactionRemoteDataSource] Erreur lors de la création: $e', error: e, stackTrace: stackTrace);
      throw NetworkError(
        userMessage: 'Erreur lors de la création',
        technicalMessage: 'Failed to create transaction: $e',
      );
    }
  }

  /// Met à jour une transaction sur Supabase
  Future<TransactionModel> updateTransaction(TransactionModel transaction) async {
    try {
      final response = await _supabase
          .from('transactions')
          .update(transaction.toJson())
          .eq('id', transaction.id ?? 0)
          .eq('user_id', _supabase.auth.currentUser?.id ?? '')
          .select()
          .single();

      return TransactionModel.fromJson(response);
    } catch (e) {
      throw NetworkError(
        userMessage: 'Erreur lors de la mise à jour',
        technicalMessage: 'Failed to update transaction: $e',
      );
    }
  }

  /// Supprime une transaction de Supabase
  Future<void> deleteTransaction(String transactionId) async {
    try {
      await _supabase
          .from('transactions')
          .delete()
          .eq('id', transactionId)
          .eq('user_id', _supabase.auth.currentUser?.id ?? '');
    } catch (e) {
      throw NetworkError(
        userMessage: 'Erreur lors de la suppression',
        technicalMessage: 'Failed to delete transaction: $e',
      );
    }
  }

  /// Met en pause/active une récurrence sur Supabase
  Future<void> toggleRecurrenceActive(String transactionId, bool isActive) async {
    try {
      await _supabase
          .from('transactions')
          .update({'is_recurrence_active': isActive})
          .eq('id', transactionId)
          .eq('user_id', _supabase.auth.currentUser?.id ?? '');
    } catch (e) {
      throw NetworkError(
        userMessage: 'Erreur lors de la modification',
        technicalMessage: 'Failed to update recurrence: $e',
      );
    }
  }

  /// Génère les occurrences futures d'une transaction récurrente
  Future<List<TransactionModel>> generateFutureOccurrences({
    required String transactionId,
    required DateTime until,
  }) async {
    try {
      // Récupère la transaction récurrente
      final transaction = await getTransactionById(transactionId);
      if (transaction == null || !transaction.isRecurring) {
        return [];
      }

      final occurrences = <TransactionModel>[];
      DateTime currentDate = transaction.date;

      while (currentDate.isBefore(until)) {
        currentDate = transaction.getNextOccurrence(currentDate);
        if (currentDate.isAfter(until)) break;

        occurrences.add(transaction.copyWith(date: currentDate));
      }

      return occurrences;
    } catch (e) {
      throw NetworkError(
        userMessage: 'Erreur lors de la génération',
        technicalMessage: 'Failed to generate recurrence occurrences: $e',
      );
    }
  }

  /// Récupère les statistiques des transactions depuis Supabase
  Future<TransactionStats> getTransactionStats({
    DateTime? start,
    DateTime? end,
  }) async {
    try {
      List<TransactionModel> transactions;
      
      if (start != null && end != null) {
        transactions = await getTransactionsBetween(
          start: start,
          end: end,
        );
      } else {
        transactions = await getAllTransactions();
      }

      return TransactionStats.fromTransactions(
        transactions.map((t) => t.toEntity()).toList(),
      );
    } catch (e) {
      throw NetworkError(
        userMessage: 'Erreur lors de la récupération',
        technicalMessage: 'Failed to fetch transaction statistics: $e',
      );
    }
  }

  /// Synchronise les transactions avec Supabase
  Future<void> syncTransactions() async {
    try {
      // Synchronisation avec les transactions récurrentes
      await _supabase.rpc('sync_recurring_transactions');
    } catch (e) {
      throw NetworkError(
        userMessage: 'Erreur lors de la synchronisation',
        technicalMessage: 'Failed to sync recurring transactions: $e',
      );
    }
  }
}

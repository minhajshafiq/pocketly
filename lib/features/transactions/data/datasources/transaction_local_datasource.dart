import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/transaction_model.dart';
import '../../domain/entities/transaction_entity.dart';

/// Implémentation locale de la source de données pour les transactions
class TransactionLocalDataSource {
  final SharedPreferences _prefs;

  TransactionLocalDataSource({required SharedPreferences prefs})
      : _prefs = prefs;

  static const String _transactionsKey = 'transactions';
  static const String _lastSyncKey = 'transactions_last_sync';

  /// Récupère toutes les transactions depuis le cache local
  Future<List<TransactionModel>> getAllTransactions() async {
    try {
      final jsonString = _prefs.getString(_transactionsKey);
      if (jsonString == null) return [];

      final List<dynamic> jsonList = jsonDecode(jsonString);
      return jsonList
          .map((json) => TransactionModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      return [];
    }
  }

  /// Récupère les transactions par type depuis le cache local
  Future<List<TransactionModel>> getTransactionsByType(TransactionType type) async {
    try {
      final allTransactions = await getAllTransactions();
      return allTransactions.where((t) => t.type == type).toList();
    } catch (e) {
      return [];
    }
  }

  /// Récupère les transactions par catégorie depuis le cache local
  Future<List<TransactionModel>> getTransactionsByCategory(int categoryId) async {
    try {
      final allTransactions = await getAllTransactions();
      return allTransactions.where((t) => t.categoryId == categoryId).toList();
    } catch (e) {
      return [];
    }
  }

  /// Récupère les transactions récurrentes depuis le cache local
  Future<List<TransactionModel>> getRecurringTransactions() async {
    try {
      final allTransactions = await getAllTransactions();
      return allTransactions.where((t) => t.isRecurring).toList();
    } catch (e) {
      return [];
    }
  }

  /// Récupère les transactions entre deux dates depuis le cache local
  Future<List<TransactionModel>> getTransactionsBetween({
    required DateTime start,
    required DateTime end,
  }) async {
    try {
      final allTransactions = await getAllTransactions();
      return allTransactions.where((t) {
        // Utiliser >= et <= pour une inclusion exacte des bornes
        return (t.date.isAfter(start) || t.date.isAtSameMomentAs(start)) &&
               (t.date.isBefore(end) || t.date.isAtSameMomentAs(end));
      }).toList();
    } catch (e) {
      return [];
    }
  }

  /// Récupère les transactions pour un mois donné depuis le cache local
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
      return [];
    }
  }

  /// Récupère une transaction par son ID depuis le cache local
  Future<TransactionModel?> getTransactionById(int id) async {
    try {
      final allTransactions = await getAllTransactions();
      return allTransactions.where((t) => t.id == id).firstOrNull;
    } catch (e) {
      return null;
    }
  }

  /// Sauvegarde une transaction dans le cache local
  Future<void> saveTransaction(TransactionModel transaction) async {
    try {
      final allTransactions = await getAllTransactions();
      
      // Trouve l'index de la transaction existante
      final existingIndex = allTransactions.indexWhere((t) => t.id == transaction.id);
      
      if (existingIndex != -1) {
        // Met à jour la transaction existante
        allTransactions[existingIndex] = transaction;
      } else {
        // Ajoute une nouvelle transaction
        allTransactions.add(transaction);
      }

      await _saveTransactions(allTransactions);
    } catch (e) {
      // Ignore les erreurs de cache local
    }
  }

  /// Sauvegarde plusieurs transactions dans le cache local
  Future<void> saveTransactions(List<TransactionModel> transactions) async {
    try {
      await _saveTransactions(transactions);
    } catch (e) {
      // Ignore les erreurs de cache local
    }
  }

  /// Supprime une transaction du cache local
  Future<void> deleteTransaction(int transactionId) async {
    try {
      final allTransactions = await getAllTransactions();
      allTransactions.removeWhere((t) => t.id == transactionId);
      await _saveTransactions(allTransactions);
    } catch (e) {
      // Ignore les erreurs de cache local
    }
  }

  /// Vide le cache local des transactions
  Future<void> clearCache() async {
    try {
      await _prefs.remove(_transactionsKey);
      await _prefs.remove(_lastSyncKey);
    } catch (e) {
      // Ignore les erreurs de cache local
    }
  }

  /// Récupère la date de dernière synchronisation
  DateTime? getLastSyncDate() {
    try {
      final timestamp = _prefs.getInt(_lastSyncKey);
      if (timestamp == null) return null;
      return DateTime.fromMillisecondsSinceEpoch(timestamp);
    } catch (e) {
      return null;
    }
  }

  /// Sauvegarde la date de dernière synchronisation
  Future<void> setLastSyncDate(DateTime date) async {
    try {
      await _prefs.setInt(_lastSyncKey, date.millisecondsSinceEpoch);
    } catch (e) {
      // Ignore les erreurs de cache local
    }
  }

  /// Sauvegarde les transactions dans SharedPreferences
  Future<void> _saveTransactions(List<TransactionModel> transactions) async {
    final jsonList = transactions.map((t) => t.toJson()).toList();
    final jsonString = jsonEncode(jsonList);
    await _prefs.setString(_transactionsKey, jsonString);
  }

  /// Vérifie si le cache est valide (moins de 24h)
  bool isCacheValid() {
    final lastSync = getLastSyncDate();
    if (lastSync == null) return false;
    
    final now = DateTime.now();
    return now.difference(lastSync).inHours < 24;
  }
}

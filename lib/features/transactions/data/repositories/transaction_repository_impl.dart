import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pocketly/core/services/logger_service.dart';
import '../../domain/entities/transaction_entity.dart';
import '../../domain/repositories/transaction_repository.dart';
import '../datasources/transaction_local_datasource.dart';
import '../datasources/transaction_remote_datasource.dart';
import '../models/transaction_model.dart';

/// Implémentation du repository des transactions
class TransactionRepositoryImpl implements TransactionRepository {
  final TransactionLocalDataSource _localDataSource;
  final TransactionRemoteDataSource _remoteDataSource;
  final logger = const LoggerService();

  TransactionRepositoryImpl({
    required SupabaseClient supabase,
    required SharedPreferences prefs,
  })  : _localDataSource = TransactionLocalDataSource(prefs: prefs),
        _remoteDataSource = TransactionRemoteDataSource(supabase: supabase);

  @override
  Future<List<TransactionEntity>> getAllTransactions() async {
    try {
      // Essayer de récupérer depuis le cache local d'abord
      final localTransactions = await _localDataSource.getAllTransactions();
      
      if (localTransactions.isNotEmpty && _localDataSource.isCacheValid()) {
        return localTransactions.map((model) => model.toEntity()).toList();
      }

      // Si pas de cache ou cache expiré, récupérer depuis le serveur
      final remoteTransactions = await _remoteDataSource.getAllTransactions();
      
      // Sauvegarder en cache local
      await _localDataSource.saveTransactions(remoteTransactions);
      await _localDataSource.setLastSyncDate(DateTime.now());
      
      return remoteTransactions.map((model) => model.toEntity()).toList();
    } catch (e) {
      // En cas d'erreur réseau, retourner le cache local
      final localTransactions = await _localDataSource.getAllTransactions();
      return localTransactions.map((model) => model.toEntity()).toList();
    }
  }

  @override
  Future<List<TransactionEntity>> getTransactionsByType(TransactionType type) async {
    try {
      final localTransactions = await _localDataSource.getTransactionsByType(type);
      
      if (localTransactions.isNotEmpty && _localDataSource.isCacheValid()) {
        return localTransactions.map((model) => model.toEntity()).toList();
      }

      // Si pas de cache, récupérer depuis le serveur
      final remoteTransactions = await _remoteDataSource.getTransactionsByType(type);

      // Fusionner avec le cache existant au lieu d'écraser
      final allLocalTransactions = await _localDataSource.getAllTransactions();
      final Map<String, TransactionModel> transactionMap = {
        for (var t in allLocalTransactions) if (t.id != null) t.id!: t
      };

      // Ajouter/mettre à jour avec les transactions récupérées
      for (var t in remoteTransactions) {
        if (t.id != null) {
          transactionMap[t.id!] = t;
        }
      }

      // Sauvegarder le cache fusionné
      await _localDataSource.saveTransactions(transactionMap.values.toList());

      return remoteTransactions.map((model) => model.toEntity()).toList();
    } catch (e) {
      // En cas d'erreur, retourner le cache local
      final localTransactions = await _localDataSource.getTransactionsByType(type);
      return localTransactions.map((model) => model.toEntity()).toList();
    }
  }

  @override
  Future<List<TransactionEntity>> getTransactionsByCategory(String categoryId) async {
    try {
      final localTransactions = await _localDataSource.getTransactionsByCategory(categoryId);

      if (localTransactions.isNotEmpty && _localDataSource.isCacheValid()) {
        return localTransactions.map((model) => model.toEntity()).toList();
      }

      // Si pas de cache, récupérer depuis le serveur
      final remoteTransactions = await _remoteDataSource.getTransactionsByCategory(categoryId);

      // Fusionner avec le cache existant au lieu d'écraser
      final allLocalTransactions = await _localDataSource.getAllTransactions();
      final Map<String, TransactionModel> transactionMap = {
        for (var t in allLocalTransactions) if (t.id != null) t.id!: t
      };

      // Ajouter/mettre à jour avec les transactions récupérées
      for (var t in remoteTransactions) {
        if (t.id != null) {
          transactionMap[t.id!] = t;
        }
      }

      // Sauvegarder le cache fusionné
      await _localDataSource.saveTransactions(transactionMap.values.toList());

      return remoteTransactions.map((model) => model.toEntity()).toList();
    } catch (e) {
      // En cas d'erreur, retourner le cache local
      final localTransactions = await _localDataSource.getTransactionsByCategory(categoryId);
      return localTransactions.map((model) => model.toEntity()).toList();
    }
  }

  @override
  Future<List<TransactionEntity>> getTransactionsByPocket(String pocketId) async {
    try {
      // Récupérer depuis le serveur directement (pas de cache local par pocket pour l'instant)
      final remoteTransactions = await _remoteDataSource.getTransactionsByPocket(pocketId);
      return remoteTransactions.map((model) => model.toEntity()).toList();
    } catch (e) {
      // En cas d'erreur, retourner une liste vide
      return [];
    }
  }

  @override
  Future<List<TransactionEntity>> getRecurringTransactions() async {
    try {
      final localTransactions = await _localDataSource.getRecurringTransactions();
      
      if (localTransactions.isNotEmpty && _localDataSource.isCacheValid()) {
        return localTransactions.map((model) => model.toEntity()).toList();
      }

      // Si pas de cache, récupérer depuis le serveur
      final remoteTransactions = await _remoteDataSource.getRecurringTransactions();

      // Fusionner avec le cache existant au lieu d'écraser
      final allLocalTransactions = await _localDataSource.getAllTransactions();
      final Map<String, TransactionModel> transactionMap = {
        for (var t in allLocalTransactions) if (t.id != null) t.id!: t
      };

      // Ajouter/mettre à jour avec les transactions récupérées
      for (var t in remoteTransactions) {
        if (t.id != null) {
          transactionMap[t.id!] = t;
        }
      }

      // Sauvegarder le cache fusionné
      await _localDataSource.saveTransactions(transactionMap.values.toList());

      return remoteTransactions.map((model) => model.toEntity()).toList();
    } catch (e) {
      // En cas d'erreur, retourner le cache local
      final localTransactions = await _localDataSource.getRecurringTransactions();
      return localTransactions.map((model) => model.toEntity()).toList();
    }
  }

  @override
  Future<List<TransactionEntity>> getTransactionsBetween({
    required DateTime start,
    required DateTime end,
  }) async {
    try {
      final localTransactions = await _localDataSource.getTransactionsBetween(
        start: start,
        end: end,
      );

      if (localTransactions.isNotEmpty && _localDataSource.isCacheValid()) {
        return localTransactions.map((model) => model.toEntity()).toList();
      }

      // Si pas de cache, récupérer depuis le serveur
      final remoteTransactions = await _remoteDataSource.getTransactionsBetween(
        start: start,
        end: end,
      );

      // Fusionner avec le cache existant au lieu d'écraser
      final allLocalTransactions = await _localDataSource.getAllTransactions();
      final Map<String, TransactionModel> transactionMap = {
        for (var t in allLocalTransactions) if (t.id != null) t.id!: t
      };

      // Ajouter/mettre à jour avec les transactions récupérées
      for (var t in remoteTransactions) {
        if (t.id != null) {
          transactionMap[t.id!] = t;
        }
      }

      // Sauvegarder le cache fusionné
      await _localDataSource.saveTransactions(transactionMap.values.toList());

      return remoteTransactions.map((model) => model.toEntity()).toList();
    } catch (e) {
      // En cas d'erreur, retourner le cache local
      final localTransactions = await _localDataSource.getTransactionsBetween(
        start: start,
        end: end,
      );
      return localTransactions.map((model) => model.toEntity()).toList();
    }
  }

  @override
  Future<List<TransactionEntity>> getTransactionsForMonth({
    required int year,
    required int month,
  }) async {
    try {
      final localTransactions = await _localDataSource.getTransactionsForMonth(
        year: year,
        month: month,
      );
      
      if (localTransactions.isNotEmpty && _localDataSource.isCacheValid()) {
        return localTransactions.map((model) => model.toEntity()).toList();
      }

      // Si pas de cache, récupérer depuis le serveur
      final remoteTransactions = await _remoteDataSource.getTransactionsForMonth(
        year: year,
        month: month,
      );

      // Fusionner avec le cache existant au lieu d'écraser
      final allLocalTransactions = await _localDataSource.getAllTransactions();
      final Map<String, TransactionModel> transactionMap = {
        for (var t in allLocalTransactions) if (t.id != null) t.id!: t
      };

      // Ajouter/mettre à jour avec les transactions récupérées
      for (var t in remoteTransactions) {
        if (t.id != null) {
          transactionMap[t.id!] = t;
        }
      }

      // Sauvegarder le cache fusionné
      await _localDataSource.saveTransactions(transactionMap.values.toList());

      return remoteTransactions.map((model) => model.toEntity()).toList();
    } catch (e) {
      // En cas d'erreur, retourner le cache local
      final localTransactions = await _localDataSource.getTransactionsForMonth(
        year: year,
        month: month,
      );
      return localTransactions.map((model) => model.toEntity()).toList();
    }
  }

  @override
  Future<TransactionEntity?> getTransactionById(String id) async {
    try {
      // Essayer le cache local d'abord
      final localTransaction = await _localDataSource.getTransactionById(id);

      if (localTransaction != null) {
        return localTransaction.toEntity();
      }

      // Si pas trouvé localement, chercher sur le serveur
      final remoteTransaction = await _remoteDataSource.getTransactionById(id);
      
      if (remoteTransaction != null) {
        // Sauvegarder en cache local
        await _localDataSource.saveTransaction(remoteTransaction);
        return remoteTransaction.toEntity();
      }

      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<TransactionEntity> createTransaction(TransactionEntity transaction) async {
    try {
      logger.d('[TransactionRepository] Conversion de l\'entité en modèle...');
      final transactionModel = transaction.toModel();

      logger.d('[TransactionRepository] Modèle créé: ${transactionModel.toJson()}');

      // Créer sur le serveur
      logger.d('[TransactionRepository] Envoi vers Supabase...');
      final createdModel = await _remoteDataSource.createTransaction(transactionModel);

      logger.i('[TransactionRepository] Transaction créée sur Supabase avec ID: ${createdModel.id}');

      // Invalider le cache et recharger toutes les transactions
      logger.d('[TransactionRepository] Invalidation du cache et rechargement...');
      final allRemoteTransactions = await _remoteDataSource.getAllTransactions();
      await _localDataSource.saveTransactions(allRemoteTransactions);
      await _localDataSource.setLastSyncDate(DateTime.now());

      logger.i('[TransactionRepository] Cache rechargé avec ${allRemoteTransactions.length} transactions');

      return createdModel.toEntity();
    } catch (e, stackTrace) {
      logger.e('[TransactionRepository] Erreur lors de la création: $e', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }

  @override
  Future<TransactionEntity> updateTransaction(TransactionEntity transaction) async {
    try {
      final transactionModel = transaction.toModel();

      // Mettre à jour sur le serveur
      final updatedModel = await _remoteDataSource.updateTransaction(transactionModel);

      // Invalider le cache et recharger toutes les transactions
      final allRemoteTransactions = await _remoteDataSource.getAllTransactions();
      await _localDataSource.saveTransactions(allRemoteTransactions);
      await _localDataSource.setLastSyncDate(DateTime.now());

      return updatedModel.toEntity();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<TransactionEntity> assignTransactionToPocket({
    required String transactionId,
    required String pocketId,
  }) async {
    try {
      // Assigner sur le serveur
      final updatedModel = await _remoteDataSource.assignTransactionToPocket(
        transactionId: transactionId,
        pocketId: pocketId,
      );

      // Invalider le cache et recharger toutes les transactions
      final allRemoteTransactions = await _remoteDataSource.getAllTransactions();
      await _localDataSource.saveTransactions(allRemoteTransactions);
      await _localDataSource.setLastSyncDate(DateTime.now());

      return updatedModel.toEntity();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<TransactionEntity> unassignTransactionFromPocket({
    required String transactionId,
  }) async{
    try {
      // Retirer du serveur
      final updatedModel = await _remoteDataSource.unassignTransactionFromPocket(
        transactionId: transactionId,
      );

      // Invalider le cache et recharger toutes les transactions
      final allRemoteTransactions = await _remoteDataSource.getAllTransactions();
      await _localDataSource.saveTransactions(allRemoteTransactions);
      await _localDataSource.setLastSyncDate(DateTime.now());

      return updatedModel.toEntity();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteTransaction(String transactionId) async {
    try {
      // Supprimer du serveur
      await _remoteDataSource.deleteTransaction(transactionId);

      // Supprimer du cache local
      await _localDataSource.deleteTransaction(transactionId);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> toggleRecurrenceActive(String transactionId, bool isActive) async {
    try {
      // Mettre à jour sur le serveur
      await _remoteDataSource.toggleRecurrenceActive(transactionId, isActive);

      // Mettre à jour en cache local
      final localTransaction = await _localDataSource.getTransactionById(transactionId);
      if (localTransaction != null) {
        final updatedTransaction = localTransaction.copyWith(isRecurrenceActive: isActive);
        await _localDataSource.saveTransaction(updatedTransaction);
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<TransactionEntity>> generateFutureOccurrences({
    required String transactionId,
    required DateTime until,
  }) async {
    try {
      final occurrences = await _remoteDataSource.generateFutureOccurrences(
        transactionId: transactionId,
        until: until,
      );
      
      return occurrences.map((model) => model.toEntity()).toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<TransactionStats> getTransactionStats({
    DateTime? start,
    DateTime? end,
  }) async {
    try {
      return await _remoteDataSource.getTransactionStats(
        start: start,
        end: end,
      );
    } catch (e) {
      // En cas d'erreur, calculer depuis le cache local
      final localTransactions = await _localDataSource.getAllTransactions();
      return TransactionStats.fromTransactions(
        localTransactions.map((model) => model.toEntity()).toList(),
      );
    }
  }

  @override
  Future<void> syncTransactions() async {
    try {
      // Récupérer depuis le serveur
      final remoteTransactions = await _remoteDataSource.getAllTransactions();
      
      // Vider le cache local
      await _localDataSource.clearCache();
      
      // Sauvegarder les nouvelles données
      await _localDataSource.saveTransactions(remoteTransactions);
      await _localDataSource.setLastSyncDate(DateTime.now());
    } catch (e) {
      rethrow;
    }
  }
}

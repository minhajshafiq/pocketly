import 'package:pocketly/core/errors/common_errors.dart';
import 'package:pocketly/core/services/logger_service.dart';
import 'package:pocketly/features/statistics/data/datasources/statistics_local_datasource.dart';
import 'package:pocketly/features/statistics/data/datasources/statistics_remote_datasource.dart';
import 'package:pocketly/features/statistics/domain/entities/chart_data_entity.dart';
import 'package:pocketly/features/statistics/domain/entities/daily_expense_entity.dart';
import 'package:pocketly/features/statistics/domain/entities/statistics_summary_entity.dart';
import 'package:pocketly/features/statistics/domain/repositories/statistics_repository.dart';
import 'package:pocketly/features/transactions/transactions.dart';

/// Implémentation du repository pour les statistiques.
///
/// Utilise la stratégie Cache-First :
/// 1. Retourne immédiatement les données en cache si disponibles
/// 2. Synchronise en arrière-plan sans bloquer l'UI
/// 3. Fallback sur le cache en cas d'erreur réseau
class StatisticsRepositoryImpl implements StatisticsRepository {
  final StatisticsRemoteDataSource _remoteDataSource;
  final StatisticsLocalDataSource _localDataSource;
  final LoggerService _logger;

  const StatisticsRepositoryImpl({
    required StatisticsRemoteDataSource remoteDataSource,
    required StatisticsLocalDataSource localDataSource,
    required LoggerService logger,
  }) : _remoteDataSource = remoteDataSource,
       _localDataSource = localDataSource,
       _logger = logger;

  @override
  Future<StatisticsSummaryEntity> getStatisticsSummary({
    required String userId,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    try {
      _logger.d(
        '📊 [Cache-First] Fetching statistics summary for user: $userId',
      );

      // 1. CACHE-FIRST : Essayer le cache d'abord
      final cachedSummary = await _localDataSource.getCachedStatisticsSummary(
        userId,
        startDate,
        endDate,
      );

      if (cachedSummary != null) {
        _logger.d('✅ [Cache-First] Statistics summary found in cache');

        // 2. Synchroniser en arrière-plan
        _syncSummaryInBackground(userId, startDate, endDate);

        return cachedSummary;
      }

      _logger.d('⚠️ [Cache-First] No cached summary, fetching from network');

      // 4. FALLBACK : Récupérer depuis le réseau
      final summary = await _fetchSummaryFromRemote(userId, startDate, endDate);

      // 5. Sauvegarder en cache
      await _localDataSource.cacheStatisticsSummary(
        userId,
        startDate,
        endDate,
        summary,
      );

      return summary;
    } on NetworkError catch (e) {
      _logger.w(
        '🔌 [Cache-First] Network error, trying expired cache',
        error: e,
      );

      // 6. ERREUR RÉSEAU : Utiliser le cache expiré
      final cachedSummary = await _localDataSource.getCachedStatisticsSummary(
        userId,
        startDate,
        endDate,
      );

      if (cachedSummary != null) {
        _logger.d('✅ [Cache-First] Returning expired cache');
        return cachedSummary;
      }

      _logger.e('❌ [Cache-First] No cache available');
      rethrow;
    } catch (e, stackTrace) {
      _logger.e(
        '❌ Error fetching statistics summary',
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  @override
  Future<ChartDataEntity> getChartData({
    required String userId,
    required TimePeriod period,
    required DateTime startDate,
  }) async {
    try {
      _logger.d(
        '📈 [Cache-First] Fetching chart data for user: $userId, period: $period',
      );

      // 1. CACHE-FIRST : Essayer le cache d'abord
      final cachedChartData = await _localDataSource.getCachedChartData(
        userId,
        period,
        startDate,
      );

      if (cachedChartData != null) {
        _logger.d('✅ [Cache-First] Chart data found in cache');

        // 2. Synchroniser en arrière-plan
        _syncChartDataInBackground(userId, period, startDate);

        return cachedChartData;
      }

      _logger.d('⚠️ [Cache-First] No cached chart data, fetching from network');

      // 4. FALLBACK : Récupérer depuis le réseau
      final chartData = await _fetchChartDataFromRemote(
        userId,
        period,
        startDate,
      );

      // 5. Sauvegarder en cache
      await _localDataSource.cacheChartData(
        userId,
        period,
        startDate,
        chartData,
      );

      return chartData;
    } on NetworkError catch (e) {
      _logger.w(
        '🔌 [Cache-First] Network error, trying expired cache',
        error: e,
      );

      // 6. ERREUR RÉSEAU : Utiliser le cache expiré
      final cachedChartData = await _localDataSource.getCachedChartData(
        userId,
        period,
        startDate,
      );

      if (cachedChartData != null) {
        _logger.d('✅ [Cache-First] Returning expired cache');
        return cachedChartData;
      }

      _logger.e('❌ [Cache-First] No cache available');
      rethrow;
    } catch (e, stackTrace) {
      _logger.e(
        '❌ Error fetching chart data',
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  @override
  Future<List<TransactionEntity>> getTransactionsByDateRange({
    required String userId,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    try {
      _logger.d(
        '📊 [Cache-First] Fetching transactions by date range for user: $userId',
      );

      // 1. CACHE-FIRST : Essayer le cache d'abord
      final cachedTransactions = await _localDataSource.getCachedTransactions(
        userId,
        startDate,
        endDate,
      );

      if (cachedTransactions != null) {
        _logger.d('✅ [Cache-First] Transactions found in cache');

        // 2. Synchroniser en arrière-plan
        _syncTransactionsInBackground(userId, startDate, endDate);

        return cachedTransactions;
      }

      _logger.d(
        '⚠️ [Cache-First] No cached transactions, fetching from network',
      );

      // 4. FALLBACK : Récupérer depuis le réseau
      final transactions = await _fetchTransactionsFromRemote(
        userId,
        startDate,
        endDate,
      );

      // 5. Sauvegarder en cache
      await _localDataSource.cacheTransactions(
        userId,
        startDate,
        endDate,
        transactions,
      );

      return transactions;
    } on NetworkError catch (e) {
      _logger.w(
        '🔌 [Cache-First] Network error, trying expired cache',
        error: e,
      );

      // 6. ERREUR RÉSEAU : Utiliser le cache expiré
      final cachedTransactions = await _localDataSource.getCachedTransactions(
        userId,
        startDate,
        endDate,
      );

      if (cachedTransactions != null) {
        _logger.d('✅ [Cache-First] Returning expired cache');
        return cachedTransactions;
      }

      _logger.e('❌ [Cache-First] No cache available');
      rethrow;
    } catch (e, stackTrace) {
      _logger.e(
        '❌ Error fetching transactions by date range',
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  // ==================== REMOTE DATA FETCHING ====================

  /// Récupère le résumé depuis le réseau
  Future<StatisticsSummaryEntity> _fetchSummaryFromRemote(
    String userId,
    DateTime startDate,
    DateTime endDate,
  ) async {
    final transactions = await _remoteDataSource.getTransactionsByDateRange(
      userId: userId,
      startDate: startDate,
      endDate: endDate,
    );

    double totalIncome = 0;
    double totalExpense = 0;

    for (final transaction in transactions) {
      final amount = (transaction['amount'] as num).toDouble();
      final type = transaction['type'] as String;

      if (type == 'income') {
        totalIncome += amount;
      } else if (type == 'expense') {
        totalExpense += amount;
      }
    }

    final balance = totalIncome - totalExpense;

    final summary = StatisticsSummaryEntity(
      totalIncome: totalIncome,
      totalExpense: totalExpense,
      balance: balance,
      transactionCount: transactions.length,
      startDate: startDate,
      endDate: endDate,
    );

    _logger.d(
      '✅ Statistics summary fetched from network: income=$totalIncome, expense=$totalExpense',
    );
    return summary;
  }

  /// Récupère les données du graphique depuis le réseau
  Future<ChartDataEntity> _fetchChartDataFromRemote(
    String userId,
    TimePeriod period,
    DateTime startDate,
  ) async {
    // Calculer la date de fin selon la période
    final DateTime endDate;
    switch (period) {
      case TimePeriod.week:
        endDate = startDate.add(const Duration(days: 7));
        break;
      case TimePeriod.month:
        endDate = DateTime(startDate.year, startDate.month + 1, startDate.day);
        break;
      case TimePeriod.year:
        endDate = DateTime(startDate.year + 1, startDate.month, startDate.day);
        break;
    }

    // Récupérer les transactions
    final transactions = await _remoteDataSource.getTransactionsByDateRange(
      userId: userId,
      startDate: startDate,
      endDate: endDate,
    );

    // Grouper par jour
    final Map<DateTime, List<Map<String, dynamic>>> groupedByDay = {};

    // Initialiser tous les jours avec des valeurs vides
    for (int i = 0; i < period.daysCount; i++) {
      final date = startDate.add(Duration(days: i));
      final dateOnly = DateTime(date.year, date.month, date.day);
      groupedByDay[dateOnly] = [];
    }

    // Remplir avec les vraies transactions
    for (final transaction in transactions) {
      final date = DateTime.parse(transaction['date'] as String);
      final dateOnly = DateTime(date.year, date.month, date.day);

      if (groupedByDay.containsKey(dateOnly)) {
        groupedByDay[dateOnly]!.add(transaction);
      }
    }

    // Créer les DailyExpenseEntity
    final List<DailyExpenseEntity> dailyExpenses = [];
    double totalIncome = 0;
    double totalExpense = 0;
    double maxExpense = 0;

    for (final entry in groupedByDay.entries) {
      double dayIncome = 0;
      double dayExpense = 0;

      for (final transaction in entry.value) {
        final amount = (transaction['amount'] as num).toDouble();
        final type = transaction['type'] as String;

        if (type == 'income') {
          dayIncome += amount;
          totalIncome += amount;
        } else if (type == 'expense') {
          dayExpense += amount;
          totalExpense += amount;
        }
      }

      if (dayExpense > maxExpense) {
        maxExpense = dayExpense;
      }

      dailyExpenses.add(
        DailyExpenseEntity(
          date: entry.key,
          dayOfWeek: entry.key.weekday,
          income: dayIncome,
          expense: dayExpense,
          transactionCount: entry.value.length,
        ),
      );
    }

    // Trier par date
    dailyExpenses.sort((a, b) => a.date.compareTo(b.date));

    final chartData = ChartDataEntity(
      dailyExpenses: dailyExpenses,
      period: period,
      startDate: startDate,
      endDate: endDate,
      maxExpense: maxExpense,
      totalExpense: totalExpense,
      totalIncome: totalIncome,
    );

    _logger.d('✅ Chart data fetched from network: totalExpense=$totalExpense');
    return chartData;
  }

  /// Récupère les transactions depuis le réseau
  Future<List<TransactionEntity>> _fetchTransactionsFromRemote(
    String userId,
    DateTime startDate,
    DateTime endDate,
  ) async {
    final transactionsData = await _remoteDataSource.getTransactionsByDateRange(
      userId: userId,
      startDate: startDate,
      endDate: endDate,
    );

    final List<TransactionEntity> transactions = [];
    for (final data in transactionsData) {
      try {
        final transaction = TransactionEntity.fromJson(data);
        transactions.add(transaction);
      } catch (e) {
        _logger.w('Failed to parse transaction: $e');
      }
    }

    _logger.d(
      '✅ Transactions fetched from network: count=${transactions.length}',
    );
    return transactions;
  }

  // ==================== BACKGROUND SYNC ====================

  /// Synchronise le résumé en arrière-plan
  void _syncSummaryInBackground(
    String userId,
    DateTime startDate,
    DateTime endDate,
  ) {
    Future.microtask(() async {
      try {
        _logger.d('🔄 [Background Sync] Syncing statistics summary');
        final summary = await _fetchSummaryFromRemote(
          userId,
          startDate,
          endDate,
        );
        await _localDataSource.cacheStatisticsSummary(
          userId,
          startDate,
          endDate,
          summary,
        );
        _logger.d('✅ [Background Sync] Summary synced successfully');
      } catch (e) {
        _logger.w('⚠️ [Background Sync] Failed to sync summary', error: e);
      }
    });
  }

  /// Synchronise les données du graphique en arrière-plan
  void _syncChartDataInBackground(
    String userId,
    TimePeriod period,
    DateTime startDate,
  ) {
    Future.microtask(() async {
      try {
        _logger.d('🔄 [Background Sync] Syncing chart data');
        final chartData = await _fetchChartDataFromRemote(
          userId,
          period,
          startDate,
        );
        await _localDataSource.cacheChartData(
          userId,
          period,
          startDate,
          chartData,
        );
        _logger.d('✅ [Background Sync] Chart data synced successfully');
      } catch (e) {
        _logger.w('⚠️ [Background Sync] Failed to sync chart data', error: e);
      }
    });
  }

  /// Synchronise les transactions en arrière-plan
  void _syncTransactionsInBackground(
    String userId,
    DateTime startDate,
    DateTime endDate,
  ) {
    Future.microtask(() async {
      try {
        _logger.d('🔄 [Background Sync] Syncing transactions');
        final transactions = await _fetchTransactionsFromRemote(
          userId,
          startDate,
          endDate,
        );
        await _localDataSource.cacheTransactions(
          userId,
          startDate,
          endDate,
          transactions,
        );
        _logger.d('✅ [Background Sync] Transactions synced successfully');
      } catch (e) {
        _logger.w('⚠️ [Background Sync] Failed to sync transactions', error: e);
      }
    });
  }
}

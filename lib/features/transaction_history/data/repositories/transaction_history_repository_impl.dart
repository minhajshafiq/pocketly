import 'package:pocketly/core/errors/common_errors.dart';
import 'package:pocketly/core/services/logger_service.dart';
import 'package:pocketly/features/transaction_history/data/datasources/transaction_history_local_datasource.dart';
import 'package:pocketly/features/transaction_history/data/datasources/transaction_history_remote_datasource.dart';
import 'package:pocketly/features/transaction_history/domain/entities/calendar_day_entity.dart';
import 'package:pocketly/features/transaction_history/domain/entities/transaction_period_entity.dart';
import 'package:pocketly/features/transaction_history/domain/entities/transaction_summary_entity.dart';
import 'package:pocketly/features/transaction_history/domain/repositories/transaction_history_repository.dart';
import 'package:pocketly/features/transactions/transactions.dart';

/// Implémentation du repository pour l'historique des transactions.
///
/// Utilise la stratégie Cache-First :
/// 1. Retourne immédiatement les données en cache si disponibles
/// 2. Synchronise en arrière-plan sans bloquer l'UI
/// 3. Fallback sur le cache en cas d'erreur réseau
class TransactionHistoryRepositoryImpl implements TransactionHistoryRepository {
  final TransactionHistoryRemoteDataSource _remoteDataSource;
  final TransactionHistoryLocalDataSource _localDataSource;
  final LoggerService _logger;

  const TransactionHistoryRepositoryImpl({
    required TransactionHistoryRemoteDataSource remoteDataSource,
    required TransactionHistoryLocalDataSource localDataSource,
    required LoggerService logger,
  })  : _remoteDataSource = remoteDataSource,
        _localDataSource = localDataSource,
        _logger = logger;

  @override
  Future<List<TransactionEntity>> getTransactionsByDate({
    required String userId,
    required DateTime date,
  }) async {
    try {
      _logger.d('📊 [Cache-First] Fetching transactions for date: $date');

      // Pour une date spécifique, on récupère directement depuis le réseau
      // (les données d'un jour changent fréquemment)
      final transactions = await _fetchTransactionsByDateFromRemote(userId, date);

      return transactions;
    } catch (e, stackTrace) {
      _logger.e('❌ Error fetching transactions by date', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }

  @override
  Future<List<TransactionEntity>> getTransactionsByPeriod({
    required String userId,
    required TransactionPeriodEntity period,
  }) async {
    try {
      _logger.d('📊 [Cache-First] Fetching transactions for period: ${period.label}');

      // 1. CACHE-FIRST : Essayer le cache d'abord
      final cachedTransactions = await _localDataSource.getCachedTransactionsByPeriod(
        userId,
        period.startDate,
        period.endDate,
      );

      if (cachedTransactions != null) {
        _logger.d('✅ [Cache-First] Transactions found in cache');

        // 2. Synchroniser en arrière-plan
        _syncTransactionsByPeriodInBackground(userId, period);

        return cachedTransactions;
      }

      _logger.d('⚠️ [Cache-First] No cached transactions, fetching from network');

      // 4. FALLBACK : Récupérer depuis le réseau
      final transactions = await _fetchTransactionsByPeriodFromRemote(userId, period);

      // 5. Sauvegarder en cache
      await _localDataSource.cacheTransactionsByPeriod(
        userId,
        period.startDate,
        period.endDate,
        transactions,
      );

      return transactions;
    } on NetworkError catch (e) {
      _logger.w('🔌 [Cache-First] Network error, trying expired cache', error: e);

      // 6. ERREUR RÉSEAU : Utiliser le cache expiré
      final cachedTransactions = await _localDataSource.getCachedTransactionsByPeriod(
        userId,
        period.startDate,
        period.endDate,
      );

      if (cachedTransactions != null) {
        _logger.d('✅ [Cache-First] Returning expired cache');
        return cachedTransactions;
      }

      _logger.e('❌ [Cache-First] No cache available');
      rethrow;
    } catch (e, stackTrace) {
      _logger.e('❌ Error fetching transactions by period', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }

  @override
  Future<List<CalendarDayEntity>> getCalendarData({
    required String userId,
    required int year,
    required int month,
  }) async {
    try {
      _logger.d('📅 [Cache-First] Fetching calendar data for $year-$month');

      // 1. CACHE-FIRST : Essayer le cache d'abord
      final cachedCalendar = await _localDataSource.getCachedCalendarData(userId, year, month);

      if (cachedCalendar != null) {
        _logger.d('✅ [Cache-First] Calendar data found in cache');

        // 2. Synchroniser en arrière-plan
        _syncCalendarDataInBackground(userId, year, month);

        return cachedCalendar;
      }

      _logger.d('⚠️ [Cache-First] No cached calendar, fetching from network');

      // 4. FALLBACK : Récupérer depuis le réseau
      final calendarDays = await _fetchCalendarDataFromRemote(userId, year, month);

      // 5. Sauvegarder en cache
      await _localDataSource.cacheCalendarData(userId, year, month, calendarDays);

      return calendarDays;
    } on NetworkError catch (e) {
      _logger.w('🔌 [Cache-First] Network error, trying expired cache', error: e);

      // 6. ERREUR RÉSEAU : Utiliser le cache expiré
      final cachedCalendar = await _localDataSource.getCachedCalendarData(userId, year, month);

      if (cachedCalendar != null) {
        _logger.d('✅ [Cache-First] Returning expired cache');
        return cachedCalendar;
      }

      _logger.e('❌ [Cache-First] No cache available');
      rethrow;
    } catch (e, stackTrace) {
      _logger.e('❌ Error fetching calendar data', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }

  @override
  Future<TransactionSummaryEntity> getTransactionSummary({
    required String userId,
    required TransactionPeriodEntity period,
  }) async {
    try {
      _logger.d('📊 [Cache-First] Fetching summary for period: ${period.label}');

      // 1. CACHE-FIRST : Essayer le cache d'abord
      final cachedSummary = await _localDataSource.getCachedSummary(
        userId,
        period.startDate,
        period.endDate,
      );

      if (cachedSummary != null) {
        _logger.d('✅ [Cache-First] Summary found in cache');

        // 2. Synchroniser en arrière-plan
        _syncSummaryInBackground(userId, period);

        return cachedSummary;
      }

      _logger.d('⚠️ [Cache-First] No cached summary, fetching from network');

      // 4. FALLBACK : Récupérer depuis le réseau
      final summary = await _fetchSummaryFromRemote(userId, period);

      // 5. Sauvegarder en cache
      await _localDataSource.cacheSummary(
        userId,
        period.startDate,
        period.endDate,
        summary,
      );

      return summary;
    } on NetworkError catch (e) {
      _logger.w('🔌 [Cache-First] Network error, trying expired cache', error: e);

      // 6. ERREUR RÉSEAU : Utiliser le cache expiré
      final cachedSummary = await _localDataSource.getCachedSummary(
        userId,
        period.startDate,
        period.endDate,
      );

      if (cachedSummary != null) {
        _logger.d('✅ [Cache-First] Returning expired cache');
        return cachedSummary;
      }

      _logger.e('❌ [Cache-First] No cache available');
      rethrow;
    } catch (e, stackTrace) {
      _logger.e('❌ Error fetching summary', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }

  @override
  Future<TransactionSummaryEntity> getDaySummary({
    required String userId,
    required DateTime date,
  }) async {
    try {
      _logger.d('📊 Fetching day summary for: $date');

      // Récupérer les transactions du jour
      final transactions = await getTransactionsByDate(userId: userId, date: date);

      // Créer les bornes de la journée
      final startOfDay = DateTime(date.year, date.month, date.day);
      final endOfDay = DateTime(date.year, date.month, date.day, 23, 59, 59);

      // Créer le résumé
      return TransactionSummaryX.fromTransactions(
        transactions: transactions,
        startDate: startOfDay,
        endDate: endOfDay,
        periodLabel: '${date.day}/${date.month}/${date.year}',
      );
    } catch (e, stackTrace) {
      _logger.e('❌ Error fetching day summary', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }

  // ==================== REMOTE DATA FETCHING ====================

  /// Récupère les transactions d'un jour depuis le réseau
  Future<List<TransactionEntity>> _fetchTransactionsByDateFromRemote(
    String userId,
    DateTime date,
  ) async {
    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = DateTime(date.year, date.month, date.day, 23, 59, 59);

    // Récupérer les transactions du jour
    final dayTransactions = await _remoteDataSource.getTransactionsBetween(
      userId: userId,
      start: startOfDay,
      end: endOfDay,
    );

    // Récupérer les transactions récurrentes
    final recurringTransactions = await _remoteDataSource.getRecurringTransactions(userId);

    // Générer les occurrences des transactions récurrentes
    final allTransactions = await _processRecurringTransactions(
      dayTransactions,
      recurringTransactions,
      startOfDay,
      endOfDay,
    );

    // Trier par date décroissante
    allTransactions.sort((a, b) => b.date.compareTo(a.date));

    _logger.d('✅ Transactions fetched from network: ${allTransactions.length}');
    return allTransactions;
  }

  /// Récupère les transactions d'une période depuis le réseau
  Future<List<TransactionEntity>> _fetchTransactionsByPeriodFromRemote(
    String userId,
    TransactionPeriodEntity period,
  ) async {
    // Récupérer les transactions de la période
    final periodTransactions = await _remoteDataSource.getTransactionsBetween(
      userId: userId,
      start: period.startDate,
      end: period.endDate,
    );

    // Récupérer les transactions récurrentes
    final recurringTransactions = await _remoteDataSource.getRecurringTransactions(userId);

    // Générer les occurrences des transactions récurrentes
    final allTransactions = await _processRecurringTransactions(
      periodTransactions,
      recurringTransactions,
      period.startDate,
      period.endDate,
    );

    // Trier par date décroissante
    allTransactions.sort((a, b) => b.date.compareTo(a.date));

    _logger.d('✅ Transactions fetched from network: ${allTransactions.length}');
    return allTransactions;
  }

  /// Récupère les données du calendrier depuis le réseau
  Future<List<CalendarDayEntity>> _fetchCalendarDataFromRemote(
    String userId,
    int year,
    int month,
  ) async {
    // Récupérer les transactions du mois
    final monthTransactions = await _remoteDataSource.getTransactionsByMonth(
      userId: userId,
      year: year,
      month: month,
    );

    // Récupérer les transactions récurrentes
    final recurringTransactions = await _remoteDataSource.getRecurringTransactions(userId);

    // Créer les bornes du mois
    final startOfMonth = DateTime(year, month, 1);
    final endOfMonth = DateTime(year, month + 1, 0, 23, 59, 59);

    // Générer les occurrences des transactions récurrentes
    final allTransactions = await _processRecurringTransactions(
      monthTransactions,
      recurringTransactions,
      startOfMonth,
      endOfMonth,
    );

    // Grouper les transactions par jour
    final Map<int, List<TransactionEntity>> transactionsByDay = {};
    for (final transaction in allTransactions) {
      // Vérifier que la transaction appartient bien au mois demandé
      if (transaction.date.year == year && transaction.date.month == month) {
        final day = transaction.date.day;
        if (!transactionsByDay.containsKey(day)) {
          transactionsByDay[day] = [];
        }
        transactionsByDay[day]!.add(transaction);
      }
    }

    // Créer les CalendarDayEntity pour chaque jour du mois
    final List<CalendarDayEntity> calendarDays = [];
    final daysInMonth = DateTime(year, month + 1, 0).day;

    for (int day = 1; day <= daysInMonth; day++) {
      final date = DateTime(year, month, day);
      final dayTransactions = transactionsByDay[day] ?? [];

      double totalExpense = 0;
      double totalIncome = 0;

      for (final transaction in dayTransactions) {
        if (transaction.type == TransactionType.expense) {
          totalExpense += transaction.amount;
        } else if (transaction.type == TransactionType.income) {
          totalIncome += transaction.amount;
        }
      }

      // Prendre jusqu'à 3 transactions pour l'affichage dans le calendrier
      final transactionsForDisplay = dayTransactions.take(3).map((t) {
        return CalendarTransactionItem(
          imageUrl: t.imageUrl,
          type: t.type == TransactionType.expense ? 'expense' : 'income',
        );
      }).toList();

      final now = DateTime.now();
      final isToday = date.year == now.year &&
          date.month == now.month &&
          date.day == now.day;

      calendarDays.add(CalendarDayEntity(
        date: date,
        transactionCount: dayTransactions.length,
        totalExpense: totalExpense,
        totalIncome: totalIncome,
        transactions: transactionsForDisplay,
        hasTransactions: dayTransactions.isNotEmpty,
        isToday: isToday,
        isSelected: false,
        isCurrentMonth: true,
      ));
    }

    _logger.d('✅ Calendar data fetched from network: ${calendarDays.length} days');
    return calendarDays;
  }

  /// Récupère le résumé d'une période depuis le réseau
  Future<TransactionSummaryEntity> _fetchSummaryFromRemote(
    String userId,
    TransactionPeriodEntity period,
  ) async {
    // Récupérer les transactions de la période
    final transactions = await _fetchTransactionsByPeriodFromRemote(userId, period);

    // Créer le résumé
    return TransactionSummaryX.fromTransactions(
      transactions: transactions,
      startDate: period.startDate,
      endDate: period.endDate,
      periodLabel: period.label ?? '',
    );
  }

  /// Traite les transactions récurrentes et génère les occurrences
  Future<List<TransactionEntity>> _processRecurringTransactions(
    List<Map<String, dynamic>> normalTransactions,
    List<Map<String, dynamic>> recurringTransactions,
    DateTime startDate,
    DateTime endDate,
  ) async {
    final List<TransactionEntity> allTransactions = [];

    // Ajouter les transactions normales
    for (final transactionData in normalTransactions) {
      try {
        final transaction = TransactionEntity.fromJson(transactionData);
        allTransactions.add(transaction);
      } catch (e) {
        _logger.w('Failed to parse transaction: $e');
      }
    }

    // Traiter les transactions récurrentes
    for (final recurringData in recurringTransactions) {
      try {
        final recurring = TransactionEntity.fromJson(recurringData);

        // Ne générer que pour les transactions actives
        if (!recurring.isRecurrenceActive) continue;

        // Générer les occurrences pour cette période
        final occurrences = recurring.getOccurrencesBetween(
          start: startDate,
          end: endDate,
        );

        // Ajouter les occurrences qui ne sont pas déjà dans la liste
        for (final occurrence in occurrences) {
          // Vérifier si cette occurrence n'existe pas déjà
          // On compare par recurrenceGroupId s'il existe, sinon par ID de transaction
          final alreadyExists = allTransactions.any((t) {
            // Même date ?
            final sameDate = t.date.year == occurrence.date.year &&
                t.date.month == occurrence.date.month &&
                t.date.day == occurrence.date.day;

            if (!sameDate) return false;

            // Si les deux ont un recurrenceGroupId, comparer par groupe
            if (t.recurrenceGroupId != null && occurrence.recurrenceGroupId != null) {
              return t.recurrenceGroupId == occurrence.recurrenceGroupId;
            }

            // Sinon, comparer par ID de transaction pour distinguer les différentes transactions récurrentes
            return t.id != null && t.id == occurrence.id;
          });

          if (!alreadyExists) {
            allTransactions.add(occurrence);
          }
        }
      } catch (e) {
        _logger.w('Failed to process recurring transaction: $e');
      }
    }

    return allTransactions;
  }

  // ==================== BACKGROUND SYNC ====================

  /// Synchronise les transactions d'une période en arrière-plan
  void _syncTransactionsByPeriodInBackground(String userId, TransactionPeriodEntity period) {
    Future.microtask(() async {
      try {
        _logger.d('🔄 [Background Sync] Syncing transactions for period');
        final transactions = await _fetchTransactionsByPeriodFromRemote(userId, period);
        await _localDataSource.cacheTransactionsByPeriod(
          userId,
          period.startDate,
          period.endDate,
          transactions,
        );
        _logger.d('✅ [Background Sync] Transactions synced successfully');
      } catch (e) {
        _logger.w('⚠️ [Background Sync] Failed to sync transactions', error: e);
      }
    });
  }

  /// Synchronise les données du calendrier en arrière-plan
  void _syncCalendarDataInBackground(String userId, int year, int month) {
    Future.microtask(() async {
      try {
        _logger.d('🔄 [Background Sync] Syncing calendar data');
        final calendarDays = await _fetchCalendarDataFromRemote(userId, year, month);
        await _localDataSource.cacheCalendarData(userId, year, month, calendarDays);
        _logger.d('✅ [Background Sync] Calendar synced successfully');
      } catch (e) {
        _logger.w('⚠️ [Background Sync] Failed to sync calendar', error: e);
      }
    });
  }

  /// Synchronise le résumé en arrière-plan
  void _syncSummaryInBackground(String userId, TransactionPeriodEntity period) {
    Future.microtask(() async {
      try {
        _logger.d('🔄 [Background Sync] Syncing summary');
        final summary = await _fetchSummaryFromRemote(userId, period);
        await _localDataSource.cacheSummary(
          userId,
          period.startDate,
          period.endDate,
          summary,
        );
        _logger.d('✅ [Background Sync] Summary synced successfully');
      } catch (e) {
        _logger.w('⚠️ [Background Sync] Failed to sync summary', error: e);
      }
    });
  }
}

import 'dart:convert';

import 'package:pocketly/core/errors/common_errors.dart';
import 'package:pocketly/features/transaction_history/domain/entities/calendar_day_entity.dart';
import 'package:pocketly/features/transaction_history/domain/entities/transaction_summary_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pocketly/features/transactions/transactions.dart';

/// DataSource local pour la feature Transaction History.
///
/// Gère le cache local avec SharedPreferences.
/// Utilise la stratégie Cache-First pour réduire les requêtes réseau.
class TransactionHistoryLocalDataSource {
  final SharedPreferences _prefs;

  static const String _cacheKeyPrefix = 'cached_transaction_history_';
  static const String _cacheTimestampPrefix = 'cached_transaction_history_timestamp_';

  /// Durée d'expiration du cache pour les données du calendrier (10 minutes)
  /// Les données changent peu fréquemment
  static const Duration _calendarCacheExpiration = Duration(minutes: 10);

  /// Durée d'expiration du cache pour les transactions (5 minutes)
  /// Les données sont dynamiques
  static const Duration _transactionsCacheExpiration = Duration(minutes: 5);

  const TransactionHistoryLocalDataSource(this._prefs);

  // ==================== CALENDAR DATA ====================

  /// Récupère les données du calendrier depuis le cache
  Future<List<CalendarDayEntity>?> getCachedCalendarData(
    String userId,
    int year,
    int month,
  ) async {
    try {
      final cacheKey = _getCalendarCacheKey(userId, year, month);
      final cachedJson = _prefs.getString(cacheKey);

      if (cachedJson == null) {
        return null;
      }

      // Vérifier la validité du cache
      if (!_isCacheValid(userId, 'calendar_${year}_$month', _calendarCacheExpiration)) {
        return null;
      }

      final jsonList = jsonDecode(cachedJson) as List<dynamic>;
      return jsonList
          .map((json) => CalendarDayEntity.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      // En cas d'erreur, retourner null (cache invalide)
      return null;
    }
  }

  /// Sauvegarde les données du calendrier en cache
  Future<void> cacheCalendarData(
    String userId,
    int year,
    int month,
    List<CalendarDayEntity> calendarDays,
  ) async {
    try {
      final cacheKey = _getCalendarCacheKey(userId, year, month);
      final timestampKey = _getTimestampKey(userId, 'calendar_${year}_$month');

      final jsonList = calendarDays.map((day) => day.toJson()).toList();
      final json = jsonEncode(jsonList);
      await _prefs.setString(cacheKey, json);
      await _prefs.setInt(timestampKey, DateTime.now().millisecondsSinceEpoch);
    } catch (e) {
      // Erreur de cache non-bloquante
      throw CacheError(
        operation: 'cache_calendar_data',
        technicalMessage: 'Failed to cache calendar data: $e',
      );
    }
  }

  // ==================== TRANSACTIONS BY PERIOD ====================

  /// Récupère les transactions d'une période depuis le cache
  Future<List<TransactionEntity>?> getCachedTransactionsByPeriod(
    String userId,
    DateTime startDate,
    DateTime endDate,
  ) async {
    try {
      final cacheKey = _getPeriodCacheKey(userId, startDate, endDate);
      final cachedJson = _prefs.getString(cacheKey);

      if (cachedJson == null) {
        return null;
      }

      // Vérifier la validité du cache
      final periodKey = 'period_${startDate.toIso8601String()}_${endDate.toIso8601String()}';
      if (!_isCacheValid(userId, periodKey, _transactionsCacheExpiration)) {
        return null;
      }

      final jsonList = jsonDecode(cachedJson) as List<dynamic>;
      return jsonList
          .map((json) => TransactionEntity.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      // En cas d'erreur, retourner null (cache invalide)
      return null;
    }
  }

  /// Sauvegarde les transactions d'une période en cache
  Future<void> cacheTransactionsByPeriod(
    String userId,
    DateTime startDate,
    DateTime endDate,
    List<TransactionEntity> transactions,
  ) async {
    try {
      final cacheKey = _getPeriodCacheKey(userId, startDate, endDate);
      final periodKey = 'period_${startDate.toIso8601String()}_${endDate.toIso8601String()}';
      final timestampKey = _getTimestampKey(userId, periodKey);

      final jsonList = transactions.map((t) => t.toJson()).toList();
      final json = jsonEncode(jsonList);
      await _prefs.setString(cacheKey, json);
      await _prefs.setInt(timestampKey, DateTime.now().millisecondsSinceEpoch);
    } catch (e) {
      // Erreur de cache non-bloquante
      throw CacheError(
        operation: 'cache_transactions_by_period',
        technicalMessage: 'Failed to cache transactions by period: $e',
      );
    }
  }

  // ==================== TRANSACTION SUMMARY ====================

  /// Récupère le résumé d'une période depuis le cache
  Future<TransactionSummaryEntity?> getCachedSummary(
    String userId,
    DateTime startDate,
    DateTime endDate,
  ) async {
    try {
      final cacheKey = _getSummaryCacheKey(userId, startDate, endDate);
      final cachedJson = _prefs.getString(cacheKey);

      if (cachedJson == null) {
        return null;
      }

      // Vérifier la validité du cache
      final summaryKey = 'summary_${startDate.toIso8601String()}_${endDate.toIso8601String()}';
      if (!_isCacheValid(userId, summaryKey, _transactionsCacheExpiration)) {
        return null;
      }

      final json = jsonDecode(cachedJson) as Map<String, dynamic>;
      return TransactionSummaryEntity.fromJson(json);
    } catch (e) {
      // En cas d'erreur, retourner null (cache invalide)
      return null;
    }
  }

  /// Sauvegarde le résumé d'une période en cache
  Future<void> cacheSummary(
    String userId,
    DateTime startDate,
    DateTime endDate,
    TransactionSummaryEntity summary,
  ) async {
    try {
      final cacheKey = _getSummaryCacheKey(userId, startDate, endDate);
      final summaryKey = 'summary_${startDate.toIso8601String()}_${endDate.toIso8601String()}';
      final timestampKey = _getTimestampKey(userId, summaryKey);

      final json = jsonEncode(summary.toJson());
      await _prefs.setString(cacheKey, json);
      await _prefs.setInt(timestampKey, DateTime.now().millisecondsSinceEpoch);
    } catch (e) {
      // Erreur de cache non-bloquante
      throw CacheError(
        operation: 'cache_summary',
        technicalMessage: 'Failed to cache summary: $e',
      );
    }
  }

  // ==================== CACHE MANAGEMENT ====================

  /// Vide tout le cache pour un utilisateur
  Future<void> clearAllCache(String userId) async {
    try {
      // Récupérer toutes les clés
      final keys = _prefs.getKeys();

      // Filtrer les clés qui appartiennent à cet utilisateur
      final userKeys = keys.where((key) => key.contains(userId));

      // Supprimer toutes les clés
      for (final key in userKeys) {
        await _prefs.remove(key);
      }
    } catch (e) {
      throw CacheError(
        operation: 'clear_all_cache',
        technicalMessage: 'Failed to clear transaction history cache: $e',
      );
    }
  }

  /// Vide le cache du calendrier pour un mois spécifique
  Future<void> clearCalendarCache(String userId, int year, int month) async {
    try {
      final cacheKey = _getCalendarCacheKey(userId, year, month);
      final timestampKey = _getTimestampKey(userId, 'calendar_${year}_$month');

      await _prefs.remove(cacheKey);
      await _prefs.remove(timestampKey);
    } catch (e) {
      throw CacheError(
        operation: 'clear_calendar_cache',
        technicalMessage: 'Failed to clear calendar cache: $e',
      );
    }
  }

  /// Vérifie si le cache est encore valide
  bool _isCacheValid(String userId, String dataType, Duration expiration) {
    try {
      final timestampKey = _getTimestampKey(userId, dataType);
      final timestamp = _prefs.getInt(timestampKey);

      if (timestamp == null) {
        return false;
      }

      final cacheDate = DateTime.fromMillisecondsSinceEpoch(timestamp);
      final now = DateTime.now();
      final difference = now.difference(cacheDate);

      return difference < expiration;
    } catch (e) {
      return false;
    }
  }

  /// Génère une clé de cache pour le calendrier
  String _getCalendarCacheKey(String userId, int year, int month) {
    return '${_cacheKeyPrefix}calendar_${userId}_${year}_$month';
  }

  /// Génère une clé de cache pour les transactions d'une période
  String _getPeriodCacheKey(String userId, DateTime startDate, DateTime endDate) {
    final start = startDate.toIso8601String();
    final end = endDate.toIso8601String();
    return '${_cacheKeyPrefix}period_${userId}_${start}_$end';
  }

  /// Génère une clé de cache pour le résumé d'une période
  String _getSummaryCacheKey(String userId, DateTime startDate, DateTime endDate) {
    final start = startDate.toIso8601String();
    final end = endDate.toIso8601String();
    return '${_cacheKeyPrefix}summary_${userId}_${start}_$end';
  }

  /// Génère une clé de timestamp pour le cache
  String _getTimestampKey(String userId, String dataType) {
    return '$_cacheTimestampPrefix${dataType}_$userId';
  }
}

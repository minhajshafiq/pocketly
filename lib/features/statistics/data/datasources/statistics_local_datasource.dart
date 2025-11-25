import 'dart:convert';

import 'package:pocketly/core/errors/common_errors.dart';
import 'package:pocketly/features/statistics/domain/entities/chart_data_entity.dart';
import 'package:pocketly/features/statistics/domain/entities/statistics_summary_entity.dart';
import 'package:pocketly/features/transactions/transactions.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// DataSource local pour la feature Statistics.
///
/// Gère le cache local avec SharedPreferences.
/// Utilise la stratégie Cache-First pour réduire les requêtes réseau.
class StatisticsLocalDataSource {
  final SharedPreferences _prefs;

  static const String _cacheKeyPrefix = 'cached_statistics_';
  static const String _cacheTimestampPrefix = 'cached_statistics_timestamp_';

  /// Durée d'expiration du cache pour les statistiques (5 minutes)
  /// Les données sont dynamiques et changent fréquemment
  static const Duration _cacheExpiration = Duration(minutes: 5);

  const StatisticsLocalDataSource(this._prefs);

  // ==================== STATISTICS SUMMARY ====================

  /// Récupère le résumé des statistiques depuis le cache
  Future<StatisticsSummaryEntity?> getCachedStatisticsSummary(
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
      final summaryKey =
          'summary_${startDate.toIso8601String()}_${endDate.toIso8601String()}';
      if (!_isCacheValid(userId, summaryKey)) {
        return null;
      }

      final json = jsonDecode(cachedJson) as Map<String, dynamic>;
      return StatisticsSummaryEntity.fromJson(json);
    } catch (e) {
      // En cas d'erreur, retourner null (cache invalide)
      return null;
    }
  }

  /// Sauvegarde le résumé des statistiques en cache
  Future<void> cacheStatisticsSummary(
    String userId,
    DateTime startDate,
    DateTime endDate,
    StatisticsSummaryEntity summary,
  ) async {
    try {
      final cacheKey = _getSummaryCacheKey(userId, startDate, endDate);
      final summaryKey =
          'summary_${startDate.toIso8601String()}_${endDate.toIso8601String()}';
      final timestampKey = _getTimestampKey(userId, summaryKey);

      final json = jsonEncode(summary.toJson());
      await _prefs.setString(cacheKey, json);
      await _prefs.setInt(timestampKey, DateTime.now().millisecondsSinceEpoch);
    } catch (e) {
      // Erreur de cache non-bloquante
      throw CacheError(
        operation: 'cache_statistics_summary',
        technicalMessage: 'Failed to cache statistics summary: $e',
      );
    }
  }

  // ==================== CHART DATA ====================

  /// Récupère les données du graphique depuis le cache
  Future<ChartDataEntity?> getCachedChartData(
    String userId,
    TimePeriod period,
    DateTime startDate,
  ) async {
    try {
      final cacheKey = _getChartDataCacheKey(userId, period, startDate);
      final cachedJson = _prefs.getString(cacheKey);

      if (cachedJson == null) {
        return null;
      }

      // Vérifier la validité du cache
      final chartKey = 'chart_${period.name}_${startDate.toIso8601String()}';
      if (!_isCacheValid(userId, chartKey)) {
        return null;
      }

      final json = jsonDecode(cachedJson) as Map<String, dynamic>;
      return ChartDataEntity.fromJson(json);
    } catch (e) {
      // En cas d'erreur, retourner null (cache invalide)
      return null;
    }
  }

  /// Sauvegarde les données du graphique en cache
  Future<void> cacheChartData(
    String userId,
    TimePeriod period,
    DateTime startDate,
    ChartDataEntity chartData,
  ) async {
    try {
      final cacheKey = _getChartDataCacheKey(userId, period, startDate);
      final chartKey = 'chart_${period.name}_${startDate.toIso8601String()}';
      final timestampKey = _getTimestampKey(userId, chartKey);

      final json = jsonEncode(chartData.toJson());
      await _prefs.setString(cacheKey, json);
      await _prefs.setInt(timestampKey, DateTime.now().millisecondsSinceEpoch);
    } catch (e) {
      // Erreur de cache non-bloquante
      throw CacheError(
        operation: 'cache_chart_data',
        technicalMessage: 'Failed to cache chart data: $e',
      );
    }
  }

  // ==================== TRANSACTIONS ====================

  /// Récupère les transactions d'une période depuis le cache
  Future<List<TransactionEntity>?> getCachedTransactions(
    String userId,
    DateTime startDate,
    DateTime endDate,
  ) async {
    try {
      final cacheKey = _getTransactionsCacheKey(userId, startDate, endDate);
      final cachedJson = _prefs.getString(cacheKey);

      if (cachedJson == null) {
        return null;
      }

      // Vérifier la validité du cache
      final transactionsKey =
          'transactions_${startDate.toIso8601String()}_${endDate.toIso8601String()}';
      if (!_isCacheValid(userId, transactionsKey)) {
        return null;
      }

      final jsonList = jsonDecode(cachedJson) as List<dynamic>;
      return jsonList
          .map(
            (json) => TransactionEntity.fromJson(json as Map<String, dynamic>),
          )
          .toList();
    } catch (e) {
      // En cas d'erreur, retourner null (cache invalide)
      return null;
    }
  }

  /// Sauvegarde les transactions d'une période en cache
  Future<void> cacheTransactions(
    String userId,
    DateTime startDate,
    DateTime endDate,
    List<TransactionEntity> transactions,
  ) async {
    try {
      final cacheKey = _getTransactionsCacheKey(userId, startDate, endDate);
      final transactionsKey =
          'transactions_${startDate.toIso8601String()}_${endDate.toIso8601String()}';
      final timestampKey = _getTimestampKey(userId, transactionsKey);

      final jsonList = transactions.map((t) => t.toJson()).toList();
      final json = jsonEncode(jsonList);
      await _prefs.setString(cacheKey, json);
      await _prefs.setInt(timestampKey, DateTime.now().millisecondsSinceEpoch);
    } catch (e) {
      // Erreur de cache non-bloquante
      throw CacheError(
        operation: 'cache_transactions',
        technicalMessage: 'Failed to cache transactions: $e',
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
        technicalMessage: 'Failed to clear statistics cache: $e',
      );
    }
  }

  /// Vide le cache pour une période spécifique
  Future<void> clearPeriodCache(
    String userId,
    TimePeriod period,
    DateTime startDate,
  ) async {
    try {
      final chartKey = _getChartDataCacheKey(userId, period, startDate);
      final chartTimestampKey = _getTimestampKey(
        userId,
        'chart_${period.name}_${startDate.toIso8601String()}',
      );

      await _prefs.remove(chartKey);
      await _prefs.remove(chartTimestampKey);
    } catch (e) {
      throw CacheError(
        operation: 'clear_period_cache',
        technicalMessage: 'Failed to clear period cache: $e',
      );
    }
  }

  /// Vérifie si le cache est encore valide
  bool _isCacheValid(String userId, String dataType) {
    try {
      final timestampKey = _getTimestampKey(userId, dataType);
      final timestamp = _prefs.getInt(timestampKey);

      if (timestamp == null) {
        return false;
      }

      final cacheDate = DateTime.fromMillisecondsSinceEpoch(timestamp);
      final now = DateTime.now();
      final difference = now.difference(cacheDate);

      return difference < _cacheExpiration;
    } catch (e) {
      return false;
    }
  }

  /// Génère une clé de cache pour le résumé
  String _getSummaryCacheKey(
    String userId,
    DateTime startDate,
    DateTime endDate,
  ) {
    final start = startDate.toIso8601String();
    final end = endDate.toIso8601String();
    return '${_cacheKeyPrefix}summary_${userId}_${start}_$end';
  }

  /// Génère une clé de cache pour les données du graphique
  String _getChartDataCacheKey(
    String userId,
    TimePeriod period,
    DateTime startDate,
  ) {
    final start = startDate.toIso8601String();
    return '${_cacheKeyPrefix}chart_${userId}_${period.name}_$start';
  }

  /// Génère une clé de cache pour les transactions
  String _getTransactionsCacheKey(
    String userId,
    DateTime startDate,
    DateTime endDate,
  ) {
    final start = startDate.toIso8601String();
    final end = endDate.toIso8601String();
    return '${_cacheKeyPrefix}transactions_${userId}_${start}_$end';
  }

  /// Génère une clé de timestamp pour le cache
  String _getTimestampKey(String userId, String dataType) {
    return '$_cacheTimestampPrefix${dataType}_$userId';
  }
}

import 'package:pocketly/features/statistics/domain/entities/chart_data_entity.dart';
import 'package:pocketly/features/statistics/domain/entities/statistics_summary_entity.dart';
import 'package:pocketly/features/transactions/transactions.dart';

/// Interface du repository pour les statistiques
abstract class StatisticsRepository {
  /// Récupère le résumé des statistiques pour une période donnée
  Future<StatisticsSummaryEntity> getStatisticsSummary({
    required String userId,
    required DateTime startDate,
    required DateTime endDate,
  });

  /// Récupère les données du graphique pour une période donnée
  Future<ChartDataEntity> getChartData({
    required String userId,
    required TimePeriod period,
    required DateTime startDate,
  });

  /// Récupère les transactions pour une période donnée
  Future<List<TransactionEntity>> getTransactionsByDateRange({
    required String userId,
    required DateTime startDate,
    required DateTime endDate,
  });
}

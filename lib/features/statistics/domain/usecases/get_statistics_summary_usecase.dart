import 'package:pocketly/features/statistics/domain/entities/statistics_summary_entity.dart';
import 'package:pocketly/features/statistics/domain/repositories/statistics_repository.dart';

/// Use case pour récupérer le résumé des statistiques
class GetStatisticsSummaryUseCase {
  final StatisticsRepository _repository;

  const GetStatisticsSummaryUseCase(this._repository);

  Future<StatisticsSummaryEntity> call({
    required String userId,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    try {
      return await _repository.getStatisticsSummary(
        userId: userId,
        startDate: startDate,
        endDate: endDate,
      );
    } catch (e) {
      rethrow;
    }
  }
}

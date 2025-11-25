import 'package:pocketly/features/statistics/domain/entities/chart_data_entity.dart';
import 'package:pocketly/features/statistics/domain/repositories/statistics_repository.dart';

/// Use case pour récupérer les données du graphique
class GetChartDataUseCase {
  final StatisticsRepository _repository;

  const GetChartDataUseCase(this._repository);

  Future<ChartDataEntity> call({
    required String userId,
    required TimePeriod period,
    required DateTime startDate,
  }) async {
    try {
      return await _repository.getChartData(
        userId: userId,
        period: period,
        startDate: startDate,
      );
    } catch (e) {
      rethrow;
    }
  }
}

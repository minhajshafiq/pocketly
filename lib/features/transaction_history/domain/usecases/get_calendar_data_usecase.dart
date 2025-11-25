import 'package:pocketly/features/transaction_history/domain/entities/calendar_day_entity.dart';
import 'package:pocketly/features/transaction_history/domain/repositories/transaction_history_repository.dart';

/// Use case pour récupérer les données du calendrier pour un mois
class GetCalendarDataUseCase {
  final TransactionHistoryRepository _repository;

  const GetCalendarDataUseCase(this._repository);

  /// Exécute le use case
  Future<List<CalendarDayEntity>> call({
    required String userId,
    required int year,
    required int month,
  }) async {
    try {
      return await _repository.getCalendarData(
        userId: userId,
        year: year,
        month: month,
      );
    } catch (e) {
      rethrow;
    }
  }
}

import 'package:freezed_annotation/freezed_annotation.dart';

part 'statistics_summary_entity.freezed.dart';
part 'statistics_summary_entity.g.dart';

/// Entité représentant le résumé des statistiques
@freezed
sealed class StatisticsSummaryEntity with _$StatisticsSummaryEntity {
  const factory StatisticsSummaryEntity({
    required double totalIncome,
    required double totalExpense,
    required double balance,
    required int transactionCount,
    required DateTime startDate,
    required DateTime endDate,
  }) = _StatisticsSummaryEntity;

  factory StatisticsSummaryEntity.fromJson(Map<String, dynamic> json) =>
      _$StatisticsSummaryEntityFromJson(json);
}

import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_summary_entity.freezed.dart';
part 'home_summary_entity.g.dart';

/// Entité représentant le résumé de la page d'accueil.
///
/// Contient le solde actuel, la variation sur 24h et les statistiques clés.
@freezed
sealed class HomeSummaryEntity with _$HomeSummaryEntity {
  const factory HomeSummaryEntity({
    /// Solde total actuel (revenus - dépenses)
    required double totalBalance,

    /// Montant total épargné dans les pockets savings
    @Default(0.0) double totalSavings,

    /// Solde disponible (totalBalance - totalSavings)
    @Default(0.0) double availableBalance,

    /// Variation du solde sur les dernières 24h
    required double variation24h,

    /// Pourcentage de variation sur 24h
    required double variationPercentage24h,

    /// Nombre total de transactions
    @Default(0) int totalTransactions,

    /// Nombre de transactions du jour
    @Default(0) int todayTransactions,

    /// Dernière mise à jour
    required DateTime lastUpdate,
  }) = _HomeSummaryEntity;

  factory HomeSummaryEntity.fromJson(Map<String, dynamic> json) =>
      _$HomeSummaryEntityFromJson(json);
}

/// Extension pour calculer si la variation est positive
extension HomeSummaryEntityX on HomeSummaryEntity {
  /// Indique si la variation est positive
  bool get isPositiveVariation => variation24h >= 0;

  /// Indique si le solde est positif
  bool get isPositiveBalance => totalBalance >= 0;

  /// Retourne le symbole de variation (+ ou -)
  String get variationSymbol => isPositiveVariation ? '+' : '';

  /// Retourne la variation formatée avec symbole
  String get formattedVariation =>
      '$variationSymbol${variation24h.toStringAsFixed(2)}';

  /// Retourne le pourcentage formatté avec symbole
  String get formattedPercentage =>
      '$variationSymbol${variationPercentage24h.toStringAsFixed(1)}%';
}

import 'package:pocketly/features/home/domain/entities/home_summary_entity.dart';
import 'package:pocketly/features/transactions/transactions.dart';
import 'package:pocketly/features/pockets/pockets.dart';

/// Use case pour calculer le résumé de la page d'accueil.
///
/// Prend une liste de transactions et de pockets, et calcule:
/// - Le solde total (revenus - dépenses)
/// - Le solde disponible (solde total - épargne)
/// - La variation 24h
/// - Les statistiques de transactions
class GetHomeSummaryUseCase {
  const GetHomeSummaryUseCase();

  /// Calcule le résumé à partir des transactions et pockets
  ///
  /// [transactions] - Liste de toutes les transactions
  /// [pockets] - Liste des pockets pour calculer l'épargne
  HomeSummaryEntity call({
    required List<TransactionEntity> transactions,
    required List<PocketEntity> pockets,
  }) {
    // Calculer le solde total (revenus - dépenses)
    double totalBalance = 0;
    for (final transaction in transactions) {
      if (transaction.isIncome) {
        totalBalance += transaction.amount;
      } else {
        totalBalance -= transaction.amount;
      }
    }

    // Calculer le total épargné depuis les pockets
    final savingsPockets = pockets.where((p) => p.category == PocketCategory.savings).toList();
    final totalSavings = savingsPockets.fold(0.0, (sum, pocket) => sum + pocket.savedAmount);

    // Calculer le solde disponible
    final availableBalance = totalBalance - totalSavings;

    // Calculer la variation 24h (transactions des dernières 24h)
    final now = DateTime.now();
    final yesterday = now.subtract(const Duration(hours: 24));
    double variation24h = 0;
    for (final transaction in transactions) {
      if (transaction.date.isAfter(yesterday)) {
        if (transaction.isIncome) {
          variation24h += transaction.amount;
        } else {
          variation24h -= transaction.amount;
        }
      }
    }

    // Calculer le pourcentage de variation
    final yesterdayBalance = totalBalance - variation24h;
    final variationPercentage = yesterdayBalance != 0
        ? (variation24h / yesterdayBalance.abs()) * 100
        : 0.0;

    // Calculer les transactions d'aujourd'hui
    final today = DateTime(now.year, now.month, now.day);
    final todayTransactions = transactions.where((t) {
      return t.date.isAfter(today) || t.date.isAtSameMomentAs(today);
    }).length;

    return HomeSummaryEntity(
      totalBalance: totalBalance,
      totalSavings: totalSavings,
      availableBalance: availableBalance,
      variation24h: variation24h,
      variationPercentage24h: variationPercentage,
      totalTransactions: transactions.length,
      todayTransactions: todayTransactions,
      lastUpdate: DateTime.now(),
    );
  }
}

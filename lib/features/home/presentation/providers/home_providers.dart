import 'package:pocketly/features/home/domain/entities/home_summary_entity.dart';
import 'package:pocketly/features/home/domain/entities/weekly_expense_entity.dart';
import 'package:pocketly/features/home/domain/usecases/get_home_summary_usecase.dart';
import 'package:pocketly/features/home/domain/usecases/get_recent_transactions_usecase.dart';
import 'package:pocketly/features/home/domain/usecases/get_weekly_expenses_usecase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pocketly/features/pockets/pockets.dart';
import 'package:pocketly/features/transactions/transactions.dart';
import 'package:pocketly/features/user/user.dart';

part 'home_providers.g.dart';

// ==================== USE CASES ====================

/// Provider pour le use case de calcul du résumé
@riverpod
GetHomeSummaryUseCase getHomeSummaryUseCase(Ref ref) {
  return const GetHomeSummaryUseCase();
}

/// Provider pour le use case de calcul des dépenses hebdomadaires
@riverpod
GetWeeklyExpensesUseCase getWeeklyExpensesUseCase(Ref ref) {
  return const GetWeeklyExpensesUseCase();
}

/// Provider pour le use case de récupération des transactions récentes
@riverpod
GetRecentTransactionsUseCase getRecentTransactionsUseCase(Ref ref) {
  return const GetRecentTransactionsUseCase();
}

// ==================== CONTROLLERS ====================

/// Provider pour le résumé de la page d'accueil
/// 
/// Watch automatiquement transactionProvider pour se mettre à jour
/// instantanément quand de nouvelles transactions sont créées/modifiées/supprimées
@riverpod
Future<HomeSummaryEntity> homeSummaryController(Ref ref) async {
  // Watch le transactionProvider pour se mettre à jour automatiquement
  final transactionState = ref.watch(transactionProvider);
  
  // S'assurer que les transactions sont chargées
  if (transactionState is TransactionStateInitial) {
    Future.microtask(() {
      ref.read(transactionProvider.notifier).loadTransactions();
    });
    // Retourner un résumé vide temporairement
    return HomeSummaryEntity(
      totalBalance: 0,
      availableBalance: 0,
      variation24h: 0,
      variationPercentage24h: 0,
      lastUpdate: DateTime.now(),
    );
  }
  
      // Attendre que l'utilisateur soit chargé
      final user = await ref.watch(currentUserProvider.future);
      if (user == null) {
        throw Exception('User not authenticated');
      }

  // Récupérer les transactions
  final transactions = transactionState.allTransactions;
  
  // Récupérer les pockets (pour calculer l'épargne)
  final pocketsAsync = ref.watch(userPocketsProvider);
  final pockets = pocketsAsync.maybeWhen(
    data: (data) => data,
    orElse: () => <PocketEntity>[],
  );
  
  // Utiliser le use case pour calculer le résumé
  final useCase = ref.read(getHomeSummaryUseCaseProvider);
  return useCase(
    transactions: transactions,
    pockets: pockets,
          );
  }

/// Provider pour les dépenses hebdomadaires
/// 
/// Watch automatiquement transactionProvider pour se mettre à jour
/// instantanément quand de nouvelles transactions sont créées/modifiées/supprimées
@riverpod
WeeklyExpensesEntity weeklyExpensesController(Ref ref) {
  // Watch le transactionProvider pour se mettre à jour automatiquement
  final transactionState = ref.watch(transactionProvider);
  
  // S'assurer que les transactions sont chargées
  if (transactionState is TransactionStateInitial) {
    Future.microtask(() {
      ref.read(transactionProvider.notifier).loadTransactions();
    });
    // Retourner des dépenses vides temporairement
    final weekStartDate = _getWeekStartDate();
    return WeeklyExpensesEntity(
      expenses: List.generate(7, (index) => WeeklyExpenseEntity(
        dayOfWeek: index + 1,
        date: weekStartDate.add(Duration(days: index)),
        amount: 0,
        transactionCount: 0,
      )),
      totalWeekAmount: 0,
      weekStartDate: weekStartDate,
      weekEndDate: weekStartDate.add(const Duration(days: 6, hours: 23, minutes: 59, seconds: 59)),
    );
      }

  // Récupérer les transactions
  final transactions = transactionState.allTransactions;
  
  // Utiliser le use case pour calculer les dépenses hebdomadaires
  final useCase = ref.read(getWeeklyExpensesUseCaseProvider);
  return useCase(transactions: transactions);
      }
      
/// Helper pour obtenir le lundi de la semaine actuelle
DateTime _getWeekStartDate() {
  final now = DateTime.now();
  final weekDay = now.weekday;
  final daysFromMonday = weekDay - 1;
  final monday = now.subtract(Duration(days: daysFromMonday));
  return DateTime(monday.year, monday.month, monday.day, 0, 0, 0);
}

/// Provider pour les transactions récentes
/// 
/// Watch automatiquement transactionProvider pour se mettre à jour
/// instantanément quand de nouvelles transactions sont créées/modifiées/supprimées
@riverpod
List<TransactionEntity> recentTransactionsController(Ref ref) {
  // Watch le transactionProvider pour se mettre à jour automatiquement
  final transactionState = ref.watch(transactionProvider);
  
  // S'assurer que les transactions sont chargées
  if (transactionState is TransactionStateInitial) {
    // Si l'état est initial, charger les transactions
    Future.microtask(() {
      ref.read(transactionProvider.notifier).loadTransactions();
    });
    return [];
      }

      // Récupérer les transactions
  final transactions = transactionState.allTransactions;
  
  // Utiliser le use case pour récupérer les transactions récentes
  final useCase = ref.read(getRecentTransactionsUseCaseProvider);
  return useCase(
    transactions: transactions,
    limit: 4,
  );
}

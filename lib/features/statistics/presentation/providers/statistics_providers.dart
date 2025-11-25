import 'package:pocketly/core/config/supabase_config.dart';
import 'package:pocketly/core/services/logger_service.dart';
import 'package:pocketly/features/statistics/data/datasources/statistics_local_datasource.dart';
import 'package:pocketly/features/statistics/data/datasources/statistics_remote_datasource.dart';
import 'package:pocketly/features/statistics/data/repositories/statistics_repository_impl.dart';
import 'package:pocketly/features/statistics/domain/entities/chart_data_entity.dart';
import 'package:pocketly/features/statistics/domain/entities/daily_expense_entity.dart';
import 'package:pocketly/features/statistics/domain/entities/statistics_summary_entity.dart';
import 'package:pocketly/features/statistics/domain/repositories/statistics_repository.dart';
import 'package:pocketly/features/statistics/domain/usecases/get_chart_data_usecase.dart';
import 'package:pocketly/features/statistics/domain/usecases/get_statistics_summary_usecase.dart';
import 'package:pocketly/features/statistics/domain/usecases/get_transactions_by_date_usecase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pocketly/features/transactions/transactions.dart';

part 'statistics_providers.g.dart';

// ==================== DATASOURCES ====================

/// Provider pour SharedPreferences (cache local)
@Riverpod(keepAlive: true)
Future<SharedPreferences> sharedPreferences(Ref ref) async {
  return await SharedPreferences.getInstance();
}

/// Provider pour le datasource distant des statistiques
@Riverpod(keepAlive: true)
StatisticsRemoteDataSource statisticsRemoteDataSource(Ref ref) {
  final supabase = SupabaseConfig.client;
  return StatisticsRemoteDataSource(supabase);
}

/// Provider pour le datasource local (cache SharedPreferences)
@Riverpod(keepAlive: true)
Future<StatisticsLocalDataSource> statisticsLocalDataSource(Ref ref) async {
  final prefs = await ref.watch(sharedPreferencesProvider.future);
  return StatisticsLocalDataSource(prefs);
}

// ==================== REPOSITORIES ====================

/// Provider pour le repository des statistiques
@Riverpod(keepAlive: true)
Future<StatisticsRepository> statisticsRepository(Ref ref) async {
  final remoteDataSource = ref.watch(statisticsRemoteDataSourceProvider);
  final localDataSource = await ref.watch(
    statisticsLocalDataSourceProvider.future,
  );
  final logger = ref.watch(loggerProvider);
  return StatisticsRepositoryImpl(
    remoteDataSource: remoteDataSource,
    localDataSource: localDataSource,
    logger: logger,
  );
}

// ==================== USE CASES ====================

/// Provider pour le use case de récupération du résumé
@Riverpod(keepAlive: true)
Future<GetStatisticsSummaryUseCase> getStatisticsSummaryUseCase(Ref ref) async {
  final repository = await ref.watch(statisticsRepositoryProvider.future);
  return GetStatisticsSummaryUseCase(repository);
}

/// Provider pour le use case de récupération des données du graphique
@Riverpod(keepAlive: true)
Future<GetChartDataUseCase> getChartDataUseCase(Ref ref) async {
  final repository = await ref.watch(statisticsRepositoryProvider.future);
  return GetChartDataUseCase(repository);
}

/// Provider pour le use case de récupération des transactions par date
@Riverpod(keepAlive: true)
Future<GetTransactionsByDateUseCase> getTransactionsByDateUseCase(
  Ref ref,
) async {
  final repository = await ref.watch(statisticsRepositoryProvider.future);
  return GetTransactionsByDateUseCase(repository);
}

// ==================== STATE PROVIDERS ====================

/// Provider pour le type de graphique sélectionné
@riverpod
class ChartTypeNotifier extends _$ChartTypeNotifier {
  @override
  ChartType build() => ChartType.bar;

  void toggle() {
    state = state == ChartType.bar ? ChartType.line : ChartType.bar;
  }

  void setType(ChartType type) {
    state = type;
  }
}

/// Provider pour la période sélectionnée
@riverpod
class TimePeriodNotifier extends _$TimePeriodNotifier {
  @override
  TimePeriod build() => TimePeriod.week;

  void setPeriod(TimePeriod period) {
    state = period;
    // Réinitialiser la date de début pour la nouvelle période
    ref.read(currentStartDateProvider.notifier).resetForPeriod(period);
  }
}

/// Provider pour la date de début actuelle
@riverpod
class CurrentStartDateNotifier extends _$CurrentStartDateNotifier {
  @override
  DateTime build() {
    // Par défaut, commencer au lundi de la semaine actuelle
    final now = DateTime.now();
    final weekDay = now.weekday;
    final monday = now.subtract(Duration(days: weekDay - 1));
    return DateTime(monday.year, monday.month, monday.day);
  }
  
  void resetForPeriod(TimePeriod period) {
    final now = DateTime.now();
    switch (period) {
      case TimePeriod.week:
        // Commencer au lundi de la semaine actuelle
        final weekDay = now.weekday;
        final monday = now.subtract(Duration(days: weekDay - 1));
        state = DateTime(monday.year, monday.month, monday.day);
        break;
      case TimePeriod.month:
        // Commencer 5 mois avant le mois actuel pour voir 6 mois (incluant le mois actuel)
        state = DateTime(now.year, now.month - 5, 1);
        break;
      case TimePeriod.year:
        // Commencer 6 ans avant l'année actuelle pour voir 7 ans (incluant l'année actuelle)
        state = DateTime(now.year - 6, 1, 1);
        break;
    }
  }

  void goToPrevious(TimePeriod period) {
    switch (period) {
      case TimePeriod.week:
        state = state.subtract(const Duration(days: 7));
        break;
      case TimePeriod.month:
        // Reculer de 6 mois
        state = DateTime(state.year, state.month - 6, 1);
        break;
      case TimePeriod.year:
        // Reculer de 7 ans
        state = DateTime(state.year - 7, 1, 1);
        break;
    }
  }

  void goToNext(TimePeriod period) {
    switch (period) {
      case TimePeriod.week:
        state = state.add(const Duration(days: 7));
        break;
      case TimePeriod.month:
        // Avancer de 6 mois
        state = DateTime(state.year, state.month + 6, 1);
        break;
      case TimePeriod.year:
        // Avancer de 7 ans
        state = DateTime(state.year + 7, 1, 1);
        break;
    }
  }

  void reset() {
    final now = DateTime.now();
    final weekDay = now.weekday;
    final monday = now.subtract(Duration(days: weekDay - 1));
    state = DateTime(monday.year, monday.month, monday.day);
  }
}

/// Provider pour le jour sélectionné dans le graphique
@riverpod
class SelectedDayNotifier extends _$SelectedDayNotifier {
  @override
  DateTime? build() => null; // Pas de sélection par défaut

  void selectDay(DateTime date) {
    state = DateTime(date.year, date.month, date.day);
  }

  void clearSelection() {
    state = null;
  }
}

// ==================== DATA CONTROLLERS ====================

/// Provider pour le résumé des statistiques
/// 
/// Watch automatiquement transactionProvider pour se mettre à jour
/// instantanément quand de nouvelles transactions sont créées/modifiées/supprimées
@riverpod
Future<StatisticsSummaryEntity> statisticsSummaryController(Ref ref) async {
  // Watch le transactionProvider pour se mettre à jour automatiquement
  final transactionState = ref.watch(transactionProvider);
      final period = ref.watch(timePeriodProvider);
      final startDate = ref.watch(currentStartDateProvider);
  
  // S'assurer que les transactions sont chargées
  if (transactionState is TransactionStateInitial) {
    Future.microtask(() {
      ref.read(transactionProvider.notifier).loadTransactions();
    });
    // Retourner un résumé vide temporairement
    final DateTime endDate;
    switch (period) {
      case TimePeriod.week:
        endDate = startDate.add(const Duration(days: 7));
        break;
      case TimePeriod.month:
        // 6 mois
        endDate = DateTime(startDate.year, startDate.month + 6, 1);
        break;
      case TimePeriod.year:
        // 7 ans
        endDate = DateTime(startDate.year + 7, 1, 1);
        break;
    }
    return StatisticsSummaryEntity(
      totalIncome: 0,
      totalExpense: 0,
      balance: 0,
      transactionCount: 0,
      startDate: startDate,
      endDate: endDate,
    );
  }

      // Calculer la date de fin
      final DateTime endDate;
      switch (period) {
        case TimePeriod.week:
          endDate = startDate.add(const Duration(days: 7));
          break;
        case TimePeriod.month:
          // 6 mois
          endDate = DateTime(startDate.year, startDate.month + 6, 1);
          break;
        case TimePeriod.year:
          // 7 ans
          endDate = DateTime(startDate.year + 7, 1, 1);
          break;
      }

  // Calculer directement à partir des transactions
  final allTransactions = transactionState.allTransactions;
  final periodTransactions = allTransactions.where((transaction) {
    final transactionDate = transaction.date;
    return transactionDate.isAfter(startDate.subtract(const Duration(seconds: 1))) &&
        transactionDate.isBefore(endDate.add(const Duration(seconds: 1)));
  }).toList();
  
  double totalIncome = 0;
  double totalExpense = 0;
  
  for (final transaction in periodTransactions) {
    if (transaction.isIncome) {
      totalIncome += transaction.amount;
    } else {
      totalExpense += transaction.amount;
    }
  }
  
  return StatisticsSummaryEntity(
    totalIncome: totalIncome,
    totalExpense: totalExpense,
    balance: totalIncome - totalExpense,
    transactionCount: periodTransactions.length,
    startDate: startDate,
    endDate: endDate,
  );
}

/// Provider pour les données du graphique
/// 
/// Watch automatiquement transactionProvider pour se mettre à jour
/// instantanément quand de nouvelles transactions sont créées/modifiées/supprimées
@riverpod
Future<ChartDataEntity> chartDataController(Ref ref) async {
  // Watch le transactionProvider pour se mettre à jour automatiquement
  final transactionState = ref.watch(transactionProvider);
      final period = ref.watch(timePeriodProvider);
      final startDate = ref.watch(currentStartDateProvider);

  // S'assurer que les transactions sont chargées
  if (transactionState is TransactionStateInitial) {
    Future.microtask(() {
      ref.read(transactionProvider.notifier).loadTransactions();
    });
    // Retourner des données vides temporairement
    final DateTime endDate;
    switch (period) {
      case TimePeriod.week:
        endDate = startDate.add(const Duration(days: 7));
        break;
      case TimePeriod.month:
        endDate = DateTime(startDate.year, startDate.month + 1, startDate.day);
        break;
      case TimePeriod.year:
        endDate = DateTime(startDate.year + 1, startDate.month, startDate.day);
        break;
    }
    return ChartDataEntity(
      dailyExpenses: [],
        period: period,
        startDate: startDate,
      endDate: endDate,
      maxExpense: 0,
      totalExpense: 0,
      totalIncome: 0,
    );
  }
  
  // Calculer les données selon la période
  final allTransactions = transactionState.allTransactions;
  
  switch (period) {
    case TimePeriod.week:
      return _buildWeeklyChartData(startDate, allTransactions);
    case TimePeriod.month:
      return _buildMonthlyChartData(startDate, allTransactions);
    case TimePeriod.year:
      return _buildYearlyChartData(startDate, allTransactions);
  }
}

/// Construit les données pour la vue hebdomadaire (7 jours)
ChartDataEntity _buildWeeklyChartData(
  DateTime startDate,
  List<TransactionEntity> allTransactions,
) {
  final endDate = startDate.add(const Duration(days: 7));
  
  // Filtrer les transactions de la semaine
  final periodTransactions = allTransactions.where((transaction) {
    final transactionDate = transaction.date;
    return transactionDate.isAfter(startDate.subtract(const Duration(seconds: 1))) &&
        transactionDate.isBefore(endDate.add(const Duration(seconds: 1)));
  }).toList();
  
  // Grouper les transactions par jour
  final Map<DateTime, List<TransactionEntity>> transactionsByDay = {};
  for (final transaction in periodTransactions) {
    final day = DateTime(
      transaction.date.year,
      transaction.date.month,
      transaction.date.day,
    );
    if (!transactionsByDay.containsKey(day)) {
      transactionsByDay[day] = [];
    }
    transactionsByDay[day]!.add(transaction);
  }
  
  // Créer les DailyExpenseEntity
  final List<DailyExpenseEntity> dailyExpenses = [];
  double maxExpense = 0;
  double totalExpense = 0;
  double totalIncome = 0;
  
  // Générer tous les jours de la semaine (7 jours)
  for (int i = 0; i < 7; i++) {
    final date = startDate.add(Duration(days: i));
    final dayTransactions = transactionsByDay[date] ?? [];
    
    double dayIncome = 0;
    double dayExpense = 0;
    
    for (final transaction in dayTransactions) {
      if (transaction.isIncome) {
        dayIncome += transaction.amount;
        totalIncome += transaction.amount;
      } else {
        dayExpense += transaction.amount;
        totalExpense += transaction.amount;
      }
    }
    
    if (dayExpense > maxExpense) {
      maxExpense = dayExpense;
    }
    
    dailyExpenses.add(DailyExpenseEntity(
      date: date,
      dayOfWeek: date.weekday,
      income: dayIncome,
      expense: dayExpense,
      transactionCount: dayTransactions.length,
    ));
  }
  
  return ChartDataEntity(
    dailyExpenses: dailyExpenses,
    period: TimePeriod.week,
    startDate: startDate,
    endDate: endDate,
    maxExpense: maxExpense,
    totalExpense: totalExpense,
    totalIncome: totalIncome,
  );
}

/// Construit les données pour la vue mensuelle (6 mois)
ChartDataEntity _buildMonthlyChartData(
  DateTime startDate,
  List<TransactionEntity> allTransactions,
) {
  final endDate = DateTime(startDate.year, startDate.month + 6, 1);
  
  // Filtrer les transactions de la période (6 mois)
  final periodTransactions = allTransactions.where((transaction) {
    final transactionDate = transaction.date;
    return transactionDate.isAfter(startDate.subtract(const Duration(seconds: 1))) &&
        transactionDate.isBefore(endDate.add(const Duration(seconds: 1)));
  }).toList();
  
  // Grouper les transactions par mois
  final Map<String, List<TransactionEntity>> transactionsByMonth = {};
  for (final transaction in periodTransactions) {
    final monthKey = '${transaction.date.year}-${transaction.date.month}';
    if (!transactionsByMonth.containsKey(monthKey)) {
      transactionsByMonth[monthKey] = [];
    }
    transactionsByMonth[monthKey]!.add(transaction);
  }
  
  // Créer les DailyExpenseEntity (réutilisé pour représenter des mois)
  final List<DailyExpenseEntity> monthlyExpenses = [];
  double maxExpense = 0;
  double totalExpense = 0;
  double totalIncome = 0;
  
  // Générer les 6 mois
  for (int i = 0; i < 6; i++) {
    final monthDate = DateTime(startDate.year, startDate.month + i, 1);
    final monthKey = '${monthDate.year}-${monthDate.month}';
    final monthTransactions = transactionsByMonth[monthKey] ?? [];
    
    double monthIncome = 0;
    double monthExpense = 0;
    
    for (final transaction in monthTransactions) {
      if (transaction.isIncome) {
        monthIncome += transaction.amount;
        totalIncome += transaction.amount;
      } else {
        monthExpense += transaction.amount;
        totalExpense += transaction.amount;
      }
    }
    
    if (monthExpense > maxExpense) {
      maxExpense = monthExpense;
    }
    
    monthlyExpenses.add(DailyExpenseEntity(
      date: monthDate,
      dayOfWeek: monthDate.month, // Réutilisé pour stocker le numéro du mois
      income: monthIncome,
      expense: monthExpense,
      transactionCount: monthTransactions.length,
    ));
  }
  
  return ChartDataEntity(
    dailyExpenses: monthlyExpenses,
    period: TimePeriod.month,
    startDate: startDate,
    endDate: endDate,
    maxExpense: maxExpense,
    totalExpense: totalExpense,
    totalIncome: totalIncome,
  );
}

/// Construit les données pour la vue annuelle (7 années)
ChartDataEntity _buildYearlyChartData(
  DateTime startDate,
  List<TransactionEntity> allTransactions,
) {
  final endDate = DateTime(startDate.year + 7, 1, 1);
  
  // Filtrer les transactions de la période (7 ans)
  final periodTransactions = allTransactions.where((transaction) {
    final transactionDate = transaction.date;
    return transactionDate.isAfter(startDate.subtract(const Duration(seconds: 1))) &&
        transactionDate.isBefore(endDate.add(const Duration(seconds: 1)));
  }).toList();
  
  // Grouper les transactions par année
  final Map<int, List<TransactionEntity>> transactionsByYear = {};
  for (final transaction in periodTransactions) {
    final year = transaction.date.year;
    if (!transactionsByYear.containsKey(year)) {
      transactionsByYear[year] = [];
    }
    transactionsByYear[year]!.add(transaction);
  }
  
  // Créer les DailyExpenseEntity (réutilisé pour représenter des années)
  final List<DailyExpenseEntity> yearlyExpenses = [];
  double maxExpense = 0;
  double totalExpense = 0;
  double totalIncome = 0;
  
  // Générer les 7 années
  for (int i = 0; i < 7; i++) {
    final year = startDate.year + i;
    final yearDate = DateTime(year, 1, 1);
    final yearTransactions = transactionsByYear[year] ?? [];
    
    double yearIncome = 0;
    double yearExpense = 0;
    
    for (final transaction in yearTransactions) {
      if (transaction.isIncome) {
        yearIncome += transaction.amount;
        totalIncome += transaction.amount;
      } else {
        yearExpense += transaction.amount;
        totalExpense += transaction.amount;
      }
    }
    
    if (yearExpense > maxExpense) {
      maxExpense = yearExpense;
    }
    
    yearlyExpenses.add(DailyExpenseEntity(
      date: yearDate,
      dayOfWeek: year % 10, // Réutilisé pour stocker l'année (dernier chiffre)
      income: yearIncome,
      expense: yearExpense,
      transactionCount: yearTransactions.length,
    ));
  }
  
  return ChartDataEntity(
    dailyExpenses: yearlyExpenses,
    period: TimePeriod.year,
    startDate: startDate,
    endDate: endDate,
    maxExpense: maxExpense,
    totalExpense: totalExpense,
    totalIncome: totalIncome,
  );
}

/// Provider pour les transactions de la période
/// 
/// Watch automatiquement transactionProvider pour se mettre à jour
/// instantanément quand de nouvelles transactions sont créées/modifiées/supprimées
@riverpod
List<TransactionEntity> periodTransactionsController(Ref ref) {
  // Watch le transactionProvider pour se mettre à jour automatiquement
  final transactionState = ref.watch(transactionProvider);
      final period = ref.watch(timePeriodProvider);
      final startDate = ref.watch(currentStartDateProvider);
  
  // S'assurer que les transactions sont chargées
  if (transactionState is TransactionStateInitial) {
    Future.microtask(() {
      ref.read(transactionProvider.notifier).loadTransactions();
    });
    return [];
  }

      // Calculer la date de fin
      final DateTime endDate;
      switch (period) {
        case TimePeriod.week:
          endDate = startDate.add(const Duration(days: 7));
          break;
        case TimePeriod.month:
          endDate = DateTime(
            startDate.year,
            startDate.month + 1,
            startDate.day,
          );
          break;
        case TimePeriod.year:
          endDate = DateTime(
            startDate.year + 1,
            startDate.month,
            startDate.day,
          );
          break;
      }

  // Filtrer les transactions selon la période
  final allTransactions = transactionState.allTransactions;
  return allTransactions.where((transaction) {
    final transactionDate = transaction.date;
    return transactionDate.isAfter(startDate.subtract(const Duration(seconds: 1))) &&
        transactionDate.isBefore(endDate.add(const Duration(seconds: 1)));
  }).toList()
    ..sort((a, b) => b.date.compareTo(a.date)); // Trier par date décroissante
}

/// Provider pour les transactions filtrées par jour sélectionné
@riverpod
List<TransactionEntity> filteredDayTransactions(Ref ref) {
  final selectedDay = ref.watch(selectedDayProvider);
  final allTransactions = ref.watch(periodTransactionsControllerProvider);

      if (selectedDay == null) {
        // Pas de sélection, retourner toutes les transactions
    return allTransactions;
      }

      // Filtrer par jour sélectionné
  return allTransactions.where((transaction) {
        final transactionDate = transaction.date;
        return transactionDate.year == selectedDay.year &&
            transactionDate.month == selectedDay.month &&
            transactionDate.day == selectedDay.day;
      }).toList();
}

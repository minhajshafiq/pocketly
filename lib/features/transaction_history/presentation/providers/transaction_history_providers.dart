import 'package:pocketly/core/config/supabase_config.dart';
import 'package:pocketly/core/services/logger_service.dart';
import 'package:pocketly/features/transaction_history/data/datasources/transaction_history_local_datasource.dart';
import 'package:pocketly/features/transaction_history/data/datasources/transaction_history_remote_datasource.dart';
import 'package:pocketly/features/transaction_history/data/repositories/transaction_history_repository_impl.dart';
import 'package:pocketly/features/transaction_history/domain/entities/calendar_day_entity.dart';
import 'package:pocketly/features/transaction_history/domain/entities/transaction_period_entity.dart';
import 'package:pocketly/features/transaction_history/domain/entities/transaction_summary_entity.dart';
import 'package:pocketly/features/transaction_history/domain/repositories/transaction_history_repository.dart';
import 'package:pocketly/features/transaction_history/domain/usecases/get_calendar_data_usecase.dart';
import 'package:pocketly/features/transaction_history/domain/usecases/get_transaction_summary_usecase.dart';
import 'package:pocketly/features/transaction_history/domain/usecases/get_transactions_by_date_usecase.dart';
import 'package:pocketly/features/transaction_history/domain/usecases/get_transactions_by_period_usecase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pocketly/features/transactions/domain/entities/transaction_entity.dart';
import 'package:pocketly/features/transactions/presentation/providers/transaction_provider.dart';
import 'package:pocketly/features/transactions/presentation/providers/transaction_state.dart';
import 'package:pocketly/features/user/user.dart';

part 'transaction_history_providers.g.dart';

// ==================== DATASOURCES ====================

/// Provider pour SharedPreferences (cache local)
@Riverpod(keepAlive: true)
Future<SharedPreferences> sharedPreferences(Ref ref) async {
  return await SharedPreferences.getInstance();
}

/// Provider pour le datasource remote (Supabase)
@riverpod
TransactionHistoryRemoteDataSource transactionHistoryRemoteDataSource(Ref ref) {
  final supabase = SupabaseConfig.client;
  return TransactionHistoryRemoteDataSource(supabase);
}

/// Provider pour le datasource local (cache SharedPreferences)
@riverpod
Future<TransactionHistoryLocalDataSource> transactionHistoryLocalDataSource(Ref ref) async {
  final prefs = await ref.watch(sharedPreferencesProvider.future);
  return TransactionHistoryLocalDataSource(prefs);
}

// ==================== REPOSITORIES ====================

/// Provider pour le repository
@riverpod
Future<TransactionHistoryRepository> transactionHistoryRepository(Ref ref) async {
  final remoteDataSource = ref.watch(transactionHistoryRemoteDataSourceProvider);
  final localDataSource = await ref.watch(transactionHistoryLocalDataSourceProvider.future);
  final logger = ref.watch(loggerProvider);
  return TransactionHistoryRepositoryImpl(
    remoteDataSource: remoteDataSource,
    localDataSource: localDataSource,
    logger: logger,
  );
}

// ==================== USE CASES ====================

/// Provider pour le use case de récupération par date
@riverpod
Future<GetTransactionsByDateUseCase> getTransactionsByDateUseCase(Ref ref) async {
  final repository = await ref.watch(transactionHistoryRepositoryProvider.future);
  return GetTransactionsByDateUseCase(repository);
}

/// Provider pour le use case de récupération par période
@riverpod
Future<GetTransactionsByPeriodUseCase> getTransactionsByPeriodUseCase(Ref ref) async {
  final repository = await ref.watch(transactionHistoryRepositoryProvider.future);
  return GetTransactionsByPeriodUseCase(repository);
}

/// Provider pour le use case de récupération du calendrier
@riverpod
Future<GetCalendarDataUseCase> getCalendarDataUseCase(Ref ref) async {
  final repository = await ref.watch(transactionHistoryRepositoryProvider.future);
  return GetCalendarDataUseCase(repository);
}

/// Provider pour le use case de résumé
@riverpod
Future<GetTransactionSummaryUseCase> getTransactionSummaryUseCase(Ref ref) async {
  final repository = await ref.watch(transactionHistoryRepositoryProvider.future);
  return GetTransactionSummaryUseCase(repository);
}

/// État pour le contrôleur du calendrier
class CalendarState {
  final int year;
  final int month;
  final DateTime? selectedDate;
  final List<CalendarDayEntity> days;
  final bool isLoading;
  final String? error;

  const CalendarState({
    required this.year,
    required this.month,
    this.selectedDate,
    this.days = const [],
    this.isLoading = false,
    this.error,
  });

  CalendarState copyWith({
    int? year,
    int? month,
    DateTime? selectedDate,
    List<CalendarDayEntity>? days,
    bool? isLoading,
    String? error,
  }) {
    return CalendarState(
      year: year ?? this.year,
      month: month ?? this.month,
      selectedDate: selectedDate ?? this.selectedDate,
      days: days ?? this.days,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

/// Controller pour le calendrier
@riverpod
class CalendarController extends _$CalendarController {
  @override
  CalendarState build() {
    final now = DateTime.now();
    return CalendarState(year: now.year, month: now.month);
  }

  /// Charge les données du calendrier pour le mois actuel
  Future<void> loadCalendarData() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final userAsync = ref.read(currentUserProvider);
      final user = userAsync.value;

      if (user == null) {
        throw Exception('Utilisateur non connecté');
      }

      final useCase = await ref.read(getCalendarDataUseCaseProvider.future);
      final days = await useCase(
        userId: user.id,
        year: state.year,
        month: state.month,
      );

      state = state.copyWith(days: days, isLoading: false);
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  /// Sélectionne un jour
  void selectDay(DateTime date) {
    final updatedDays = state.days.map((day) {
      return day.copyWith(
        isSelected: day.date.year == date.year &&
            day.date.month == date.month &&
            day.date.day == date.day,
      );
    }).toList();

    state = state.copyWith(selectedDate: date, days: updatedDays);
  }

  /// Navigue vers le mois suivant
  Future<void> nextMonth() async {
    int newMonth = state.month + 1;
    int newYear = state.year;

    if (newMonth > 12) {
      newMonth = 1;
      newYear++;
    }

    state = state.copyWith(year: newYear, month: newMonth);
    await loadCalendarData();
  }

  /// Navigue vers le mois précédent
  Future<void> previousMonth() async {
    int newMonth = state.month - 1;
    int newYear = state.year;

    if (newMonth < 1) {
      newMonth = 12;
      newYear--;
    }

    state = state.copyWith(year: newYear, month: newMonth);
    await loadCalendarData();
  }

  /// Retourne au mois actuel
  Future<void> goToToday() async {
    final now = DateTime.now();
    state = state.copyWith(year: now.year, month: now.month);
    await loadCalendarData();
  }

  /// Désélectionne le jour actuellement sélectionné
  void clearDaySelection() {
    final updatedDays = state.days.map((day) {
      return day.copyWith(isSelected: false);
    }).toList();

    state = state.copyWith(selectedDate: null, days: updatedDays);
  }
}

/// Controller pour le filtre de période
@riverpod
class PeriodFilterController extends _$PeriodFilterController {
  @override
  TransactionPeriodEntity build() {
    return TransactionPeriodX.today();
  }

  /// Change la période
  void setPeriod(TransactionPeriodEntity period) {
    state = period;
  }

  /// Sélectionne aujourd'hui
  void selectToday() {
    state = TransactionPeriodX.today();
  }

  /// Sélectionne cette semaine
  void selectThisWeek() {
    state = TransactionPeriodX.thisWeek();
  }

  /// Sélectionne ce mois
  void selectThisMonth() {
    state = TransactionPeriodX.thisMonth();
  }

  /// Sélectionne cette année
  void selectThisYear() {
    state = TransactionPeriodX.thisYear();
  }

  /// Sélectionne une période personnalisée
  void selectCustomPeriod({
    required DateTime startDate,
    required DateTime endDate,
    String? label,
  }) {
    state = TransactionPeriodX.custom(
      startDate: startDate,
      endDate: endDate,
      label: label,
    );
  }
}

/// Provider pour les transactions filtrées par période
///
/// Watch automatiquement transactionProvider pour se mettre à jour
/// instantanément quand de nouvelles transactions sont créées/modifiées/supprimées
///
/// IMPORTANT: Ce provider génère les occurrences des transactions récurrentes
/// pour la période sélectionnée avant de les filtrer
@riverpod
List<TransactionEntity> filteredTransactions(Ref ref) {
  // Watch le transactionProvider pour se mettre à jour automatiquement
  final transactionState = ref.watch(transactionProvider);
  final period = ref.watch(periodFilterControllerProvider);

  // S'assurer que les transactions sont chargées
  if (transactionState is TransactionStateInitial) {
    Future.microtask(() {
      ref.read(transactionProvider.notifier).loadTransactions();
    });
    return [];
  }

  // Récupérer les transactions brutes
  final allTransactions = transactionState.allTransactions;
  final now = DateTime.now();

  // Déterminer les bornes de la période
  DateTime startDate;
  DateTime endDate;

  switch (period.type) {
    case PeriodType.today:
      final today = DateTime(now.year, now.month, now.day);
      startDate = today;
      endDate = DateTime(now.year, now.month, now.day, 23, 59, 59);
      break;

    case PeriodType.week:
      final weekDay = now.weekday;
      final daysFromMonday = weekDay - 1;
      final monday = now.subtract(Duration(days: daysFromMonday));
      startDate = DateTime(monday.year, monday.month, monday.day);
      endDate = startDate.add(const Duration(days: 7));
      break;

    case PeriodType.month:
      startDate = DateTime(now.year, now.month, 1);
      endDate = DateTime(now.year, now.month + 1, 0, 23, 59, 59);
      break;

    case PeriodType.year:
      startDate = DateTime(now.year, 1, 1);
      endDate = DateTime(now.year, 12, 31, 23, 59, 59);
      break;

    case PeriodType.custom:
      startDate = period.startDate;
      endDate = period.endDate;
      break;
  }

  // Séparer les transactions normales et récurrentes
  final normalTransactions = <TransactionEntity>[];
  final recurringTransactions = <TransactionEntity>[];

  for (final transaction in allTransactions) {
    if (transaction.recurrence != RecurrenceType.none && transaction.isRecurrenceActive) {
      recurringTransactions.add(transaction);
    } else {
      // Ajouter seulement si la transaction est dans la période
      if ((transaction.date.isAfter(startDate) || transaction.date.isAtSameMomentAs(startDate)) &&
          transaction.date.isBefore(endDate.add(const Duration(seconds: 1)))) {
        normalTransactions.add(transaction);
      }
    }
  }

  // Générer les occurrences des transactions récurrentes pour la période
  final expandedTransactions = List<TransactionEntity>.from(normalTransactions);

  for (final recurring in recurringTransactions) {
    final occurrences = recurring.getOccurrencesBetween(
      start: startDate,
      end: endDate,
    );

    // Ajouter les occurrences qui n'existent pas déjà
    for (final occurrence in occurrences) {
      final alreadyExists = expandedTransactions.any((t) {
        final sameDate = t.date.year == occurrence.date.year &&
            t.date.month == occurrence.date.month &&
            t.date.day == occurrence.date.day;

        if (!sameDate) return false;

        // Comparer par recurrenceGroupId si disponible
        if (t.recurrenceGroupId != null && occurrence.recurrenceGroupId != null) {
          return t.recurrenceGroupId == occurrence.recurrenceGroupId;
        }

        // Sinon comparer par ID
        return t.id != null && t.id == occurrence.id;
      });

      if (!alreadyExists) {
        expandedTransactions.add(occurrence);
      }
    }
  }

  // Trier par date décroissante
  expandedTransactions.sort((a, b) => b.date.compareTo(a.date));

  return expandedTransactions;
}

/// Provider pour le résumé de la période sélectionnée
@riverpod
Future<TransactionSummaryEntity> periodSummary(
  Ref ref,
) async {
  final period = ref.watch(periodFilterControllerProvider);
  final userAsync = ref.watch(currentUserProvider);
  final user = userAsync.value;

  if (user == null) {
    throw Exception('Utilisateur non connecté');
  }

  final useCase = await ref.watch(getTransactionSummaryUseCaseProvider.future);
  return await useCase(userId: user.id, period: period);
}

/// Provider pour les transactions d'un jour sélectionné
///
/// Watch automatiquement transactionProvider pour se mettre à jour
/// instantanément quand de nouvelles transactions sont créées/modifiées/supprimées
///
/// IMPORTANT: Ce provider génère les occurrences des transactions récurrentes
/// pour le jour sélectionné avant de les filtrer
@riverpod
List<TransactionEntity> selectedDayTransactions(Ref ref) {
  // Watch le transactionProvider pour se mettre à jour automatiquement
  final transactionState = ref.watch(transactionProvider);
  final calendarState = ref.watch(calendarControllerProvider);
  final selectedDate = calendarState.selectedDate;

  if (selectedDate == null) {
    return [];
  }

  // S'assurer que les transactions sont chargées
  if (transactionState is TransactionStateInitial) {
    Future.microtask(() {
      ref.read(transactionProvider.notifier).loadTransactions();
    });
    return [];
  }

  // Récupérer les transactions brutes
  final allTransactions = transactionState.allTransactions;

  // Définir les bornes du jour sélectionné
  final startOfDay = DateTime(selectedDate.year, selectedDate.month, selectedDate.day);
  final endOfDay = DateTime(selectedDate.year, selectedDate.month, selectedDate.day, 23, 59, 59);

  // Séparer les transactions normales et récurrentes
  final normalTransactions = <TransactionEntity>[];
  final recurringTransactions = <TransactionEntity>[];

  for (final transaction in allTransactions) {
    if (transaction.recurrence != RecurrenceType.none && transaction.isRecurrenceActive) {
      recurringTransactions.add(transaction);
    } else {
      // Ajouter seulement si la transaction est le jour sélectionné
      final transactionDate = transaction.date;
      if (transactionDate.year == startOfDay.year &&
          transactionDate.month == startOfDay.month &&
          transactionDate.day == startOfDay.day) {
        normalTransactions.add(transaction);
      }
    }
  }

  // Générer les occurrences des transactions récurrentes pour le jour sélectionné
  final expandedTransactions = List<TransactionEntity>.from(normalTransactions);

  for (final recurring in recurringTransactions) {
    final occurrences = recurring.getOccurrencesBetween(
      start: startOfDay,
      end: endOfDay,
    );

    // Ajouter les occurrences qui n'existent pas déjà
    for (final occurrence in occurrences) {
      final alreadyExists = expandedTransactions.any((t) {
        final sameDate = t.date.year == occurrence.date.year &&
            t.date.month == occurrence.date.month &&
            t.date.day == occurrence.date.day;

        if (!sameDate) return false;

        // Comparer par recurrenceGroupId si disponible
        if (t.recurrenceGroupId != null && occurrence.recurrenceGroupId != null) {
          return t.recurrenceGroupId == occurrence.recurrenceGroupId;
        }

        // Sinon comparer par ID
        return t.id != null && t.id == occurrence.id;
      });

      if (!alreadyExists) {
        expandedTransactions.add(occurrence);
      }
    }
  }

  // Trier par date décroissante
  expandedTransactions.sort((a, b) => b.date.compareTo(a.date));

  return expandedTransactions;
}

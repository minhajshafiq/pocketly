import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:pocketly/core/core.dart';
import '../../domain/entities/transaction_entity.dart';
import '../../domain/repositories/transaction_repository.dart';
import '../../domain/usecases/get_all_transactions_usecase.dart';
import '../../domain/usecases/create_transaction_usecase.dart';
import '../../domain/usecases/update_transaction_usecase.dart';
import '../../domain/usecases/delete_transaction_usecase.dart';
import '../../domain/usecases/get_transactions_by_period_usecase.dart';
import '../../domain/usecases/get_transaction_stats_usecase.dart';
import '../../data/repositories/transaction_repository_impl.dart';
import 'transaction_state.dart';
import 'package:pocketly/features/notifications/notifications.dart';
import 'package:pocketly/features/pockets/pockets.dart' show pocketByIdProvider;

part 'transaction_provider.g.dart';

/// Provider pour SupabaseClient
@riverpod
SupabaseClient supabaseClient(Ref ref) {
  return Supabase.instance.client;
}

/// Provider pour TransactionRepository
@riverpod
TransactionRepository transactionRepository(Ref ref) {
  final supabase = ref.watch(supabaseClientProvider);
  final prefs = ref.watch(sharedPreferencesProvider);

  return TransactionRepositoryImpl(
    supabase: supabase,
    prefs: prefs,
  );
}

/// Provider pour les use cases
@riverpod
GetAllTransactionsUseCase getAllTransactionsUseCase(Ref ref) {
  final repository = ref.watch(transactionRepositoryProvider);
  return GetAllTransactionsUseCase(repository);
}

@riverpod
CreateTransactionUseCase createTransactionUseCase(Ref ref) {
  final repository = ref.watch(transactionRepositoryProvider);
  return CreateTransactionUseCase(repository);
}

@riverpod
UpdateTransactionUseCase updateTransactionUseCase(Ref ref) {
  final repository = ref.watch(transactionRepositoryProvider);
  return UpdateTransactionUseCase(repository);
}

@riverpod
DeleteTransactionUseCase deleteTransactionUseCase(Ref ref) {
  final repository = ref.watch(transactionRepositoryProvider);
  return DeleteTransactionUseCase(repository);
}

@riverpod
GetTransactionsByPeriodUseCase getTransactionsByPeriodUseCase(Ref ref) {
  final repository = ref.watch(transactionRepositoryProvider);
  return GetTransactionsByPeriodUseCase(repository);
}

@riverpod
GetTransactionStatsUseCase getTransactionStatsUseCase(Ref ref) {
  final repository = ref.watch(transactionRepositoryProvider);
  return GetTransactionStatsUseCase(repository);
}

/// Provider pour récupérer les transactions par pocket_id
@riverpod
Future<List<TransactionEntity>> transactionsByPocket(
  Ref ref,
  String pocketId,
) async {
  final repository = ref.watch(transactionRepositoryProvider);
  return await repository.getTransactionsByPocket(pocketId);
}

/// ========================================================================
/// PROVIDER PRINCIPAL - Notifier unifié avec Freezed State
/// ========================================================================
///
/// Ce provider remplace tous les anciens providers et offre :
/// - ✅ Réactivité UI automatique via Freezed
/// - ✅ Mises à jour optimistes
/// - ✅ Gestion d'erreurs robuste
/// - ✅ Support des notifications de budget
///
/// UTILISATION:
/// ```dart
/// // Écouter les changements
/// final state = ref.watch(transactionProvider);
///
/// // Accéder aux transactions
/// final transactions = state.allTransactions;
///
/// // Vérifier l'état
/// if (state.isLoadingState) { ... }
/// if (state.hasError) { ... }
///
/// // Actions
/// ref.read(transactionProvider.notifier).createTransaction(...);
/// ref.read(transactionProvider.notifier).updateTransaction(...);
/// ref.read(transactionProvider.notifier).deleteTransaction(...);
/// ```
/// Notifier unifié pour la gestion réactive des transactions
///
/// Remplace TransactionReactiveNotifier et l'ancien TransactionNotifier
@riverpod
class TransactionNotifier extends _$TransactionNotifier {
  @override
  TransactionState build() => const TransactionState.initial();

  /// Charge toutes les transactions
  Future<void> loadTransactions() async {
    // Préserver les transactions existantes pendant le chargement
    final currentTransactions = state.allTransactions;
    state = TransactionState.loading(transactions: currentTransactions);

    try {
      final useCase = ref.read(getAllTransactionsUseCaseProvider);
      final transactions = await useCase();

      if (kDebugMode) {
        debugPrint('✅ [TransactionNotifier] ${transactions.length} transactions chargées');
      }

      state = TransactionState.loaded(transactions: transactions);
    } catch (e, stackTrace) {
      if (kDebugMode) {
        debugPrint('❌ [TransactionNotifier] Erreur de chargement: $e');
        debugPrint('$stackTrace');
      }
      state = TransactionState.error(
        message: 'Erreur lors du chargement des transactions',
        transactions: currentTransactions,
      );
    }
  }

  /// Rafraîchit les transactions (pull-to-refresh)
  Future<void> refreshTransactions() async {
    // Préserver les transactions pendant le rafraîchissement
    final currentTransactions = state.allTransactions;
    state = TransactionState.refreshing(transactions: currentTransactions);

    try {
      final useCase = ref.read(getAllTransactionsUseCaseProvider);
      final transactions = await useCase();

      if (kDebugMode) {
        debugPrint('🔄 [TransactionNotifier] ${transactions.length} transactions rafraîchies');
      }

      state = TransactionState.loaded(transactions: transactions);
    } catch (e) {
      if (kDebugMode) {
        debugPrint('❌ [TransactionNotifier] Erreur de rafraîchissement: $e');
      }
      state = TransactionState.error(
        message: 'Erreur lors du rafraîchissement',
        transactions: currentTransactions,
      );
    }
  }

  /// Crée une nouvelle transaction
  ///
  /// Met à jour automatiquement l'UI en ajoutant la transaction à la liste.
  /// Vérifie aussi les notifications de budget si applicable.
  Future<void> createTransaction({
    required String name,
    required double amount,
    required DateTime date,
    required String categoryId,
    required TransactionType type,
    RecurrenceType recurrence = RecurrenceType.none,
    String? imageUrl,
    String? notes,
    required String userId,
    DateTime? recurrenceEndDate,
  }) async {
    try {
      if (kDebugMode) {
        debugPrint('🔍 [TransactionNotifier] Création transaction: $name ($amount)');
      }

      final useCase = ref.read(createTransactionUseCaseProvider);
      final newTransaction = await useCase(
        name: name,
        amount: amount,
        date: date,
        categoryId: categoryId,
        type: type,
        recurrence: recurrence,
        imageUrl: imageUrl,
        notes: notes,
        userId: userId,
        recurrenceEndDate: recurrenceEndDate,
      );

      // Mise à jour optimiste: ajouter immédiatement à la liste
      final updatedTransactions = [newTransaction, ...state.allTransactions];
      state = TransactionState.loaded(transactions: updatedTransactions);

      if (kDebugMode) {
        debugPrint(
            '✅ [TransactionNotifier] Transaction créée: ${newTransaction.id}');
        debugPrint(
            '✅ [TransactionNotifier] Total transactions: ${updatedTransactions.length}');
      }

      // ✨ VÉRIFICATION DES NOTIFICATIONS DE BUDGET
      if (newTransaction.pocketId != null &&
          newTransaction.type == TransactionType.expense) {
        _checkBudgetNotifications(newTransaction.pocketId!);
      }
    } catch (e, stackTrace) {
      if (kDebugMode) {
        debugPrint('❌ [TransactionNotifier] Erreur création: $e');
        debugPrint('$stackTrace');
      }
      state = TransactionState.error(
        message: 'Erreur lors de la création de la transaction',
        transactions: state.allTransactions,
      );
      rethrow;
    }
  }

  /// Met à jour une transaction existante
  ///
  /// Met à jour automatiquement l'UI en modifiant la transaction dans la liste.
  Future<void> updateTransaction(TransactionEntity transaction) async {
    // Sauvegarder pour rollback en cas d'échec
    final previousTransactions = state.allTransactions;

    try {
      if (kDebugMode) {
        debugPrint('🔍 [TransactionNotifier] Mise à jour transaction: ${transaction.id}');
      }

      // Mise à jour optimiste
      final optimisticTransactions = state.allTransactions.map((t) {
        return t.id == transaction.id ? transaction : t;
      }).toList();

      state = TransactionState.loaded(transactions: optimisticTransactions);

      // Appeler l'API
      final useCase = ref.read(updateTransactionUseCaseProvider);
      final updatedTransaction = await useCase(transaction);

      // Mise à jour finale avec les données du serveur
      final finalTransactions = state.allTransactions.map((t) {
        return t.id == updatedTransaction.id ? updatedTransaction : t;
      }).toList();

      state = TransactionState.loaded(transactions: finalTransactions);

      if (kDebugMode) {
        debugPrint('✅ [TransactionNotifier] Transaction mise à jour');
      }
    } catch (e, stackTrace) {
      if (kDebugMode) {
        debugPrint('❌ [TransactionNotifier] Erreur mise à jour: $e');
        debugPrint('$stackTrace');
      }
      // Rollback
      state = TransactionState.error(
        message: 'Erreur lors de la mise à jour de la transaction',
        transactions: previousTransactions,
      );
      rethrow;
    }
  }

  /// Supprime une transaction
  ///
  /// Met à jour automatiquement l'UI en retirant la transaction de la liste.
  Future<void> deleteTransaction(String id) async {
    // Sauvegarder pour rollback en cas d'échec
    final previousTransactions = state.allTransactions;

    try {
      if (kDebugMode) {
        debugPrint('🔍 [TransactionNotifier] Suppression transaction: $id');
      }

      // Mise à jour optimiste: retirer immédiatement de la liste
      final updatedTransactions = state.allTransactions
          .where((transaction) => transaction.id != id)
          .toList();

      state = TransactionState.loaded(transactions: updatedTransactions);

      // Appeler l'API
      final useCase = ref.read(deleteTransactionUseCaseProvider);
      await useCase(id);

      if (kDebugMode) {
        debugPrint('✅ [TransactionNotifier] Transaction supprimée');
        debugPrint('✅ [TransactionNotifier] Total transactions: ${updatedTransactions.length}');
      }
    } catch (e, stackTrace) {
      if (kDebugMode) {
        debugPrint('❌ [TransactionNotifier] Erreur suppression: $e');
        debugPrint('$stackTrace');
      }
      // Rollback en cas d'erreur
      state = TransactionState.error(
        message: 'Erreur lors de la suppression de la transaction',
        transactions: previousTransactions,
      );
      rethrow;
    }
  }

  /// Vérifie et envoie les notifications de budget si nécessaire
  Future<void> _checkBudgetNotifications(String pocketId) async {
    try {
      // Récupérer le pocket
      final pocket = await ref.read(pocketByIdProvider(pocketId).future);
      if (pocket == null || pocket.id == null) return;

      // Récupérer les préférences de notification
      final preferences =
          await ref.read(notificationPreferencesProvider.future);
      if (preferences == null || !preferences.budgetExceededEnabled) return;

      // Récupérer le service de surveillance de budget
      final budgetMonitor = ref.read(budgetMonitorProvider);

      // Vérifier l'alerte à 80% du budget
      await budgetMonitor.checkBudgetWarning(
        pocketId: pocket.id!,
        pocketName: pocket.name,
        budget: pocket.budget,
        currentAmount: pocket.spent,
        preferences: preferences,
      );

      // Vérifier le dépassement de budget
      await budgetMonitor.checkBudgetExceeded(
        pocketId: pocket.id!,
        pocketName: pocket.name,
        budget: pocket.budget,
        currentAmount: pocket.spent,
        preferences: preferences,
      );
    } catch (e) {
      // Ne pas faire échouer la création de transaction si les notifications échouent
      if (kDebugMode) {
        debugPrint(
            '⚠️ [TransactionNotifier] Erreur vérification budget: $e');
      }
    }
  }

  /// Efface l'erreur actuelle
  void clearError() {
    if (state.hasError) {
      state = TransactionState.loaded(transactions: state.allTransactions);
    }
  }

  /// Recherche des transactions par terme
  List<TransactionEntity> searchTransactions(String query) {
    if (query.isEmpty) return state.allTransactions;

    final lowerQuery = query.toLowerCase();
    return state.allTransactions.where((transaction) {
      return transaction.name.toLowerCase().contains(lowerQuery) ||
          (transaction.notes?.toLowerCase().contains(lowerQuery) ?? false);
    }).toList();
  }

  /// Filtre les transactions par catégorie
  List<TransactionEntity> filterByCategory(String categoryId) {
    return state.allTransactions
        .where((transaction) => transaction.categoryId == categoryId)
        .toList();
  }

  /// Filtre les transactions par plage de dates
  List<TransactionEntity> filterByDateRange(DateTime start, DateTime end) {
    return state.allTransactions.where((transaction) {
      return transaction.date.isAfter(start) &&
          transaction.date.isBefore(end);
    }).toList();
  }
}

/// ========================================================================
/// PROVIDERS DÉRIVÉS - Pour des accès spécifiques aux données
/// ========================================================================

/// Provider pour les transactions filtrées par type
@riverpod
List<TransactionEntity> transactionsByType(Ref ref, TransactionType type) {
  final state = ref.watch(transactionProvider);
  return state.allTransactions.where((t) => t.type == type).toList();
}

/// Provider pour les transactions par catégorie
@riverpod
List<TransactionEntity> transactionsByCategory(Ref ref, String categoryId) {
  final state = ref.watch(transactionProvider);
  return state.allTransactions.where((t) => t.categoryId == categoryId).toList();
}

/// Provider pour les transactions récurrentes
@riverpod
List<TransactionEntity> recurringTransactions(Ref ref) {
  final state = ref.watch(transactionProvider);
  return state.allTransactions.where((t) => t.isRecurring).toList();
}

/// Provider pour les transactions d'un mois
@riverpod
List<TransactionEntity> transactionsForMonth(
  Ref ref,
  ({int year, int month}) period,
) {
  final state = ref.watch(transactionProvider);
  return state.allTransactions.where((t) {
    return t.date.year == period.year && t.date.month == period.month;
  }).toList();
}

/// Provider pour les statistiques des transactions
@riverpod
TransactionStats transactionStats(Ref ref) {
  final state = ref.watch(transactionProvider);
  return TransactionStats.fromTransactions(state.allTransactions);
}


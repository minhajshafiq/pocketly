import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocketly/core/core.dart';
import 'package:pocketly/features/transactions/data/datasources/transaction_local_datasource.dart';
import 'package:pocketly/features/category/data/datasources/category_local_datasource.dart';
import 'package:pocketly/features/pockets/data/datasources/pocket_local_datasource.dart';
import 'package:pocketly/features/onboarding/data/datasources/onboarding_local_datasource.dart';
import 'package:pocketly/features/user/data/datasources/user_local_datasource_impl.dart';
import 'package:pocketly/features/transaction_history/data/datasources/transaction_history_local_datasource.dart';
import 'package:pocketly/features/statistics/data/datasources/statistics_local_datasource.dart';

/// Service centralisé pour nettoyer toutes les données locales
///
/// Ce service est utilisé lors de la déconnexion ou de la suppression de compte
/// pour garantir que toutes les données locales sont supprimées.
class LocalDataService {
  final Ref _ref;
  final LoggerService _logger = LoggerService();

  LocalDataService(this._ref);

  /// Nettoie toutes les données locales pour un utilisateur
  ///
  /// [userId] - L'ID de l'utilisateur dont les données doivent être supprimées
  /// Si null, nettoie toutes les données (pour la déconnexion)
  Future<void> clearAllLocalData({String? userId}) async {
    try {
      if (kDebugMode) {
        _logger.i('[LocalDataService] Début du nettoyage des données locales${userId != null ? " pour userId: $userId" : ""}');
      }

      // Récupérer SharedPreferences
      final prefs = _ref.read(sharedPreferencesProvider);

      // 1. Nettoyer les transactions
      try {
        final transactionLocalDataSource = TransactionLocalDataSource(prefs: prefs);
        await transactionLocalDataSource.clearCache();
        if (kDebugMode) {
          _logger.d('[LocalDataService] Cache transactions nettoyé');
        }
      } catch (e) {
        if (kDebugMode) {
          _logger.w('[LocalDataService] Erreur nettoyage transactions: $e');
        }
      }

      // 2. Nettoyer les catégories
      try {
        final categoryLocalDataSource = CategoryLocalDataSource(prefs: prefs);
        await categoryLocalDataSource.clearCache();
        if (kDebugMode) {
          _logger.d('[LocalDataService] Cache catégories nettoyé');
        }
      } catch (e) {
        if (kDebugMode) {
          _logger.w('[LocalDataService] Erreur nettoyage catégories: $e');
        }
      }

      // 3. Nettoyer les pockets
      try {
        final pocketLocalDataSource = PocketLocalDataSource(prefs);
        if (userId != null) {
          await pocketLocalDataSource.clearCache(userId);
        } else {
          await pocketLocalDataSource.clearAllCache();
        }
        if (kDebugMode) {
          _logger.d('[LocalDataService] Cache pockets nettoyé');
        }
      } catch (e) {
        if (kDebugMode) {
          _logger.w('[LocalDataService] Erreur nettoyage pockets: $e');
        }
      }

      // 4. Nettoyer l'historique des transactions
      if (userId != null) {
        try {
          final transactionHistoryLocalDataSource = TransactionHistoryLocalDataSource(prefs);
          await transactionHistoryLocalDataSource.clearAllCache(userId);
          if (kDebugMode) {
            _logger.d('[LocalDataService] Cache transaction history nettoyé');
          }
        } catch (e) {
          if (kDebugMode) {
            _logger.w('[LocalDataService] Erreur nettoyage transaction history: $e');
          }
        }
      }

      // 5. Nettoyer les statistiques
      if (userId != null) {
        try {
          final statisticsLocalDataSource = StatisticsLocalDataSource(prefs);
          await statisticsLocalDataSource.clearAllCache(userId);
          if (kDebugMode) {
            _logger.d('[LocalDataService] Cache statistics nettoyé');
          }
        } catch (e) {
          if (kDebugMode) {
            _logger.w('[LocalDataService] Erreur nettoyage statistics: $e');
          }
        }
      }

      // 6. Nettoyer l'état d'onboarding
      try {
        final onboardingLocalDataSource = OnboardingLocalDataSourceImpl(prefs);
        await onboardingLocalDataSource.clearOnboardingState();
        if (kDebugMode) {
          _logger.d('[LocalDataService] État onboarding nettoyé');
        }
      } catch (e) {
        if (kDebugMode) {
          _logger.w('[LocalDataService] Erreur nettoyage onboarding: $e');
        }
      }

      // 7. Nettoyer les données utilisateur (SecureStorage)
      try {
        final secureStorage = _ref.read(secureStorageProvider);
        final userLocalDataSource = UserLocalDataSourceImpl(secureStorage);
        await userLocalDataSource.clearCurrentUser();
        await userLocalDataSource.clearPushToken();
        if (kDebugMode) {
          _logger.d('[LocalDataService] Données utilisateur nettoyées');
        }
      } catch (e) {
        if (kDebugMode) {
          _logger.w('[LocalDataService] Erreur nettoyage utilisateur: $e');
        }
      }

      if (kDebugMode) {
        _logger.i('[LocalDataService] Nettoyage des données locales terminé');
      }
    } catch (e, stackTrace) {
      _logger.e(
        '[LocalDataService] Erreur lors du nettoyage des données locales',
        error: e,
        stackTrace: stackTrace,
      );
      // Ne pas rethrow - continuer même en cas d'erreur partielle
    }
  }
}


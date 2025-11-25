import 'package:pocketly/core/errors/common_errors.dart';
import 'package:pocketly/features/pockets/data/datasources/pocket_local_datasource.dart';
import 'package:pocketly/features/pockets/data/datasources/pocket_remote_datasource.dart';
import 'package:pocketly/features/pockets/data/models/pocket_model.dart';
import 'package:pocketly/features/pockets/domain/entities/pocket_entity.dart';
import 'package:pocketly/features/pockets/domain/repositories/pocket_repository.dart';

/// Implémentation du repository Pocket
///
/// Coordonne les opérations entre le datasource remote (Supabase)
/// et le datasource local (cache SharedPreferences).
class PocketRepositoryImpl implements PocketRepository {
  final PocketRemoteDataSource _remoteDataSource;
  final PocketLocalDataSource _localDataSource;

  PocketRepositoryImpl({
    required PocketRemoteDataSource remoteDataSource,
    required PocketLocalDataSource localDataSource,
  })  : _remoteDataSource = remoteDataSource,
        _localDataSource = localDataSource;

  // =====================================================
  // 📋 CRUD OPERATIONS
  // =====================================================

  @override
  Future<List<PocketEntity>> getAllPockets(String userId) async {
    try {
      // Essayer de récupérer depuis le cache d'abord
      final cachedModels = await _localDataSource.getCachedPockets(userId);
      if (cachedModels != null) {
        return cachedModels.toEntities();
      }

      // Si pas de cache, récupérer depuis le remote
      final remoteModels = await _remoteDataSource.getAllPockets(userId);

      // Mettre en cache
      await _localDataSource.cachePockets(userId, remoteModels);

      return remoteModels.toEntities();
    } on NetworkError {
      // En cas d'erreur réseau, essayer de retourner le cache même expiré
      final cachedModels = await _localDataSource.getCachedPockets(userId);
      if (cachedModels != null) {
        return cachedModels.toEntities();
      }
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<PocketEntity>> getPocketsByCategory({
    required String userId,
    required PocketCategory category,
  }) async {
    try {
      // Essayer de récupérer depuis le cache d'abord
      final categoryString = _categoryToString(category);
      final cachedModels =
          await _localDataSource.getCachedPocketsByCategory(
        userId: userId,
        category: categoryString,
      );

      if (cachedModels != null) {
        return cachedModels.toEntities();
      }

      // Si pas de cache, récupérer depuis le remote
      final remoteModels = await _remoteDataSource.getPocketsByCategory(
        userId: userId,
        category: categoryString,
      );

      // Note: Le cache complet est mis à jour par getAllPockets
      // On ne cache pas les résultats partiels ici

      return remoteModels.toEntities();
    } on NetworkError {
      // En cas d'erreur réseau, essayer de retourner le cache même expiré
      final categoryString = _categoryToString(category);
      final cachedModels =
          await _localDataSource.getCachedPocketsByCategory(
        userId: userId,
        category: categoryString,
      );

      if (cachedModels != null) {
        return cachedModels.toEntities();
      }
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<PocketEntity?> getPocketById(String pocketId) async {
    try {
      final remoteModel = await _remoteDataSource.getPocketById(pocketId);
      return remoteModel?.toEntity();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<PocketEntity> createPocket(PocketEntity pocket) async {
    try {
      // Validation
      final errors = pocket.validate(null);
      if (errors.isNotEmpty) {
        throw ValidationError(
          field: 'pocket',
          technicalMessage: 'Pocket validation failed: ${errors.join(', ')}',
          userMessage: errors.first,
        );
      }

      // Créer le pocket
      final model = pocket.toModel();
      final createdModel = await _remoteDataSource.createPocket(model);

      // Mettre à jour le cache
      await _localDataSource.updateCachedPocket(
        userId: pocket.userId,
        pocket: createdModel,
      );

      return createdModel.toEntity();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<PocketEntity> updatePocket(PocketEntity pocket) async {
    try {
      if (pocket.id == null) {
        throw ValidationError(
          field: 'id',
          technicalMessage: 'Cannot update pocket without an ID',
          userMessage: 'Invalid pocket',
        );
      }

      // Validation
      final errors = pocket.validate(null);
      if (errors.isNotEmpty) {
        throw ValidationError(
          field: 'pocket',
          technicalMessage: 'Pocket validation failed: ${errors.join(', ')}',
          userMessage: errors.first,
        );
      }

      // Mettre à jour le pocket
      final model = pocket.toModel();
      final updatedModel = await _remoteDataSource.updatePocket(model);

      // Mettre à jour le cache
      await _localDataSource.updateCachedPocket(
        userId: pocket.userId,
        pocket: updatedModel,
      );

      return updatedModel.toEntity();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deletePocket(String pocketId) async {
    try {
      // Récupérer le pocket pour obtenir l'userId
      final pocket = await getPocketById(pocketId);
      if (pocket == null) {
        throw NotFoundError(
          resourceType: 'Pocket',
          technicalMessage: 'Pocket not found: $pocketId',
          userMessage: 'Pocket not found',
        );
      }

      // Supprimer le pocket
      await _remoteDataSource.deletePocket(pocketId);

      // Mettre à jour le cache
      await _localDataSource.removeCachedPocket(
        userId: pocket.userId,
        pocketId: pocketId,
      );
    } catch (e) {
      rethrow;
    }
  }

  // =====================================================
  // 🔄 ÉTAT ET ACTIVATION
  // =====================================================

  @override
  Future<PocketEntity> activatePocket(String pocketId) async {
    try {
      final model = await _remoteDataSource.activatePocket(pocketId);

      // Mettre à jour le cache
      await _localDataSource.updateCachedPocket(
        userId: model.userId,
        pocket: model,
      );

      return model.toEntity();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<PocketEntity> deactivatePocket(String pocketId) async {
    try {
      final model = await _remoteDataSource.deactivatePocket(pocketId);

      // Mettre à jour le cache
      await _localDataSource.updateCachedPocket(
        userId: model.userId,
        pocket: model,
      );

      return model.toEntity();
    } catch (e) {
      rethrow;
    }
  }

  // =====================================================
  // 💰 GESTION DES MONTANTS (NEEDS & WANTS)
  // =====================================================

  @override
  Future<PocketEntity> updateSpentAmount({
    required String pocketId,
    required double amount,
  }) async {
    try {
      if (amount < 0) {
        throw ValidationError(
          field: 'amount',
          technicalMessage: 'Amount cannot be negative',
          userMessage: 'Amount cannot be negative',
        );
      }

      final model = await _remoteDataSource.updateSpentAmount(
        pocketId: pocketId,
        amount: amount,
      );

      // Mettre à jour le cache
      await _localDataSource.updateCachedPocket(
        userId: model.userId,
        pocket: model,
      );

      return model.toEntity();
    } catch (e) {
      rethrow;
    }
  }

  // =====================================================
  // 🏦 GESTION DE L'ÉPARGNE (SAVINGS)
  // =====================================================

  @override
  Future<PocketEntity> addToSavings({
    required String pocketId,
    required double amount,
  }) async {
    try {
      if (amount <= 0) {
        throw ValidationError(
          field: 'amount',
          technicalMessage: 'Amount must be positive',
          userMessage: 'Amount must be positive',
        );
      }

      final model = await _remoteDataSource.addToSavings(
        pocketId: pocketId,
        amount: amount,
      );

      // Mettre à jour le cache
      await _localDataSource.updateCachedPocket(
        userId: model.userId,
        pocket: model,
      );

      return model.toEntity();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<PocketEntity> withdrawFromSavings({
    required String pocketId,
    required double amount,
  }) async {
    try {
      if (amount <= 0) {
        throw ValidationError(
          field: 'amount',
          technicalMessage: 'Amount must be positive',
          userMessage: 'Amount must be positive',
        );
      }

      final model = await _remoteDataSource.withdrawFromSavings(
        pocketId: pocketId,
        amount: amount,
      );

      // Mettre à jour le cache
      await _localDataSource.updateCachedPocket(
        userId: model.userId,
        pocket: model,
      );

      return model.toEntity();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<PocketEntity> setMonthlySavings({
    required String pocketId,
    double? amount,
  }) async {
    try {
      if (amount != null && amount < 0) {
        throw ValidationError(
          field: 'amount',
          technicalMessage: 'Amount cannot be negative',
          userMessage: 'Amount cannot be negative',
        );
      }

      final model = await _remoteDataSource.setMonthlySavings(
        pocketId: pocketId,
        amount: amount,
      );

      // Mettre à jour le cache
      await _localDataSource.updateCachedPocket(
        userId: model.userId,
        pocket: model,
      );

      return model.toEntity();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<PocketEntity>> applyMonthlySavings(String userId) async {
    try {
      final models = await _remoteDataSource.applyMonthlySavings(userId);

      // Mettre à jour le cache avec tous les pockets mis à jour
      for (final model in models) {
        await _localDataSource.updateCachedPocket(
          userId: userId,
          pocket: model,
        );
      }

      return models.toEntities();
    } catch (e) {
      rethrow;
    }
  }

  // =====================================================
  // 🎯 POCKETS PAR DÉFAUT
  // =====================================================

  @override
  Future<List<PocketEntity>> createDefaultPockets(String userId) async {
    try {
      final models = await _remoteDataSource.createDefaultPockets(userId);

      // Mettre en cache
      await _localDataSource.cachePockets(userId, models);

      return models.toEntities();
    } catch (e) {
      rethrow;
    }
  }

  // =====================================================
  // 📊 STATISTIQUES ET RÉSUMÉS
  // =====================================================

  @override
  Future<Map<PocketCategory, PocketSummary>> getPocketSummary(
      String userId) async {
    try {
      // Récupérer tous les pockets
      final pockets = await getAllPockets(userId);

      // Calculer les résumés par catégorie
      final summary = <PocketCategory, PocketSummary>{};

      for (final category in PocketCategory.values) {
        final categoryPockets = pockets.byCategory(category);

        summary[category] = PocketSummary(
          pocketCount: categoryPockets.length,
          activeCount: categoryPockets.activeOnly.length,
          totalBudget: categoryPockets.totalBudget,
          totalSpent: categoryPockets.totalSpent,
          totalSaved: categoryPockets.totalSaved,
          totalTarget: categoryPockets.fold(
            0.0,
            (sum, p) => sum + (p.targetAmount ?? 0.0),
          ),
        );
      }

      return summary;
    } catch (e) {
      rethrow;
    }
  }

  // =====================================================
  // 🔧 HELPER METHODS
  // =====================================================

  /// Convertit PocketCategory en string
  String _categoryToString(PocketCategory category) {
    return switch (category) {
      PocketCategory.needs => 'needs',
      PocketCategory.wants => 'wants',
      PocketCategory.savings => 'savings',
    };
  }
}

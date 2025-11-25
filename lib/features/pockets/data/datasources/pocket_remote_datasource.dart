import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:pocketly/core/config/supabase_config.dart';
import 'package:pocketly/core/errors/common_errors.dart';
import 'package:pocketly/features/pockets/data/models/pocket_model.dart';

/// Remote data source pour les pockets (Supabase)
///
/// Gère toutes les opérations CRUD avec la base de données Supabase.
class PocketRemoteDataSource {
  final SupabaseClient _client;

  PocketRemoteDataSource({SupabaseClient? client})
      : _client = client ?? SupabaseConfig.client;

  static const String _tableName = 'pockets';

  // =====================================================
  // 📋 CRUD OPERATIONS
  // =====================================================

  /// Récupère tous les pockets d'un utilisateur
  Future<List<PocketModel>> getAllPockets(String userId) async {
    try {
      final response = await _client
          .from(_tableName)
          .select()
          .eq('user_id', userId)
          .order('category')
          .order('name');

      final pockets = (response as List<dynamic>)
          .map((json) => PocketModel.fromJson(json as Map<String, dynamic>))
          .toList();

      return pockets;
    } on PostgrestException catch (e) {
      throw ServerError(
        technicalMessage: 'Supabase error while fetching pockets: ${e.message}',
        userMessage: 'Failed to load pockets',
      );
    } catch (e) {
      throw NetworkError(
        technicalMessage: 'Network error while fetching pockets: $e',
        userMessage: 'Please check your internet connection',
      );
    }
  }

  /// Récupère les pockets d'une catégorie spécifique
  Future<List<PocketModel>> getPocketsByCategory({
    required String userId,
    required String category,
  }) async {
    try {
      final response = await _client
          .from(_tableName)
          .select()
          .eq('user_id', userId)
          .eq('category', category)
          .order('name');

      final pockets = (response as List<dynamic>)
          .map((json) => PocketModel.fromJson(json as Map<String, dynamic>))
          .toList();

      return pockets;
    } on PostgrestException catch (e) {
      throw ServerError(
        technicalMessage:
            'Supabase error while fetching pockets by category: ${e.message}',
        userMessage: 'Failed to load pockets',
      );
    } catch (e) {
      throw NetworkError(
        technicalMessage: 'Network error while fetching pockets by category: $e',
        userMessage: 'Please check your internet connection',
      );
    }
  }

  /// Récupère un pocket par son ID
  Future<PocketModel?> getPocketById(String pocketId) async {
    try {
      final response = await _client
          .from(_tableName)
          .select()
          .eq('id', pocketId)
          .maybeSingle();

      if (response == null) return null;

      return PocketModel.fromJson(response);
    } on PostgrestException catch (e) {
      throw ServerError(
        technicalMessage: 'Supabase error while fetching pocket: ${e.message}',
        userMessage: 'Failed to load pocket',
      );
    } catch (e) {
      throw NetworkError(
        technicalMessage: 'Network error while fetching pocket: $e',
        userMessage: 'Please check your internet connection',
      );
    }
  }

  /// Crée un nouveau pocket
  Future<PocketModel> createPocket(PocketModel pocket) async {
    try {
      final json = pocket.toJson();
      // Supprimer les champs générés automatiquement
      json.remove('id');
      json.remove('created_at');
      json.remove('updated_at');

      final response = await _client
          .from(_tableName)
          .insert(json)
          .select()
          .single();

      return PocketModel.fromJson(response);
    } on PostgrestException catch (e) {
      if (e.code == '23505') {
        // Duplicate key violation
        throw ValidationError(
          field: 'name',
          technicalMessage: 'A pocket with this name already exists',
          userMessage: 'A pocket with this name already exists',
        );
      }

      throw ServerError(
        technicalMessage: 'Supabase error while creating pocket: ${e.message}',
        userMessage: 'Failed to create pocket',
      );
    } catch (e) {
      throw NetworkError(
        technicalMessage: 'Network error while creating pocket: $e',
        userMessage: 'Please check your internet connection',
      );
    }
  }

  /// Met à jour un pocket existant
  Future<PocketModel> updatePocket(PocketModel pocket) async {
    try {
      if (pocket.id == null) {
        throw ValidationError(
          field: 'id',
          technicalMessage: 'Cannot update pocket without an ID',
          userMessage: 'Invalid pocket',
        );
      }

      final json = pocket.toJson();
      // Supprimer les champs non modifiables
      json.remove('id');
      json.remove('user_id');
      json.remove('created_at');
      // updated_at sera mis à jour automatiquement par le trigger

      final response = await _client
          .from(_tableName)
          .update(json)
          .eq('id', pocket.id!)
          .select()
          .single();

      return PocketModel.fromJson(response);
    } on PostgrestException catch (e) {
      if (e.code == '23505') {
        throw ValidationError(
          field: 'name',
          technicalMessage: 'A pocket with this name already exists',
          userMessage: 'A pocket with this name already exists',
        );
      }

      throw ServerError(
        technicalMessage: 'Supabase error while updating pocket: ${e.message}',
        userMessage: 'Failed to update pocket',
      );
    } catch (e) {
      throw NetworkError(
        technicalMessage: 'Network error while updating pocket: $e',
        userMessage: 'Please check your internet connection',
      );
    }
  }

  /// Supprime un pocket
  Future<void> deletePocket(String pocketId) async {
    try {
      await _client.from(_tableName).delete().eq('id', pocketId);
    } on PostgrestException catch (e) {
      if (e.code == '23503') {
        // Foreign key violation
        throw ValidationError(
          field: 'pocket_id',
          technicalMessage: 'Cannot delete pocket with linked transactions',
          userMessage:
              'This pocket has transactions linked to it and cannot be deleted',
        );
      }

      throw ServerError(
        technicalMessage: 'Supabase error while deleting pocket: ${e.message}',
        userMessage: 'Failed to delete pocket',
      );
    } catch (e) {
      throw NetworkError(
        technicalMessage: 'Network error while deleting pocket: $e',
        userMessage: 'Please check your internet connection',
      );
    }
  }

  // =====================================================
  // 🔄 ÉTAT ET ACTIVATION
  // =====================================================

  /// Active un pocket
  Future<PocketModel> activatePocket(String pocketId) async {
    return _updatePocketStatus(pocketId, isActive: true);
  }

  /// Désactive un pocket
  Future<PocketModel> deactivatePocket(String pocketId) async {
    return _updatePocketStatus(pocketId, isActive: false);
  }

  /// Met à jour le statut d'un pocket
  Future<PocketModel> _updatePocketStatus(
    String pocketId, {
    required bool isActive,
  }) async {
    try {
      final response = await _client
          .from(_tableName)
          .update({'is_active': isActive})
          .eq('id', pocketId)
          .select()
          .single();

      return PocketModel.fromJson(response);
    } on PostgrestException catch (e) {
      throw ServerError(
        technicalMessage:
            'Supabase error while updating pocket status: ${e.message}',
        userMessage: 'Failed to update pocket status',
      );
    } catch (e) {
      throw NetworkError(
        technicalMessage: 'Network error while updating pocket status: $e',
        userMessage: 'Please check your internet connection',
      );
    }
  }

  // =====================================================
  // 💰 GESTION DES MONTANTS
  // =====================================================

  /// Met à jour le montant dépensé
  Future<PocketModel> updateSpentAmount({
    required String pocketId,
    required double amount,
  }) async {
    try {
      final response = await _client
          .from(_tableName)
          .update({'spent': amount})
          .eq('id', pocketId)
          .select()
          .single();

      return PocketModel.fromJson(response);
    } on PostgrestException catch (e) {
      throw ServerError(
        technicalMessage:
            'Supabase error while updating spent amount: ${e.message}',
        userMessage: 'Failed to update spent amount',
      );
    } catch (e) {
      throw NetworkError(
        technicalMessage: 'Network error while updating spent amount: $e',
        userMessage: 'Please check your internet connection',
      );
    }
  }

  /// Ajoute un montant à l'épargne
  Future<PocketModel> addToSavings({
    required String pocketId,
    required double amount,
  }) async {
    try {
      // Récupérer le pocket actuel
      final pocket = await getPocketById(pocketId);
      if (pocket == null) {
        throw NotFoundError(
          resourceType: 'Pocket',
          technicalMessage: 'Pocket not found: $pocketId',
          userMessage: 'Pocket not found',
        );
      }

      final newAmount = pocket.savedAmount + amount;

      final response = await _client
          .from(_tableName)
          .update({'saved_amount': newAmount})
          .eq('id', pocketId)
          .select()
          .single();

      return PocketModel.fromJson(response);
    } on PostgrestException catch (e) {
      throw ServerError(
        technicalMessage: 'Supabase error while adding to savings: ${e.message}',
        userMessage: 'Failed to add to savings',
      );
    } catch (e) {
      throw NetworkError(
        technicalMessage: 'Network error while adding to savings: $e',
        userMessage: 'Please check your internet connection',
      );
    }
  }

  /// Retire un montant de l'épargne
  Future<PocketModel> withdrawFromSavings({
    required String pocketId,
    required double amount,
  }) async {
    try {
      // Récupérer le pocket actuel
      final pocket = await getPocketById(pocketId);
      if (pocket == null) {
        throw NotFoundError(
          resourceType: 'Pocket',
          technicalMessage: 'Pocket not found: $pocketId',
          userMessage: 'Pocket not found',
        );
      }

      if (pocket.savedAmount < amount) {
        throw ValidationError(
          field: 'amount',
          technicalMessage:
              'Cannot withdraw more than saved amount (saved: ${pocket.savedAmount}, withdraw: $amount)',
          userMessage: 'Insufficient savings',
        );
      }

      final newAmount = pocket.savedAmount - amount;

      final response = await _client
          .from(_tableName)
          .update({'saved_amount': newAmount})
          .eq('id', pocketId)
          .select()
          .single();

      return PocketModel.fromJson(response);
    } on PostgrestException catch (e) {
      throw ServerError(
        technicalMessage:
            'Supabase error while withdrawing from savings: ${e.message}',
        userMessage: 'Failed to withdraw from savings',
      );
    } catch (e) {
      throw NetworkError(
        technicalMessage: 'Network error while withdrawing from savings: $e',
        userMessage: 'Please check your internet connection',
      );
    }
  }

  /// Définit le montant d'épargne mensuelle
  Future<PocketModel> setMonthlySavings({
    required String pocketId,
    double? amount,
  }) async {
    try {
      final response = await _client
          .from(_tableName)
          .update({'monthly_savings_amount': amount})
          .eq('id', pocketId)
          .select()
          .single();

      return PocketModel.fromJson(response);
    } on PostgrestException catch (e) {
      throw ServerError(
        technicalMessage:
            'Supabase error while setting monthly savings: ${e.message}',
        userMessage: 'Failed to set monthly savings',
      );
    } catch (e) {
      throw NetworkError(
        technicalMessage: 'Network error while setting monthly savings: $e',
        userMessage: 'Please check your internet connection',
      );
    }
  }

  /// Applique l'épargne mensuelle automatique
  Future<List<PocketModel>> applyMonthlySavings(String userId) async {
    try {
      // Récupérer tous les pockets de savings avec épargne mensuelle active
      final pockets = await _client
          .from(_tableName)
          .select()
          .eq('user_id', userId)
          .eq('category', 'savings')
          .eq('is_active', true)
          .not('monthly_savings_amount', 'is', null);

      if ((pockets as List).isEmpty) {
        return [];
      }

      final updatedPockets = <PocketModel>[];

      for (final pocketJson in pockets) {
        final pocket = PocketModel.fromJson(pocketJson);
        if (pocket.monthlySavingsAmount != null && pocket.id != null) {
          final newAmount =
              pocket.savedAmount + pocket.monthlySavingsAmount!;

          final updatedPocket = await _client
              .from(_tableName)
              .update({'saved_amount': newAmount})
              .eq('id', pocket.id!)
              .select()
              .single();

          updatedPockets
              .add(PocketModel.fromJson(updatedPocket));
        }
      }

      return updatedPockets;
    } on PostgrestException catch (e) {
      throw ServerError(
        technicalMessage:
            'Supabase error while applying monthly savings: ${e.message}',
        userMessage: 'Failed to apply monthly savings',
      );
    } catch (e) {
      throw NetworkError(
        technicalMessage: 'Network error while applying monthly savings: $e',
        userMessage: 'Please check your internet connection',
      );
    }
  }

  // =====================================================
  // 🎯 POCKETS PAR DÉFAUT
  // =====================================================

  /// Crée les pockets par défaut pour un nouvel utilisateur
  Future<List<PocketModel>> createDefaultPockets(String userId) async {
    try {
      // Vérifier que l'utilisateur n'a pas déjà de pockets
      final existingPockets = await getAllPockets(userId);
      if (existingPockets.isNotEmpty) {
        throw ValidationError(
          field: 'user_id',
          technicalMessage: 'User already has pockets',
          userMessage: 'Default pockets have already been created',
        );
      }

      // Appeler la fonction Supabase pour créer les pockets par défaut
      await _client.rpc('create_default_pockets', params: {'p_user_id': userId});

      // Récupérer les pockets créés
      return await getAllPockets(userId);
    } on PostgrestException catch (e) {
      throw ServerError(
        technicalMessage:
            'Supabase error while creating default pockets: ${e.message}',
        userMessage: 'Failed to create default pockets',
      );
    } catch (e) {
      throw NetworkError(
        technicalMessage: 'Network error while creating default pockets: $e',
        userMessage: 'Please check your internet connection',
      );
    }
  }
}

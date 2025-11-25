import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pocketly/core/errors/common_errors.dart';
import 'package:pocketly/features/pockets/data/models/pocket_model.dart';

/// Local data source pour le cache des pockets (SharedPreferences)
///
/// Gère le stockage local et la récupération des pockets pour un accès hors ligne.
class PocketLocalDataSource {
  final SharedPreferences _prefs;

  PocketLocalDataSource(this._prefs);

  static const String _cacheKeyPrefix = 'cached_pockets_';
  static const String _cacheTimestampPrefix = 'cached_pockets_timestamp_';
  static const Duration _cacheExpiration = Duration(minutes: 30);

  /// Clé de cache pour un utilisateur
  String _getCacheKey(String userId) => '$_cacheKeyPrefix$userId';

  /// Clé du timestamp pour un utilisateur
  String _getTimestampKey(String userId) => '$_cacheTimestampPrefix$userId';

  // =====================================================
  // 💾 CACHE OPERATIONS
  // =====================================================

  /// Récupère les pockets depuis le cache
  ///
  /// Retourne `null` si le cache est vide ou expiré.
  Future<List<PocketModel>?> getCachedPockets(String userId) async {
    try {
      // Vérifier si le cache existe et n'est pas expiré
      if (!_isCacheValid(userId)) {
        await clearCache(userId);
        return null;
      }

      final cachedJson = _prefs.getString(_getCacheKey(userId));
      if (cachedJson == null) return null;

      final List<dynamic> decoded = json.decode(cachedJson);
      final pockets = decoded
          .map((json) => PocketModel.fromJson(json as Map<String, dynamic>))
          .toList();

      return pockets;
    } catch (e) {
      // En cas d'erreur de lecture, vider le cache
      await clearCache(userId);
      throw CacheError(
        operation: 'read_pockets_cache',
        technicalMessage: 'Failed to read pockets from cache: $e',
        userMessage: 'Failed to load cached data',
      );
    }
  }

  /// Sauvegarde les pockets dans le cache
  Future<void> cachePockets(String userId, List<PocketModel> pockets) async {
    try {
      final jsonList = pockets.map((p) => p.toJson()).toList();
      final encoded = json.encode(jsonList);

      await _prefs.setString(_getCacheKey(userId), encoded);
      await _prefs.setInt(
        _getTimestampKey(userId),
        DateTime.now().millisecondsSinceEpoch,
      );
    } catch (e) {
      throw CacheError(
        operation: 'write_pockets_cache',
        technicalMessage: 'Failed to cache pockets: $e',
        userMessage: 'Failed to save data locally',
      );
    }
  }

  /// Vide le cache pour un utilisateur
  Future<void> clearCache(String userId) async {
    try {
      await _prefs.remove(_getCacheKey(userId));
      await _prefs.remove(_getTimestampKey(userId));
    } catch (e) {
      throw CacheError(
        operation: 'clear_pockets_cache',
        technicalMessage: 'Failed to clear pockets cache: $e',
        userMessage: 'Failed to clear cached data',
      );
    }
  }

  /// Vide tout le cache (tous les utilisateurs)
  Future<void> clearAllCache() async {
    try {
      final keys = _prefs.getKeys();
      for (final key in keys) {
        if (key.startsWith(_cacheKeyPrefix) ||
            key.startsWith(_cacheTimestampPrefix)) {
          await _prefs.remove(key);
        }
      }
    } catch (e) {
      throw CacheError(
        operation: 'clear_all_pockets_cache',
        technicalMessage: 'Failed to clear all pockets cache: $e',
        userMessage: 'Failed to clear all cached data',
      );
    }
  }

  /// Vérifie si le cache est valide (non expiré)
  bool _isCacheValid(String userId) {
    final timestamp = _prefs.getInt(_getTimestampKey(userId));
    if (timestamp == null) return false;

    final cacheDate = DateTime.fromMillisecondsSinceEpoch(timestamp);
    final now = DateTime.now();

    return now.difference(cacheDate) < _cacheExpiration;
  }

  /// Obtient la date d'expiration du cache
  DateTime? getCacheExpiration(String userId) {
    final timestamp = _prefs.getInt(_getTimestampKey(userId));
    if (timestamp == null) return null;

    final cacheDate = DateTime.fromMillisecondsSinceEpoch(timestamp);
    return cacheDate.add(_cacheExpiration);
  }

  /// Vérifie si le cache existe pour un utilisateur
  bool hasCachedPockets(String userId) {
    return _prefs.containsKey(_getCacheKey(userId));
  }

  // =====================================================
  // 🔍 CACHE-ONLY QUERIES (OPTIONAL)
  // =====================================================

  /// Récupère un pocket depuis le cache par son ID
  Future<PocketModel?> getCachedPocketById({
    required String userId,
    required String pocketId,
  }) async {
    final pockets = await getCachedPockets(userId);
    if (pockets == null) return null;

    try {
      return pockets.firstWhere((p) => p.id == pocketId);
    } catch (e) {
      return null;
    }
  }

  /// Récupère les pockets d'une catégorie depuis le cache
  Future<List<PocketModel>?> getCachedPocketsByCategory({
    required String userId,
    required String category,
  }) async {
    final pockets = await getCachedPockets(userId);
    if (pockets == null) return null;

    return pockets.where((p) => p.category == category).toList();
  }

  // =====================================================
  // 🔄 CACHE UPDATE HELPERS
  // =====================================================

  /// Met à jour un pocket dans le cache
  ///
  /// Utile après une opération locale de mise à jour.
  Future<void> updateCachedPocket({
    required String userId,
    required PocketModel pocket,
  }) async {
    try {
      final pockets = await getCachedPockets(userId);
      if (pockets == null) return;

      final index = pockets.indexWhere((p) => p.id == pocket.id);
      if (index == -1) {
        // Ajouter le pocket s'il n'existe pas
        pockets.add(pocket);
      } else {
        // Remplacer le pocket existant
        pockets[index] = pocket;
      }

      await cachePockets(userId, pockets);
    } catch (e) {
      throw CacheError(
        operation: 'update_cached_pocket',
        technicalMessage: 'Failed to update cached pocket: $e',
        userMessage: 'Failed to update local data',
      );
    }
  }

  /// Supprime un pocket du cache
  Future<void> removeCachedPocket({
    required String userId,
    required String pocketId,
  }) async {
    try {
      final pockets = await getCachedPockets(userId);
      if (pockets == null) return;

      pockets.removeWhere((p) => p.id == pocketId);
      await cachePockets(userId, pockets);
    } catch (e) {
      throw CacheError(
        operation: 'remove_cached_pocket',
        technicalMessage: 'Failed to remove cached pocket: $e',
        userMessage: 'Failed to update local data',
      );
    }
  }
}

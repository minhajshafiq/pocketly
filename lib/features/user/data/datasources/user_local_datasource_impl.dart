import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/user_model.dart';
import 'user_local_datasource.dart';
import '../../../../core/errors/common_errors.dart';

/// Implémentation du datasource local pour les utilisateurs avec stockage sécurisé.
///
/// Utilise flutter_secure_storage pour chiffrer les données sensibles utilisateur.
/// Les données sont stockées de manière sécurisée sur l'appareil (Keychain sur iOS,
/// KeyStore sur Android).
class UserLocalDataSourceImpl implements UserLocalDataSource {
  const UserLocalDataSourceImpl(this._secureStorage);

  final FlutterSecureStorage _secureStorage;

  static const String _currentUserKey = 'current_user_secure';
  static const String _pushTokenKey = 'push_token_secure';

  @override
  Future<UserModel?> getCurrentUser() async {
    try {
      final userJson = await _secureStorage.read(key: _currentUserKey);
      if (userJson == null) return null;

      final userMap = jsonDecode(userJson) as Map<String, dynamic>;
      return UserModel.fromJson(userMap);
    } catch (e) {
      throw CacheError(
        operation: 'get_current_user',
        technicalMessage: 'Failed to get current user from secure storage: $e',
      );
    }
  }

  @override
  Future<void> saveCurrentUser(UserModel user) async {
    try {
      final userJson = jsonEncode(user.toJson());
      await _secureStorage.write(key: _currentUserKey, value: userJson);
    } catch (e) {
      throw CacheError(
        operation: 'save_current_user',
        technicalMessage: 'Failed to save current user to secure storage: $e',
      );
    }
  }

  @override
  Future<void> clearCurrentUser() async {
    try {
      await _secureStorage.delete(key: _currentUserKey);
    } catch (e) {
      throw CacheError(
        operation: 'clear_current_user',
        technicalMessage:
            'Failed to clear current user from secure storage: $e',
      );
    }
  }

  @override
  Future<bool> hasCurrentUser() async {
    try {
      final userJson = await _secureStorage.read(key: _currentUserKey);
      return userJson != null;
    } catch (e) {
      throw CacheError(
        operation: 'has_current_user',
        technicalMessage: 'Failed to check if current user exists: $e',
      );
    }
  }

  @override
  Future<String?> getPushToken() async {
    try {
      return await _secureStorage.read(key: _pushTokenKey);
    } catch (e) {
      throw CacheError(
        operation: 'get_push_token',
        technicalMessage: 'Failed to get push token from secure storage: $e',
      );
    }
  }

  @override
  Future<void> savePushToken(String token) async {
    try {
      await _secureStorage.write(key: _pushTokenKey, value: token);
    } catch (e) {
      throw CacheError(
        operation: 'save_push_token',
        technicalMessage: 'Failed to save push token to secure storage: $e',
      );
    }
  }

  @override
  Future<void> clearPushToken() async {
    try {
      await _secureStorage.delete(key: _pushTokenKey);
    } catch (e) {
      throw CacheError(
        operation: 'clear_push_token',
        technicalMessage: 'Failed to clear push token from secure storage: $e',
      );
    }
  }
}

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pocketly/features/onboarding/data/models/onboarding_state_model.dart';
import 'package:pocketly/core/errors/common_errors.dart';

/// Clé pour stocker l'état de l'onboarding dans SharedPreferences
const String _kOnboardingStateKey = 'onboarding_state';

/// Datasource local pour l'onboarding
///
/// Gère la persistance de l'état de l'onboarding dans SharedPreferences
abstract class OnboardingLocalDataSource {
  /// Sauvegarde l'état de l'onboarding localement
  Future<void> saveOnboardingState(OnboardingStateModel state);

  /// Récupère l'état de l'onboarding depuis le stockage local
  Future<OnboardingStateModel?> getOnboardingState();

  /// Supprime l'état de l'onboarding du stockage local
  Future<void> clearOnboardingState();

  /// Vérifie si un état d'onboarding existe
  Future<bool> hasOnboardingState();
}

/// Implémentation du datasource local pour l'onboarding
class OnboardingLocalDataSourceImpl implements OnboardingLocalDataSource {
  final SharedPreferences _prefs;

  const OnboardingLocalDataSourceImpl(this._prefs);

  @override
  Future<void> saveOnboardingState(OnboardingStateModel state) async {
    try {
      final json = state.toJson();
      final jsonString = jsonEncode(json);
      final success = await _prefs.setString(_kOnboardingStateKey, jsonString);

      if (!success) {
        throw CacheError(
          operation: 'save_onboarding_state',
          technicalMessage: 'Failed to save onboarding state to SharedPreferences',
        );
      }
    } catch (e) {
      if (e is CacheError) rethrow;
      throw CacheError(
        operation: 'save_onboarding_state',
        technicalMessage: 'Error saving onboarding state: $e',
      );
    }
  }

  @override
  Future<OnboardingStateModel?> getOnboardingState() async {
    try {
      final jsonString = _prefs.getString(_kOnboardingStateKey);
      if (jsonString == null) {
        return null;
      }

      final json = jsonDecode(jsonString) as Map<String, dynamic>;
      return OnboardingStateModel.fromJson(json);
    } catch (e) {
      throw CacheError(
        operation: 'get_onboarding_state',
        technicalMessage: 'Error retrieving onboarding state: $e',
      );
    }
  }

  @override
  Future<void> clearOnboardingState() async {
    try {
      final success = await _prefs.remove(_kOnboardingStateKey);
      if (!success) {
        throw CacheError(
          operation: 'clear_onboarding_state',
          technicalMessage: 'Failed to clear onboarding state from SharedPreferences',
        );
      }
    } catch (e) {
      if (e is CacheError) rethrow;
      throw CacheError(
        operation: 'clear_onboarding_state',
        technicalMessage: 'Error clearing onboarding state: $e',
      );
    }
  }

  @override
  Future<bool> hasOnboardingState() async {
    return _prefs.containsKey(_kOnboardingStateKey);
  }
}

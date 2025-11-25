import 'package:pocketly/features/onboarding/domain/entities/onboarding_state_entity.dart';

/// Repository pour gérer l'état de l'onboarding
///
/// Permet de sauvegarder et récupérer l'état de l'onboarding
/// localement pour reprendre le processus en cas d'interruption
abstract class OnboardingRepository {
  /// Sauvegarde l'état actuel de l'onboarding localement
  Future<void> saveOnboardingState(OnboardingStateEntity state);

  /// Récupère l'état sauvegardé de l'onboarding
  ///
  /// Retourne null si aucun état n'est sauvegardé
  Future<OnboardingStateEntity?> getOnboardingState();

  /// Supprime l'état sauvegardé de l'onboarding
  ///
  /// Utilisé après la complétion de l'onboarding
  Future<void> clearOnboardingState();

  /// Vérifie si un état d'onboarding existe localement
  Future<bool> hasOnboardingState();
}

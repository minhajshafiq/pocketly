import 'package:pocketly/features/onboarding/domain/entities/onboarding_state_entity.dart';
import 'package:pocketly/features/onboarding/domain/repositories/onboarding_repository.dart';

/// Use case pour récupérer l'état de l'onboarding
class GetOnboardingStateUseCase {
  final OnboardingRepository _repository;

  const GetOnboardingStateUseCase(this._repository);

  /// Récupère l'état sauvegardé de l'onboarding
  ///
  /// Retourne une instance par défaut si aucun état n'est sauvegardé
  Future<OnboardingStateEntity> call() async {
    final state = await _repository.getOnboardingState();
    return state ?? const OnboardingStateEntity();
  }
}

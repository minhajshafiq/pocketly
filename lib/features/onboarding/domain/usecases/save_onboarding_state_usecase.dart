import 'package:pocketly/features/onboarding/domain/entities/onboarding_state_entity.dart';
import 'package:pocketly/features/onboarding/domain/repositories/onboarding_repository.dart';

/// Use case pour sauvegarder l'état de l'onboarding
class SaveOnboardingStateUseCase {
  final OnboardingRepository _repository;

  const SaveOnboardingStateUseCase(this._repository);

  /// Sauvegarde l'état actuel de l'onboarding
  Future<void> call(OnboardingStateEntity state) async {
    await _repository.saveOnboardingState(state);
  }
}

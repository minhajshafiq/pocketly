import 'package:pocketly/features/onboarding/domain/repositories/onboarding_repository.dart';

/// Use case pour nettoyer l'état local de l'onboarding
class ClearOnboardingStateUseCase {
  final OnboardingRepository _repository;

  const ClearOnboardingStateUseCase(this._repository);

  /// Nettoie l'état sauvegardé localement après complétion de l'onboarding
  Future<void> call() async {
    await _repository.clearOnboardingState();
  }
}

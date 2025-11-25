import 'package:pocketly/features/onboarding/domain/entities/onboarding_state_entity.dart';
import 'package:pocketly/features/onboarding/domain/repositories/onboarding_repository.dart';
import 'package:pocketly/features/onboarding/data/datasources/onboarding_local_datasource.dart';
import 'package:pocketly/features/onboarding/data/models/onboarding_state_model.dart';

/// Implémentation du repository onboarding
class OnboardingRepositoryImpl implements OnboardingRepository {
  final OnboardingLocalDataSource _localDataSource;

  const OnboardingRepositoryImpl(this._localDataSource);

  @override
  Future<void> saveOnboardingState(OnboardingStateEntity state) async {
    try {
      final model = state.toModel();
      await _localDataSource.saveOnboardingState(model);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<OnboardingStateEntity?> getOnboardingState() async {
    try {
      final model = await _localDataSource.getOnboardingState();
      return model?.toEntity();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> clearOnboardingState() async {
    try {
      await _localDataSource.clearOnboardingState();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> hasOnboardingState() async {
    try {
      return await _localDataSource.hasOnboardingState();
    } catch (e) {
      rethrow;
    }
  }
}

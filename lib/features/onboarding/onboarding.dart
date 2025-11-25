/// Feature Onboarding - Barrel file
/// This file exports all the public APIs of the onboarding feature

// ==================== DOMAIN ====================

// Entities
export 'domain/entities/onboarding_state_entity.dart';

// Repositories
export 'domain/repositories/onboarding_repository.dart';

// Use Cases
export 'domain/usecases/save_onboarding_state_usecase.dart';
export 'domain/usecases/get_onboarding_state_usecase.dart';
export 'domain/usecases/clear_onboarding_state_usecase.dart';

// ==================== DATA ====================

// Models
export 'data/models/onboarding_state_model.dart';

// Data Sources
export 'data/datasources/onboarding_local_datasource.dart';

// Repositories Implementation
export 'data/repositories/onboarding_repository_impl.dart';

// ==================== PRESENTATION ====================

// Providers
export 'presentation/providers/onboarding_providers.dart';

// Screens
export 'presentation/screens/onboarding_step1_screen.dart';
export 'presentation/screens/onboarding_step2_screen.dart';
export 'presentation/screens/onboarding_step3_screen.dart';
export 'presentation/screens/onboarding_step4_screen.dart';


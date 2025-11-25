/// Feature Notifications - Barrel file
/// This file exports all the public APIs of the notifications feature

// ==================== DOMAIN ====================

// Entities
export 'domain/entities/notification_entity.dart';

// Repositories
export 'domain/repositories/notification_repository.dart';

// Use Cases
export 'domain/usecases/notification_service.dart';
export 'domain/usecases/notification_scheduler_service.dart';
export 'domain/usecases/budget_monitor_service.dart';
export 'domain/usecases/goal_tracker_service.dart';
export 'domain/usecases/in_app_notification_service.dart';

// ==================== DATA ====================

// Models
export 'data/models/notification_model.dart';

// Data Sources
export 'data/datasources/notification_local_datasource.dart';

// Repositories
export 'data/repositories/notification_repository_impl.dart';

// ==================== PRESENTATION ====================

// Providers
export 'presentation/providers/notification_services_provider.dart';
export 'presentation/providers/notification_preferences_provider.dart';
export 'presentation/providers/app_notifications_provider.dart';

// Screens
export 'presentation/screens/notifications_center_screen.dart';
export 'presentation/screens/notification_settings_screen.dart';
export 'presentation/screens/notification_preferences_screen.dart';

// Widgets
// notification_card.dart does not exist
// notification_preferences_card.dart does not exist


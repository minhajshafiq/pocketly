/// Feature subscription - Gestion des abonnements avec RevenueCat
///
/// Exports publics de la feature
library subscription;

// Domain - Entities
export 'domain/entities/subscription_offer_entity.dart';
export 'domain/entities/subscription_package_entity.dart';
export 'domain/entities/subscription_status_entity.dart';

// Domain - Repositories
export 'domain/repositories/subscription_repository.dart';

// Domain - Use Cases
export 'domain/usecases/get_subscription_offers_usecase.dart';
export 'domain/usecases/purchase_subscription_usecase.dart';
export 'domain/usecases/restore_purchases_usecase.dart';
export 'domain/usecases/check_subscription_status_usecase.dart';
export 'domain/usecases/sync_subscription_to_backend_usecase.dart';

// Presentation - Providers
export 'presentation/providers/subscription_providers.dart';

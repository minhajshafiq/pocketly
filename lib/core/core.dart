// Export central pour le module core de Pocketly.
//
// Importer ce fichier unique pour accéder à tout le système core:
// ```dart
// import 'package:pocketly/core/core.dart';
// ```

// ==================== CONFIGURATION ====================
export 'config/supabase_config.dart';

// ==================== PROVIDERS ====================
export 'providers/shared_preferences_provider.dart';

// ==================== CONSTANTES ====================
export 'constants/app_colors.dart';
export 'constants/app_constants.dart';
export 'constants/app_dimensions.dart';
export 'constants/app_icons.dart';
export 'constants/app_typography.dart';

// ==================== GESTION D'ERREURS ====================
export 'errors/errors.dart';

// ==================== SERVICES ====================
export 'services/auth_rate_limiter.dart';
export 'services/auth_service.dart';
export 'services/logger_service.dart';
export 'services/local_data_service.dart';

// ==================== ROUTER ====================
export 'router/app_route_paths.dart';
export 'router/app_router_config.dart';
export 'router/app_page.dart';

// ==================== UTILS ====================
export 'utils/utils.dart';

// ==================== NETWORK ====================
export 'network/network.dart';

// ==================== WIDGETS PARTAGÉS ====================
export 'widgets/app_button.dart';
export 'widgets/app_card.dart';
export 'widgets/app_container.dart';
export 'widgets/app_text_field.dart';
export 'widgets/error_boundary.dart';
export 'widgets/error_display.dart';
export 'widgets/error_snackbar.dart';
export 'widgets/localized_error_display.dart';
export 'widgets/platform_safe_area.dart';

// ==================== NAVIGATION ====================
// Models
export 'navigation/models/navigation_item.dart';
export 'navigation/models/app_bar_config.dart';

// Providers
export 'navigation/providers/navigation_provider.dart';

// Widgets
export 'navigation/widgets/adaptive_app_bar.dart';
export 'navigation/widgets/adaptive_bottom_navigation.dart';
export 'navigation/widgets/conditional_app_bar.dart';
export 'navigation/widgets/main_navigation_screen.dart';

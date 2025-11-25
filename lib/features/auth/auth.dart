// Export barrel pour la feature Auth de Pocketly.
//
// Importer ce fichier unique pour accéder à toute la feature Auth:
// ```dart
// import 'package:pocketly/features/auth/auth.dart';
// ```

// ==================== DOMAIN ====================
// Entities
export 'domain/entities/auth_user.dart';
export 'domain/entities/auth_session.dart';
export 'domain/entities/auth_state.dart';

// Repositories
export 'domain/repositories/auth_repository.dart';

// Use Cases
export 'domain/usecases/sign_in_usecase.dart';
export 'domain/usecases/sign_up_usecase.dart';
export 'domain/usecases/sign_out_usecase.dart';
export 'domain/usecases/get_current_session_usecase.dart';
export 'domain/usecases/get_current_user_id_usecase.dart';
export 'domain/usecases/is_authenticated_usecase.dart';
export 'domain/usecases/watch_auth_state_usecase.dart';
export 'domain/usecases/reset_password_usecase.dart';
export 'domain/usecases/update_password_usecase.dart';

// ==================== DATA ====================
// Models
export 'data/models/auth_user_model.dart';
export 'data/models/auth_session_model.dart';

// DataSources
export 'data/datasources/auth_remote_datasource.dart';
export 'data/datasources/auth_remote_datasource_impl.dart';

// Repositories
export 'data/repositories/auth_repository_impl.dart';

// ==================== PRESENTATION ====================
// Providers
export 'presentation/providers/auth_providers.dart';

// Screens (ThemeColors not exported to avoid conflicts)
// Use direct imports for screens if needed
// export 'presentation/screens/signin_screen.dart';
// export 'presentation/screens/signup_screen.dart';

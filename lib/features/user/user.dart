// Domain exports
export 'domain/entities/user_entity.dart';
export 'domain/repositories/user_repository.dart';
export 'domain/usecases/get_current_user_usecase.dart';
export 'domain/usecases/create_user_usecase.dart';
export 'domain/usecases/update_user_usecase.dart';
export 'domain/usecases/delete_user_usecase.dart';
export 'domain/usecases/activate_trial_usecase.dart';
export 'domain/usecases/activate_premium_usecase.dart';
export 'domain/usecases/complete_onboarding_usecase.dart';
export 'domain/usecases/upload_avatar_usecase.dart';
export 'domain/usecases/delete_avatar_usecase.dart';

// Data exports
export 'data/models/user_model.dart';
export 'data/datasources/user_remote_datasource.dart';
export 'data/datasources/user_remote_datasource_impl.dart';
export 'data/datasources/user_local_datasource.dart';
export 'data/datasources/user_local_datasource_impl.dart';
export 'data/datasources/storage_datasource.dart';
export 'data/repositories/user_repository_impl.dart';

// Presentation exports
export 'presentation/providers/user_provider.dart';
export 'presentation/providers/avatar_providers.dart';
export 'presentation/screens/profile_edit_screen.dart';
export 'presentation/widgets/user_profile_card.dart';
export 'presentation/widgets/avatar_picker_widget.dart';
export 'presentation/widgets/avatar_display_widget.dart';

// Category Feature - Barrel file
// This file exports all the public APIs of the category feature

// ==================== DOMAIN ====================
// Entities
export 'domain/entities/category_entity.dart';

// Repositories
export 'domain/repositories/category_repository.dart';

// Use Cases
export 'domain/usecases/get_all_categories_usecase.dart';
export 'domain/usecases/create_custom_category_usecase.dart';
export 'domain/usecases/delete_custom_category_usecase.dart';
export 'domain/usecases/validate_category_usecase.dart';

// Errors
export 'domain/errors/category_errors.dart';

// ==================== DATA ====================
// Models
export 'data/models/category_model.dart';

// Repositories
export 'data/repositories/category_repository_impl.dart';

// ==================== PRESENTATION ====================
// Providers
export 'presentation/providers/category_provider.dart';

// Widgets
export 'presentation/widgets/category_selector.dart';

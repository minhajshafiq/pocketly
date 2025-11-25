/// Barrel file for the Pockets feature
///
/// This file exports the public API of the Pockets feature.
/// External features should only import this file, not individual files.
library pockets;

// Domain - Entities
export 'domain/entities/pocket_entity.dart';

// Domain - Repositories
export 'domain/repositories/pocket_repository.dart';

// Domain - Use Cases
export 'domain/usecases/get_all_pockets_usecase.dart';
export 'domain/usecases/get_pockets_by_category_usecase.dart';
export 'domain/usecases/get_pocket_by_id_usecase.dart';
export 'domain/usecases/create_pocket_usecase.dart';
export 'domain/usecases/update_pocket_usecase.dart';
export 'domain/usecases/delete_pocket_usecase.dart';
export 'domain/usecases/activate_pocket_usecase.dart';
export 'domain/usecases/deactivate_pocket_usecase.dart';
export 'domain/usecases/update_spent_amount_usecase.dart';
export 'domain/usecases/add_to_savings_usecase.dart';
export 'domain/usecases/withdraw_from_savings_usecase.dart';
export 'domain/usecases/set_monthly_savings_usecase.dart';
export 'domain/usecases/apply_monthly_savings_usecase.dart';
export 'domain/usecases/create_default_pockets_usecase.dart';
export 'domain/usecases/get_pocket_summary_usecase.dart';

// Presentation - Providers
export 'presentation/providers/pocket_providers.dart';

// Presentation - Screens
export 'presentation/screens/pockets_list_screen.dart';
export 'presentation/screens/pocket_details_screen.dart';
export 'presentation/screens/create_pocket_screen.dart';
export 'presentation/screens/edit_pocket_screen.dart';
export 'presentation/screens/assign_transactions_screen.dart';
export 'presentation/screens/savings_goal_screen.dart';

// Presentation - Widgets
export 'presentation/widgets/pocket_card.dart';
export 'presentation/widgets/pocket_category_section.dart';
export 'presentation/widgets/budget_progress_bar.dart';
export 'presentation/widgets/savings_progress_widget.dart';
export 'presentation/widgets/pocket_icon_picker.dart';
export 'presentation/widgets/pocket_color_picker.dart';
export 'presentation/widgets/pocket_form.dart';
export 'presentation/widgets/savings_goal_config_widget.dart';
export 'presentation/widgets/pocket_summary_card.dart';
export 'presentation/widgets/pocket_statistics_widget.dart';

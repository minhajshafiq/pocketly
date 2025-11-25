/// Transaction History feature exports.
///
/// This barrel file exports the public API of the transaction history feature.
/// Import this file to use transaction history functionality in other features.
library;

// Domain - Entities
export 'domain/entities/calendar_day_entity.dart';
export 'domain/entities/transaction_period_entity.dart';
export 'domain/entities/transaction_summary_entity.dart';

// Domain - Repositories
export 'domain/repositories/transaction_history_repository.dart';

// Domain - Use Cases
export 'domain/usecases/get_calendar_data_usecase.dart';
export 'domain/usecases/get_transaction_summary_usecase.dart';
export 'domain/usecases/get_transactions_by_date_usecase.dart';
export 'domain/usecases/get_transactions_by_period_usecase.dart';

// Data - Repositories
export 'data/repositories/transaction_history_repository_impl.dart';

// Presentation - Providers
export 'presentation/providers/transaction_history_providers.dart';

// Presentation - Screens
export 'presentation/screens/transaction_history_screen.dart';

// Presentation - Widgets
export 'presentation/widgets/calendar_day_widget.dart';
export 'presentation/widgets/interactive_calendar.dart';
export 'presentation/widgets/period_filter_buttons.dart';
export 'presentation/widgets/transaction_card.dart';
export 'presentation/widgets/transaction_list_widget.dart';

// Transactions Feature - Barrel file
// This file exports all the public APIs of the transactions feature

// Domain layer
export 'domain/entities/transaction_entity.dart';
export 'domain/repositories/transaction_repository.dart';
export 'domain/usecases/get_all_transactions_usecase.dart';
export 'domain/usecases/create_transaction_usecase.dart';
export 'domain/usecases/update_transaction_usecase.dart';
export 'domain/usecases/delete_transaction_usecase.dart';
export 'domain/usecases/get_transactions_by_period_usecase.dart';
export 'domain/usecases/get_transaction_stats_usecase.dart';
export 'domain/usecases/validate_transaction_usecase.dart';

// Data layer
export 'data/models/transaction_model.dart';
export 'data/datasources/transaction_local_datasource.dart';
export 'data/datasources/transaction_remote_datasource.dart';
export 'data/repositories/transaction_repository_impl.dart';

// Presentation layer
export 'presentation/providers/transaction_provider.dart';
export 'presentation/providers/transaction_state.dart';

// Presentation widgets
export 'presentation/widgets/transaction_detail_modal.dart';
export 'presentation/widgets/transaction_type_modal.dart';
export 'presentation/widgets/edit_transaction_modal.dart';

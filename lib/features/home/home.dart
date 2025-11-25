/// Feature Home - Page d'accueil de Pocketly
///
/// Cette feature gère l'affichage de la page d'accueil avec :
/// - Résumé du solde et variation 24h
/// - Dépenses hebdomadaires
/// - Boutons d'action rapides
/// - Transactions récentes
library;

// ==================== DOMAIN ====================

// Entities
export 'domain/entities/home_summary_entity.dart';
export 'domain/entities/weekly_expense_entity.dart';

// Use Cases
export 'domain/usecases/get_home_summary_usecase.dart';
export 'domain/usecases/get_recent_transactions_usecase.dart';
export 'domain/usecases/get_weekly_expenses_usecase.dart';

// ==================== PRESENTATION ====================

// Providers
export 'presentation/providers/home_providers.dart';

// Screens
export 'presentation/screens/home_screen.dart';

// Widgets
export 'presentation/widgets/action_buttons_widget.dart';
export 'presentation/widgets/balance_card.dart';
export 'presentation/widgets/recent_transactions_widget.dart';
export 'presentation/widgets/user_header_widget.dart';
export 'presentation/widgets/weekly_expenses_widget.dart';

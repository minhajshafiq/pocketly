import 'package:pocketly/features/pockets/domain/entities/pocket_entity.dart';

/// Repository interface for Pocket operations
///
/// Defines the contract for data operations related to pockets.
/// The implementation will handle both remote (Supabase) and local (cache) data sources.
abstract class PocketRepository {
  // =====================================================
  // 📋 CRUD OPERATIONS
  // =====================================================

  /// Récupère tous les pockets de l'utilisateur
  ///
  /// Retourne une liste de pockets ordonnés par catégorie puis par nom.
  /// Lance une exception en cas d'erreur réseau ou de données.
  Future<List<PocketEntity>> getAllPockets(String userId);

  /// Récupère les pockets d'une catégorie spécifique
  ///
  /// [userId] - ID de l'utilisateur
  /// [category] - Catégorie de pockets à récupérer (needs, wants, savings)
  Future<List<PocketEntity>> getPocketsByCategory({
    required String userId,
    required PocketCategory category,
  });

  /// Récupère un pocket par son ID
  ///
  /// Retourne `null` si le pocket n'existe pas.
  /// Lance une exception en cas d'erreur.
  Future<PocketEntity?> getPocketById(String pocketId);

  /// Crée un nouveau pocket
  ///
  /// Valide les données avant l'insertion.
  /// Retourne le pocket créé avec son ID généré.
  /// Lance une exception si la validation échoue ou en cas d'erreur.
  Future<PocketEntity> createPocket(PocketEntity pocket);

  /// Met à jour un pocket existant
  ///
  /// Valide les données avant la mise à jour.
  /// Retourne le pocket mis à jour.
  /// Lance une exception si le pocket n'existe pas ou en cas d'erreur.
  Future<PocketEntity> updatePocket(PocketEntity pocket);

  /// Supprime un pocket
  ///
  /// Vérifie qu'il n'y a pas de transactions liées avant la suppression.
  /// Lance une exception si le pocket a des transactions liées ou en cas d'erreur.
  Future<void> deletePocket(String pocketId);

  // =====================================================
  // 🔄 ÉTAT ET ACTIVATION
  // =====================================================

  /// Active un pocket
  ///
  /// Change le statut `isActive` à `true`.
  /// Retourne le pocket mis à jour.
  Future<PocketEntity> activatePocket(String pocketId);

  /// Désactive un pocket
  ///
  /// Change le statut `isActive` à `false`.
  /// Les pockets désactivés ne sont pas inclus dans les calculs de budget.
  Future<PocketEntity> deactivatePocket(String pocketId);

  // =====================================================
  // 💰 GESTION DES MONTANTS (NEEDS & WANTS)
  // =====================================================

  /// Met à jour le montant dépensé d'un pocket de dépense
  ///
  /// [pocketId] - ID du pocket
  /// [amount] - Nouveau montant dépensé
  ///
  /// Lance une exception si le pocket est de type savings.
  Future<PocketEntity> updateSpentAmount({
    required String pocketId,
    required double amount,
  });

  // =====================================================
  // 🏦 GESTION DE L'ÉPARGNE (SAVINGS)
  // =====================================================

  /// Ajoute un montant à l'épargne d'un pocket
  ///
  /// [pocketId] - ID du pocket d'épargne
  /// [amount] - Montant à ajouter (doit être positif)
  ///
  /// Lance une exception si le pocket n'est pas de type savings ou si le montant est négatif.
  Future<PocketEntity> addToSavings({
    required String pocketId,
    required double amount,
  });

  /// Retire un montant de l'épargne d'un pocket
  ///
  /// [pocketId] - ID du pocket d'épargne
  /// [amount] - Montant à retirer (doit être positif)
  ///
  /// Lance une exception si :
  /// - Le pocket n'est pas de type savings
  /// - Le montant est négatif
  /// - Le montant à retirer est supérieur au montant épargné
  Future<PocketEntity> withdrawFromSavings({
    required String pocketId,
    required double amount,
  });

  /// Définit le montant d'épargne mensuelle automatique
  ///
  /// [pocketId] - ID du pocket d'épargne
  /// [amount] - Montant mensuel (null pour désactiver)
  ///
  /// Lance une exception si le pocket n'est pas de type savings.
  Future<PocketEntity> setMonthlySavings({
    required String pocketId,
    double? amount,
  });

  /// Applique l'épargne mensuelle automatique à tous les pockets actifs
  ///
  /// Cette méthode est appelée automatiquement au début de chaque mois.
  /// Elle ajoute le montant `monthlySavingsAmount` à `savedAmount` pour
  /// tous les pockets de type savings qui ont un montant mensuel défini.
  ///
  /// [userId] - ID de l'utilisateur
  ///
  /// Retourne la liste des pockets mis à jour.
  Future<List<PocketEntity>> applyMonthlySavings(String userId);

  // =====================================================
  // 🎯 POCKETS PAR DÉFAUT
  // =====================================================

  /// Crée les 8 pockets par défaut pour un nouvel utilisateur
  ///
  /// Les pockets créés sont :
  /// - Needs (3) : Logement, Alimentation, Transport
  /// - Wants (2) : Loisirs, Shopping
  /// - Savings (3) : Fonds d'urgence, Vacances, Projets
  ///
  /// [userId] - ID de l'utilisateur
  ///
  /// Retourne la liste des pockets créés.
  /// Lance une exception si l'utilisateur a déjà des pockets.
  Future<List<PocketEntity>> createDefaultPockets(String userId);

  // =====================================================
  // 📊 STATISTIQUES ET RÉSUMÉS
  // =====================================================

  /// Récupère un résumé des pockets par catégorie
  ///
  /// Retourne un Map avec les statistiques par catégorie :
  /// - Nombre total de pockets
  /// - Nombre de pockets actifs
  /// - Budget total (needs/wants)
  /// - Montant total dépensé (needs/wants)
  /// - Montant total épargné (savings)
  /// - Montant total des objectifs (savings)
  ///
  /// [userId] - ID de l'utilisateur
  Future<Map<PocketCategory, PocketSummary>> getPocketSummary(String userId);
}

/// Classe représentant le résumé d'une catégorie de pockets
class PocketSummary {
  /// Nombre total de pockets dans cette catégorie
  final int pocketCount;

  /// Nombre de pockets actifs
  final int activeCount;

  /// Budget total alloué (needs/wants uniquement)
  final double totalBudget;

  /// Montant total dépensé (needs/wants uniquement)
  final double totalSpent;

  /// Montant total épargné (savings uniquement)
  final double totalSaved;

  /// Montant total des objectifs (savings uniquement)
  final double totalTarget;

  const PocketSummary({
    required this.pocketCount,
    required this.activeCount,
    required this.totalBudget,
    required this.totalSpent,
    required this.totalSaved,
    required this.totalTarget,
  });

  /// Budget restant (pour needs/wants)
  double get remainingBudget => totalBudget - totalSpent;

  /// Pourcentage d'utilisation du budget
  double get budgetUsagePercentage {
    if (totalBudget == 0) return 0.0;
    return (totalSpent / totalBudget) * 100;
  }

  /// Pourcentage de progression vers les objectifs (pour savings)
  double get savingsProgressPercentage {
    if (totalTarget == 0) return 0.0;
    return (totalSaved / totalTarget) * 100;
  }

  /// Montant restant pour atteindre les objectifs
  double get remainingSavings {
    final remaining = totalTarget - totalSaved;
    return remaining > 0 ? remaining : 0.0;
  }

  @override
  String toString() {
    return 'PocketSummary(pocketCount: $pocketCount, activeCount: $activeCount, '
        'totalBudget: $totalBudget, totalSpent: $totalSpent, '
        'totalSaved: $totalSaved, totalTarget: $totalTarget)';
  }
}

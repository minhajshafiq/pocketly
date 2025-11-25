import 'package:freezed_annotation/freezed_annotation.dart';

part 'pocket_entity.freezed.dart';
part 'pocket_entity.g.dart';

/// Catégorie de pocket selon la règle 50/30/20
enum PocketCategory {
  needs,    // 50% - Besoins essentiels
  wants,    // 30% - Envies et loisirs
  savings;  // 20% - Épargne

  String getName(dynamic l10n) {
    return switch (this) {
      PocketCategory.needs => l10n.pocketCategoryNeeds,
      PocketCategory.wants => l10n.pocketCategoryWants,
      PocketCategory.savings => l10n.pocketCategorySavings,
    };
  }

  /// Pourcentage recommandé selon la règle 50/30/20
  int get recommendedPercentage {
    return switch (this) {
      PocketCategory.needs => 50,
      PocketCategory.wants => 30,
      PocketCategory.savings => 20,
    };
  }

  /// Couleur principale de la catégorie
  String get primaryColor {
    return switch (this) {
      PocketCategory.needs => '#F48A99', // Rose pastel
      PocketCategory.wants => '#78D078', // Vert pastel
      PocketCategory.savings => '#6BC6EA', // Bleu clair
    };
  }
}

/// Type d'objectif d'épargne
enum SavingsGoalType {
  none,         // Pas d'objectif
  fixedAmount,  // Objectif de montant fixe
  targetDate;   // Objectif avec date cible

  String getName(dynamic l10n) {
    return switch (this) {
      SavingsGoalType.none => l10n.savingsGoalNone,
      SavingsGoalType.fixedAmount => l10n.savingsGoalFixedAmount,
      SavingsGoalType.targetDate => l10n.savingsGoalTargetDate,
    };
  }
}

/// Clés des pockets par défaut pour i18n
class PocketKeys {
  // Needs (Besoins)
  static const String housing = 'housing';
  static const String food = 'food';
  static const String transport = 'transport';

  // Wants (Envies)
  static const String entertainment = 'entertainment';
  static const String shopping = 'shopping';

  // Savings (Épargne)
  static const String emergencyFund = 'emergency_fund';
  static const String vacation = 'vacation';
  static const String projects = 'projects';
}

/// Entité représentant un pocket (sous-portefeuille budgétaire)
@freezed
sealed class PocketEntity with _$PocketEntity {
  const PocketEntity._();

  const factory PocketEntity({
    /// Identifiant unique
    String? id,

    /// Nom du pocket
    required String name,

    /// Icône (nom Material Design)
    required String icon,

    /// Couleur hexadécimale
    required String color,

    /// Catégorie du pocket
    required PocketCategory category,

    // ==================== BUDGETS (needs & wants) ====================

    /// Budget alloué (needs/wants uniquement)
    @Default(0.0) double budget,

    /// Montant dépensé (needs/wants uniquement)
    @Default(0.0) double spent,

    // ==================== ÉPARGNE (savings) ====================

    /// Montant épargné actuel (savings uniquement)
    @Default(0.0) double savedAmount,

    /// Montant d'épargne mensuelle automatique (savings uniquement)
    double? monthlySavingsAmount,

    // ==================== OBJECTIFS D'ÉPARGNE ====================

    /// Type d'objectif d'épargne
    @Default(SavingsGoalType.none) SavingsGoalType savingsGoalType,

    /// Montant cible de l'objectif
    double? targetAmount,

    /// Date cible de l'objectif
    DateTime? targetDate,

    // ==================== MÉTADONNÉES ====================

    /// Identifiant de l'utilisateur
    required String userId,

    /// Le pocket est-il actif ?
    @Default(true) bool isActive,

    /// Le pocket est-il par défaut ?
    @Default(false) bool isDefault,

    /// Date de création
    DateTime? createdAt,

    /// Date de dernière mise à jour
    DateTime? updatedAt,
  }) = _PocketEntity;

  /// Conversion depuis JSON
  factory PocketEntity.fromJson(Map<String, dynamic> json) =>
      _$PocketEntityFromJson(json);

  // =====================================================
  // 🏭 FACTORY METHODS
  // =====================================================

  /// Crée un pocket de type dépense (needs ou wants)
  factory PocketEntity.expense({
    required String name,
    required String icon,
    required String color,
    required PocketCategory category,
    required double budget,
    required String userId,
    String? id,
    double spent = 0.0,
    bool isActive = true,
    bool isDefault = false,
  }) {
    assert(
      category == PocketCategory.needs || category == PocketCategory.wants,
      'Expense pockets must be of category needs or wants',
    );

    return PocketEntity(
      id: id,
      name: name,
      icon: icon,
      color: color,
      category: category,
      budget: budget,
      spent: spent,
      userId: userId,
      isActive: isActive,
      isDefault: isDefault,
    );
  }

  /// Crée un pocket de type épargne (savings)
  factory PocketEntity.savings({
    required String name,
    required String icon,
    required String color,
    required String userId,
    String? id,
    double savedAmount = 0.0,
    double? monthlySavingsAmount,
    SavingsGoalType savingsGoalType = SavingsGoalType.none,
    double? targetAmount,
    DateTime? targetDate,
    bool isActive = true,
    bool isDefault = false,
  }) {
    return PocketEntity(
      id: id,
      name: name,
      icon: icon,
      color: color,
      category: PocketCategory.savings,
      savedAmount: savedAmount,
      monthlySavingsAmount: monthlySavingsAmount,
      savingsGoalType: savingsGoalType,
      targetAmount: targetAmount,
      targetDate: targetDate,
      userId: userId,
      isActive: isActive,
      isDefault: isDefault,
    );
  }

  // =====================================================
  // 🧮 GETTERS & COMPUTED PROPERTIES
  // =====================================================

  /// Le pocket est-il un pocket de dépense (needs ou wants) ?
  bool get isExpensePocket =>
      category == PocketCategory.needs || category == PocketCategory.wants;

  /// Le pocket est-il un pocket d'épargne ?
  bool get isSavingsPocket => category == PocketCategory.savings;

  /// Le budget est-il dépassé ? (needs/wants uniquement)
  bool get isBudgetExceeded => isExpensePocket && spent > budget;

  /// Montant restant du budget (needs/wants uniquement)
  double get remainingBudget => isExpensePocket ? budget - spent : 0.0;

  /// Pourcentage du budget utilisé (needs/wants uniquement)
  double get budgetUsagePercentage {
    if (!isExpensePocket || budget == 0) return 0.0;
    return (spent / budget) * 100;
  }

  /// L'objectif d'épargne est-il atteint ? (savings uniquement)
  bool get isSavingsGoalReached {
    if (!isSavingsPocket || targetAmount == null) return false;
    return savedAmount >= targetAmount!;
  }

  /// Pourcentage de progression vers l'objectif (savings uniquement)
  double get savingsGoalPercentage {
    if (!isSavingsPocket || targetAmount == null || targetAmount == 0) {
      return 0.0;
    }
    return (savedAmount / targetAmount!) * 100;
  }

  /// Montant restant pour atteindre l'objectif (savings uniquement)
  double get remainingSavingsAmount {
    if (!isSavingsPocket || targetAmount == null) return 0.0;
    final remaining = targetAmount! - savedAmount;
    return remaining > 0 ? remaining : 0.0;
  }

  /// Le pocket a-t-il un objectif d'épargne défini ?
  bool get hasSavingsGoal =>
      isSavingsPocket && savingsGoalType != SavingsGoalType.none;

  // =====================================================
  // 📊 CALCULS DE RECOMMANDATIONS (SAVINGS)
  // =====================================================

  /// Calcule le montant quotidien recommandé pour atteindre l'objectif
  double? get recommendedDailySavings {
    if (!isSavingsPocket ||
        targetAmount == null ||
        targetDate == null ||
        isSavingsGoalReached) {
      return null;
    }

    final today = DateTime.now();
    if (targetDate!.isBefore(today)) return null;

    final daysRemaining = targetDate!.difference(today).inDays;
    if (daysRemaining <= 0) return null;

    return remainingSavingsAmount / daysRemaining;
  }

  /// Calcule le montant mensuel recommandé pour atteindre l'objectif
  double? get recommendedMonthlySavings {
    if (!isSavingsPocket ||
        targetAmount == null ||
        targetDate == null ||
        isSavingsGoalReached) {
      return null;
    }

    final today = DateTime.now();
    if (targetDate!.isBefore(today)) return null;

    final monthsRemaining = _calculateMonthsBetween(today, targetDate!);
    if (monthsRemaining <= 0) return null;

    return remainingSavingsAmount / monthsRemaining;
  }

  /// Nombre de jours restants jusqu'à la date cible
  int? get daysUntilTargetDate {
    if (!isSavingsPocket || targetDate == null) return null;

    final today = DateTime.now();
    if (targetDate!.isBefore(today)) return 0;

    return targetDate!.difference(today).inDays;
  }

  /// Nombre de mois restants jusqu'à la date cible
  int? get monthsUntilTargetDate {
    if (!isSavingsPocket || targetDate == null) return null;

    final today = DateTime.now();
    if (targetDate!.isBefore(today)) return 0;

    return _calculateMonthsBetween(today, targetDate!);
  }

  // =====================================================
  // 🎨 HELPERS POUR UI
  // =====================================================

  /// Obtient le nom traduit du pocket (pour les pockets par défaut)
  String getName(dynamic l10n) {
    if (!isDefault) return name;

    return switch (name) {
      PocketKeys.housing => l10n.pocketHousing,
      PocketKeys.food => l10n.pocketFood,
      PocketKeys.transport => l10n.pocketTransport,
      PocketKeys.entertainment => l10n.pocketEntertainment,
      PocketKeys.shopping => l10n.pocketShopping,
      PocketKeys.emergencyFund => l10n.pocketEmergencyFund,
      PocketKeys.vacation => l10n.pocketVacation,
      PocketKeys.projects => l10n.pocketProjects,
      _ => name,
    };
  }

  /// Couleur de la barre de progression selon le pourcentage
  String get progressBarColor {
    if (isSavingsPocket) {
      // Pour l'épargne : toujours vert
      return '#10B981';
    }

    // Pour les dépenses : vert -> orange -> rouge
    final percentage = budgetUsagePercentage;
    if (percentage < 80) return '#10B981'; // Vert
    if (percentage < 100) return '#F97316'; // Orange
    return '#EF4444'; // Rouge
  }

  /// Badge à afficher selon l'état du pocket
  String? getBadgeText(dynamic l10n) {
    if (isExpensePocket && isBudgetExceeded) {
      return l10n.badgeBudgetExceeded;
    }

    if (isSavingsPocket && isSavingsGoalReached) {
      return l10n.badgeGoalReached;
    }

    return null;
  }

  // =====================================================
  // ✅ VALIDATION
  // =====================================================

  /// Valide les données du pocket
  List<String> validate(dynamic l10n) {
    final errors = <String>[];

    // Validation du nom
    if (name.trim().isEmpty) {
      errors.add(l10n.errorPocketNameRequired);
    } else if (name.length > 100) {
      errors.add(l10n.errorPocketNameTooLong);
    }

    // Validation de l'icône
    if (icon.trim().isEmpty) {
      errors.add(l10n.errorPocketIconRequired);
    }

    // Validation de la couleur
    final colorRegex = RegExp(r'^#[0-9A-Fa-f]{6}$');
    if (!colorRegex.hasMatch(color)) {
      errors.add(l10n.errorPocketInvalidColor);
    }

    // Validation selon le type de pocket
    if (isExpensePocket) {
      if (budget < 0) {
        errors.add(l10n.errorPocketBudgetNegative);
      }
      if (spent < 0) {
        errors.add(l10n.errorPocketSpentNegative);
      }
      // Les pockets de dépense ne doivent pas avoir d'épargne
      if (savedAmount != 0.0 || monthlySavingsAmount != null) {
        errors.add(l10n.errorExpensePocketCannotHaveSavings);
      }
    }

    if (isSavingsPocket) {
      if (savedAmount < 0) {
        errors.add(l10n.errorPocketSavedAmountNegative);
      }
      if (monthlySavingsAmount != null && monthlySavingsAmount! < 0) {
        errors.add(l10n.errorPocketMonthlySavingsNegative);
      }
      // Les pockets d'épargne ne doivent pas avoir de budget
      if (budget != 0.0 || spent != 0.0) {
        errors.add(l10n.errorSavingsPocketCannotHaveBudget);
      }

      // Validation de l'objectif d'épargne
      if (savingsGoalType == SavingsGoalType.fixedAmount) {
        if (targetAmount == null || targetAmount! <= 0) {
          errors.add(l10n.errorSavingsGoalAmountRequired);
        }
      }

      if (savingsGoalType == SavingsGoalType.targetDate) {
        if (targetAmount == null || targetAmount! <= 0) {
          errors.add(l10n.errorSavingsGoalAmountRequired);
        }
        if (targetDate == null) {
          errors.add(l10n.errorSavingsGoalDateRequired);
        } else if (targetDate!.isBefore(DateTime.now())) {
          errors.add(l10n.errorSavingsGoalDatePast);
        }
      }
    }

    return errors;
  }

  /// Le pocket est-il valide ?
  bool isValid(dynamic l10n) => validate(l10n).isEmpty;

  // =====================================================
  // 🔧 HELPER METHODS
  // =====================================================

  /// Calcule le nombre de mois entre deux dates
  int _calculateMonthsBetween(DateTime start, DateTime end) {
    return (end.year - start.year) * 12 + (end.month - start.month);
  }
}

// =====================================================
// 📋 EXTENSIONS POUR LISTES DE POCKETS
// =====================================================

extension PocketListExtension on List<PocketEntity> {
  /// Filtre par catégorie
  List<PocketEntity> byCategory(PocketCategory category) =>
      where((p) => p.category == category).toList();

  /// Récupère uniquement les pockets actifs
  List<PocketEntity> get activeOnly => where((p) => p.isActive).toList();

  /// Récupère uniquement les pockets inactifs
  List<PocketEntity> get inactiveOnly => where((p) => !p.isActive).toList();

  /// Récupère uniquement les pockets par défaut
  List<PocketEntity> get defaultOnly => where((p) => p.isDefault).toList();

  /// Récupère uniquement les pockets custom
  List<PocketEntity> get customOnly => where((p) => !p.isDefault).toList();

  /// Récupère les pockets de dépense (needs + wants)
  List<PocketEntity> get expensePockets =>
      where((p) => p.isExpensePocket).toList();

  /// Récupère les pockets d'épargne
  List<PocketEntity> get savingsPockets =>
      where((p) => p.isSavingsPocket).toList();

  /// Récupère les pockets de type needs
  List<PocketEntity> get needs => byCategory(PocketCategory.needs);

  /// Récupère les pockets de type wants
  List<PocketEntity> get wants => byCategory(PocketCategory.wants);

  /// Récupère les pockets de type savings
  List<PocketEntity> get savings => byCategory(PocketCategory.savings);

  /// Calcule le budget total de tous les pockets de dépense
  double get totalBudget =>
      expensePockets.fold(0.0, (sum, p) => sum + p.budget);

  /// Calcule le montant total dépensé
  double get totalSpent => expensePockets.fold(0.0, (sum, p) => sum + p.spent);

  /// Calcule le montant total épargné
  double get totalSaved => savingsPockets.fold(0.0, (sum, p) => sum + p.savedAmount);

  /// Calcule l'épargne mensuelle totale
  double get totalMonthlySavings => savingsPockets.fold(
        0.0,
        (sum, p) => sum + (p.monthlySavingsAmount ?? 0.0),
      );

  /// Récupère les pockets avec budget dépassé
  List<PocketEntity> get overBudget =>
      expensePockets.where((p) => p.isBudgetExceeded).toList();

  /// Récupère les pockets avec objectif atteint
  List<PocketEntity> get goalsReached =>
      savingsPockets.where((p) => p.isSavingsGoalReached).toList();

  /// Trouve un pocket par ID
  PocketEntity? findById(String id) {
    try {
      return firstWhere((p) => p.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Trie les pockets par nom
  List<PocketEntity> sortedByName({bool ascending = true}) {
    final sorted = List<PocketEntity>.from(this);
    sorted.sort((a, b) => ascending
        ? a.name.toLowerCase().compareTo(b.name.toLowerCase())
        : b.name.toLowerCase().compareTo(a.name.toLowerCase()));
    return sorted;
  }

  /// Trie les pockets par budget (décroissant par défaut)
  List<PocketEntity> sortedByBudget({bool ascending = false}) {
    final sorted = List<PocketEntity>.from(this);
    sorted.sort((a, b) =>
        ascending ? a.budget.compareTo(b.budget) : b.budget.compareTo(a.budget));
    return sorted;
  }

  /// Trie les pockets par montant épargné (décroissant par défaut)
  List<PocketEntity> sortedBySavings({bool ascending = false}) {
    final sorted = List<PocketEntity>.from(this);
    sorted.sort((a, b) => ascending
        ? a.savedAmount.compareTo(b.savedAmount)
        : b.savedAmount.compareTo(a.savedAmount));
    return sorted;
  }
}

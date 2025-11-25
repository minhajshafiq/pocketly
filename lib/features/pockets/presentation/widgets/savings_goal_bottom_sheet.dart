import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocketly/core/core.dart';
import 'package:pocketly/features/pockets/domain/entities/pocket_entity.dart';
import 'package:pocketly/features/pockets/presentation/providers/pocket_providers.dart';
import 'package:pocketly/generated/l10n/app_localizations.dart';
import 'package:pocketly/features/notifications/notifications.dart';

/// Bottom sheet pour gérer les objectifs d'épargne d'un pocket savings
///
/// Permet de définir/modifier :
/// - Type d'objectif (none, fixedAmount, targetDate)
/// - Montant cible (si applicable)
/// - Date cible (si applicable)
///
/// Respecte la contrainte database pockets_savings_goal_valid
class SavingsGoalBottomSheet extends ConsumerStatefulWidget {
  final PocketEntity pocket;

  const SavingsGoalBottomSheet({
    super.key,
    required this.pocket,
  });

  /// Affiche le bottom sheet et retourne true si l'objectif a été modifié
  static Future<bool?> show(
    BuildContext context,
    PocketEntity pocket,
  ) {
    return showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => SavingsGoalBottomSheet(pocket: pocket),
    );
  }

  @override
  ConsumerState<SavingsGoalBottomSheet> createState() =>
      _SavingsGoalBottomSheetState();
}

class _SavingsGoalBottomSheetState
    extends ConsumerState<SavingsGoalBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final _targetAmountController = TextEditingController();
  final _monthlySavingsController = TextEditingController();

  late SavingsGoalType _selectedGoalType;
  DateTime? _selectedTargetDate;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Initialiser avec les valeurs actuelles du pocket
    _selectedGoalType = widget.pocket.savingsGoalType;
    _selectedTargetDate = widget.pocket.targetDate;

    if (widget.pocket.targetAmount != null && widget.pocket.targetAmount! > 0) {
      _targetAmountController.text = widget.pocket.targetAmount.toString();
    }

    if (widget.pocket.monthlySavingsAmount != null && widget.pocket.monthlySavingsAmount! > 0) {
      _monthlySavingsController.text = widget.pocket.monthlySavingsAmount.toString();
    }
  }

  @override
  void dispose() {
    _targetAmountController.dispose();
    _monthlySavingsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final pocketColor = Color(int.parse(widget.pocket.color.replaceFirst('#', '0xFF')));

    return PlatformSafeArea(
      bottom: true,
      child: Container(
        decoration: BoxDecoration(
          color: isDark ? AppColors.surfaceDark : AppColors.surface,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(AppDimensions.radiusXL),
            topRight: Radius.circular(AppDimensions.radiusXL),
          ),
        ),
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(AppDimensions.paddingL),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Barre de poignée
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      margin: EdgeInsets.only(bottom: AppDimensions.paddingL),
                      decoration: BoxDecoration(
                        color: isDark
                            ? AppColors.textSecondaryOnDark
                            : AppColors.textSecondary,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),

                  // Header
                  Row(
                    children: [
                      Container(
                        width: AppDimensions.iconXL,
                        height: AppDimensions.iconXL,
                        decoration: BoxDecoration(
                          color: pocketColor.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                        ),
                        child: Icon(
                          AppIcons.getPocketIcon(widget.pocket.icon),
                          color: pocketColor,
                          size: AppDimensions.iconM,
                        ),
                      ),
                      SizedBox(width: AppDimensions.paddingM),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Objectif d\'épargne',
                              style: AppTypography.heading.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: AppDimensions.paddingXS),
                            Text(
                              widget.pocket.getName(l10n),
                              style: AppTypography.label.copyWith(
                                color: pocketColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: AppDimensions.paddingL),

                  // Sélection du type d'objectif
                  Text(
                    'Type d\'objectif',
                    style: AppTypography.bodyBold.copyWith(
                      color: isDark ? AppColors.textOnDark : AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: AppDimensions.paddingS),

                  // Options de type d'objectif
                  Column(
                    children: [
                      _buildGoalTypeOption(
                        context: context,
                        type: SavingsGoalType.none,
                        icon: AppIcons.close,
                        title: 'Aucun objectif',
                        description: 'Épargner sans objectif précis',
                      ),
                      SizedBox(height: AppDimensions.paddingS),
                      _buildGoalTypeOption(
                        context: context,
                        type: SavingsGoalType.fixedAmount,
                        icon: AppIcons.target,
                        title: 'Montant fixe',
                        description: 'Objectif de montant à atteindre',
                      ),
                      SizedBox(height: AppDimensions.paddingS),
                      _buildGoalTypeOption(
                        context: context,
                        type: SavingsGoalType.targetDate,
                        icon: AppIcons.calendar,
                        title: 'Avec date cible',
                        description: 'Objectif de montant avant une date',
                      ),
                    ],
                  ),

                  // Champs conditionnels selon le type d'objectif
                  if (_selectedGoalType != SavingsGoalType.none) ...[
                    SizedBox(height: AppDimensions.paddingL),

                    // Montant cible (obligatoire pour fixedAmount et targetDate)
                    Text(
                      'Montant cible',
                      style: AppTypography.bodyBold.copyWith(
                        color: isDark ? AppColors.textOnDark : AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: AppDimensions.paddingS),

                    TextFormField(
                      controller: _targetAmountController,
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                      ],
                      decoration: InputDecoration(
                        hintText: '0.00',
                        prefixIcon: Icon(
                          AppIcons.currency,
                          color: pocketColor,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                          borderSide: BorderSide(
                            color: isDark
                                ? AppColors.borderDark
                                : AppColors.borderLight,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                          borderSide: BorderSide(
                            color: pocketColor,
                            width: 2,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (_selectedGoalType == SavingsGoalType.none) {
                          return null; // Pas de validation si pas d'objectif
                        }

                        if (value == null || value.isEmpty) {
                          return 'Veuillez entrer un montant cible';
                        }

                        final amount = double.tryParse(value);
                        if (amount == null || amount <= 0) {
                          return 'Le montant doit être supérieur à 0';
                        }

                        return null;
                      },
                    ),

                    // Date cible (obligatoire uniquement pour targetDate)
                    if (_selectedGoalType == SavingsGoalType.targetDate) ...[
                      SizedBox(height: AppDimensions.paddingL),

                      Text(
                        'Date cible',
                        style: AppTypography.bodyBold.copyWith(
                          color: isDark ? AppColors.textOnDark : AppColors.textPrimary,
                        ),
                      ),
                      SizedBox(height: AppDimensions.paddingS),

                      InkWell(
                        onTap: () => _selectDate(context),
                        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: AppDimensions.paddingM,
                            vertical: AppDimensions.paddingM + AppDimensions.paddingXS,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: isDark
                                  ? AppColors.borderDark
                                  : AppColors.borderLight,
                            ),
                            borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                AppIcons.calendar,
                                color: pocketColor,
                              ),
                              SizedBox(width: AppDimensions.paddingM),
                              Expanded(
                                child: Text(
                                  _selectedTargetDate != null
                                      ? _formatDate(_selectedTargetDate!)
                                      : 'Sélectionner une date',
                                  style: AppTypography.body.copyWith(
                                    color: _selectedTargetDate != null
                                        ? (isDark ? AppColors.textOnDark : AppColors.textPrimary)
                                        : (isDark ? AppColors.textSecondaryOnDark : AppColors.textSecondary),
                                  ),
                                ),
                              ),
                              Icon(
                                AppIcons.arrowRight,
                                color: isDark
                                    ? AppColors.textSecondaryOnDark
                                    : AppColors.textSecondary,
                                size: AppDimensions.iconS,
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Message de validation pour la date
                      if (_selectedGoalType == SavingsGoalType.targetDate && _selectedTargetDate == null)
                        Padding(
                          padding: EdgeInsets.only(
                            top: AppDimensions.paddingS,
                            left: AppDimensions.paddingM,
                          ),
                          child: Text(
                            'Une date cible est requise',
                            style: AppTypography.caption.copyWith(
                              color: AppColors.error,
                            ),
                          ),
                        ),
                    ],
                  ],

                  SizedBox(height: AppDimensions.paddingL),

                  // Champ d'épargne mensuelle (optionnel, pour tous les types)
                  Text(
                    'Épargne mensuelle (optionnel)',
                    style: AppTypography.bodyBold.copyWith(
                      color: isDark ? AppColors.textOnDark : AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: AppDimensions.paddingS),

                  TextFormField(
                    controller: _monthlySavingsController,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                    ],
                    decoration: InputDecoration(
                      hintText: '0.00 (optionnel)',
                      helperText: 'Montant à épargner automatiquement chaque mois',
                      helperMaxLines: 2,
                      prefixIcon: Icon(
                        AppIcons.refresh,
                        color: pocketColor,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                        borderSide: BorderSide(
                          color: isDark
                              ? AppColors.borderDark
                              : AppColors.borderLight,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                        borderSide: BorderSide(
                          color: pocketColor,
                          width: 2,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value != null && value.isNotEmpty) {
                        final amount = double.tryParse(value);
                        if (amount == null || amount < 0) {
                          return 'Montant invalide';
                        }
                      }
                      return null;
                    },
                  ),

                  SizedBox(height: AppDimensions.paddingXL),

                  // Bouton de validation
                  AppButton(
                    text: 'Enregistrer l\'objectif',
                    icon: AppIcons.save,
                    onPressed: _isLoading ? null : _handleSubmit,
                    style: AppButtonStyle.gradient,
                    size: AppButtonSize.large,
                    isFullWidth: true,
                    isLoading: _isLoading,
                  ),

                  SizedBox(height: AppDimensions.paddingS),

                  // Bouton annuler
                  AppButton(
                    text: l10n.cancel,
                    onPressed: () => Navigator.of(context).pop(false),
                    style: AppButtonStyle.outline,
                    size: AppButtonSize.large,
                    isFullWidth: true,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGoalTypeOption({
    required BuildContext context,
    required SavingsGoalType type,
    required IconData icon,
    required String title,
    required String description,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isSelected = _selectedGoalType == type;
    final pocketColor = Color(int.parse(widget.pocket.color.replaceFirst('#', '0xFF')));

    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        setState(() {
          _selectedGoalType = type;

          // Si on passe à "none", effacer les champs
          if (type == SavingsGoalType.none) {
            _targetAmountController.clear();
            _selectedTargetDate = null;
          }
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.all(AppDimensions.paddingM),
        decoration: BoxDecoration(
          color: isSelected
              ? pocketColor.withValues(alpha: 0.15)
              : (isDark ? AppColors.surfaceDark : AppColors.surface),
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
          border: Border.all(
            color: isSelected
                ? pocketColor
                : (isDark ? AppColors.borderDark : AppColors.borderLight),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: AppDimensions.iconXL,
              height: AppDimensions.iconXL,
              decoration: BoxDecoration(
                color: isSelected
                    ? pocketColor.withValues(alpha: 0.2)
                    : (isDark ? AppColors.grey800 : AppColors.grey200),
                borderRadius: BorderRadius.circular(AppDimensions.radiusS),
              ),
              child: Icon(
                icon,
                color: isSelected
                    ? pocketColor
                    : (isDark ? AppColors.textSecondaryOnDark : AppColors.textSecondary),
                size: AppDimensions.iconM,
              ),
            ),
            SizedBox(width: AppDimensions.paddingM),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTypography.body.copyWith(
                      color: isSelected
                          ? pocketColor
                          : (isDark ? AppColors.textOnDark : AppColors.textPrimary),
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),
                  SizedBox(height: AppDimensions.paddingXS),
                  Text(
                    description,
                    style: AppTypography.caption.copyWith(
                      color: isDark ? AppColors.textSecondaryOnDark : AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Icon(
                AppIcons.success,
                color: pocketColor,
                size: AppDimensions.iconM,
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final now = DateTime.now();
    final firstDate = now;
    final lastDate = DateTime(now.year + 10);

    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedTargetDate ?? now.add(const Duration(days: 30)),
      firstDate: firstDate,
      lastDate: lastDate,
      builder: (context, child) {
        final pocketColor = Color(int.parse(widget.pocket.color.replaceFirst('#', '0xFF')));
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: pocketColor,
              onPrimary: AppColors.textOnDark,
              surface: AppColors.surface,
              onSurface: AppColors.textPrimary,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _selectedTargetDate = picked;
      });
    }
  }

  String _formatDate(DateTime date) {
    final months = [
      'Janvier', 'Février', 'Mars', 'Avril', 'Mai', 'Juin',
      'Juillet', 'Août', 'Septembre', 'Octobre', 'Novembre', 'Décembre'
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

  Future<void> _handleSubmit() async {
    // Validation spéciale pour targetDate
    if (_selectedGoalType == SavingsGoalType.targetDate && _selectedTargetDate == null) {
      InAppNotificationService.showError(
        context,
        message: 'Veuillez sélectionner une date cible',
      );
      return;
    }

    if (!_formKey.currentState!.validate()) {
      return;
    }

    final l10n = AppLocalizations.of(context)!;

    setState(() {
      _isLoading = true;
    });

    try {
      // Préparer les valeurs selon le type d'objectif
      double? targetAmount;
      DateTime? targetDate;

      if (_selectedGoalType == SavingsGoalType.none) {
        // Aucun objectif : targetAmount et targetDate doivent être NULL
        targetAmount = null;
        targetDate = null;
      } else if (_selectedGoalType == SavingsGoalType.fixedAmount) {
        // Montant fixe : targetAmount requis, targetDate NULL
        targetAmount = double.parse(_targetAmountController.text);
        targetDate = null;
      } else if (_selectedGoalType == SavingsGoalType.targetDate) {
        // Avec date : targetAmount et targetDate requis
        targetAmount = double.parse(_targetAmountController.text);
        targetDate = _selectedTargetDate;
      }

      // Préparer l'épargne mensuelle (optionnel)
      double? monthlySavings;
      if (_monthlySavingsController.text.isNotEmpty) {
        monthlySavings = double.tryParse(_monthlySavingsController.text);
      }

      // Créer le pocket mis à jour avec TOUS les champs requis
      final updatedPocket = widget.pocket.copyWith(
        savingsGoalType: _selectedGoalType,
        targetAmount: targetAmount,
        targetDate: targetDate,
        monthlySavingsAmount: monthlySavings,
      );

      // Sauvegarder
      final controller = ref.read(pocketControllerProvider.notifier);
      await controller.updatePocket(updatedPocket);

      if (mounted) {
        // Fermer le bottom sheet avec succès
        Navigator.of(context).pop(true);

        // Afficher notification de succès
        InAppNotificationService.showSuccess(
          context,
          message: 'Objectif d\'épargne mis à jour',
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });

        InAppNotificationService.showError(
          context,
          message: '${l10n.notificationErrorMessage}: ${e.toString()}',
        );
      }
    }
  }
}

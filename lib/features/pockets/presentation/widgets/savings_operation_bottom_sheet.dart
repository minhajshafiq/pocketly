import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocketly/core/core.dart';
import 'package:pocketly/features/currency/currency.dart';
import 'package:pocketly/features/pockets/domain/entities/pocket_entity.dart';
import 'package:pocketly/features/pockets/presentation/providers/pocket_providers.dart';
import 'package:pocketly/generated/l10n/app_localizations.dart';
import 'package:pocketly/features/notifications/notifications.dart';

/// Type d'opération sur l'épargne
enum SavingsOperationType {
  add,      // Ajouter de l'argent
  withdraw; // Retirer de l'argent
}

/// Bottom sheet pour ajouter ou retirer de l'argent d'un pocket d'épargne
///
/// Affiche un formulaire avec :
/// - Choix de l'opération (ajouter/retirer)
/// - Champ de montant
/// - Note optionnelle
class SavingsOperationBottomSheet extends ConsumerStatefulWidget {
  final PocketEntity pocket;

  const SavingsOperationBottomSheet({
    super.key,
    required this.pocket,
  });

  /// Affiche le bottom sheet et retourne true si une opération a été effectuée
  static Future<bool?> show(
    BuildContext context,
    PocketEntity pocket,
  ) {
    return showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => SavingsOperationBottomSheet(pocket: pocket),
    );
  }

  @override
  ConsumerState<SavingsOperationBottomSheet> createState() =>
      _SavingsOperationBottomSheetState();
}

class _SavingsOperationBottomSheetState
    extends ConsumerState<SavingsOperationBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  SavingsOperationType _operationType = SavingsOperationType.add;
  bool _isLoading = false;

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final pocketColor = Color(int.parse(widget.pocket.color.replaceFirst('#', '0xFF')));

    return PlatformSafeArea(
      bottom: null, // Auto: true sur Android, false sur iOS
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

                  // Header avec icône et nom du pocket
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
                              widget.pocket.getName(l10n),
                              style: AppTypography.heading.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: AppDimensions.paddingXS),
                            CurrencyAmountText(
                              amount: widget.pocket.savedAmount,
                              style: AppTypography.label.copyWith(
                                color: AppColors.successDark,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: AppDimensions.paddingL),

                  // Sélection du type d'opération
                  Text(
                    'Type d\'opération',
                    style: AppTypography.bodyBold.copyWith(
                      color: isDark ? AppColors.textOnDark : AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: AppDimensions.paddingS),

                  // Toggle buttons pour add/withdraw
                  Row(
                    children: [
                      Expanded(
                        child: _buildOperationButton(
                          context: context,
                          type: SavingsOperationType.add,
                          icon: AppIcons.income,
                          label: 'Ajouter',
                          color: AppColors.success,
                          isSelected: _operationType == SavingsOperationType.add,
                        ),
                      ),
                      SizedBox(width: AppDimensions.paddingM),
                      Expanded(
                        child: _buildOperationButton(
                          context: context,
                          type: SavingsOperationType.withdraw,
                          icon: AppIcons.expense,
                          label: 'Retirer',
                          color: AppColors.error,
                          isSelected: _operationType == SavingsOperationType.withdraw,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: AppDimensions.paddingL),

                  // Champ de montant
                  Text(
                    'Montant',
                    style: AppTypography.bodyBold.copyWith(
                      color: isDark ? AppColors.textOnDark : AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: AppDimensions.paddingS),

                  TextFormField(
                    controller: _amountController,
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
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer un montant';
                      }

                      final amount = double.tryParse(value);
                      if (amount == null || amount <= 0) {
                        return 'Montant invalide';
                      }

                      // Vérifier qu'on ne retire pas plus que disponible
                      if (_operationType == SavingsOperationType.withdraw &&
                          amount > widget.pocket.savedAmount) {
                        return 'Montant supérieur à l\'épargne disponible';
                      }

                      return null;
                    },
                    autofocus: true,
                  ),

                  SizedBox(height: AppDimensions.paddingXL),

                  // Bouton de validation
                  AppButton(
                    text: _operationType == SavingsOperationType.add
                        ? 'Ajouter à l\'épargne'
                        : 'Retirer de l\'épargne',
                    icon: _operationType == SavingsOperationType.add
                        ? AppIcons.add
                        : AppIcons.expense,
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

  Widget _buildOperationButton({
    required BuildContext context,
    required SavingsOperationType type,
    required IconData icon,
    required String label,
    required Color color,
    required bool isSelected,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        setState(() {
          _operationType = type;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.all(AppDimensions.paddingM),
        decoration: BoxDecoration(
          color: isSelected
              ? color.withValues(alpha: 0.15)
              : (isDark ? AppColors.surfaceDark : AppColors.surface),
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
          border: Border.all(
            color: isSelected
                ? color
                : (isDark ? AppColors.borderDark : AppColors.borderLight),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: isSelected
                  ? color
                  : (isDark ? AppColors.textSecondaryOnDark : AppColors.textSecondary),
              size: AppDimensions.iconM,
            ),
            SizedBox(height: AppDimensions.paddingS),
            Text(
              label,
              style: AppTypography.body.copyWith(
                color: isSelected
                    ? color
                    : (isDark ? AppColors.textOnDark : AppColors.textPrimary),
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final amount = double.parse(_amountController.text);
    final l10n = AppLocalizations.of(context)!;

    setState(() {
      _isLoading = true;
    });

    try {
      // L'épargne est une allocation interne du budget, pas une transaction réelle
      // On met simplement à jour le savedAmount du pocket
      // Le solde disponible sera calculé comme : (revenus - dépenses) - total_épargne

      final pocketController = ref.read(pocketControllerProvider.notifier);
      if (_operationType == SavingsOperationType.add) {
        await pocketController.addToSavings(widget.pocket.id!, amount);
      } else {
        await pocketController.withdrawFromSavings(widget.pocket.id!, amount);
      }

      if (mounted) {
        // Fermer le bottom sheet avec succès
        Navigator.of(context).pop(true);

        // Afficher notification de succès
        InAppNotificationService.showSuccess(
          context,
          message: _operationType == SavingsOperationType.add
              ? 'Montant ajouté avec succès'
              : 'Montant retiré avec succès',
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

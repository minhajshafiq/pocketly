import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:pocketly/core/core.dart';
import 'package:pocketly/core/widgets/animated_page_header.dart';
import 'package:pocketly/core/widgets/platform_safe_area.dart';
import 'package:pocketly/core/constants/app_dimensions.dart';
import 'package:pocketly/core/constants/app_colors.dart';
import 'package:pocketly/core/constants/app_typography.dart';
import 'package:pocketly/features/pockets/domain/entities/pocket_entity.dart';
import 'package:pocketly/features/pockets/presentation/providers/pocket_providers.dart';
import 'package:pocketly/features/pockets/presentation/widgets/pocket_icon_picker.dart';
import 'package:pocketly/features/pockets/presentation/widgets/pocket_color_picker.dart';
import 'package:pocketly/generated/l10n/app_localizations.dart';
import 'package:pocketly/features/notifications/notifications.dart';

/// Écran d'édition d'un pocket
class EditPocketScreen extends ConsumerStatefulWidget {
  final String pocketId;

  const EditPocketScreen({
    super.key,
    required this.pocketId,
  });

  @override
  ConsumerState<EditPocketScreen> createState() => _EditPocketScreenState();
}

class _EditPocketScreenState extends ConsumerState<EditPocketScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _budgetController = TextEditingController();
  final _targetAmountController = TextEditingController();
  final _scrollController = ScrollController();
  String? _selectedIcon;
  String? _selectedColor;
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _budgetController.dispose();
    _targetAmountController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final pocketAsync = ref.watch(pocketByIdProvider(widget.pocketId));

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.background,
      body: PlatformSafeArea(
        top: true,
        bottom: null, // Auto: true sur Android, false sur iOS
        padding: EdgeInsets.only(top: AppDimensions.paddingS),
        child: pocketAsync.when(
        data: (pocket) {
          if (pocket == null) {
              return Center(child: Text(l10n.pocketNotFound));
          }

          // Initialiser les valeurs
          if (_nameController.text.isEmpty) {
            _nameController.text = pocket.name;
            _budgetController.text = pocket.budget > 0 ? pocket.budget.toString() : '';
            // Note: targetAmount n'est plus modifiable dans cet écran
            _selectedIcon = pocket.icon;
            _selectedColor = pocket.color;
          }

            return Stack(
              children: [
                SingleChildScrollView(
                  controller: _scrollController,
                  padding: EdgeInsets.only(
                    top: 80 + AppDimensions.paddingM,
                    left: AppDimensions.paddingM,
                    right: AppDimensions.paddingM,
                    bottom: Platform.isAndroid 
                        ? AppDimensions.paddingXL * 2 // Plus d'espace pour les boutons Android
                        : AppDimensions.paddingM,
                  ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nom
                        Text(
                          l10n.pocketName,
                          style: AppTypography.title.copyWith(
                            color: isDark ? AppColors.textOnDark : AppColors.textPrimary,
                          ),
                        ).animate().fadeIn().slideX(begin: -0.2, end: 0),
                        SizedBox(height: AppDimensions.paddingM),
                        AppTextField(
                    controller: _nameController,
                          label: l10n.pocketName,
                          hint: l10n.pocketNameHint,
                          enabled: !pocket.isDefault,
                    validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return l10n.errorPocketNameRequired;
                      }
                      return null;
                    },
                        ).animate().fadeIn(delay: 100.ms).slideX(begin: -0.2, end: 0),

                  if (pocket.isDefault)
                    Padding(
                            padding: EdgeInsets.only(top: AppDimensions.paddingS, bottom: AppDimensions.paddingM),
                      child: Text(
                              l10n.defaultPocketNameCannotBeModified,
                        style: AppTypography.small.copyWith(
                          color: Colors.orange[700],
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),

                        // Budget/Objectif (conditionnel selon le type de pocket)
                        if (pocket.isExpensePocket) ...[
                          SizedBox(height: AppDimensions.paddingL),
                          Text(
                            l10n.monthlyBudget,
                            style: AppTypography.title.copyWith(
                              color: isDark ? AppColors.textOnDark : AppColors.textPrimary,
                            ),
                          ).animate().fadeIn(delay: 150.ms).slideX(begin: -0.2, end: 0),
                          SizedBox(height: AppDimensions.paddingM),
                          AppTextField(
                            controller: _budgetController,
                            label: l10n.monthlyBudget,
                            hint: '0.00',
                            type: AppTextFieldType.number,
                            suffixIcon: Padding(
                              padding: EdgeInsets.only(right: AppDimensions.paddingM),
                              child: Text(
                                '€',
                                style: AppTypography.body.copyWith(
                                  color: isDark ? AppColors.textSecondaryOnDark : AppColors.textSecondary,
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value != null && value.trim().isNotEmpty) {
                                final budget = double.tryParse(value.trim());
                                if (budget == null || budget < 0) {
                                  return l10n.errorPocketBudgetNegative;
                                }
                              }
                              return null;
                            },
                            onChanged: (value) {
                              // Filtrer les caractères non numériques
                              final filtered = value.replaceAll(RegExp(r'[^\d.]'), '');
                              if (filtered != value) {
                                _budgetController.value = TextEditingValue(
                                  text: filtered,
                                  selection: TextSelection.collapsed(offset: filtered.length),
                                );
                              }
                            },
                          ).animate().fadeIn(delay: 200.ms).slideX(begin: -0.2, end: 0),
                        ] else if (pocket.isSavingsPocket) ...[
                          // NOTE: L'édition des objectifs d'épargne (savingsGoalType, targetAmount, targetDate)
                          // est désactivée dans cet écran car ces champs sont interdépendants
                          // et doivent être modifiés ensemble via une interface dédiée
                          // pour respecter la contrainte database pockets_savings_goal_valid
                          SizedBox(height: AppDimensions.paddingL),
                          AppCard(
                            padding: EdgeInsets.all(AppDimensions.paddingM),
                            child: Row(
                              children: [
                                Icon(
                                  AppIcons.info,
                                  color: AppColors.infoLight,
                                  size: AppDimensions.iconM,
                                ),
                                SizedBox(width: AppDimensions.paddingM),
                                Expanded(
                                  child: Text(
                                    'Les objectifs d\'épargne ne peuvent pas être modifiés dans cet écran. Utilisez l\'écran de détails du pocket.',
                                    style: AppTypography.caption.copyWith(
                                      color: isDark ? AppColors.textSecondaryOnDark : AppColors.textSecondary,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ).animate().fadeIn(delay: 150.ms).slideX(begin: -0.2, end: 0),
                        ],

                        SizedBox(height: AppDimensions.paddingL),

                        // Sélection de l'icône
                        Text(
                          l10n.selectIcon,
                          style: AppTypography.title.copyWith(
                            color: isDark ? AppColors.textOnDark : AppColors.textPrimary,
                          ),
                        ).animate().fadeIn(delay: 250.ms).slideX(begin: -0.2, end: 0),
                        SizedBox(height: AppDimensions.paddingM),
                        PocketIconPicker(
                          selectedIcon: _selectedIcon,
                          onIconSelected: (icon) {
                            setState(() => _selectedIcon = icon);
                          },
                        ).animate().fadeIn(delay: 300.ms).slideX(begin: -0.2, end: 0),

                        SizedBox(height: AppDimensions.paddingL),

                        // Sélection de la couleur
                        Text(
                          l10n.selectColor,
                          style: AppTypography.title.copyWith(
                            color: isDark ? AppColors.textOnDark : AppColors.textPrimary,
                          ),
                        ).animate().fadeIn(delay: 350.ms).slideX(begin: -0.2, end: 0),
                        SizedBox(height: AppDimensions.paddingM),
                        PocketColorPicker(
                          selectedColor: _selectedColor,
                          onColorSelected: (color) {
                            setState(() => _selectedColor = color);
                          },
                        ).animate().fadeIn(delay: 400.ms).slideX(begin: -0.2, end: 0),

                        SizedBox(height: AppDimensions.paddingL),

                  // Catégorie (lecture seule)
                  Text(
                          l10n.category,
                          style: AppTypography.title.copyWith(
                            color: isDark ? AppColors.textOnDark : AppColors.textPrimary,
                  ),
                        ).animate().fadeIn(delay: 450.ms).slideX(begin: -0.2, end: 0),
                        SizedBox(height: AppDimensions.paddingM),
                  AppCard(
                          padding: EdgeInsets.all(AppDimensions.paddingM),
                    child: Row(
                      children: [
                        Icon(
                                AppIcons.getPocketIcon(pocket.icon),
                          color: Color(int.parse(pocket.color.replaceFirst('#', '0xFF'))),
                                size: AppDimensions.iconM,
                        ),
                              SizedBox(width: AppDimensions.paddingM),
                        Text(
                          pocket.category.getName(l10n),
                          style: AppTypography.body.copyWith(fontWeight: FontWeight.w500),
                        ),
                        const Spacer(),
                        Text(
                                l10n.nonEditable,
                          style: AppTypography.small.copyWith(
                                  color: isDark ? AppColors.textSecondaryOnDark : AppColors.textSecondary,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                        ).animate().fadeIn(delay: 500.ms).slideX(begin: -0.2, end: 0),

                        SizedBox(height: AppDimensions.paddingXL),

                  // Bouton Enregistrer
                  AppButton(
                          text: _isLoading ? l10n.saving : l10n.save,
                    onPressed: _isLoading ? null : () => _savePocket(pocket),
                    style: AppButtonStyle.primary,
                    size: AppButtonSize.large,
                    isFullWidth: true,
                          icon: AppIcons.save,
                        ).animate().fadeIn(delay: 550.ms).slideY(begin: 0.2, end: 0),
                ],
              ),
            ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: AnimatedPageHeader(
                    title: l10n.editPocket,
                    scrollController: _scrollController,
                    showBackButton: true,
                  ),
                ),
              ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: ErrorDisplay(
            error: error is AppError
                ? error
                : UnknownError(
                    technicalMessage: error.toString(),
                    stackTrace: stack,
                  ),
            onRetry: () {
              ref.invalidate(pocketByIdProvider(widget.pocketId));
            },
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _savePocket(PocketEntity originalPocket) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    ref.read(loggerProvider).d('Début de _savePocket');

    setState(() {
      _isLoading = true;
    });

    try {
      ref.read(loggerProvider).d('Création de updatedPocket');
      // Créer le pocket modifié
      final updatedPocket = originalPocket.copyWith(
        name: originalPocket.isDefault ? originalPocket.name : _nameController.text.trim(),
        icon: _selectedIcon ?? originalPocket.icon,
        color: _selectedColor ?? originalPocket.color,
        budget: originalPocket.isExpensePocket
            ? (double.tryParse(_budgetController.text) ?? originalPocket.budget)
            : originalPocket.budget,
        // NE PAS modifier targetAmount, savingsGoalType, targetDate ici
        // car cela violerait la contrainte pockets_savings_goal_valid
        // Ces champs doivent être modifiés ensemble via une interface dédiée
        // Pour l'instant, on garde les valeurs existantes
      );

      ref.read(loggerProvider).d('Lecture du notifier (AVANT await)');
      // IMPORTANT: Capturer la référence du notifier AVANT l'opération async
      // pour éviter l'erreur "Ref disposed" après le await
      final notifier = ref.read(pocketControllerProvider.notifier);

      ref.read(loggerProvider).d('Appel de updatePocket (await)');
      // Sauvegarder en utilisant la référence capturée
      await notifier.updatePocket(updatedPocket);

      ref.read(loggerProvider).i('updatePocket terminé avec succès');

      if (mounted) {
        ref.read(loggerProvider).d('Invalidation du cache (APRÈS l\'opération)');
        // Invalider le cache maintenant que l'opération est terminée
        // Vérifier que le widget est toujours monté avant d'utiliser ref
        if (mounted) {
          ref.invalidate(userPocketsProvider);
          ref.invalidate(pocketByIdProvider(widget.pocketId));
        }

        ref.read(loggerProvider).d('Widget monté, affichage de la notification');
        // Afficher un message de succès
        final l10n = AppLocalizations.of(context)!;
        InAppNotificationService.showSuccess(
          context,
          message: l10n.notificationSuccessMessage,
        );

        ref.read(loggerProvider).d('Navigation pop');
        // Retourner à l'écran précédent avec un résultat pour indiquer le succès
        Navigator.of(context).pop(true);
      } else {
        ref.read(loggerProvider).w('Widget démonté, pas de navigation');
      }
    } catch (e, stackTrace) {
      ref.read(loggerProvider).e('ERREUR capturée lors de la sauvegarde du pocket', error: e, stackTrace: stackTrace);

      if (mounted) {
        setState(() {
          _isLoading = false;
        });

        final l10n = AppLocalizations.of(context)!;
        InAppNotificationService.showError(
          context,
          message: '${l10n.notificationErrorMessage}: ${e.toString()}',
        );
      } else {
        ref.read(loggerProvider).w('Widget démonté, impossible d\'afficher l\'erreur');
      }
    }
  }

}

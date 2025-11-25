import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:pocketly/core/widgets/animated_page_header.dart';
import 'package:pocketly/core/widgets/app_button.dart';
import 'package:pocketly/core/widgets/app_text_field.dart';
import 'package:pocketly/core/widgets/platform_safe_area.dart';
import 'package:pocketly/core/constants/app_dimensions.dart';
import 'package:pocketly/core/constants/app_colors.dart';
import 'package:pocketly/core/constants/app_typography.dart';
import 'package:pocketly/core/router/app_route_paths.dart';
import 'package:pocketly/features/category/domain/entities/category_entity.dart';
import 'package:pocketly/features/category/presentation/providers/category_provider.dart';
import 'package:pocketly/generated/l10n/app_localizations.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:pocketly/features/notifications/notifications.dart';
import 'package:pocketly/features/pockets/pockets.dart';

/// Écran d'ajout ou de modification d'une catégorie personnalisée
class AddEditCategoryScreen extends ConsumerStatefulWidget {
  /// La catégorie à modifier (null si création)
  final CategoryEntity? category;

  /// Le type de catégorie par défaut (pour la création)
  final CategoryType? defaultType;

  const AddEditCategoryScreen({super.key, this.category, this.defaultType});

  @override
  ConsumerState<AddEditCategoryScreen> createState() =>
      _AddEditCategoryScreenState();
}

class _AddEditCategoryScreenState extends ConsumerState<AddEditCategoryScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _scrollController = ScrollController();

  String _selectedIcon = 'circle';
  String _selectedColor = '#FFB3BA'; // Rose pâle par défaut
  late CategoryType _selectedType;
  bool _isLoading = false;

  bool get _isEditing => widget.category != null;

  @override
  void initState() {
    super.initState();

    if (_isEditing) {
      // Mode édition
      _nameController.text = widget.category!.name;
      _selectedIcon = widget.category!.iconName;
      _selectedColor = widget.category!.color;
      _selectedType = widget.category!.type;
    } else {
      // Mode création
      _selectedType = widget.defaultType ?? CategoryType.expense;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final l10n = AppLocalizations.of(context)!;

    setState(() => _isLoading = true);

    try {
      if (_isEditing) {
        // Mode édition - on peut modifier le nom, l'icône et la couleur
        // Le type ne peut pas être modifié après création
        await ref
            .read(categoryProvider.notifier)
            .updateCustomCategory(
              categoryId: widget.category!.id!,
              name: _nameController.text.trim(),
              iconName: _selectedIcon,
              color: _selectedColor,
            );
      } else {
        // Créer une nouvelle catégorie
        await ref
            .read(categoryProvider.notifier)
            .createCustomCategory(
              name: _nameController.text.trim(),
              type: _selectedType,
              iconName: _selectedIcon,
              color: _selectedColor,
            );
      }

      if (mounted) {
        // Afficher la notification de succès
        InAppNotificationService.showSuccess(
          context,
          title: l10n.success,
          message: _isEditing
              ? l10n.categoryUpdatedSuccess
              : l10n.categoryCreatedSuccess,
        );

        // Retourner en arrière au lieu de go pour éviter l'écran noir
        // Le cache local a déjà été mis à jour dans le repository,
        // donc pas besoin de recharger les catégories
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        final l10n = AppLocalizations.of(context)!;
        String errorMessage;

        if (e.toString().contains('Premium')) {
          errorMessage = l10n.premiumRequiredForCustomCategories;
        } else {
          errorMessage = _isEditing
              ? l10n.errorUpdatingCategory
              : l10n.errorCreatingCategory;
        }

        InAppNotificationService.showError(
          context,
          title: l10n.error,
          message: errorMessage,
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isIOS = Platform.isIOS;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.background,
      body: PlatformSafeArea(
        top: true,
        bottom: null, // Auto: true sur Android, false sur iOS
        padding: EdgeInsets.only(top: AppDimensions.paddingS),
        child: Stack(
          children: [
            // Contenu scrollable
            Form(
              key: _formKey,
              child: ListView(
                controller: _scrollController,
                padding: EdgeInsets.only(
                  top: 80 + AppDimensions.paddingM, // Header + padding
                  left: AppDimensions.paddingM,
                  right: AppDimensions.paddingM,
                  bottom: Platform.isAndroid
                      ? AppDimensions.paddingXL *
                            2 // Plus d'espace pour les boutons Android
                      : AppDimensions.paddingM,
                ),
                children: [
                  // Type indicator
                  _buildTypeIndicator(l10n, isDark),
                  SizedBox(height: AppDimensions.paddingL),

                  // Name field
                  AppTextField(
                    controller: _nameController,
                    label: l10n.categoryName,
                    hint: l10n.categoryNameHint,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return l10n.errorCategoryNameRequired;
                      }
                      if (value.length > 50) {
                        return l10n.errorCategoryNameTooLong;
                      }
                      return null;
                    },
                  ).animate().fadeIn(delay: 100.ms).slideY(begin: -0.2, end: 0),

                  SizedBox(height: AppDimensions.paddingL),

                  // Type selector (only for creation)
                  if (!_isEditing) ...[
                    _buildTypeSelector(l10n, isIOS, isDark),
                    SizedBox(height: AppDimensions.paddingL),
                  ],

                  // Icon picker
                  Text(
                    l10n.selectIcon,
                    style: AppTypography.title.copyWith(
                      color: isDark
                          ? AppColors.textOnDark
                          : AppColors.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ).animate().fadeIn(delay: 200.ms).slideY(begin: -0.2, end: 0),
                  SizedBox(height: AppDimensions.paddingM),
                  PocketIconPicker(
                    selectedIcon: _selectedIcon,
                    onIconSelected: (icon) {
                      setState(() => _selectedIcon = icon);
                    },
                  ).animate().fadeIn(delay: 250.ms),

                  SizedBox(height: AppDimensions.paddingXL),

                  // Color picker
                  Text(
                    l10n.selectColor,
                    style: AppTypography.title.copyWith(
                      color: isDark
                          ? AppColors.textOnDark
                          : AppColors.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ).animate().fadeIn(delay: 300.ms).slideY(begin: -0.2, end: 0),
                  SizedBox(height: AppDimensions.paddingM),
                  PocketColorPicker(
                    selectedColor: _selectedColor,
                    onColorSelected: (color) {
                      setState(() => _selectedColor = color);
                    },
                  ).animate().fadeIn(delay: 350.ms),

                  SizedBox(height: AppDimensions.paddingXXL),

                  // Submit button
                  AppButton(
                    text: _isEditing
                        ? l10n.updateCategory
                        : l10n.createCategory,
                    onPressed: _isLoading ? null : _handleSubmit,
                    isLoading: _isLoading,
                  ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.2, end: 0),

                  // Delete button (only in edit mode)
                  if (_isEditing) ...[
                    SizedBox(height: AppDimensions.paddingM),
                    OutlinedButton(
                          onPressed: _isLoading ? null : _handleDelete,
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppColors.error,
                            side: BorderSide(color: AppColors.error),
                            padding: EdgeInsets.symmetric(
                              vertical: AppDimensions.paddingM,
                              horizontal: AppDimensions.paddingL,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                AppDimensions.radiusM,
                              ),
                            ),
                          ),
                          child: Text(
                            l10n.deleteCategory,
                            style: AppTypography.body.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )
                        .animate()
                        .fadeIn(delay: 450.ms)
                        .slideY(begin: 0.2, end: 0),
                  ],
                ],
              ),
            ),

            // Header sticky animé
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: AnimatedPageHeader(
                title: _isEditing ? l10n.editCategory : l10n.createCategory,
                scrollController: _scrollController,
                showBackButton: true,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTypeIndicator(AppLocalizations l10n, bool isDark) {
    final color = _selectedType == CategoryType.expense
        ? const Color(0xFFF48A99)
        : const Color(0xFF78D078);

    final icon = _selectedType == CategoryType.expense
        ? LucideIcons.trendingDown
        : LucideIcons.trendingUp;

    final label = _selectedType == CategoryType.expense
        ? l10n.expenseCategory
        : l10n.incomeCategory;

    return Container(
      padding: EdgeInsets.all(AppDimensions.paddingM),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: AppDimensions.iconL),
          SizedBox(width: AppDimensions.paddingM),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: AppTypography.title.copyWith(
                    color: color,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: AppDimensions.paddingXS),
                Text(
                  _selectedType == CategoryType.expense
                      ? l10n.expenseCategoryDescription
                      : l10n.incomeCategoryDescription,
                  style: AppTypography.caption.copyWith(
                    color: isDark
                        ? AppColors.textSecondaryOnDark
                        : AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn().slideY(begin: -0.2, end: 0);
  }

  Widget _buildTypeSelector(AppLocalizations l10n, bool isIOS, bool isDark) {
    final types = [CategoryType.expense, CategoryType.income];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.categoryType,
          style: AppTypography.title.copyWith(
            color: isDark ? AppColors.textOnDark : AppColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: AppDimensions.paddingM),
        Row(
          children: types.map((type) {
            final isSelected = _selectedType == type;
            final label = type == CategoryType.expense
                ? l10n.expense
                : l10n.income;
            final icon = type == CategoryType.expense
                ? LucideIcons.trendingDown
                : LucideIcons.trendingUp;

            return Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppDimensions.paddingXS,
                ),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedType = type;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: AppDimensions.paddingM,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.primary.withOpacity(isDark ? 0.3 : 0.15)
                          : (isDark
                                ? AppColors.surfaceDark
                                : AppColors.surface),
                      borderRadius: BorderRadius.circular(
                        AppDimensions.radiusM,
                      ),
                      border: Border.all(
                        color: isSelected
                            ? AppColors.primary
                            : (isDark
                                  ? AppColors.borderDark
                                  : AppColors.borderLight),
                        width: 2,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          icon,
                          color: isSelected
                              ? AppColors.primary
                              : (isDark
                                    ? AppColors.textSecondaryOnDark
                                    : AppColors.textSecondary),
                          size: AppDimensions.iconM,
                        ),
                        SizedBox(width: AppDimensions.paddingS),
                        Text(
                          label,
                          style: AppTypography.body.copyWith(
                            color: isSelected
                                ? AppColors.primary
                                : (isDark
                                      ? AppColors.textSecondaryOnDark
                                      : AppColors.textSecondary),
                            fontWeight: isSelected
                                ? FontWeight.w700
                                : FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    ).animate().fadeIn(delay: 150.ms).slideY(begin: -0.2, end: 0);
  }

  Future<void> _handleDelete() async {
    if (widget.category == null) return;

    final l10n = AppLocalizations.of(context)!;
    final isIOS = Platform.isIOS;

    // Confirmation dialog
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) {
        if (isIOS) {
          return CupertinoAlertDialog(
            title: Text(l10n.deleteCategory),
            content: Text(l10n.deleteCategoryConfirmation),
            actions: [
              CupertinoDialogAction(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(l10n.cancel),
              ),
              CupertinoDialogAction(
                onPressed: () => Navigator.of(context).pop(true),
                isDestructiveAction: true,
                child: Text(l10n.delete),
              ),
            ],
          );
        } else {
          return AlertDialog(
            title: Text(l10n.deleteCategory),
            content: Text(l10n.deleteCategoryConfirmation),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(l10n.cancel),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                style: TextButton.styleFrom(foregroundColor: AppColors.error),
                child: Text(l10n.delete),
              ),
            ],
          );
        }
      },
    );

    if (confirmed != true || !mounted) return;

    setState(() => _isLoading = true);

    try {
      await ref
          .read(categoryProvider.notifier)
          .deleteCustomCategory(widget.category!.id!);

      if (mounted) {
        InAppNotificationService.showSuccess(
          context,
          title: l10n.success,
          message: l10n.categoryDeletedSuccess,
        );

        context.go(AppRoutePaths.categories);
      }
    } catch (e) {
      if (mounted) {
        InAppNotificationService.showError(
          context,
          title: l10n.error,
          message: l10n.errorDeletingCategory,
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }
}

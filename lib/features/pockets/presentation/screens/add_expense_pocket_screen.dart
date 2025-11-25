import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:pocketly/core/core.dart';
import 'package:pocketly/core/widgets/animated_page_header.dart';
import 'package:pocketly/core/widgets/app_button.dart';
import 'package:pocketly/core/widgets/app_text_field.dart';
import 'package:pocketly/core/widgets/platform_safe_area.dart';
import 'package:pocketly/core/constants/app_dimensions.dart';
import 'package:pocketly/core/constants/app_colors.dart';
import 'package:pocketly/core/constants/app_typography.dart';
import 'package:pocketly/core/router/app_route_paths.dart';
import 'package:pocketly/features/pockets/domain/entities/pocket_entity.dart';
import 'package:pocketly/features/pockets/presentation/providers/pocket_providers.dart';
import 'package:pocketly/features/pockets/presentation/widgets/pocket_icon_picker.dart';
import 'package:pocketly/features/pockets/presentation/widgets/pocket_color_picker.dart';
import 'package:pocketly/generated/l10n/app_localizations.dart';
import 'package:pocketly/features/auth/auth.dart';
import 'package:pocketly/features/notifications/domain/usecases/in_app_notification_service.dart';

/// Écran d'ajout d'un pocket de type dépense (Wants ou Needs)
class AddExpensePocketScreen extends ConsumerStatefulWidget {
  final PocketCategory category;

  const AddExpensePocketScreen({
    super.key,
    required this.category,
  }) : assert(
          category == PocketCategory.wants || category == PocketCategory.needs,
          'AddExpensePocketScreen only accepts wants or needs category',
        );

  @override
  ConsumerState<AddExpensePocketScreen> createState() =>
      _AddExpensePocketScreenState();
}

class _AddExpensePocketScreenState
    extends ConsumerState<AddExpensePocketScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _budgetController = TextEditingController();
  final _scrollController = ScrollController();

  String _selectedIcon = 'category';
  String _selectedColor = '#F48A99'; // Default pink

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Set default color based on category
    _selectedColor = widget.category == PocketCategory.needs
        ? '#F48A99' // Pink for needs
        : '#78D078'; // Green for wants
  }

  @override
  void dispose() {
    _nameController.dispose();
    _budgetController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isLoading = true);

    try {
      final userId = ref.read(currentUserIdProvider);
      if (userId == null) {
        throw Exception('User not authenticated');
      }

      final pocket = PocketEntity.expense(
        name: _nameController.text.trim(),
        icon: _selectedIcon,
        color: _selectedColor,
        category: widget.category,
        budget: double.parse(_budgetController.text.trim()),
        userId: userId,
      );

      await ref.read(pocketControllerProvider.notifier).createPocket(pocket);

      if (mounted) {
        final l10n = AppLocalizations.of(context)!;
        
        // Afficher la notification de succès
        InAppNotificationService.showSuccess(
          context,
          title: l10n.success,
          message: l10n.notificationSuccessMessage,
        );
        
        // Naviguer vers la liste des pockets
        context.go(AppRoutePaths.pockets);
      }
    } catch (e) {
      if (mounted) {
        final l10n = AppLocalizations.of(context)!;
        InAppNotificationService.showError(
          context,
          title: l10n.error,
          message: l10n.errorCreatingPocket,
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
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final title = widget.category == PocketCategory.needs
        ? l10n.addNeedsPocket
        : l10n.addWantsPocket;

    return Scaffold(
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
                      ? AppDimensions.paddingXL * 2 // Plus d'espace pour les boutons Android
                      : AppDimensions.paddingM,
                ),
            children: [
              // Category indicator
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _getCategoryColor().withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(
                      _getCategoryIcon(),
                      color: _getCategoryColor(),
                      size: 24,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.category.getName(l10n),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: _getCategoryColor(),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            _getCategoryDescription(l10n),
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ).animate().fadeIn().slideY(begin: -0.2, end: 0),

              const SizedBox(height: 24),

              // Name field
              AppTextField(
                controller: _nameController,
                label: l10n.pocketName,
                hint: l10n.pocketNameHint,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return l10n.errorPocketNameRequired;
                  }
                  if (value.length > 100) {
                    return l10n.errorPocketNameTooLong;
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),

              // Budget field
              AppTextField(
                controller: _budgetController,
                label: l10n.monthlyBudget,
                hint: '0.00',
                type: AppTextFieldType.number,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return l10n.errorBudgetRequired;
                  }
                  final budget = double.tryParse(value.trim());
                  if (budget == null || budget < 0) {
                    return l10n.errorPocketBudgetNegative;
                  }
                  return null;
                },
              ),

              SizedBox(height: AppDimensions.paddingL),

              // Icon picker
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

              // Color picker
              Text(
                l10n.selectColor,
                style: AppTypography.title.copyWith(
                  color: isDark ? AppColors.textOnDark : AppColors.textPrimary,
                ),
              ).animate().fadeIn(delay: 350.ms).slideX(begin: -0.2, end: 0),
              const SizedBox(height: 12),
              PocketColorPicker(
                selectedColor: _selectedColor,
                onColorSelected: (color) {
                  setState(() => _selectedColor = color);
                },
              ),

              const SizedBox(height: 32),

              // Submit button
              AppButton(
                text: l10n.createPocket,
                onPressed: _isLoading ? null : _handleSubmit,
                isLoading: _isLoading,
              ),
            ],
          ),
        ),

        // Header sticky animé
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: AnimatedPageHeader(
            title: title,
            scrollController: _scrollController,
            showBackButton: true,
          ),
        ),
      ],
        ),
      ),
    );
  }

  Color _getCategoryColor() {
    return widget.category == PocketCategory.needs
        ? const Color(0xFFF48A99) // Pink for needs
        : const Color(0xFF78D078); // Green for wants
  }

  IconData _getCategoryIcon() {
    return widget.category == PocketCategory.needs
        ? Icons.restaurant // Needs icon
        : Icons.celebration; // Wants icon
  }

  String _getCategoryDescription(AppLocalizations l10n) {
    return widget.category == PocketCategory.needs
        ? l10n.needsDescription
        : l10n.wantsDescription;
  }
}

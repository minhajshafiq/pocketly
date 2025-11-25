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
import 'package:pocketly/core/router/app_route_paths.dart';
import 'package:pocketly/features/pockets/domain/entities/pocket_entity.dart';
import 'package:pocketly/features/pockets/presentation/providers/pocket_providers.dart';
import 'package:pocketly/features/pockets/presentation/widgets/pocket_icon_picker.dart';
import 'package:pocketly/features/pockets/presentation/widgets/pocket_color_picker.dart';
import 'package:pocketly/generated/l10n/app_localizations.dart';
import 'package:pocketly/features/auth/auth.dart';
import 'package:pocketly/features/notifications/domain/usecases/in_app_notification_service.dart';

/// Écran d'ajout d'un pocket de type épargne (Savings)
class AddSavingsPocketScreen extends ConsumerStatefulWidget {
  const AddSavingsPocketScreen({super.key});

  @override
  ConsumerState<AddSavingsPocketScreen> createState() =>
      _AddSavingsPocketScreenState();
}

class _AddSavingsPocketScreenState
    extends ConsumerState<AddSavingsPocketScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _targetAmountController = TextEditingController();
  final _monthlySavingsController = TextEditingController();
  final _scrollController = ScrollController();

  String _selectedIcon = 'savings';
  String _selectedColor = '#6BC6EA'; // Default blue for savings

  SavingsGoalType _goalType = SavingsGoalType.none;
  DateTime? _targetDate;

  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _targetAmountController.dispose();
    _monthlySavingsController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _selectTargetDate() async {
    final now = DateTime.now();
    final initialDate = _targetDate ?? now.add(const Duration(days: 365));

    if (Platform.isIOS) {
      await showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => Container(
          height: 216,
          padding: const EdgeInsets.only(top: 6.0),
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          color: CupertinoColors.systemBackground.resolveFrom(context),
          child: SafeArea(
            top: false,
            child: CupertinoDatePicker(
              initialDateTime: initialDate,
              mode: CupertinoDatePickerMode.date,
              minimumDate: now,
              onDateTimeChanged: (DateTime newDate) {
                setState(() => _targetDate = newDate);
              },
            ),
          ),
        ),
      );
    } else {
      final picked = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: now,
        lastDate: DateTime(now.year + 10),
      );
      if (picked != null) {
        setState(() => _targetDate = picked);
      }
    }
  }

  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final l10n = AppLocalizations.of(context)!;

    // Validation for goal type
    if (_goalType == SavingsGoalType.targetDate && _targetDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.errorSavingsGoalDateRequired),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final userId = ref.read(currentUserIdProvider);
      if (userId == null) {
        throw Exception('User not authenticated');
      }

      final targetAmount = _targetAmountController.text.trim().isNotEmpty
          ? double.parse(_targetAmountController.text.trim())
          : null;

      final monthlySavings = _monthlySavingsController.text.trim().isNotEmpty
          ? double.parse(_monthlySavingsController.text.trim())
          : null;

      final pocket = PocketEntity.savings(
        name: _nameController.text.trim(),
        icon: _selectedIcon,
        color: _selectedColor,
        userId: userId,
        monthlySavingsAmount: monthlySavings,
        savingsGoalType: _goalType,
        targetAmount: targetAmount,
        targetDate: _targetDate,
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
    final isIOS = Platform.isIOS;

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
                  color: const Color(0xFF6BC6EA).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.savings,
                      color: Color(0xFF6BC6EA),
                      size: 24,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.pocketCategorySavings,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF6BC6EA),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            l10n.savingsDescription,
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
                hint: l10n.savingsPocketNameHint,
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

              // Monthly savings amount (optional)
              AppTextField(
                controller: _monthlySavingsController,
                label: l10n.monthlySavingsAmount,
                hint: l10n.monthlySavingsHint,
                type: AppTextFieldType.number,
                validator: (value) {
                  if (value != null && value.trim().isNotEmpty) {
                    final amount = double.tryParse(value.trim());
                    if (amount == null || amount < 0) {
                      return l10n.errorPocketMonthlySavingsNegative;
                    }
                  }
                  return null;
                },
              ),

              const SizedBox(height: 24),

              // Goal type section
              Text(
                l10n.savingsGoalType,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),

              _buildGoalTypeSelector(l10n, isIOS),

              const SizedBox(height: 20),

              // Target amount (conditional)
              if (_goalType != SavingsGoalType.none) ...[
                AppTextField(
                  controller: _targetAmountController,
                  label: l10n.targetAmount,
                  hint: '0.00',
                  type: AppTextFieldType.number,
                  validator: (value) {
                    if (_goalType != SavingsGoalType.none) {
                      if (value == null || value.trim().isEmpty) {
                        return l10n.errorSavingsGoalAmountRequired;
                      }
                      final amount = double.tryParse(value.trim());
                      if (amount == null || amount <= 0) {
                        return l10n.errorPocketBudgetNegative;
                      }
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
              ],

              // Target date (for targetDate goal type)
              if (_goalType == SavingsGoalType.targetDate) ...[
                Text(
                  l10n.targetDate,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                InkWell(
                  onTap: _selectTargetDate,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _targetDate != null
                              ? '${_targetDate!.day}/${_targetDate!.month}/${_targetDate!.year}'
                              : l10n.selectTargetDate,
                          style: TextStyle(
                            fontSize: 16,
                            color: _targetDate != null
                                ? Colors.black87
                                : Colors.grey[600],
                          ),
                        ),
                        const Icon(Icons.calendar_today, size: 20),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],

              const SizedBox(height: 4),

              // Icon picker
              Text(
                l10n.selectIcon,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              PocketIconPicker(
                selectedIcon: _selectedIcon,
                onIconSelected: (icon) {
                  setState(() => _selectedIcon = icon);
                },
              ),

              const SizedBox(height: 24),

              // Color picker
              Text(
                l10n.selectColor,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
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
            title: l10n.addSavingsPocket,
            scrollController: _scrollController,
            showBackButton: true,
          ),
        ),
      ],
        ),
      ),
    );
  }

  Widget _buildGoalTypeSelector(AppLocalizations l10n, bool isIOS) {
    final goalTypes = [
      SavingsGoalType.none,
      SavingsGoalType.fixedAmount,
      SavingsGoalType.targetDate,
    ];

    return Column(
      children: goalTypes.map((type) {
        final isSelected = _goalType == type;
        return GestureDetector(
          onTap: () => setState(() => _goalType = type),
          child: Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isSelected
                  ? const Color(0xFF6BC6EA).withOpacity(0.1)
                  : Colors.grey[100],
              border: Border.all(
                color: isSelected
                    ? const Color(0xFF6BC6EA)
                    : Colors.grey[300]!,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(
                  isSelected
                      ? (isIOS
                          ? CupertinoIcons.check_mark_circled_solid
                          : Icons.check_circle)
                      : (isIOS
                          ? CupertinoIcons.circle
                          : Icons.circle_outlined),
                  color: isSelected
                      ? const Color(0xFF6BC6EA)
                      : Colors.grey[400],
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        type.getName(l10n),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: isSelected ? Colors.black87 : Colors.grey[700],
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _getGoalTypeDescription(type, l10n),
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
          ),
        );
      }).toList(),
    );
  }

  String _getGoalTypeDescription(SavingsGoalType type, AppLocalizations l10n) {
    return switch (type) {
      SavingsGoalType.none => l10n.savingsGoalNoneDescription,
      SavingsGoalType.fixedAmount => l10n.savingsGoalFixedAmountDescription,
      SavingsGoalType.targetDate => l10n.savingsGoalTargetDateDescription,
    };
  }
}

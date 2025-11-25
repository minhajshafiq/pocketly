import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pocketly/core/constants/app_colors.dart';
import 'package:pocketly/core/constants/app_dimensions.dart';
import 'package:pocketly/core/constants/app_typography.dart';
import 'package:pocketly/core/widgets/app_button.dart';
import 'package:pocketly/core/widgets/app_text_field.dart';
import 'package:pocketly/core/constants/app_icons.dart';
import 'package:pocketly/features/transactions/domain/entities/transaction_entity.dart';
import 'package:pocketly/features/transactions/presentation/providers/transaction_provider.dart';
import 'package:pocketly/features/category/category.dart';
import 'package:pocketly/features/notifications/notifications.dart';
import 'package:pocketly/features/transaction_history/transaction_history.dart';

/// Modal de modification d'une transaction (95% de l'écran)
class EditTransactionModal extends ConsumerStatefulWidget {
  final TransactionEntity transaction;

  const EditTransactionModal({
    required this.transaction,
    super.key,
  });

  @override
  ConsumerState<EditTransactionModal> createState() =>
      _EditTransactionModalState();
}

class _EditTransactionModalState extends ConsumerState<EditTransactionModal> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _amountController = TextEditingController();
  final _notesController = TextEditingController();

  late TransactionType _selectedType;
  CategoryEntity? _selectedCategory;
  DateTime _selectedDate = DateTime.now();
  RecurrenceType _selectedRecurrence = RecurrenceType.none;
  DateTime? _recurrenceEndDate;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _initializeForm();
  }

  void _initializeForm() {
    _nameController.text = widget.transaction.name;
    _amountController.text = widget.transaction.amount.toString();
    _notesController.text = widget.transaction.notes ?? '';
    _selectedType = widget.transaction.type;
    _selectedDate = widget.transaction.date;
    _selectedRecurrence = widget.transaction.recurrence;
    _recurrenceEndDate = widget.transaction.recurrenceEndDate;

    // Charger la catégorie après le premier build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final categoryAsync = ref.read(categoryByIdProvider(widget.transaction.categoryId));
      setState(() {
        _selectedCategory = categoryAsync;
      });
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _amountController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return DraggableScrollableSheet(
      initialChildSize: 0.95,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: isDark ? AppColors.backgroundDark : AppColors.background,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(AppDimensions.radiusXL),
            ),
          ),
          child: Column(
            children: [
              // Handle pour indiquer qu'on peut swiper
              _buildHandle(isDark),

              // Header avec titre et bouton close
              _buildHeader(context, isDark),

              // Contenu scrollable
              Expanded(
                child: Form(
                  key: _formKey,
                  child: ListView(
                    controller: scrollController,
                    padding: EdgeInsets.all(AppDimensions.paddingL),
                    children: [
                      // Sélecteur de type (Revenu / Dépense)
                      _buildTypeToggle(isDark),

                      SizedBox(height: AppDimensions.paddingL),

                      // Montant
                      _buildAmountField(),

                      SizedBox(height: AppDimensions.paddingL),

                      // Nom
                      _buildNameField(),

                      SizedBox(height: AppDimensions.paddingL),

                      // Catégorie
                      _buildCategorySelector(isDark),

                      SizedBox(height: AppDimensions.paddingL),

                      // Date
                      _buildDateSelector(isDark),

                      SizedBox(height: AppDimensions.paddingL),

                      // Récurrence
                      _buildRecurrenceSelector(isDark),

                      // Date de fin de récurrence (si récurrence activée)
                      if (_selectedRecurrence != RecurrenceType.none) ...[
                        SizedBox(height: AppDimensions.paddingL),
                        _buildRecurrenceEndDateSelector(isDark),
                      ],

                      SizedBox(height: AppDimensions.paddingL),

                      // Notes
                      _buildNotesField(),

                      SizedBox(height: AppDimensions.paddingXL),

                      // Boutons d'action
                      _buildActionButtons(),

                      SizedBox(height: AppDimensions.paddingXL),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHandle(bool isDark) {
    return Container(
      margin: EdgeInsets.only(
        top: AppDimensions.paddingM,
        bottom: AppDimensions.paddingS,
      ),
      width: 40,
      height: 4,
      decoration: BoxDecoration(
        color: isDark ? AppColors.borderDark : AppColors.borderLight,
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, bool isDark) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingL,
        vertical: AppDimensions.paddingM,
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: isDark ? AppColors.borderDark : AppColors.borderLight,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              'Modifier la transaction',
              style: AppTypography.heading.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () => Navigator.of(context).pop(),
            color: isDark ? AppColors.textOnDark : AppColors.textPrimary,
          ),
        ],
      ),
    );
  }

  Widget _buildTypeToggle(bool isDark) {
    final types = [TransactionType.expense, TransactionType.income];

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingS,
        vertical: AppDimensions.paddingS,
      ),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.surface,
        borderRadius: BorderRadius.circular(28.r),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withValues(alpha: 0.2)
                : Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 2),
            ),
          ],
        ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: types.map((type) {
    final isSelected = _selectedType == type;
          final label = type == TransactionType.expense ? 'Dépense' : 'Revenu';
          final icon = type == TransactionType.expense
              ? Icons.arrow_upward
              : Icons.arrow_downward;

          return Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppDimensions.paddingXS,
              ),
              child: GestureDetector(
      onTap: () {
                  HapticFeedback.lightImpact();
        setState(() {
          _selectedType = type;
          // Réinitialiser la catégorie car elle dépend du type
          _selectedCategory = null;
        });
      },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                  padding: EdgeInsets.symmetric(
                    horizontal: AppDimensions.paddingM,
                    vertical: AppDimensions.paddingS,
                  ),
        decoration: BoxDecoration(
          color: isSelected
                        ? AppColors.primary.withValues(alpha: 0.15)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(28.r),
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
                      AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeInOut,
                        style: AppTypography.small.copyWith(
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                          color: isSelected
                              ? AppColors.primary
                              : (isDark
                                    ? AppColors.textSecondaryOnDark
                                    : AppColors.textSecondary),
                        ),
                        child: Text(
              label,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
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
    );
  }

  Widget _buildAmountField() {
    final isExpense = _selectedType == TransactionType.expense;

    return AppTextField(
          controller: _amountController,
      label: 'Montant',
      hint: '0.00',
      type: AppTextFieldType.number,
      icon: Icons.attach_money,
      iconColor: isExpense ? AppColors.error : AppColors.success,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Le montant est requis';
            }
            final amount = double.tryParse(value);
            if (amount == null || amount <= 0) {
              return 'Entrez un montant valide';
            }
            return null;
          },
    );
  }

  Widget _buildNameField() {
    return AppTextField(
          controller: _nameController,
      label: 'Nom',
      hint: 'Ex: Courses, Salaire, Restaurant...',
      icon: Icons.edit,
      iconColor: AppColors.primary,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Le nom est requis';
            }
            if (value.trim().length < 3) {
              return 'Le nom doit contenir au moins 3 caractères';
            }
            return null;
          },
    );
  }

  Widget _buildCategorySelector(bool isDark) {
    final categoryType = _selectedType == TransactionType.expense
        ? CategoryType.expense
        : CategoryType.income;
    final filteredCategoriesAsync = ref.watch(categoriesByTypeAsyncProvider(categoryType));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Catégorie *',
          style: AppTypography.body.copyWith(
            fontWeight: FontWeight.w600,
            color: isDark ? AppColors.textOnDark : AppColors.textPrimary,
          ),
        ),
        SizedBox(height: AppDimensions.paddingS),
        filteredCategoriesAsync.when(
          data: (filteredCategories) {
            if (filteredCategories.isEmpty) {
              return Container(
                padding: EdgeInsets.all(AppDimensions.paddingL),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.surfaceDark : AppColors.surface,
                  borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                  border: Border.all(
                    color: AppColors.error.withValues(alpha: 0.5),
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(Icons.warning_amber, color: AppColors.error),
                    SizedBox(width: AppDimensions.paddingM),
                    Expanded(
                      child: Text(
                        'Aucune catégorie disponible',
                        style: AppTypography.body.copyWith(
                          color: AppColors.error,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }

            return DropdownButtonFormField<CategoryEntity>(
              value: _selectedCategory,
              decoration: InputDecoration(
                filled: true,
                fillColor: isDark ? AppColors.surfaceDark : AppColors.surface,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                  borderSide: BorderSide(
                    color: isDark ? AppColors.borderDark : AppColors.borderLight,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                  borderSide: BorderSide(
                    color: AppColors.primary,
                    width: 2,
                  ),
                ),
              ),
              hint: Text(
                'Sélectionner une catégorie',
                style: AppTypography.body.copyWith(
                  color: isDark
                      ? AppColors.textSecondaryOnDark
                      : AppColors.textSecondary,
                ),
              ),
              selectedItemBuilder: (context) {
                return filteredCategories.map((category) {
                  return Row(
                    children: [
                      Icon(
                        AppIcons.getPocketIcon(category.iconName),
                        color: _parseColor(category.color),
                        size: 20,
                      ),
                      SizedBox(width: AppDimensions.paddingS),
                      Text(
                        category.name,
                        style: AppTypography.body.copyWith(
                          color: isDark ? AppColors.textOnDark : AppColors.textPrimary,
                        ),
                      ),
                    ],
                  );
                }).toList();
              },
              items: filteredCategories.map((category) {
                return DropdownMenuItem<CategoryEntity>(
                  value: category,
                  child: Row(
                    children: [
                      Icon(
                        AppIcons.getPocketIcon(category.iconName),
                        color: _parseColor(category.color),
                        size: 20,
                      ),
                      SizedBox(width: AppDimensions.paddingS),
                      Text(
                        category.name,
                        style: AppTypography.body,
                      ),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (CategoryEntity? newValue) {
                setState(() {
                  _selectedCategory = newValue;
                });
              },
              validator: (value) {
                if (value == null) {
                  return 'Veuillez sélectionner une catégorie';
                }
                return null;
              },
            );
          },
          loading: () => Container(
            padding: EdgeInsets.all(AppDimensions.paddingL),
            decoration: BoxDecoration(
              color: isDark ? AppColors.surfaceDark : AppColors.surface,
              borderRadius: BorderRadius.circular(AppDimensions.radiusM),
              border: Border.all(
                color: isDark ? AppColors.borderDark : AppColors.borderLight,
              ),
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: AppColors.primary,
                  ),
                ),
                SizedBox(width: AppDimensions.paddingM),
                Text(
                  'Chargement des catégories...',
                  style: AppTypography.body.copyWith(
                    color: isDark
                        ? AppColors.textSecondaryOnDark
                        : AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          error: (error, stack) => Container(
            padding: EdgeInsets.all(AppDimensions.paddingL),
            decoration: BoxDecoration(
              color: isDark ? AppColors.surfaceDark : AppColors.surface,
              borderRadius: BorderRadius.circular(AppDimensions.radiusM),
              border: Border.all(
                color: AppColors.error.withValues(alpha: 0.5),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.error_outline, color: AppColors.error),
                SizedBox(width: AppDimensions.paddingM),
                Expanded(
                  child: Text(
                    'Erreur de chargement',
                    style: AppTypography.body.copyWith(
                      color: AppColors.error,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDateSelector(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Date *',
          style: AppTypography.body.copyWith(
            fontWeight: FontWeight.w600,
            color: isDark ? AppColors.textOnDark : AppColors.textPrimary,
          ),
        ),
        SizedBox(height: AppDimensions.paddingS),
        InkWell(
          onTap: _selectDate,
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
          child: Container(
            padding: EdgeInsets.all(AppDimensions.paddingL),
            decoration: BoxDecoration(
              color: isDark ? AppColors.surfaceDark : AppColors.surface,
              borderRadius: BorderRadius.circular(AppDimensions.radiusM),
              border: Border.all(
                color: isDark
                    ? AppColors.textSecondaryOnDark.withValues(alpha: 0.3)
                    : AppColors.textSecondary.withValues(alpha: 0.3),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  color: AppColors.primary,
                  size: 24,
                ),
                SizedBox(width: AppDimensions.paddingM),
                Expanded(
                  child: Text(
                    _formatDate(_selectedDate),
                    style: AppTypography.body.copyWith(
                      fontWeight: FontWeight.w600,
                      color: isDark
                          ? AppColors.textOnDark
                          : AppColors.textPrimary,
                    ),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: isDark
                      ? AppColors.textSecondaryOnDark
                      : AppColors.textSecondary,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRecurrenceSelector(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Récurrence',
          style: AppTypography.body.copyWith(
            fontWeight: FontWeight.w600,
            color: isDark ? AppColors.textOnDark : AppColors.textPrimary,
          ),
        ),
        SizedBox(height: AppDimensions.paddingS),
        DropdownButtonFormField<RecurrenceType>(
          value: _selectedRecurrence,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.repeat, color: AppColors.primary),
            filled: true,
            fillColor: isDark ? AppColors.surfaceDark : AppColors.surface,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimensions.radiusM),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimensions.radiusM),
              borderSide: BorderSide(
                color: isDark ? AppColors.borderDark : AppColors.borderLight,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimensions.radiusM),
              borderSide: BorderSide(
                color: AppColors.primary,
                width: 2,
              ),
            ),
          ),
          items: RecurrenceType.values.map((recurrence) {
            return DropdownMenuItem<RecurrenceType>(
              value: recurrence,
              child: Text(
                _getRecurrenceName(recurrence),
                style: AppTypography.body,
              ),
            );
          }).toList(),
          onChanged: (RecurrenceType? newValue) {
            setState(() {
              _selectedRecurrence = newValue ?? RecurrenceType.none;
              if (_selectedRecurrence == RecurrenceType.none) {
                _recurrenceEndDate = null;
              }
            });
          },
        ),
      ],
    );
  }

  Widget _buildRecurrenceEndDateSelector(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Fin de récurrence (optionnel)',
          style: AppTypography.body.copyWith(
            fontWeight: FontWeight.w600,
            color: isDark ? AppColors.textOnDark : AppColors.textPrimary,
          ),
        ),
        SizedBox(height: AppDimensions.paddingS),
        InkWell(
          onTap: _selectRecurrenceEndDate,
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
          child: Container(
            padding: EdgeInsets.all(AppDimensions.paddingL),
            decoration: BoxDecoration(
              color: isDark ? AppColors.surfaceDark : AppColors.surface,
              borderRadius: BorderRadius.circular(AppDimensions.radiusM),
              border: Border.all(
                color: isDark
                    ? AppColors.textSecondaryOnDark.withValues(alpha: 0.3)
                    : AppColors.textSecondary.withValues(alpha: 0.3),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.event_busy,
                  color: AppColors.primary,
                  size: 24,
                ),
                SizedBox(width: AppDimensions.paddingM),
                Expanded(
                  child: Text(
                    _recurrenceEndDate != null
                        ? _formatDate(_recurrenceEndDate!)
                        : 'Aucune date de fin',
                    style: AppTypography.body.copyWith(
                      fontWeight: FontWeight.w600,
                      color: _recurrenceEndDate != null
                          ? (isDark ? AppColors.textOnDark : AppColors.textPrimary)
                          : (isDark ? AppColors.textSecondaryOnDark : AppColors.textSecondary),
                    ),
                  ),
                ),
                if (_recurrenceEndDate != null)
                  IconButton(
                    icon: Icon(Icons.clear, size: 20),
                    onPressed: () {
                      setState(() {
                        _recurrenceEndDate = null;
                      });
                    },
                    color: isDark
                        ? AppColors.textSecondaryOnDark
                        : AppColors.textSecondary,
                  )
                else
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: isDark
                        ? AppColors.textSecondaryOnDark
                        : AppColors.textSecondary,
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNotesField() {
    return AppTextField(
          controller: _notesController,
      label: 'Notes (optionnel)',
      hint: 'Ajoutez des notes...',
      type: AppTextFieldType.multiline,
      maxLines: 2,
      icon: Icons.notes,
      iconColor: AppColors.primary,
    );
  }

  Widget _buildActionButtons() {
    return AppButton(
      text: 'Mettre à jour',
      onPressed: _isSubmitting ? null : _submitForm,
      style: AppButtonStyle.gradient,
      isLoading: _isSubmitting,
    );
  }

  Future<void> _selectDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.primary,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: AppColors.textPrimary,
            ),
          ),
          child: child!,
        );
      },
    );

    if (date != null) {
      setState(() {
        _selectedDate = date;
      });
    }
  }

  Future<void> _selectRecurrenceEndDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _recurrenceEndDate ?? _selectedDate.add(const Duration(days: 30)),
      firstDate: _selectedDate,
      lastDate: DateTime.now().add(const Duration(days: 3650)), // 10 ans
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.primary,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: AppColors.textPrimary,
            ),
          ),
          child: child!,
        );
      },
    );

    if (date != null) {
      setState(() {
        _recurrenceEndDate = date;
      });
    }
  }

  Future<void> _submitForm() async {
    // Validation du formulaire
    if (!_formKey.currentState!.validate() || _selectedCategory == null) {
      return;
    }

    setState(() => _isSubmitting = true);

    try {
      // Préparer les données
      final updatedTransaction = _buildUpdatedTransaction();

      // Mettre à jour la transaction
      await ref
          .read(transactionProvider.notifier)
          .updateTransaction(updatedTransaction);

      // Rafraîchir la liste
      ref.invalidate(filteredTransactionsProvider);

      if (!mounted) return;

      // Fermer la modal
      Navigator.pop(context);

      // Attendre que la modal soit fermée avant d'afficher la notification
      await Future.delayed(const Duration(milliseconds: 200));

      if (!mounted) return;

      // Afficher la notification de succès
      InAppNotificationService.showSuccess(
        context,
        title: 'Modifiée',
        message: 'Transaction mise à jour avec succès',
        duration: const Duration(seconds: 4),
      );
    } catch (e) {
      _handleError(e);
    }
  }

  /// Construit la transaction mise à jour avec les nouvelles valeurs
  TransactionEntity _buildUpdatedTransaction() {
    final amount = double.parse(_amountController.text);
    final name = _nameController.text.trim();
    final notes = _notesController.text.trim();

    return TransactionEntity(
      id: widget.transaction.id,
      name: name,
      amount: amount,
      date: _selectedDate,
      categoryId: _selectedCategory!.id!,
      type: _selectedType,
      recurrence: _selectedRecurrence,
      imageUrl: widget.transaction.imageUrl,
      notes: notes.isEmpty ? null : notes,
      userId: widget.transaction.userId,
      recurrenceGroupId: widget.transaction.recurrenceGroupId,
      recurrenceStartDate: _selectedRecurrence != RecurrenceType.none
          ? (widget.transaction.recurrenceStartDate ?? _selectedDate)
          : null,
      recurrenceEndDate: _selectedRecurrence != RecurrenceType.none
          ? _recurrenceEndDate
          : null,
      recurrenceDayOfMonth: widget.transaction.recurrenceDayOfMonth,
      isRecurrenceActive: _selectedRecurrence != RecurrenceType.none,
      createdAt: widget.transaction.createdAt,
      updatedAt: DateTime.now(),
    );
  }

  /// Gère les erreurs lors de la soumission
  void _handleError(Object error) {
    setState(() => _isSubmitting = false);

    if (!mounted) return;

    InAppNotificationService.showError(
      context,
      title: 'Erreur',
      message: 'Impossible de modifier la transaction',
    );
  }

  String _formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final year = date.year;
    return '$day/$month/$year';
  }

  String _getRecurrenceName(RecurrenceType recurrence) {
    return switch (recurrence) {
      RecurrenceType.none => 'Aucune',
      RecurrenceType.daily => 'Quotidienne',
      RecurrenceType.weekly => 'Hebdomadaire',
      RecurrenceType.biweekly => 'Bi-mensuelle',
      RecurrenceType.monthly => 'Mensuelle',
      RecurrenceType.quarterly => 'Trimestrielle',
      RecurrenceType.yearly => 'Annuelle',
    };
  }

  Color _parseColor(String colorString) {
    String hexColor = colorString.trim();

    if (hexColor.startsWith('#')) {
      hexColor = hexColor.substring(1);
      if (hexColor.length == 6) {
        hexColor = 'FF$hexColor';
      }
      return Color(int.parse(hexColor, radix: 16));
    }

    if (hexColor.startsWith('0x')) {
      return Color(int.parse(hexColor));
    }

    if (hexColor.length == 6) {
      hexColor = 'FF$hexColor';
    }
    return Color(int.parse(hexColor, radix: 16));
  }

}

/// Helper function pour ouvrir la modal de modification de transaction
void showEditTransactionModal(BuildContext context, TransactionEntity transaction) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    isDismissible: true,
    enableDrag: true,
    builder: (context) => EditTransactionModal(transaction: transaction),
  );
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:pocketly/core/constants/app_colors.dart';
import 'package:pocketly/core/constants/app_dimensions.dart';
import 'package:pocketly/core/constants/app_typography.dart';
import 'package:pocketly/core/services/logger_service.dart';
import 'package:pocketly/core/widgets/app_button.dart';
import 'package:pocketly/core/widgets/app_card.dart';
import 'package:pocketly/core/widgets/animated_page_header.dart';
import 'package:pocketly/core/widgets/platform_safe_area.dart';
import 'package:pocketly/features/transactions/domain/entities/transaction_entity.dart';
import 'package:pocketly/features/transactions/presentation/providers/transaction_provider.dart';
import 'package:pocketly/features/transactions/presentation/widgets/transaction_image_picker.dart';
import 'package:pocketly/features/transactions/presentation/widgets/recurrence_selector.dart';
import 'package:pocketly/core/services/image_processing_service.dart';
import 'package:pocketly/features/category/category.dart';
import 'package:pocketly/features/home/home.dart';
import 'package:pocketly/features/notifications/notifications.dart';
import 'package:pocketly/features/user/user.dart';

/// Écran d'ajout/édition d'une transaction
class AddTransactionScreen extends ConsumerStatefulWidget {
  final TransactionType transactionType;
  final TransactionEntity? existingTransaction;

  const AddTransactionScreen({
    super.key,
    required this.transactionType,
    this.existingTransaction,
  });

  @override
  ConsumerState<AddTransactionScreen> createState() =>
      _AddTransactionScreenState();
}

class _AddTransactionScreenState extends ConsumerState<AddTransactionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _amountController = TextEditingController();
  final _notesController = TextEditingController();
  final _scrollController = ScrollController();

  CategoryEntity? _selectedCategory;
  DateTime _selectedDate = DateTime.now();
  RecurrenceType _selectedRecurrence = RecurrenceType.none;
  String? _imageUrl;
  bool _isSubmitting = false;
  bool _isUploadingImage = false;

  @override
  void initState() {
    super.initState();
    _initializeForm();
  }

  void _initializeForm() {
    if (widget.existingTransaction != null) {
      final transaction = widget.existingTransaction!;
      _nameController.text = transaction.name;
      _amountController.text = transaction.amount.toString();
      _notesController.text = transaction.notes ?? '';
      _selectedDate = transaction.date;
      _selectedRecurrence = transaction.recurrence;
      _imageUrl = transaction.imageUrl;
      // TODO: Load category from transaction
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _amountController.dispose();
    _notesController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isExpense = widget.transactionType == TransactionType.expense;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.background,
      body: PlatformSafeArea(
        top: true,
        bottom: false,
        padding: EdgeInsets.only(top: AppDimensions.paddingS),
        child: Stack(
          children: [
            // Contenu scrollable
            SingleChildScrollView(
              controller: _scrollController,
              padding: EdgeInsets.only(
                top: 80 + AppDimensions.paddingM, // Header + padding
                left: AppDimensions.paddingM,
                right: AppDimensions.paddingM,
                bottom: AppDimensions.paddingM,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // En-tête avec icône et type
                    _buildHeader(isExpense, isDark).animate().fadeIn().slideY(
                          begin: -0.2,
                          end: 0,
                        ),

                SizedBox(height: AppDimensions.paddingL),

                // Montant
                _buildAmountField(isExpense, isDark).animate().fadeIn(
                      delay: 100.ms,
                    ).slideX(
                      begin: -0.2,
                      end: 0,
                    ),

                SizedBox(height: AppDimensions.paddingL),

                // Nom de la transaction
                _buildNameField(isDark).animate().fadeIn(
                      delay: 200.ms,
                    ).slideX(
                      begin: -0.2,
                      end: 0,
                    ),

                SizedBox(height: AppDimensions.paddingL),

                // Image/Logo de la transaction
                _buildImagePicker(isDark).animate().fadeIn(
                      delay: 250.ms,
                    ).slideX(
                      begin: -0.2,
                      end: 0,
                    ),

                SizedBox(height: AppDimensions.paddingL),

                // Catégorie
                _buildCategorySelector(isExpense, isDark).animate().fadeIn(
                      delay: 300.ms,
                    ).slideX(
                      begin: -0.2,
                      end: 0,
                    ),

                SizedBox(height: AppDimensions.paddingL),

                // Date
                _buildDateSelector(isDark).animate().fadeIn(
                      delay: 400.ms,
                    ).slideX(
                      begin: -0.2,
                      end: 0,
                    ),

                SizedBox(height: AppDimensions.paddingL),

                // Récurrence
                _buildRecurrenceSelector(isDark).animate().fadeIn(
                      delay: 450.ms,
                    ).slideX(
                      begin: -0.2,
                      end: 0,
                    ),

                SizedBox(height: AppDimensions.paddingL),

                // Notes (optionnel)
                _buildNotesField(isDark).animate().fadeIn(
                      delay: 500.ms,
                    ).slideX(
                      begin: -0.2,
                      end: 0,
                    ),

                SizedBox(height: AppDimensions.paddingXL),

                    // Bouton de sauvegarde
                    _buildSubmitButton(isExpense).animate().fadeIn(
                          delay: 600.ms,
                        ).scale(
                          begin: const Offset(0.8, 0.8),
                          end: const Offset(1, 1),
                        ),
                  ],
                ),
              ),
            ),

            // Header sticky animé
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: AnimatedPageHeader(
                title: widget.existingTransaction != null
                    ? 'Modifier la transaction'
                    : isExpense
                        ? 'Nouvelle dépense'
                        : 'Nouveau revenu',
                scrollController: _scrollController,
                showBackButton: true,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(bool isExpense, bool isDark) {
    return AppCard(
      padding: EdgeInsets.all(AppDimensions.paddingL),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(AppDimensions.paddingL),
            decoration: BoxDecoration(
              color: (isExpense ? AppColors.error : AppColors.success)
                  .withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isExpense ? Icons.arrow_upward : Icons.arrow_downward,
              color: isExpense ? AppColors.error : AppColors.success,
              size: 32,
            ),
          ),
          SizedBox(width: AppDimensions.paddingL),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isExpense ? 'Dépense' : 'Revenu',
                  style: AppTypography.heading.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isExpense ? AppColors.error : AppColors.success,
                  ),
                ),
                Text(
                  'Enregistrez votre ${isExpense ? "dépense" : "revenu"}',
                  style: AppTypography.small.copyWith(
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
    );
  }

  Widget _buildAmountField(bool isExpense, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Montant *',
          style: AppTypography.body.copyWith(
            fontWeight: FontWeight.w600,
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
              Icons.attach_money,
              color: isExpense ? AppColors.error : AppColors.success,
            ),
            filled: true,
            fillColor: isDark ? AppColors.surfaceDark : AppColors.surface,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimensions.radiusM),
              borderSide: BorderSide(
                color: isDark ? AppColors.borderDark : AppColors.borderLight,
              ),
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
        ),
      ],
    );
  }

  Widget _buildNameField(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Nom *',
          style: AppTypography.body.copyWith(
            fontWeight: FontWeight.w600,
            color: isDark ? AppColors.textOnDark : AppColors.textPrimary,
          ),
        ),
        SizedBox(height: AppDimensions.paddingS),
        TextFormField(
          controller: _nameController,
          decoration: InputDecoration(
            hintText: 'Ex: Courses, Salaire, Restaurant...',
            prefixIcon: Icon(Icons.edit, color: AppColors.primary),
            filled: true,
            fillColor: isDark ? AppColors.surfaceDark : AppColors.surface,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimensions.radiusM),
              borderSide: BorderSide(
                color: isDark ? AppColors.borderDark : AppColors.borderLight,
              ),
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
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Le nom est requis';
            }
            if (value.trim().length < 3) {
              return 'Le nom doit contenir au moins 3 caractères';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildCategorySelector(bool isExpense, bool isDark) {
    // Utiliser le provider qui filtre déjà par type et préserve les états
    final categoryType = _toCategoryType(widget.transactionType);
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
            // Debug: afficher le nombre de catégories
            ref.read(loggerProvider).d('Type recherché: $categoryType');
            ref.read(loggerProvider).d('Filtered categories: ${filteredCategories.length}');
            for (final cat in filteredCategories) {
              ref.read(loggerProvider).d('- ${cat.name} (type: ${cat.type}, isCustom: ${cat.isCustom})');
            }

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
                prefixIcon: _selectedCategory != null
                    ? Icon(
                        _getCategoryIcon(_selectedCategory!.iconName),
                        color: _parseColor(_selectedCategory!.color),
                      )
                    : Icon(
                        Icons.category_outlined,
                        color: isDark
                            ? AppColors.textSecondaryOnDark
                            : AppColors.textSecondary,
                      ),
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
              items: filteredCategories.map((category) {
                return DropdownMenuItem<CategoryEntity>(
                  value: category,
                  child: Row(
                    children: [
                      Icon(
                        _getCategoryIcon(category.iconName),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
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
                SizedBox(height: AppDimensions.paddingXS),
                Text(
                  error.toString(),
                  style: AppTypography.small.copyWith(
                    color: isDark
                        ? AppColors.textSecondaryOnDark
                        : AppColors.textSecondary,
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
        RecurrenceSelector(
          selectedRecurrence: _selectedRecurrence,
          onRecurrenceChanged: (recurrence) {
            setState(() {
              _selectedRecurrence = recurrence;
            });
          },
        ),
      ],
    );
  }

  Widget _buildNotesField(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Notes (optionnel)',
          style: AppTypography.body.copyWith(
            fontWeight: FontWeight.w600,
            color: isDark ? AppColors.textOnDark : AppColors.textPrimary,
          ),
        ),
        SizedBox(height: AppDimensions.paddingS),
        TextFormField(
          controller: _notesController,
          maxLines: 3,
          decoration: InputDecoration(
            hintText: 'Ajoutez des notes...',
            prefixIcon: Icon(Icons.notes, color: AppColors.primary),
            filled: true,
            fillColor: isDark ? AppColors.surfaceDark : AppColors.surface,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimensions.radiusM),
              borderSide: BorderSide(
                color: isDark ? AppColors.borderDark : AppColors.borderLight,
              ),
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
        ),
      ],
    );
  }

  Widget _buildImagePicker(bool isDark) {
    return AppCard(
      child: Padding(
        padding: EdgeInsets.all(AppDimensions.paddingM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Logo / Image (optionnel)',
              style: AppTypography.label.copyWith(
                color: isDark ? AppColors.textOnDark : AppColors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: AppDimensions.paddingM),
            Center(
              child: _isUploadingImage
                  ? const CircularProgressIndicator()
                  : TransactionImagePicker(
                      currentImageUrl: _imageUrl,
                      size: 100,
                      onImageSelected: _handleImageSelected,
                      onLogoSelected: _handleLogoSelected,
                      onImageRemoved: _handleImageRemoved,
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleImageSelected(File imageFile) async {
    setState(() {
      _isUploadingImage = true;
    });

    try {
      // 1. Valider l'image
      final imageProcessingService = ref.read(imageProcessingServiceProvider);
      final isValid = await imageProcessingService.validateImage(imageFile);

      if (!isValid) {
        if (mounted) {
          InAppNotificationService.showError(
            context,
            title: 'Image invalide',
            message: 'L\'image doit être au format JPG/PNG et moins de 5MB',
          );
        }
        return;
      }

      // 2. Compresser et redimensionner
      final compressedBytes = await imageProcessingService.compressAndResizeImage(
        imageFile: imageFile,
        maxWidth: 400,
        maxHeight: 400,
        quality: 85,
        maxSizeKB: 500,
      );

      // 3. Upload vers Supabase Storage
      final storageDataSource = ref.read(storageDataSourceProvider);
      final currentUserAsync = ref.read(currentUserProvider);
      final currentUser = currentUserAsync.value;

      if (currentUser == null) {
        throw Exception('User not logged in');
      }

      final fileName = 'transaction_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final path = '${currentUser.id}/$fileName';

      final uploadedUrl = await storageDataSource.uploadFile(
        fileBytes: compressedBytes,
        fileName: fileName,
        bucket: 'transaction-icons',
        path: path,
      );

      setState(() {
        _imageUrl = uploadedUrl;
      });

      if (mounted) {
        InAppNotificationService.showSuccess(
          context,
          title: 'Image ajoutée',
          message: 'L\'image a été téléchargée avec succès',
        );
      }
    } catch (e) {
      if (mounted) {
        InAppNotificationService.showError(
          context,
          title: 'Erreur',
          message: 'Impossible de télécharger l\'image: $e',
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isUploadingImage = false;
        });
      }
    }
  }

  void _handleLogoSelected(String logoUrl) {
    setState(() {
      _imageUrl = logoUrl;
    });

    InAppNotificationService.showSuccess(
      context,
      title: 'Logo ajouté',
      message: 'Le logo a été ajouté à la transaction',
    );
  }

  void _handleImageRemoved() {
    setState(() {
      _imageUrl = null;
    });
  }

  Widget _buildSubmitButton(bool isExpense) {
    return AppButton(
      text: widget.existingTransaction != null
          ? 'Mettre à jour'
          : 'Enregistrer',
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

  Future<void> _submitForm() async {
    setState(() {
      _isSubmitting = true;
    });

    // Valider le formulaire
    if (!_formKey.currentState!.validate()) {
      setState(() {
        _isSubmitting = false;
      });
      return;
    }

    // Vérifier la catégorie
    if (_selectedCategory == null) {
      setState(() {
        _isSubmitting = false;
      });
      return;
    }

    try {
      final amount = double.parse(_amountController.text);
      final name = _nameController.text.trim();
      final notes = _notesController.text.trim();

      ref.read(loggerProvider).d('Début de création de transaction');
      ref.read(loggerProvider).d('Type: ${widget.transactionType}');
      ref.read(loggerProvider).d('Montant: $amount');
      ref.read(loggerProvider).d('Nom: $name');
      ref.read(loggerProvider).d('Catégorie ID: ${_selectedCategory!.id}');
      ref.read(loggerProvider).d('Date: $_selectedDate');

      // Récupérer l'utilisateur actuel
      final currentUserAsync = ref.read(currentUserProvider);
      final currentUser = currentUserAsync.value;

      if (currentUser == null) {
        ref.read(loggerProvider).e('Utilisateur non connecté');
        throw Exception('Utilisateur non connecté');
      }

      ref.read(loggerProvider).d('User ID: ${currentUser.id}');

      // Vérifier que la catégorie a un ID
      if (_selectedCategory!.id == null) {
        ref.read(loggerProvider).e('Catégorie sans ID');
        throw Exception('La catégorie sélectionnée n\'a pas d\'ID valide');
      }

      // Créer la transaction via le provider
      ref.read(loggerProvider).d('Appel du provider pour créer la transaction...');
      await ref.read(transactionProvider.notifier).createTransaction(
            type: widget.transactionType,
            amount: amount,
            name: name,
            categoryId: _selectedCategory!.id!,
            date: _selectedDate,
            recurrence: _selectedRecurrence,
            notes: notes.isEmpty ? null : notes,
            imageUrl: _imageUrl,
            userId: currentUser.id,
          );

      ref.read(loggerProvider).i('Transaction créée avec succès');

      // Invalider les contrôleurs cache-first pour rafraîchir immédiatement l'UI
      ref.invalidate(recentTransactionsControllerProvider);
      ref.invalidate(homeSummaryControllerProvider);
      ref.invalidate(weeklyExpensesControllerProvider);

      if (!mounted) return;

      // Retourner à l'écran précédent IMMÉDIATEMENT pour une UX fluide
      context.pop(true);

      // Ne pas rafraîchir les providers - le cache se met à jour automatiquement
      // Le système cache-first du repository se resynchronisera en arrière-plan

      // Attendre que la navigation soit terminée avant d'afficher la notification
      await Future.delayed(const Duration(milliseconds: 200));

      if (!mounted) return;

      // Afficher la notification de succès
      final successMessage = 'Votre ${widget.transactionType == TransactionType.expense ? "dépense" : "revenu"} a été enregistré avec succès';

      InAppNotificationService.showSuccess(
        context,
        title: 'Transaction enregistrée',
        message: successMessage,
        duration: const Duration(seconds: 3),
      );
    } catch (e, stackTrace) {
      ref.read(loggerProvider).e('Erreur lors de la création de la transaction', error: e, stackTrace: stackTrace);

      if (!mounted) return;

      // Extraire un message d'erreur court et compréhensible
      String errorMessage = 'Impossible d\'enregistrer la transaction';
      final errorString = e.toString();

      if (errorString.contains('UnimplementedError')) {
        errorMessage = 'Erreur de configuration. Veuillez redémarrer l\'application.';
      } else if (errorString.contains('network') || errorString.contains('NetworkError')) {
        errorMessage = 'Erreur de connexion. Vérifiez votre connexion internet.';
      } else if (errorString.length < 100) {
        // Si le message est court, l'afficher
        errorMessage = errorString;
      }

      // Pour l'erreur, on reste sur la page donc pas de problème de context
      InAppNotificationService.showError(
        context,
        title: 'Erreur',
        message: errorMessage,
      );

      setState(() {
        _isSubmitting = false;
      });
    }
  }

  String _formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final year = date.year;
    return '$day/$month/$year';
  }

  /// Convertit TransactionType en CategoryType
  CategoryType _toCategoryType(TransactionType type) {
    return type == TransactionType.expense
        ? CategoryType.expense
        : CategoryType.income;
  }

  /// Convertit une couleur hexadécimale (#RRGGBB ou 0xFFRRGGBB) en Color
  Color _parseColor(String colorString) {
    String hexColor = colorString.trim();

    // Si la couleur commence par #, la convertir en format 0xFFRRGGBB
    if (hexColor.startsWith('#')) {
      hexColor = hexColor.substring(1); // Enlever le #
      if (hexColor.length == 6) {
        hexColor = 'FF$hexColor'; // Ajouter l'opacité
      }
      return Color(int.parse(hexColor, radix: 16));
    }

    // Si la couleur commence par 0x, parser directement
    if (hexColor.startsWith('0x')) {
      return Color(int.parse(hexColor));
    }

    // Par défaut, essayer de parser comme hexadécimal
    if (hexColor.length == 6) {
      hexColor = 'FF$hexColor';
    }
    return Color(int.parse(hexColor, radix: 16));
  }

  IconData _getCategoryIcon(String iconName) {
    final iconMap = <String, IconData>{
      'shopping_cart': Icons.shopping_cart,
      'restaurant': Icons.restaurant,
      'local_gas_station': Icons.local_gas_station,
      'home': Icons.home,
      'health_and_safety': Icons.health_and_safety,
      'school': Icons.school,
      'sports_soccer': Icons.sports_soccer,
      'movie': Icons.movie,
      'flight': Icons.flight,
      'account_balance': Icons.account_balance,
      'work': Icons.work,
      'card_giftcard': Icons.card_giftcard,
      'savings': Icons.savings,
      'trending_up': Icons.trending_up,
      'attach_money': Icons.attach_money,
      'payment': Icons.payment,
    };

    return iconMap[iconName] ?? Icons.category;
  }
}

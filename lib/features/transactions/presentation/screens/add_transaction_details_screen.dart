import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:pocketly/core/constants/app_colors.dart';
import 'package:pocketly/core/constants/app_dimensions.dart';
import 'package:pocketly/core/constants/app_typography.dart';
import 'package:pocketly/core/constants/app_icons.dart';
import 'package:pocketly/core/widgets/app_button.dart';
import 'package:pocketly/core/widgets/app_card.dart';
import 'package:pocketly/core/widgets/app_text_field.dart';
import 'package:pocketly/core/widgets/animated_page_header.dart';
import 'package:pocketly/core/widgets/platform_safe_area.dart';
import 'package:pocketly/features/transactions/domain/entities/transaction_entity.dart';
import 'package:pocketly/features/transactions/presentation/providers/transaction_provider.dart';
import 'package:pocketly/features/transactions/presentation/widgets/transaction_image_picker.dart';
import 'package:pocketly/features/transactions/presentation/widgets/recurrence_selector.dart';
import 'package:pocketly/core/services/image_processing_service.dart';
import 'package:pocketly/features/category/category.dart';
import 'package:pocketly/features/notifications/notifications.dart';
import 'package:pocketly/features/user/user.dart';

/// Deuxième étape de l'ajout d'une transaction : saisie des détails
class AddTransactionDetailsScreen extends ConsumerStatefulWidget {
  final TransactionType transactionType;
  final double amount;

  const AddTransactionDetailsScreen({
    super.key,
    required this.transactionType,
    required this.amount,
  });

  @override
  ConsumerState<AddTransactionDetailsScreen> createState() =>
      _AddTransactionDetailsScreenState();
}

class _AddTransactionDetailsScreenState
    extends ConsumerState<AddTransactionDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _notesController = TextEditingController();
  final _scrollController = ScrollController();

  CategoryEntity? _selectedCategory;
  DateTime _selectedDate = DateTime.now();
  RecurrenceType _selectedRecurrence = RecurrenceType.none;
  String? _imageUrl;
  bool _isSubmitting = false;
  bool _isUploadingImage = false;

  @override
  void dispose() {
    _nameController.dispose();
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
        bottom: null, // Auto: true sur Android, false sur iOS
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
                bottom: Platform.isAndroid 
                    ? AppDimensions.paddingXL * 2 // Plus d'espace pour les boutons Android
                    : AppDimensions.paddingM,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // En-tête avec montant
                    _buildHeader(isExpense, isDark),

                    SizedBox(height: AppDimensions.paddingL),

                    // Nom de la transaction
                    _buildNameField(isDark),

                    SizedBox(height: AppDimensions.paddingL),

                    // Image/Logo de la transaction
                    _buildImagePicker(isDark),

                    SizedBox(height: AppDimensions.paddingL),

                    // Catégorie
                    _buildCategorySelector(isExpense, isDark),

                    SizedBox(height: AppDimensions.paddingL),

                    // Date
                    _buildDateSelector(isDark),

                    SizedBox(height: AppDimensions.paddingL),

                    // Récurrence
                    _buildRecurrenceSelector(isDark),

                    SizedBox(height: AppDimensions.paddingL),

                    // Notes (optionnel)
                    _buildNotesField(isDark),

                    SizedBox(height: AppDimensions.paddingXL),

                    // Bouton de sauvegarde
                    _buildSubmitButton(isExpense),
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
                title: isExpense ? 'Nouvelle dépense' : 'Nouveau revenu',
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
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(AppDimensions.paddingM),
                decoration: BoxDecoration(
                  color: (isExpense ? AppColors.error : AppColors.success)
                      .withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.attach_money,
                  color: isExpense ? AppColors.error : AppColors.success,
                  size: 28,
                ),
              ),
              SizedBox(width: AppDimensions.paddingM),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Montant',
                      style: AppTypography.small.copyWith(
                        color: isDark
                            ? AppColors.textSecondaryOnDark
                            : AppColors.textSecondary,
                      ),
                    ),
                    Text(
                      '${widget.amount.toStringAsFixed(2)} €',
                      style: AppTypography.heading.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                        color: isExpense ? AppColors.error : AppColors.success,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: AppDimensions.paddingM),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: AppDimensions.paddingM,
              vertical: AppDimensions.paddingS,
            ),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppDimensions.radiusM),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.edit,
                  size: 16,
                  color: AppColors.primary,
                ),
                SizedBox(width: AppDimensions.paddingXS),
                Text(
                  'Étape 2/2 : Détails',
                  style: AppTypography.small.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn().slideY(begin: -0.2, end: 0);
  }

  Widget _buildNameField(bool isDark) {
    return AppTextField(
      controller: _nameController,
      label: 'Nom',
      hint: 'Ex: Courses, Salaire, Restaurant...',
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Le nom est requis';
        }
        if (value.trim().length < 3) {
          return 'Le nom doit contenir au moins 3 caractères';
        }
        return null;
      },
    ).animate().fadeIn(delay: 100.ms).slideY(begin: -0.2, end: 0);
  }

  Widget _buildCategorySelector(bool isExpense, bool isDark) {
    // Utiliser le provider qui filtre déjà par type et préserve les états
    final categoryType = _toCategoryType(widget.transactionType);
    final filteredCategoriesAsync =
        ref.watch(categoriesByTypeAsyncProvider(categoryType));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Catégorie *',
          style: AppTypography.title.copyWith(
            fontWeight: FontWeight.w600,
            color: isDark ? AppColors.textOnDark : AppColors.textPrimary,
          ),
        ).animate().fadeIn(delay: 200.ms).slideY(begin: -0.2, end: 0),
        SizedBox(height: AppDimensions.paddingM),
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
              initialValue: _selectedCategory,
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
            ).animate().fadeIn(delay: 250.ms);
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
          style: AppTypography.title.copyWith(
            fontWeight: FontWeight.w600,
            color: isDark ? AppColors.textOnDark : AppColors.textPrimary,
          ),
        ).animate().fadeIn(delay: 300.ms).slideY(begin: -0.2, end: 0),
        SizedBox(height: AppDimensions.paddingM),
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
        ).animate().fadeIn(delay: 350.ms),
      ],
    );
  }

  Widget _buildRecurrenceSelector(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Récurrence',
          style: AppTypography.title.copyWith(
            fontWeight: FontWeight.w600,
            color: isDark ? AppColors.textOnDark : AppColors.textPrimary,
          ),
        ).animate().fadeIn(delay: 350.ms).slideY(begin: -0.2, end: 0),
        SizedBox(height: AppDimensions.paddingM),
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
    return AppTextField(
      controller: _notesController,
      label: 'Notes (optionnel)',
      hint: 'Ajoutez des notes...',
      maxLines: 2,
    ).animate().fadeIn(delay: 400.ms).slideY(begin: -0.2, end: 0);
  }

  Widget _buildImagePicker(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Logo / Image (optionnel)',
          style: AppTypography.title.copyWith(
            color: isDark ? AppColors.textOnDark : AppColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ).animate().fadeIn(delay: 150.ms).slideY(begin: -0.2, end: 0),
        SizedBox(height: AppDimensions.paddingM),
        AppCard(
          padding: EdgeInsets.all(AppDimensions.paddingL),
          child: Center(
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
        ).animate().fadeIn(delay: 200.ms),
      ],
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
      final compressedBytes =
          await imageProcessingService.compressAndResizeImage(
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

      final fileName =
          'transaction_${DateTime.now().millisecondsSinceEpoch}.jpg';
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
      text: 'Enregistrer',
      onPressed: _isSubmitting ? null : _submitForm,
      style: AppButtonStyle.gradient,
      isLoading: _isSubmitting,
      size: AppButtonSize.large,
      isFullWidth: true,
      customBorderRadius: 28,
    ).animate().fadeIn(delay: 450.ms).slideY(begin: 0.2, end: 0);
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
      final name = _nameController.text.trim();
      final notes = _notesController.text.trim();

      // Récupérer l'utilisateur actuel
      final currentUserAsync = ref.read(currentUserProvider);
      final currentUser = currentUserAsync.value;

      if (currentUser == null) {
        throw Exception('Utilisateur non connecté');
      }

      // Vérifier que la catégorie a un ID
      if (_selectedCategory!.id == null) {
        throw Exception('La catégorie sélectionnée n\'a pas d\'ID valide');
      }

      // Créer la transaction via le provider
      await ref.read(transactionProvider.notifier).createTransaction(
            type: widget.transactionType,
            amount: widget.amount,
            name: name,
            categoryId: _selectedCategory!.id!,
            date: _selectedDate,
            recurrence: _selectedRecurrence,
            notes: notes.isEmpty ? null : notes,
            imageUrl: _imageUrl,
            userId: currentUser.id,
          );

      if (!mounted) return;

      // Retourner à l'écran précédent (2 fois pour revenir à home)
      context.pop();
      context.pop();

      // Attendre que la navigation soit terminée avant d'afficher la notification
      await Future.delayed(const Duration(milliseconds: 200));

      if (!mounted) return;

      // Afficher la notification de succès
      final successMessage =
          'Votre ${widget.transactionType == TransactionType.expense ? "dépense" : "revenu"} a été enregistrée avec succès';

      InAppNotificationService.showSuccess(
        context,
        title: 'Transaction enregistrée',
        message: successMessage,
        duration: const Duration(seconds: 3),
      );
    } catch (e) {
      // Debug logging removed for production

      if (!mounted) return;

      // Extraire un message d'erreur court et compréhensible
      String errorMessage = 'Impossible d\'enregistrer la transaction';
      final errorString = e.toString();

      if (errorString.contains('UnimplementedError')) {
        errorMessage =
            'Erreur de configuration. Veuillez redémarrer l\'application.';
      } else if (errorString.contains('network') ||
          errorString.contains('NetworkError')) {
        errorMessage =
            'Erreur de connexion. Vérifiez votre connexion internet.';
      } else if (errorString.length < 100) {
        // Si le message est court, l'afficher
        errorMessage = errorString;
      }

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

}

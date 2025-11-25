import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pocketly/core/constants/app_colors.dart';
import 'package:pocketly/core/constants/app_dimensions.dart';
import 'package:pocketly/core/constants/app_typography.dart';
import 'package:pocketly/core/widgets/app_button.dart';
import 'package:pocketly/core/widgets/app_card.dart';
import 'package:pocketly/core/widgets/animated_page_header.dart';
import 'package:pocketly/core/widgets/platform_safe_area.dart';
import 'package:pocketly/core/router/app_route_paths.dart';
import 'package:pocketly/features/transactions/domain/entities/transaction_entity.dart';

/// Première étape de l'ajout d'une transaction : saisie du montant
class AddTransactionAmountScreen extends ConsumerStatefulWidget {
  final TransactionType transactionType;

  const AddTransactionAmountScreen({
    super.key,
    required this.transactionType,
  });

  @override
  ConsumerState<AddTransactionAmountScreen> createState() =>
      _AddTransactionAmountScreenState();
}

class _AddTransactionAmountScreenState
    extends ConsumerState<AddTransactionAmountScreen> {
  final _amountController = TextEditingController();
  final _focusNode = FocusNode();
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Focus automatiquement le champ de montant au démarrage
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _amountController.dispose();
    _focusNode.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  bool get _isFormValid {
    final text = _amountController.text.trim();
    if (text.isEmpty) return false;
    final amount = double.tryParse(text);
    return amount != null && amount > 0;
  }

  void _handleNext() {
    if (!_isFormValid) return;

    final amount = double.parse(_amountController.text.trim());
    final typeParam =
        widget.transactionType == TransactionType.income ? 'income' : 'expense';

    // Naviguer vers l'écran de détails avec le montant
    context.push(
      '${AppRoutePaths.addTransactionDetails}?type=$typeParam&amount=$amount',
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isExpense = widget.transactionType == TransactionType.expense;

    return Scaffold(
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // En-tête avec icône et type
                  _buildHeader(isExpense, isDark),

                  SizedBox(height: AppDimensions.paddingXL * 2),

                  // Grande icône centrale
                  _buildCenterIcon(isExpense),

                  SizedBox(height: AppDimensions.paddingXL),

                  // Montant - Champ large et centré
                  _buildAmountField(isExpense, isDark),

                  SizedBox(height: AppDimensions.paddingXL * 2),

                  // Indication
                  _buildHintText(isExpense, isDark),

                  SizedBox(height: AppDimensions.paddingXL),

                  // Bouton suivant
                  _buildNextButton(isExpense),
                ],
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
      padding: EdgeInsets.all(AppDimensions.paddingM),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(AppDimensions.paddingM),
            decoration: BoxDecoration(
              color: (isExpense ? AppColors.error : AppColors.success)
                  .withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isExpense ? Icons.arrow_upward : Icons.arrow_downward,
              color: isExpense ? AppColors.error : AppColors.success,
              size: 24,
            ),
          ),
          SizedBox(width: AppDimensions.paddingM),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isExpense ? 'Dépense' : 'Revenu',
                  style: AppTypography.title.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isExpense ? AppColors.error : AppColors.success,
                  ),
                ),
                Text(
                  'Étape 1/2 : Montant',
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

  Widget _buildCenterIcon(bool isExpense) {
    return Center(
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: (isExpense ? AppColors.error : AppColors.success)
              .withValues(alpha: 0.15),
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.attach_money,
          color: isExpense ? AppColors.error : AppColors.success,
          size: 36,
        ),
      ),
    );
  }

  Widget _buildAmountField(bool isExpense, bool isDark) {
    return Column(
      children: [
        Text(
          'Quel est le montant ?',
          style: AppTypography.display.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: isDark ? AppColors.textOnDark : AppColors.textPrimary,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: AppDimensions.paddingL),
        Container(
          constraints: const BoxConstraints(maxWidth: 400),
          child: TextField(
            controller: _amountController,
            focusNode: _focusNode,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            textAlign: TextAlign.center,
            autofocus: true,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
            ],
            style: AppTypography.display.copyWith(
              fontSize: 48,
              fontWeight: FontWeight.bold,
              color: isExpense ? AppColors.error : AppColors.success,
            ),
            decoration: InputDecoration(
              hintText: '0.00',
              hintStyle: AppTypography.display.copyWith(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: (isExpense ? AppColors.error : AppColors.success)
                    .withValues(alpha: 0.3),
              ),
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: AppDimensions.paddingL,
                vertical: AppDimensions.paddingM,
              ),
            ),
            onChanged: (_) => setState(() {}),
          ),
        ),
        // Ligne de séparation stylisée
        Container(
          height: 3,
          width: 200,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                (isExpense ? AppColors.error : AppColors.success)
                    .withValues(alpha: 0.1),
                isExpense ? AppColors.error : AppColors.success,
                (isExpense ? AppColors.error : AppColors.success)
                    .withValues(alpha: 0.1),
              ],
            ),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ],
    );
  }

  Widget _buildHintText(bool isExpense, bool isDark) {
    return Text(
      isExpense
          ? 'Combien avez-vous dépensé ?'
          : 'Combien avez-vous reçu ?',
      style: AppTypography.body.copyWith(
        color:
            isDark ? AppColors.textSecondaryOnDark : AppColors.textSecondary,
        fontSize: 16,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildNextButton(bool isExpense) {
    return AppButton(
      text: 'Suivant',
      onPressed: _isFormValid ? _handleNext : null,
      style: AppButtonStyle.gradient,
      size: AppButtonSize.large,
      isFullWidth: true,
      customBorderRadius: 28,
      icon: Icons.arrow_forward,
      iconPosition: IconPosition.right,
    );
  }
}

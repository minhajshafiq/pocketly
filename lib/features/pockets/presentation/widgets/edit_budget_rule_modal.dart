import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:pocketly/core/core.dart';
import 'package:pocketly/features/pockets/domain/entities/pocket_entity.dart';
import 'package:pocketly/features/user/user.dart';

/// Modal moderne et adaptative pour modifier la règle budgétaire personnalisée
///
/// Permet de configurer les pourcentages pour les besoins, envies et épargne.
/// La somme doit toujours être égale à 100%.
class EditBudgetRuleModal extends ConsumerStatefulWidget {
  /// L'utilisateur actuel
  final UserEntity user;

  const EditBudgetRuleModal({super.key, required this.user});

  @override
  ConsumerState<EditBudgetRuleModal> createState() => _EditBudgetRuleModalState();
}

class _EditBudgetRuleModalState extends ConsumerState<EditBudgetRuleModal> {
  late int _needs;
  late int _wants;
  late int _savings;
  bool _isSaving = false;

  bool get _isIOS => !kIsWeb && Platform.isIOS;

  @override
  void initState() {
    super.initState();
    _needs = widget.user.budgetRuleNeeds;
    _wants = widget.user.budgetRuleWants;
    _savings = widget.user.budgetRuleSavings;
  }

  /// Vérifie si la règle est valide (somme = 100)
  bool get _isValid => _needs + _wants + _savings == 100;

  /// Calcule la différence avec 100
  int get _difference => 100 - (_needs + _wants + _savings);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (_isIOS) {
      return _buildCupertinoModal(context, isDark);
    }
    return _buildMaterialModal(context, isDark);
  }

  /// Modal iOS - Design iOS natif et épuré sans effet de modal dans modal
  Widget _buildCupertinoModal(BuildContext context, bool isDark) {
    final surfaceColor = isDark ? AppColors.surfaceDark : AppColors.surface;
    final textPrimaryColor = isDark ? AppColors.textOnDark : AppColors.textPrimary;
    final textSecondaryColor = isDark ? AppColors.textSecondaryOnDark : AppColors.textSecondary;
    
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.9,
      ),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(28),
          topRight: Radius.circular(28),
        ),
      ),
      child: _buildIOSContent(context, isDark, surfaceColor, textPrimaryColor, textSecondaryColor),
    );
  }

  /// Modal Android avec BottomSheet
  Widget _buildMaterialModal(BuildContext context, bool isDark) {
    return SafeArea(
      top: false,
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.9,
        ),
        decoration: BoxDecoration(
          color: isDark ? AppColors.surfaceDark : AppColors.surface,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(AppDimensions.radiusXL),
            topRight: Radius.circular(AppDimensions.radiusXL),
      ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.1),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Poignée de drag pour Android
            Container(
              margin: EdgeInsets.only(top: AppDimensions.paddingS, bottom: AppDimensions.paddingXS),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: (isDark ? AppColors.textSecondaryOnDark : AppColors.textSecondary)
                    .withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Flexible(
              child: _buildContent(context, isDark, false),
            ),
          ],
        ),
      ),
    );
  }

  /// Contenu iOS natif et épuré
  Widget _buildIOSContent(
    BuildContext context,
    bool isDark,
    Color surfaceColor,
    Color textPrimaryColor,
    Color textSecondaryColor,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Poignée de drag pour iOS
        Container(
          margin: EdgeInsets.only(top: AppDimensions.paddingS, bottom: AppDimensions.paddingXS),
          width: 40,
          height: 4,
          decoration: BoxDecoration(
            color: textSecondaryColor.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        // Header iOS avec séparateur
        _buildIOSHeader(context, textPrimaryColor, textSecondaryColor),
        
        // Contenu scrollable
        Flexible(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: AppDimensions.paddingM,
              vertical: AppDimensions.paddingM,
            ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
                // Indicateur de validité iOS
                _buildIOSValidityIndicator(isDark, textSecondaryColor)
                    .animate()
                    .fadeIn(delay: 100.ms, duration: 300.ms),
                
                SizedBox(height: AppDimensions.paddingM),
                
                // Slider Besoins iOS
                AppCard(
                  padding: EdgeInsets.all(AppDimensions.paddingM),
                  child: _buildIOSSlider(
                    label: 'Besoins',
                    value: _needs,
                    color: Color(int.parse(PocketCategory.needs.primaryColor.replaceFirst('#', '0xFF'))),
                    icon: AppIcons.home,
                    onChanged: (value) {
                      setState(() => _needs = value.toInt());
                    },
                    textSecondaryColor: textSecondaryColor,
                    category: PocketCategory.needs,
                  ),
                )
                    .animate()
                    .fadeIn(delay: 200.ms, duration: 300.ms),
                
                SizedBox(height: AppDimensions.paddingM),
                
                // Slider Envies iOS
                AppCard(
                  padding: EdgeInsets.all(AppDimensions.paddingM),
                  child: _buildIOSSlider(
                    label: 'Envies',
                    value: _wants,
                    color: Color(int.parse(PocketCategory.wants.primaryColor.replaceFirst('#', '0xFF'))),
                    icon: AppIcons.favorite,
                    onChanged: (value) {
                      setState(() => _wants = value.toInt());
                    },
                    textSecondaryColor: textSecondaryColor,
                    category: PocketCategory.wants,
                  ),
                )
                    .animate()
                    .fadeIn(delay: 300.ms, duration: 300.ms),
                
                SizedBox(height: AppDimensions.paddingM),
                
                // Slider Épargne iOS
                AppCard(
                  padding: EdgeInsets.all(AppDimensions.paddingM),
                  child: _buildIOSSlider(
                    label: 'Épargne',
                    value: _savings,
                    color: Color(int.parse(PocketCategory.savings.primaryColor.replaceFirst('#', '0xFF'))),
                    icon: AppIcons.savings,
                    onChanged: (value) {
                      setState(() => _savings = value.toInt());
                    },
                    textSecondaryColor: textSecondaryColor,
                    category: PocketCategory.savings,
                  ),
                )
                    .animate()
                    .fadeIn(delay: 400.ms, duration: 300.ms),
                
                SizedBox(height: AppDimensions.paddingM),
                
                // Boutons d'action iOS
                _buildIOSActionButtons(context, textPrimaryColor, textSecondaryColor)
                    .animate()
                    .fadeIn(delay: 500.ms, duration: 300.ms),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// Contenu Android/Material
  Widget _buildContent(BuildContext context, bool isDark, bool isIOS) {
    final safeBottom = isIOS ? 0.0 : MediaQuery.of(context).padding.bottom;

    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(
        AppDimensions.paddingM,
        AppDimensions.paddingM,
        AppDimensions.paddingM,
        AppDimensions.paddingM + safeBottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header avec titre et bouton fermer
          _buildHeader(context, isDark, isIOS)
              .animate()
              .fadeIn(duration: 200.ms)
              .slideY(begin: -0.2, end: 0),
          
            SizedBox(height: AppDimensions.paddingM),

            // Indicateur de validité
          _buildValidityIndicator(isDark)
              .animate()
              .fadeIn(delay: 100.ms, duration: 300.ms)
              .scale(begin: const Offset(0.9, 0.9), end: const Offset(1, 1)),
          
          SizedBox(height: AppDimensions.paddingM),

            // Slider Besoins
            _buildSlider(
              label: 'Besoins',
              value: _needs,
              color: Color(int.parse(PocketCategory.needs.primaryColor.replaceFirst('#', '0xFF'))),
              icon: AppIcons.home,
              onChanged: (value) {
                setState(() => _needs = value.toInt());
              },
              isDark: isDark,
              isIOS: isIOS,
              category: PocketCategory.needs,
            )
              .animate()
              .fadeIn(delay: 200.ms, duration: 300.ms)
              .slideX(begin: -0.2, end: 0),
          
          SizedBox(height: AppDimensions.paddingM),

            // Slider Envies
            _buildSlider(
              label: 'Envies',
              value: _wants,
              color: Color(int.parse(PocketCategory.wants.primaryColor.replaceFirst('#', '0xFF'))),
              icon: AppIcons.favorite,
              onChanged: (value) {
                setState(() => _wants = value.toInt());
              },
              isDark: isDark,
              isIOS: isIOS,
              category: PocketCategory.wants,
            )
              .animate()
              .fadeIn(delay: 300.ms, duration: 300.ms)
              .slideX(begin: -0.2, end: 0),
          
          SizedBox(height: AppDimensions.paddingM),

            // Slider Épargne
            _buildSlider(
              label: 'Épargne',
              value: _savings,
              color: Color(int.parse(PocketCategory.savings.primaryColor.replaceFirst('#', '0xFF'))),
              icon: AppIcons.savings,
              onChanged: (value) {
                setState(() => _savings = value.toInt());
              },
              isDark: isDark,
              isIOS: isIOS,
              category: PocketCategory.savings,
            )
              .animate()
              .fadeIn(delay: 400.ms, duration: 300.ms)
              .slideX(begin: -0.2, end: 0),
          
          SizedBox(height: AppDimensions.paddingM),

            // Boutons d'action
          _buildActionButtons(context, isDark, isIOS)
              .animate()
              .fadeIn(delay: 500.ms, duration: 300.ms)
              .slideY(begin: 0.2, end: 0),
        ],
      ),
    );
  }

  /// Header iOS natif avec séparateur
  Widget _buildIOSHeader(
    BuildContext context,
    Color textPrimaryColor,
    Color textSecondaryColor,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: textSecondaryColor.withValues(alpha: 0.2),
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(width: 36), // Espace pour centrer
          Expanded(
            child: Column(
              children: [
                Material(
                  color: Colors.transparent,
                  child: Text(
                    'Règle budgétaire',
                    style: AppTypography.heading.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: textPrimaryColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: AppDimensions.paddingXS / 2),
                Material(
                  color: Colors.transparent,
                  child: Text(
                    'Personnalisez la répartition',
                    style: AppTypography.caption.copyWith(
                      fontSize: 12,
                      color: textSecondaryColor,
                    ),
                    textAlign: TextAlign.center,
                    ),
                  ),
              ],
            ),
          ),
          CupertinoButton(
            padding: EdgeInsets.zero,
            minimumSize: const Size(36, 36),
                  onPressed: () => Navigator.of(context).pop(),
            child: Icon(
              CupertinoIcons.xmark,
              size: 16,
              color: textSecondaryColor,
            ),
          ),
        ],
      ),
    );
  }

  /// Indicateur de validité iOS épuré avec AppCard
  Widget _buildIOSValidityIndicator(bool isDark, Color textSecondaryColor) {
    final isValid = _isValid;
    final difference = _difference;

    return AppCard(
      backgroundColor: isValid
          ? AppColors.success.withValues(alpha: 0.1)
          : AppColors.error.withValues(alpha: 0.1),
      borderColor: isValid ? AppColors.success : AppColors.error,
      padding: EdgeInsets.all(AppDimensions.paddingS),
      child: Row(
        children: [
          Material(
            color: Colors.transparent,
            child: Icon(
              isValid ? AppIcons.checkCircle : AppIcons.warning,
              color: isValid ? AppColors.success : AppColors.error,
              size: 18,
            ),
          ),
          SizedBox(width: AppDimensions.paddingS),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Material(
                  color: Colors.transparent,
                  child: Text(
                    isValid ? 'Règle valide' : 'Règle invalide',
                    style: AppTypography.title.copyWith(
                      fontSize: 14,
                      color: isValid ? AppColors.success : AppColors.error,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: 2),
                Material(
                  color: Colors.transparent,
                  child: Text(
                    isValid
                        ? 'Total = 100%'
                        : difference > 0
                            ? 'Il manque $difference%'
                            : 'Dépassement de ${difference.abs()}%',
                    style: AppTypography.small.copyWith(
                      fontSize: 11,
                      color: textSecondaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Bouton Réinitialiser à droite de l'indicateur
          CupertinoButton(
            padding: EdgeInsets.zero,
            minimumSize: const Size(36, 36),
            onPressed: () {
              HapticFeedback.mediumImpact();
              setState(() {
                _needs = 50;
                _wants = 30;
                _savings = 20;
              });
            },
            child: Material(
              color: Colors.transparent,
              child: Icon(
                CupertinoIcons.arrow_counterclockwise,
                size: 18,
                color: textSecondaryColor,
              ),
            ),
            ),
          ],
      ),
    );
  }

  /// Slider iOS natif et épuré
  Widget _buildIOSSlider({
    required String label,
    required int value,
    required Color color,
    required IconData icon,
    required ValueChanged<double> onChanged,
    required Color textSecondaryColor,
    required PocketCategory category,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label avec icône et pourcentage
        Padding(
          padding: EdgeInsets.only(left: 4, bottom: AppDimensions.paddingS),
          child: Row(
          children: [
              Icon(
                icon,
                size: 18,
                color: color,
              ),
              SizedBox(width: AppDimensions.paddingS),
              Text(
                label,
                style: AppTypography.title.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            const Spacer(),
              Text(
                '$value%',
                style: AppTypography.title.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
        ),
        
        // CupertinoSlider natif avec largeur adaptative
        Semantics(
          label: 'Slider pour $label, valeur actuelle: $value%',
          value: '$value%',
          child: CupertinoSlider(
            value: value.toDouble(),
            min: 0,
            max: 100,
            divisions: 50, // Réduit pour améliorer les performances
            activeColor: color,
            thumbColor: color,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }

  /// Boutons d'action iOS natifs
  Widget _buildIOSActionButtons(
    BuildContext context,
    Color textPrimaryColor,
    Color textSecondaryColor,
  ) {
    return Row(
      children: [
        // Bouton Annuler
        Expanded(
          child: AppButton(
            text: 'Annuler',
            onPressed: () {
              HapticFeedback.lightImpact();
              Navigator.of(context).pop();
            },
            style: AppButtonStyle.outline,
            size: AppButtonSize.large,
            icon: AppIcons.close,
            iconPosition: IconPosition.left,
          ),
        ),
        
        SizedBox(width: AppDimensions.paddingM),
        
        // Bouton Enregistrer avec AppButton (style primary comme dans l'app)
        Expanded(
          child: AppButton(
            text: 'Enregistrer',
            onPressed: _isValid && !_isSaving ? _save : null,
            isLoading: _isSaving,
            style: AppButtonStyle.primary,
            size: AppButtonSize.large,
            icon: AppIcons.checkCircle,
            iconPosition: IconPosition.left,
          ),
        ),
      ],
    );
  }

  /// Construit le header de la modal
  Widget _buildHeader(BuildContext context, bool isDark, bool isIOS) {
    return Row(
      children: [
        // Icône avec fond coloré
        Container(
          padding: EdgeInsets.all(AppDimensions.paddingXS),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(AppDimensions.radiusM),
          ),
          child: Icon(
            AppIcons.budget,
            color: AppColors.primary,
            size: 18,
          ),
        ),
        SizedBox(width: AppDimensions.paddingS),
        
        // Titre et sous-titre
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Règle budgétaire',
                style: AppTypography.heading.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 2),
              Text(
                'Personnalisez la répartition de votre budget',
                style: AppTypography.caption.copyWith(
                  fontSize: 12,
                  color: isDark
                      ? AppColors.textSecondaryOnDark
                      : AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
        
        // Bouton fermer
        if (isIOS)
          CupertinoButton(
            padding: EdgeInsets.zero,
            minimumSize: const Size(36, 36),
            onPressed: () => Navigator.of(context).pop(),
            child: Container(
              padding: EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: (isDark ? AppColors.textSecondaryOnDark : AppColors.textSecondary)
                    .withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                CupertinoIcons.xmark,
                size: 14,
                color: isDark ? AppColors.textSecondaryOnDark : AppColors.textSecondary,
              ),
            ),
          )
        else
          IconButton(
            iconSize: 20,
            icon: Icon(
              AppIcons.close,
              color: isDark ? AppColors.textSecondaryOnDark : AppColors.textSecondary,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
      ],
    );
  }

  /// Construit un slider adaptatif (iOS/Android) avec AppCard
  Widget _buildSlider({
    required String label,
    required int value,
    required Color color,
    required IconData icon,
    required ValueChanged<double> onChanged,
    required bool isDark,
    required bool isIOS,
    required PocketCategory category,
  }) {
    return AppCard(
      backgroundColor: color.withValues(alpha: 0.05),
      borderColor: color.withValues(alpha: 0.3),
      padding: EdgeInsets.all(AppDimensions.paddingM),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Label avec icône et pourcentage
          Row(
            children: [
              // Icône dans un cercle coloré
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  size: 18,
                  color: color,
                ),
              ),
              SizedBox(width: AppDimensions.paddingS),
              
              // Label
              Expanded(
                child: Text(
                  label,
                  style: AppTypography.title.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              
              // Pourcentage avec badge
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: AppDimensions.paddingS,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                ),
                child: Text(
                  '$value%',
                  style: AppTypography.title.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ),
            ],
          ),
          
          SizedBox(height: AppDimensions.paddingS),

          // Slider adaptatif avec accessibilité
          Semantics(
            label: 'Slider pour $label, valeur actuelle: $value%',
            value: '$value%',
            child: isIOS
                ? CupertinoSlider(
                    value: value.toDouble(),
                    min: 0,
                    max: 100,
                    divisions: 50, // Réduit pour améliorer les performances
                    activeColor: color,
                    thumbColor: color,
                    onChanged: onChanged,
                  )
                : SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      activeTrackColor: color,
                      inactiveTrackColor: color.withValues(alpha: 0.2),
                      thumbColor: color,
                      overlayColor: color.withValues(alpha: 0.2),
                      valueIndicatorColor: color,
                      trackHeight: 6,
                      thumbShape: const RoundSliderThumbShape(
                        enabledThumbRadius: 12,
                      ),
                      overlayShape: const RoundSliderOverlayShape(
                        overlayRadius: 20,
                      ),
                    ),
                    child: Slider(
                      value: value.toDouble(),
                      min: 0,
                      max: 100,
                      divisions: 50, // Réduit pour améliorer les performances
                      label: '$value%',
                      onChanged: onChanged,
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  /// Construit l'indicateur de validité amélioré avec AppCard
  Widget _buildValidityIndicator(bool isDark) {
    final isValid = _isValid;
    final difference = _difference;

    return Semantics(
      label: isValid ? 'Règle budgétaire valide, total égal à 100%' : 'Règle budgétaire invalide',
      child: AppCard(
        backgroundColor: isValid
            ? AppColors.success.withValues(alpha: 0.1)
            : AppColors.error.withValues(alpha: 0.1),
        borderColor: isValid ? AppColors.success : AppColors.error,
        elevation: 4.0,
        padding: EdgeInsets.all(AppDimensions.paddingS),
      child: Row(
        children: [
            // Icône animée
            Container(
              padding: EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: isValid ? AppColors.success : AppColors.error,
                shape: BoxShape.circle,
              ),
              child: Icon(
            isValid ? AppIcons.checkCircle : AppIcons.warning,
                color: Colors.white,
                size: 18,
              ),
            )
                .animate(target: isValid ? 1 : 0)
                .scale(duration: 300.ms, curve: Curves.elasticOut),
            
            SizedBox(width: AppDimensions.paddingS),
            
            // Message
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Material(
                    color: Colors.transparent,
                    child: Text(
                      isValid ? 'Règle valide' : 'Règle invalide',
                      style: AppTypography.title.copyWith(
            fontSize: 14,
            color: isValid ? AppColors.success : AppColors.error,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
          ),
                  SizedBox(height: 2),
                  Material(
                    color: Colors.transparent,
            child: Text(
              isValid
                          ? 'Total = 100%'
                  : difference > 0
                      ? 'Il manque $difference% (total = ${100 - difference}%)'
                      : 'Dépassement de ${difference.abs()}% (total = ${100 - difference}%)',
              style: AppTypography.small.copyWith(
                fontSize: 11,
                color: isValid ? AppColors.success : AppColors.error,
                        fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
            ),
            // Bouton Réinitialiser à droite de l'indicateur
            IconButton(
              iconSize: 20,
              icon: Icon(
                AppIcons.refresh,
                color: isDark ? AppColors.textSecondaryOnDark : AppColors.textSecondary,
              ),
              onPressed: () {
                HapticFeedback.mediumImpact();
                setState(() {
                  _needs = 50;
                  _wants = 30;
                  _savings = 20;
                });
              },
              tooltip: 'Réinitialiser',
            ),
          ],
        ),
      ),
    );
  }

  /// Construit les boutons d'action
  Widget _buildActionButtons(BuildContext context, bool isDark, bool isIOS) {
    return Row(
      children: [
        // Bouton Annuler
        Expanded(
          child: AppButton(
            text: 'Annuler',
            onPressed: () {
              HapticFeedback.lightImpact();
              Navigator.of(context).pop();
            },
            style: AppButtonStyle.outline,
            size: AppButtonSize.large,
            icon: AppIcons.close,
            iconPosition: IconPosition.left,
          ),
        ),
        
        SizedBox(width: AppDimensions.paddingM),
        
        // Bouton Enregistrer
        Expanded(
          child: AppButton(
            text: 'Enregistrer',
            onPressed: _isValid && !_isSaving ? _save : null,
            isLoading: _isSaving,
            style: AppButtonStyle.primary,
            size: AppButtonSize.large,
            icon: AppIcons.checkCircle,
            iconPosition: IconPosition.left,
          ),
        ),
      ],
    );
  }

  /// Sauvegarde la règle budgétaire
  Future<void> _save() async {
    if (!_isValid || _isSaving) return;

    setState(() => _isSaving = true);
    HapticFeedback.mediumImpact();

    try {
      ref.read(loggerProvider).d('Sauvegarde de la règle: $_needs/$_wants/$_savings');

      // Appeler le provider pour mettre à jour la règle budgétaire
      await ref.read(currentUserProvider.notifier).updateBudgetRule(
            needs: _needs,
            wants: _wants,
            savings: _savings,
          );

      ref.read(loggerProvider).i('Règle sauvegardée avec succès');

      // Forcer un refresh pour récupérer les données depuis la base de données
      await Future.delayed(const Duration(milliseconds: 200));
      await ref.read(currentUserProvider.notifier).refreshUser();

      ref.read(loggerProvider).d('Utilisateur rafraîchi depuis la base de données');

      if (!mounted) return;

      HapticFeedback.mediumImpact();

      // Fermer la modale
      Navigator.of(context).pop();

      // Afficher un snackbar de succès
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(AppIcons.checkCircle, color: Colors.white),
              SizedBox(width: AppDimensions.paddingS),
              const Text('Règle budgétaire mise à jour avec succès'),
            ],
          ),
          backgroundColor: AppColors.success,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusM),
          ),
          margin: EdgeInsets.all(AppDimensions.paddingM),
        ),
      );
    } catch (e) {
      if (!mounted) return;

      setState(() => _isSaving = false);
      HapticFeedback.heavyImpact();

      ref.read(loggerProvider).e('Erreur lors de la sauvegarde de la règle budgétaire', error: e);

      // Afficher une erreur
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(AppIcons.warning, color: Colors.white),
              SizedBox(width: AppDimensions.paddingS),
              Expanded(
                child: Text('Erreur: $e'),
              ),
            ],
          ),
          backgroundColor: AppColors.error,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusM),
          ),
          margin: EdgeInsets.all(AppDimensions.paddingM),
        ),
      );
    }
  }
}

/// Fonction helper pour afficher la modale de manière adaptative
/// Utilise le root navigator pour passer au-dessus de la bottom navigation
/// 
/// Avec MaterialApp.router, on utilise showGeneralDialog avec useRootNavigator: true
/// qui est la méthode la plus simple et directe pour afficher au-dessus de la bottom nav
void showEditBudgetRuleModal(BuildContext context, UserEntity user) {
  showGeneralDialog<void>(
    context: context,
    barrierDismissible: true,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor: Colors.black.withValues(alpha: 0.5),
    transitionDuration: const Duration(milliseconds: 300),
    useRootNavigator: true, // Passe au-dessus de la bottom nav avec MaterialApp.router
    pageBuilder: (context, animation, secondaryAnimation) {
      return _ModalWithDrag(
        animation: animation,
        child: EditBudgetRuleModal(user: user),
  );
    },
  );
}

/// Wrapper simple pour ajouter le drag-to-dismiss
class _ModalWithDrag extends StatefulWidget {
  final Animation<double> animation;
  final Widget child;

  const _ModalWithDrag({
    required this.animation,
    required this.child,
  });

  @override
  State<_ModalWithDrag> createState() => _ModalWithDragState();
}

class _ModalWithDragState extends State<_ModalWithDrag> {
  double _dragOffset = 0.0;

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, 1),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: widget.animation,
        curve: Curves.easeOut,
      )),
      child: GestureDetector(
        onVerticalDragUpdate: (details) {
          if (details.delta.dy > 0) {
            setState(() {
              _dragOffset = (_dragOffset + details.delta.dy).clamp(0.0, double.infinity);
            });
          }
        },
        onVerticalDragEnd: (details) {
          if (_dragOffset > 100 || details.velocity.pixelsPerSecond.dy > 500) {
            Navigator.of(context).pop();
          } else {
            setState(() => _dragOffset = 0.0);
          }
        },
        child: Transform.translate(
          offset: Offset(0, _dragOffset),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Material(
              color: Colors.transparent,
              child: Container(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.9,
                ),
                decoration: ShapeDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(AppDimensions.radiusXL),
                    ),
                  ),
                ),
                child: widget.child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

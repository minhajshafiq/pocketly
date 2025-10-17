import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pocketly/core/constants/app_constants.dart';

/// Types de champs de texte disponibles
enum AppTextFieldType { 
  text, 
  email, 
  password, 
  number, 
  phone, 
  multiline,
  search,
  url,
}

/// Configuration pour l'animation du label
class _LabelAnimationConfig {
  static const Duration duration = Duration(milliseconds: 250);
  static const Curve curve = Curves.easeInOutCubic;
  static const double scaleFactor = 0.75;
  static const double verticalOffset = -2.5;
  static const double horizontalPadding = 8.0;
  static const double verticalPadding = 2.0;
}

/// Widget champ de texte modulaire et réutilisable pour toute l'application.
///
/// Ce widget offre différents types, validations et états pour s'adapter
/// à tous les besoins de l'interface utilisateur avec des animations fluides.
class AppTextField extends ConsumerStatefulWidget {
  /// Contrôleur du champ de texte
  final TextEditingController controller;
  
  /// Label du champ
  final String label;
  
  /// Texte d'aide (placeholder)
  final String? hint;
  
  /// Type de champ
  final AppTextFieldType type;
  
  /// Icône personnalisée
  final IconData? icon;
  
  /// Fonction de validation
  final String? Function(String?)? validator;
  
  /// Callback de changement de texte
  final ValueChanged<String>? onChanged;
  
  /// Callback de soumission
  final ValueChanged<String>? onSubmitted;
  
  /// État activé/désactivé
  final bool enabled;
  
  /// État lecture seule
  final bool readOnly;
  
  /// Nombre maximum de lignes
  final int? maxLines;
  
  /// Longueur maximum du texte
  final int? maxLength;
  
  /// Action du clavier
  final TextInputAction? textInputAction;
  
  /// Nœud de focus
  final FocusNode? focusNode;
  
  /// Afficher le toggle de mot de passe
  final bool showPasswordToggle;
  
  /// Icône de suffixe personnalisée
  final Widget? suffixIcon;
  
  /// Padding du contenu
  final EdgeInsetsGeometry? contentPadding;
  
  /// Afficher les erreurs de validation
  final bool showValidationErrors;
  final bool hasBeenSubmitted;
  
  /// Style du texte
  final TextStyle? textStyle;
  
  /// Style du label
  final TextStyle? labelStyle;
  
  /// Couleur de l'icône
  final Color? iconColor;
  
  /// Couleur de la bordure
  final Color? borderColor;
  
  /// Couleur de fond
  final Color? backgroundColor;

  const AppTextField({
    super.key,
    required this.controller,
    required this.label,
    this.hint,
    this.type = AppTextFieldType.text,
    this.icon,
    this.validator,
    this.onChanged,
    this.onSubmitted,
    this.enabled = true,
    this.readOnly = false,
    this.maxLines,
    this.maxLength,
    this.textInputAction,
    this.focusNode,
    this.showPasswordToggle = false,
    this.suffixIcon,
    this.contentPadding,
    this.showValidationErrors = false,
    this.hasBeenSubmitted = false,
    this.textStyle,
    this.labelStyle,
    this.iconColor,
    this.borderColor,
    this.backgroundColor,
  });

  @override
  ConsumerState<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends ConsumerState<AppTextField>
    with TickerProviderStateMixin {
  
  // Animation controllers
  late final AnimationController _animationController;
  late final AnimationController _labelColorController;
  
  // Animations
  late final Animation<double> _labelAnimation;
  Animation<Color?>? _labelColorAnimation;
  late final Animation<double> _labelScaleAnimation;
  late final Animation<Offset> _labelPositionAnimation;
  
  // State variables
  bool _isFocused = false;
  bool _hasText = false;
  bool _obscurePassword = true;
  late final FocusNode _focusNode;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeFocusNode();
    _initializeAnimations();
    _setupListeners();
    _checkInitialText();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      _updateLabelColorAnimation();
      _isInitialized = true;
    }
  }

  @override
  void didUpdateWidget(AppTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    _handleWidgetUpdates(oldWidget);
  }

  @override
  void dispose() {
    _cleanup();
    super.dispose();
  }

  // Initialization methods
  void _initializeFocusNode() {
    _focusNode = widget.focusNode ?? FocusNode();
    _hasText = widget.controller.text.isNotEmpty;
  }

  void _initializeAnimations() {
    _animationController = AnimationController(
      duration: _LabelAnimationConfig.duration,
      vsync: this,
    );

    _labelColorController = AnimationController(
      duration: _LabelAnimationConfig.duration,
      vsync: this,
    );

    _labelAnimation = CurvedAnimation(
      parent: _animationController,
      curve: _LabelAnimationConfig.curve,
    );

    _labelScaleAnimation = Tween<double>(
      begin: 1.0,
      end: _LabelAnimationConfig.scaleFactor,
    ).animate(_labelAnimation);

    _labelPositionAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0, _LabelAnimationConfig.verticalOffset),
    ).animate(_labelAnimation);
  }

  void _setupListeners() {
    _focusNode.addListener(_onFocusChange);
    widget.controller.addListener(_onTextChange);
  }

  void _checkInitialText() {
    if (_hasText) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          _animationController.forward();
        }
      });
    }
  }

  void _handleWidgetUpdates(AppTextField oldWidget) {
    if (oldWidget.showValidationErrors != widget.showValidationErrors) {
      _updateLabelColorAnimation();
    }
  }

  void _cleanup() {
    _focusNode.removeListener(_onFocusChange);
    widget.controller.removeListener(_onTextChange);
    
    _animationController.dispose();
    _labelColorController.dispose();
    
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
  }

  // Animation and state management
  void _updateLabelColorAnimation() {
    if (!mounted) return;
    
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final hasError = _hasError();
    final shouldShowActiveColor = _isFocused;

    _labelColorAnimation = ColorTween(
      begin: _getDefaultLabelColor(isDark),
      end: hasError
          ? AppColors.error
          : (shouldShowActiveColor
              ? AppColors.primary
              : _getDefaultLabelColor(isDark)),
    ).animate(CurvedAnimation(
      parent: _labelColorController,
      curve: _LabelAnimationConfig.curve,
    ));
    
    // Déclencher l'animation de couleur
    if (shouldShowActiveColor) {
      _labelColorController.forward();
    } else {
      _labelColorController.reverse();
    }
  }

  Color _getDefaultLabelColor(bool isDark) {
    return isDark ? AppColors.textSecondaryOnDark : AppColors.textSecondary;
  }

  bool _hasError() {
    return widget.showValidationErrors &&
        widget.validator != null &&
        widget.hasBeenSubmitted &&
        widget.validator!(widget.controller.text) != null;
  }

  void _onFocusChange() {
    if (_isFocused != _focusNode.hasFocus) {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
      _updateLabelColorAnimation();
      _updateAnimation();
    }
  }

  void _onTextChange() {
    final hasText = widget.controller.text.isNotEmpty;
    if (hasText != _hasText) {
      setState(() {
        _hasText = hasText;
      });
      _updateAnimation();
    }

    _updateLabelColorAnimation();
    _handleTextChange();
  }

  void _handleTextChange() {
    if (widget.onChanged != null) {
      try {
        widget.onChanged!(widget.controller.text);
      } catch (e) {
        // Ignorer les erreurs dans le callback
        debugPrint('Error in onChanged callback: $e');
      }
    }
  }

  void _updateAnimation() {
    final shouldAnimateUp = _isFocused || _hasText;
    final isCurrentlyUp = _animationController.value > 0.5;
    
    if (shouldAnimateUp && !isCurrentlyUp) {
      _animationController.forward();
    } else if (!shouldAnimateUp && isCurrentlyUp) {
      _animationController.reverse();
    }
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  // UI Build methods
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTextFieldContainer(theme, isDark),
      ],
    );
  }

  Widget _buildTextFieldContainer(ThemeData theme, bool isDark) {
    final hasError = _hasError();
    final backgroundColor = _getBackgroundColor(isDark);
    final textColor = _getTextColor(isDark);

    return Container(
      decoration: _buildContainerDecoration(isDark),
      child: Stack(
        children: [
          _buildTextField(hasError, backgroundColor, textColor),
          if (_isInitialized) _buildAnimatedLabel(hasError, backgroundColor, isDark),
        ],
      ),
    );
  }

  BoxDecoration _buildContainerDecoration(bool isDark) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(28.r),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: isDark ? 0.1 : 0.05),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }

  Widget _buildTextField(bool hasError, Color backgroundColor, Color textColor) {
    return Material(
      color: Colors.transparent,
      child: TextField(
        controller: widget.controller,
        focusNode: _focusNode,
        obscureText: _shouldObscureText(),
        keyboardType: _getKeyboardType(),
        textInputAction: widget.textInputAction ?? _getTextInputAction(),
        enabled: widget.enabled,
        readOnly: widget.readOnly,
        maxLines: widget.maxLines ?? _getMaxLines(),
        maxLength: widget.maxLength,
        style: widget.textStyle ?? AppTypography.body.copyWith(color: textColor),
        onChanged: _handleTextFieldChange,
        onSubmitted: widget.onSubmitted,
        onTap: _handleTextFieldTap,
        decoration: _buildInputDecoration(hasError, backgroundColor),
      ),
    );
  }

  void _handleTextFieldChange(String value) {
    if (widget.onChanged != null) {
      try {
        widget.onChanged!(value);
      } catch (e) {
        debugPrint('Error in onChanged callback: $e');
      }
    }
  }

  void _handleTextFieldTap() {
    if (!_focusNode.hasFocus) {
      _focusNode.requestFocus();
    }
  }

  InputDecoration _buildInputDecoration(bool hasError, Color backgroundColor) {
    return InputDecoration(
      prefixIcon: _buildPrefixIcon(hasError),
      suffixIcon: _buildSuffixIcon(hasError),
      filled: true,
      fillColor: backgroundColor,
      border: _buildBorder(),
      enabledBorder: _buildEnabledBorder(hasError),
      focusedBorder: _buildFocusedBorder(hasError),
      disabledBorder: _buildDisabledBorder(),
      contentPadding: _getContentPadding(),
    );
  }

  OutlineInputBorder _buildBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(28.r),
      borderSide: BorderSide.none,
    );
  }

  OutlineInputBorder _buildEnabledBorder(bool hasError) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(28.r),
      borderSide: BorderSide(
        color: hasError
            ? AppColors.error.withValues(alpha: 0.6)
            : (isDark ? AppColors.borderDark : AppColors.borderLight),
        width: 1.5,
      ),
    );
  }

  OutlineInputBorder _buildFocusedBorder(bool hasError) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(28.r),
      borderSide: BorderSide(
        color: hasError ? AppColors.error : AppColors.primary,
        width: 2.5,
      ),
    );
  }

  OutlineInputBorder _buildDisabledBorder() {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(28.r),
      borderSide: BorderSide(
        color: (isDark ? AppColors.borderDark : AppColors.borderLight)
            .withValues(alpha: 0.5),
        width: 1,
      ),
    );
  }

  EdgeInsetsGeometry _getContentPadding() {
    return widget.contentPadding ??
        EdgeInsets.only(
          left: _hasIcon() ? 56.w : 20.w,
          right: 20.w,
          top: 24.h,
          bottom: 12.h,
        );
  }

  Widget _buildAnimatedLabel(bool hasError, Color backgroundColor, bool isDark) {
    return Positioned(
      left: _hasIcon() ? 56.w : 20.w,
      top: 0,
      bottom: 0,
      child: IgnorePointer(
        child: AnimatedBuilder(
          animation: _labelAnimation,
          builder: (context, child) {
            return Transform.translate(
              offset: _labelPositionAnimation.value * 12,
              child: Transform.scale(
                scale: _labelScaleAnimation.value,
                alignment: Alignment.centerLeft,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: _labelColorAnimation != null
                      ? AnimatedBuilder(
                          animation: _labelColorAnimation!,
                          builder: (context, child) {
                            return _buildLabelContainer(
                              hasError, 
                              backgroundColor, 
                              isDark,
                            );
                          },
                        )
                      : _buildLabelContainer(
                          hasError, 
                          backgroundColor, 
                          isDark,
                        ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildLabelContainer(bool hasError, Color backgroundColor, bool isDark) {
    final isLabelUp = _labelAnimation.value > 0.5;
    
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isLabelUp ? _LabelAnimationConfig.horizontalPadding.w : 0,
        vertical: isLabelUp ? _LabelAnimationConfig.verticalPadding.h : 0,
      ),
      decoration: BoxDecoration(
        color: isLabelUp ? backgroundColor.withValues(alpha: 0.95) : Colors.transparent,
        borderRadius: BorderRadius.circular(6.r),
        border: isLabelUp ? _buildLabelBorder(hasError, isDark) : null,
        boxShadow: isLabelUp ? _buildLabelShadow(isDark) : null,
      ),
      child: Text(
        widget.label,
        style: _getLabelStyle(),
      ),
    );
  }

  Border? _buildLabelBorder(bool hasError, bool isDark) {
    return Border.all(
      color: hasError
          ? AppColors.error.withValues(alpha: 0.3)
          : (_isFocused
              ? AppColors.primary.withValues(alpha: 0.3)
              : (isDark ? AppColors.borderDark : AppColors.borderLight)
                  .withValues(alpha: 0.2)),
      width: 1,
    );
  }

  List<BoxShadow>? _buildLabelShadow(bool isDark) {
    return [
      BoxShadow(
        color: (isDark ? AppColors.grey800 : AppColors.grey100)
            .withValues(alpha: 0.1),
        blurRadius: 4,
        offset: const Offset(0, 2),
      ),
    ];
  }

  TextStyle _getLabelStyle() {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    return (widget.labelStyle ?? AppTypography.caption).copyWith(
      fontWeight: FontWeight.w600,
      color: _labelColorAnimation?.value ?? _getDefaultLabelColor(isDark),
      letterSpacing: 0.2,
    );
  }

  // Icon and suffix methods
  Widget? _buildPrefixIcon(bool hasError) {
    if (!_hasIcon()) return null;

    final iconData = widget.icon ?? _getDefaultIcon();
    if (iconData == null) return null;

    return Padding(
      padding: EdgeInsets.all(12.w),
      child: Icon(
        iconData,
        color: _getIconColor(hasError),
        size: 22,
      ),
    );
  }

  Widget? _buildSuffixIcon(bool hasError) {
    if (widget.suffixIcon != null) {
      return widget.suffixIcon;
    }

    if (widget.type == AppTextFieldType.password && widget.showPasswordToggle) {
      return _buildPasswordToggle();
    }

    return null;
  }

  Widget _buildPasswordToggle() {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    return GestureDetector(
      onTap: _togglePasswordVisibility,
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: Icon(
          _obscurePassword ? AppIcons.passwordVisible : AppIcons.passwordHidden,
          color: (isDark ? AppColors.textSecondaryOnDark : AppColors.textSecondary)
              .withValues(alpha: 0.7),
          size: 20,
        ),
      ),
    );
  }

  // Helper methods
  bool _hasIcon() {
    return widget.icon != null || _getDefaultIcon() != null;
  }

  IconData? _getDefaultIcon() {
    switch (widget.type) {
      case AppTextFieldType.email:
        return AppIcons.email;
      case AppTextFieldType.password:
        return AppIcons.password;
      case AppTextFieldType.phone:
        return AppIcons.phone;
      case AppTextFieldType.number:
        return AppIcons.add;
      case AppTextFieldType.search:
        return AppIcons.search;
      case AppTextFieldType.url:
        return AppIcons.link;
      default:
        return null;
    }
  }

  Color _getIconColor(bool hasError) {
    if (widget.iconColor != null) return widget.iconColor!;
    
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    return hasError
        ? AppColors.error
        : (_isFocused
            ? AppColors.primary
            : (isDark ? AppColors.textSecondaryOnDark : AppColors.textSecondary));
  }

  Color _getBackgroundColor(bool isDark) {
    return widget.backgroundColor ?? 
           (isDark ? AppColors.surfaceDark : AppColors.surface);
  }

  Color _getTextColor(bool isDark) {
    return isDark ? AppColors.textOnDark : AppColors.textPrimary;
  }

  bool _shouldObscureText() {
    return widget.type == AppTextFieldType.password && _obscurePassword;
  }

  TextInputType _getKeyboardType() {
    switch (widget.type) {
      case AppTextFieldType.email:
        return TextInputType.emailAddress;
      case AppTextFieldType.password:
        return TextInputType.visiblePassword;
      case AppTextFieldType.number:
        return TextInputType.number;
      case AppTextFieldType.phone:
        return TextInputType.phone;
      case AppTextFieldType.multiline:
        return TextInputType.multiline;
      case AppTextFieldType.url:
        return TextInputType.url;
      default:
        return TextInputType.text;
    }
  }

  TextInputAction _getTextInputAction() {
    switch (widget.type) {
      case AppTextFieldType.multiline:
        return TextInputAction.newline;
      case AppTextFieldType.search:
        return TextInputAction.search;
      default:
        return TextInputAction.next;
    }
  }

  int _getMaxLines() {
    switch (widget.type) {
      case AppTextFieldType.multiline:
        return 4;
      default:
        return 1;
    }
  }
}
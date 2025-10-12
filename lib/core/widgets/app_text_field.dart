import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pocketly/core/constants/app_constants.dart';

/// Types de champs de texte disponibles
enum AppTextFieldType { text, email, password, number, phone, multiline }

/// Widget champ de texte modulaire et réutilisable pour toute l'application.
///
/// Ce widget offre différents types, validations et états pour s'adapter
/// à tous les besoins de l'interface utilisateur.
class AppTextField extends ConsumerStatefulWidget {
  final TextEditingController controller;
  final String label;
  final String? hint;
  final AppTextFieldType type;
  final IconData? icon;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final bool enabled;
  final bool readOnly;
  final int? maxLines;
  final int? maxLength;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final bool showPasswordToggle;
  final Widget? suffixIcon;
  final EdgeInsetsGeometry? contentPadding;
  final bool showValidationErrors;

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
  });

  @override
  ConsumerState<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends ConsumerState<AppTextField>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _errorController;
  late Animation<double> _labelAnimation;
  late Animation<Color?> _labelColorAnimation;
  late Animation<double> _labelScaleAnimation;
  late Animation<Offset> _labelPositionAnimation;
  late Animation<double> _errorAnimation;

  bool _isFocused = false;
  bool _hasText = false;
  bool _obscurePassword = true;
  bool _hasBeenTouched = false;
  late FocusNode _focusNode;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _hasText = widget.controller.text.isNotEmpty;

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _errorController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _labelAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    _labelScaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.75,
    ).animate(_labelAnimation);

    _labelPositionAnimation = Tween<Offset>(
      begin: const Offset(0, 0),
      end: const Offset(0, -2.0),
    ).animate(_labelAnimation);

    _errorAnimation = CurvedAnimation(
      parent: _errorController,
      curve: Curves.easeOutBack,
    );

    _focusNode.addListener(_onFocusChange);
    widget.controller.addListener(_onTextChange);

    if (_hasText) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _animationController.forward();
      });
    }
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
    if (oldWidget.showValidationErrors != widget.showValidationErrors) {
      _updateLabelColorAnimation();
      _updateErrorAnimation();
    }
  }

  void _updateLabelColorAnimation() {
    if (!mounted) return;
    
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final hasError = widget.showValidationErrors &&
        widget.validator != null &&
        widget.validator!(widget.controller.text) != null;

    final shouldShowActiveColor = _hasText || (_isFocused && _hasBeenTouched);

    _labelColorAnimation = ColorTween(
      begin: colorScheme.onSurfaceVariant,
      end: hasError
          ? colorScheme.error
          : (shouldShowActiveColor
                ? colorScheme.primary
                : colorScheme.onSurfaceVariant),
    ).animate(_labelAnimation);
  }

  void _onFocusChange() {
    if (_isFocused != _focusNode.hasFocus) {
      setState(() {
        _isFocused = _focusNode.hasFocus;
        if (_focusNode.hasFocus) {
          _hasBeenTouched = true;
        }
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

    if (widget.onChanged != null) {
      try {
        widget.onChanged!(widget.controller.text);
      } catch (e) {
        // Ignorer les erreurs dans le callback
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

  void _updateErrorAnimation() {
    final hasError = widget.showValidationErrors &&
        widget.validator != null &&
        widget.validator!(widget.controller.text) != null;

    if (hasError) {
      _errorController.forward();
    } else {
      _errorController.reverse();
    }
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    widget.controller.removeListener(_onTextChange);
    
    _animationController.dispose();
    _errorController.dispose();
    
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final colorScheme = theme.colorScheme;
    
    final hasError = widget.showValidationErrors &&
        widget.validator != null &&
        widget.validator!(widget.controller.text) != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: isDark ? 0.1 : 0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Stack(
            children: [
              Material(
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
                  style: AppTypography.body.copyWith(
                    color: colorScheme.onSurface,
                  ),
                  onChanged: (value) {
                    if (widget.onChanged != null) {
                      try {
                        widget.onChanged!(value);
                      } catch (e) {
                        // Ignorer les erreurs
                      }
                    }
                  },
                  onSubmitted: widget.onSubmitted,
                  onTap: () {
                    if (!_focusNode.hasFocus) {
                      _focusNode.requestFocus();
                    }
                  },
                  decoration: InputDecoration(
                    prefixIcon: _buildPrefixIcon(hasError),
                    suffixIcon: _buildSuffixIcon(hasError),
                    filled: true,
                    fillColor: colorScheme.surface,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(28.r),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(28.r),
                      borderSide: BorderSide(
                        color: hasError
                            ? colorScheme.error.withValues(alpha: 0.5)
                            : colorScheme.outline,
                        width: 1,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(28.r),
                      borderSide: BorderSide(
                        color: hasError ? colorScheme.error : colorScheme.primary,
                        width: 2,
                      ),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(28.r),
                      borderSide: BorderSide(
                        color: colorScheme.outline.withValues(alpha: 0.5),
                        width: 1,
                      ),
                    ),
                    contentPadding: widget.contentPadding ??
                        EdgeInsets.only(
                          left: _hasIcon() ? 56.w : 20.w,
                          right: 20.w,
                          top: 24.h,
                          bottom: 12.h,
                        ),
                  ),
                ),
              ),

              // Label animé
              if (_isInitialized)
                Positioned(
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
                              child: AnimatedBuilder(
                                animation: _labelColorAnimation,
                                builder: (context, child) {
                                  return Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: _labelAnimation.value > 0.5 ? 8.w : 0,
                                      vertical: _labelAnimation.value > 0.5 ? 2.h : 0,
                                    ),
                                    decoration: BoxDecoration(
                                      color: _labelAnimation.value > 0.5
                                          ? colorScheme.surface.withValues(alpha: 0.95)
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.circular(6.r),
                                      border: _labelAnimation.value > 0.5
                                          ? Border.all(
                                              color: hasError
                                                  ? colorScheme.error.withValues(alpha: 0.3)
                                                  : (_isFocused
                                                      ? colorScheme.primary.withValues(alpha: 0.3)
                                                      : colorScheme.outline.withValues(alpha: 0.2)),
                                              width: 1,
                                            )
                                          : null,
                                      boxShadow: _labelAnimation.value > 0.5
                                          ? [
                                              BoxShadow(
                                                color: colorScheme.shadow.withValues(alpha: 0.05),
                                                blurRadius: 4,
                                                offset: const Offset(0, 2),
                                              ),
                                            ]
                                          : null,
                                    ),
                                    child: Text(
                                      widget.label,
                                      style: AppTypography.caption.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: _labelColorAnimation.value,
                                        letterSpacing: 0.2,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
            ],
          ),
        ),

        // Message d'erreur animé
        if (hasError) ...[
          SizedBox(height: 8.h),
          SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, -0.5),
              end: Offset.zero,
            ).animate(_errorAnimation),
            child: FadeTransition(
              opacity: _errorAnimation,
              child: Row(
                children: [
                  Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 16,
                  ),
                  SizedBox(width: 6.w),
                  Expanded(
                    child: Text(
                      widget.validator!(widget.controller.text)!,
                      style: AppTypography.caption.copyWith(
                        color: Colors.red,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }

  /// Construit l'icône de préfixe
  Widget? _buildPrefixIcon(bool hasError) {
    if (!_hasIcon()) return null;

    final iconData = widget.icon ?? _getDefaultIcon();
    if (iconData == null) return null;

    final colorScheme = Theme.of(context).colorScheme;
    
    return Padding(
      padding: EdgeInsets.all(12.w),
      child: Icon(
        iconData,
        color: hasError
            ? colorScheme.error
            : (_isFocused
                  ? colorScheme.primary
                  : colorScheme.onSurfaceVariant),
        size: 22,
      ),
    );
  }

  /// Construit l'icône de suffixe
  Widget? _buildSuffixIcon(bool hasError) {
    if (widget.suffixIcon != null) {
      return widget.suffixIcon;
    }

    if (widget.type == AppTextFieldType.password && widget.showPasswordToggle) {
      final colorScheme = Theme.of(context).colorScheme;
      
      return GestureDetector(
        onTap: _togglePasswordVisibility,
        child: Padding(
          padding: EdgeInsets.all(12.w),
          child: Icon(
            _obscurePassword ? Icons.visibility : Icons.visibility_off,
            color: colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
            size: 20,
          ),
        ),
      );
    }

    return null;
  }

  /// Vérifie si le champ a une icône
  bool _hasIcon() {
    return widget.icon != null || _getDefaultIcon() != null;
  }

  /// Obtient l'icône par défaut selon le type
  IconData? _getDefaultIcon() {
    switch (widget.type) {
      case AppTextFieldType.email:
        return Icons.email_outlined;
      case AppTextFieldType.password:
        return Icons.lock_outline;
      case AppTextFieldType.phone:
        return Icons.phone_outlined;
      case AppTextFieldType.number:
        return Icons.calculate_outlined;
      default:
        return null;
    }
  }

  /// Détermine si le texte doit être masqué
  bool _shouldObscureText() {
    return widget.type == AppTextFieldType.password && _obscurePassword;
  }

  /// Obtient le type de clavier selon le type de champ
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
      default:
        return TextInputType.text;
    }
  }

  /// Obtient l'action du clavier selon le type
  TextInputAction _getTextInputAction() {
    switch (widget.type) {
      case AppTextFieldType.multiline:
        return TextInputAction.newline;
      default:
        return TextInputAction.next;
    }
  }

  /// Obtient le nombre maximum de lignes
  int _getMaxLines() {
    switch (widget.type) {
      case AppTextFieldType.multiline:
        return 4;
      default:
        return 1;
    }
  }
}

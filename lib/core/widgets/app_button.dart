import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io' show Platform;
import 'package:pocketly/core/constants/app_constants.dart';

/// Styles de bouton disponibles
enum AppButtonStyle {
  primary,
  secondary,
  outline,
  text,
  success,
  error,
}

/// Tailles de bouton disponibles
enum AppButtonSize {
  small,
  medium,
  large,
}

/// Position de l'icône par rapport au texte
enum IconPosition {
  left,
  right,
}

/// Bouton adaptatif pour iOS et Android.
/// 
/// S'adapte automatiquement à la plateforme.
class AppButton extends StatefulWidget {
  /// Texte du bouton
  final String text;
  
  /// Callback appelé lors du tap
  final VoidCallback? onPressed;
  
  /// Style du bouton
  final AppButtonStyle style;
  
  /// Taille du bouton
  final AppButtonSize size;
  
  /// Icône optionnelle
  final IconData? icon;
  
  /// Position de l'icône par rapport au texte
  final IconPosition iconPosition;
  
  /// Indique si le bouton est en cours de chargement
  final bool isLoading;
  
  /// Largeur du bouton (null = largeur automatique)
  final double? width;
  
  /// Hauteur du bouton (null = hauteur automatique selon la taille)
  final double? height;
  
  /// Indique si le bouton est plein largeur
  final bool isFullWidth;
  
  /// Indique si le bouton est désactivé
  final bool isDisabled;
  
  /// Couleur personnalisée du bouton
  final Color? customColor;
  
  /// Couleur personnalisée du texte
  final Color? customTextColor;
  
  /// Border radius personnalisé
  final double? customBorderRadius;
  
  /// Padding personnalisé
  final EdgeInsetsGeometry? customPadding;
  
  /// Widget personnalisé à afficher au lieu du contenu par défaut
  final Widget? customChild;
  
  /// Tooltip du bouton
  final String? tooltip;
  
  /// Animation de press
  final bool enablePressAnimation;
  
  /// Durée de l'animation de press
  final Duration pressAnimationDuration;

  const AppButton({
    super.key,
    required this.text,
    this.onPressed,
    this.style = AppButtonStyle.primary,
    this.size = AppButtonSize.medium,
    this.icon,
    this.iconPosition = IconPosition.left,
    this.isLoading = false,
    this.width,
    this.height,
    this.isFullWidth = false,
    this.isDisabled = false,
    this.customColor,
    this.customTextColor,
    this.customBorderRadius,
    this.customPadding,
    this.customChild,
    this.tooltip,
    this.enablePressAnimation = true,
    this.pressAnimationDuration = const Duration(milliseconds: 100),
  });

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: widget.pressAnimationDuration,
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Adaptation plateforme selon les cursor rules
    return Platform.isIOS 
      ? _buildIOS(context)
      : _buildAndroid(context);
  }

  /// Construction du bouton pour iOS avec Cupertino
  Widget _buildIOS(BuildContext context) {
    final bool isEnabled = widget.onPressed != null && !widget.isLoading && !widget.isDisabled;
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color backgroundColor = _getBackgroundColor(isDark);
    final Color textColor = _getTextColor();
    final BorderRadius borderRadius = BorderRadius.circular(widget.customBorderRadius ?? _getBorderRadius());
    final EdgeInsetsGeometry padding = _getPadding();

    // Utilisation du même design que Android pour une apparence uniforme
    return GestureDetector(
      onTapDown: isEnabled ? _onTapDown : null,
      onTapUp: isEnabled ? _onTapUp : null,
      onTapCancel: isEnabled ? _onTapCancel : null,
      onTap: isEnabled ? widget.onPressed : null,
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              width: _getButtonWidth(),
              height: _getButtonHeight(),
              decoration: _getButtonDecoration(isDark, backgroundColor),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: isEnabled ? widget.onPressed : null,
                  borderRadius: borderRadius,
                  child: Container(
                    padding: padding,
                    child: _buildButtonContent(textColor),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  /// Construction du bouton pour Android avec Material
  Widget _buildAndroid(BuildContext context) {
    final bool isEnabled = widget.onPressed != null && !widget.isLoading && !widget.isDisabled;
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color backgroundColor = _getBackgroundColor(isDark);
    final Color textColor = _getTextColor();

    Widget button = widget.isLoading
      ? _buildLoadingButton(context, backgroundColor, textColor)
      : _buildNormalButton(context, isEnabled, backgroundColor, textColor, isDark);

    // Ajout de l'accessibilité
    Widget accessibleButton = Semantics(
      label: widget.tooltip ?? widget.text,
      button: true,
      enabled: isEnabled,
      child: button,
    );

    if (widget.tooltip != null) {
      return Tooltip(
        message: widget.tooltip!,
        child: accessibleButton,
      );
    }

    return accessibleButton;
  }

  /// Construction du bouton normal pour Android
  Widget _buildNormalButton(BuildContext context, bool isEnabled, Color backgroundColor, Color textColor, bool isDark) {
    return GestureDetector(
      onTapDown: isEnabled ? _onTapDown : null,
      onTapUp: isEnabled ? _onTapUp : null,
      onTapCancel: isEnabled ? _onTapCancel : null,
      onTap: isEnabled ? widget.onPressed : null,
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              width: _getButtonWidth(),
              height: _getButtonHeight(),
              decoration: _getButtonDecoration(isDark, backgroundColor),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: isEnabled ? widget.onPressed : null,
                  borderRadius: BorderRadius.circular(widget.customBorderRadius ?? _getBorderRadius()),
                  child: Container(
                    padding: _getPadding(),
                    child: _buildButtonContent(textColor),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  /// Construction du bouton de chargement pour Android
  Widget _buildLoadingButton(BuildContext context, Color backgroundColor, Color textColor) {
    return Container(
      width: _getButtonWidth(),
      height: _getButtonHeight(),
      decoration: _getButtonDecoration(Theme.of(context).brightness == Brightness.dark, backgroundColor),
      child: Container(
        padding: _getPadding(),
        child: _buildLoadingContent(textColor),
      ),
    );
  }

  /// Construit le contenu du bouton
  Widget _buildButtonContent([Color? textColor]) {
    if (widget.isLoading) {
      return _buildLoadingContent(textColor);
    }

    final Color iconColor = textColor ?? _getTextColor();

    // Contenu texte
    final textWidget = Flexible(
      child: Text(
        widget.text,
        style: _getTextStyle().copyWith(color: iconColor),
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        textAlign: TextAlign.center,
      ),
    );

    // Si le bouton n'a pas d'icône → texte centré
    if (widget.icon == null) {
      return Center(child: textWidget);
    }

    // Si icône à gauche ou droite → on centre l'ensemble (icône + texte)
    final iconWidget = Icon(
      widget.icon,
      size: _getIconSize(),
      color: iconColor,
    );

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: widget.iconPosition == IconPosition.left
          ? [
              iconWidget,
              SizedBox(width: _getIconSpacing()),
              textWidget,
            ]
          : [
              textWidget,
              SizedBox(width: _getIconSpacing()),
              iconWidget,
            ],
    );
  }

  /// Construit le contenu de chargement
  Widget _buildLoadingContent([Color? textColor]) {
    return Center(
      child: SizedBox(
        width: _getIconSize(),
        height: _getIconSize(),
        child: CircularProgressIndicator(
          strokeWidth: 2.0,
          valueColor: AlwaysStoppedAnimation<Color>(textColor ?? _getTextColor()),
        ),
      ),
    );
  }


  /// Obtient la largeur du bouton
  double? _getButtonWidth() {
    if (widget.width != null) return widget.width;
    if (widget.isFullWidth) return double.infinity;
    return null;
  }

  /// Obtient la hauteur du bouton selon la taille
  double _getButtonHeight() {
    if (widget.height != null) return widget.height!;
    
    switch (widget.size) {
      case AppButtonSize.small:
        return AppDimensions.buttonHeight * 0.75;
      case AppButtonSize.medium:
        return AppDimensions.buttonHeight;
      case AppButtonSize.large:
        return AppDimensions.buttonHeight * 1.25;
    }
  }

  /// Obtient la taille de l'icône selon la taille du bouton
  double _getIconSize() {
    switch (widget.size) {
      case AppButtonSize.small:
        return AppDimensions.iconS;
      case AppButtonSize.medium:
        return AppDimensions.iconM;
      case AppButtonSize.large:
        return AppDimensions.iconM;
    }
  }

  /// Obtient l'espacement entre l'icône et le texte
  double _getIconSpacing() {
    switch (widget.size) {
      case AppButtonSize.small:
        return AppDimensions.paddingXS;
      case AppButtonSize.medium:
        return AppDimensions.paddingS;
      case AppButtonSize.large:
        return AppDimensions.paddingS;
    }
  }

  /// Obtient le style du texte selon la taille
  TextStyle _getTextStyle() {
    TextStyle baseStyle;
    
    switch (widget.size) {
      case AppButtonSize.small:
        baseStyle = AppTypography.caption;
        break;
      case AppButtonSize.medium:
        baseStyle = AppTypography.button;
        break;
      case AppButtonSize.large:
        baseStyle = AppTypography.button.copyWith(fontSize: 16);
        break;
    }
    
    return baseStyle.copyWith(
      fontWeight: FontWeight.w600,
    );
  }

  /// Obtient la couleur du texte selon le style
  Color _getTextColor() {
    if (widget.customTextColor != null) return widget.customTextColor!;
    
    switch (widget.style) {
      case AppButtonStyle.primary:
      case AppButtonStyle.success:
      case AppButtonStyle.error:
        return Colors.white;
      case AppButtonStyle.secondary:
      case AppButtonStyle.outline:
      case AppButtonStyle.text:
        return AppColors.primary;
    }
  }

  /// Obtient la couleur de fond selon le style
  Color _getBackgroundColor(bool isDark) {
    if (widget.customColor != null) return widget.customColor!;
    
    switch (widget.style) {
      case AppButtonStyle.primary:
        return AppColors.primary;
      case AppButtonStyle.secondary:
        return isDark 
          ? AppColors.primary.withValues(alpha: 0.2)
          : AppColors.primary.withValues(alpha: 0.1);
      case AppButtonStyle.outline:
      case AppButtonStyle.text:
        return Colors.transparent;
      case AppButtonStyle.success:
        return AppColors.success;
      case AppButtonStyle.error:
        return AppColors.error;
    }
  }

  /// Obtient le border radius selon la taille
  double _getBorderRadius() {
    switch (widget.size) {
      case AppButtonSize.small:
        return AppDimensions.radiusS;
      case AppButtonSize.medium:
        return AppDimensions.radiusM;
      case AppButtonSize.large:
        return AppDimensions.radiusL;
    }
  }

  /// Obtient le padding selon la taille
  EdgeInsetsGeometry _getPadding() {
    if (widget.customPadding != null) return widget.customPadding!;
    
    switch (widget.size) {
      case AppButtonSize.small:
        return EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingM,
          vertical: AppDimensions.paddingS,
        );
      case AppButtonSize.medium:
        return EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingL,
          vertical: AppDimensions.paddingM,
        );
      case AppButtonSize.large:
        return EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingXL,
          vertical: AppDimensions.paddingL,
        );
    }
  }

  /// Obtient la bordure selon le style
  Border? _getBorder() {
    switch (widget.style) {
      case AppButtonStyle.outline:
        return Border.all(
          color: AppColors.primary,
          width: 1.0,
        );
      case AppButtonStyle.primary:
      case AppButtonStyle.secondary:
      case AppButtonStyle.text:
      case AppButtonStyle.success:
      case AppButtonStyle.error:
        return null;
    }
  }

  /// Obtient l'ombre selon le style
  List<BoxShadow>? _getBoxShadow() {
    switch (widget.style) {
      case AppButtonStyle.primary:
      case AppButtonStyle.success:
      case AppButtonStyle.error:
        return [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.3),
            blurRadius: 4.0,
            offset: Offset(0, 2),
          ),
        ];
      case AppButtonStyle.secondary:
      case AppButtonStyle.outline:
      case AppButtonStyle.text:
        return null;
    }
  }

  /// Obtient la décoration du bouton
  BoxDecoration _getButtonDecoration(bool isDark, [Color? backgroundColor]) {
    return BoxDecoration(
      color: backgroundColor ?? _getBackgroundColor(isDark),
      borderRadius: BorderRadius.circular(widget.customBorderRadius ?? _getBorderRadius()),
      border: _getBorder(),
      boxShadow: _getBoxShadow(),
    );
  }

  void _onTapDown(TapDownDetails details) {
    // Haptic feedback pour iOS
    if (Platform.isIOS) {
      HapticFeedback.lightImpact();
    }
    
    if (widget.enablePressAnimation) {
      _animationController.forward();
    }
  }

  void _onTapUp(TapUpDetails details) {
    if (widget.enablePressAnimation) {
      _animationController.reverse();
    }
  }

  void _onTapCancel() {
    if (widget.enablePressAnimation) {
      _animationController.reverse();
    }
  }
}

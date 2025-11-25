import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io' show Platform;
import 'package:pocketly/core/constants/app_colors.dart';
import 'package:pocketly/core/constants/app_dimensions.dart';
import 'package:pocketly/core/constants/app_typography.dart';

/// Styles de bouton disponibles
enum AppButtonStyle {
  primary,
  secondary,
  outline,
  text,
  success,
  error,
  gradient,
}

/// Tailles de bouton disponibles
enum AppButtonSize { small, medium, large }

/// Position de l'icône par rapport au texte
enum IconPosition { left, right }

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

class _AppButtonState extends State<AppButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: widget.pressAnimationDuration,
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Adaptation plateforme selon les cursor rules
    return Platform.isIOS ? _buildIOS(context) : _buildAndroid(context);
  }

  /// Construction du bouton pour iOS avec Cupertino
  Widget _buildIOS(BuildContext context) {
    final bool isEnabled =
        widget.onPressed != null && !widget.isLoading && !widget.isDisabled;
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color textColor = _getTextColor();
    final BorderRadius borderRadius = BorderRadius.circular(
      widget.customBorderRadius ?? _getBorderRadius(),
    );

    return Semantics(
      label: widget.tooltip ?? widget.text,
      button: true,
      enabled: isEnabled,
      child: GestureDetector(
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
                key: widget.key,
                width: _getButtonWidth(),
                height: _getButtonHeight(),
                decoration: _getButtonDecoration(isDark),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: isEnabled ? widget.onPressed : null,
                    borderRadius: borderRadius,
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
      ),
    );
  }

  /// Construction du bouton pour Android avec Material
  Widget _buildAndroid(BuildContext context) {
    final bool isEnabled =
        widget.onPressed != null && !widget.isLoading && !widget.isDisabled;
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color textColor = _getTextColor();

    Widget button = widget.isLoading
        ? _buildLoadingButton(context, textColor)
        : _buildNormalButton(context, isEnabled, textColor, isDark);

    // Ajout de l'accessibilité
    Widget accessibleButton = Semantics(
      label: widget.tooltip ?? widget.text,
      button: true,
      enabled: isEnabled,
      child: button,
    );

    if (widget.tooltip != null) {
      return Tooltip(message: widget.tooltip!, child: accessibleButton);
    }

    return accessibleButton;
  }

  /// Construction du bouton normal pour Android
  Widget _buildNormalButton(
    BuildContext context,
    bool isEnabled,
    Color textColor,
    bool isDark,
  ) {
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
              key: widget.key,
              width: _getButtonWidth(),
              height: _getButtonHeight(),
              decoration: _getButtonDecoration(isDark),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: isEnabled ? widget.onPressed : null,
                  borderRadius: BorderRadius.circular(
                    widget.customBorderRadius ?? _getBorderRadius(),
                  ),
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
  Widget _buildLoadingButton(BuildContext context, Color textColor) {
    return Container(
      key: widget.key,
      width: _getButtonWidth(),
      height: _getButtonHeight(),
      decoration: _getButtonDecoration(
        Theme.of(context).brightness == Brightness.dark,
      ),
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
    final textWidget = Text(
      widget.text,
      style: _getTextStyle().copyWith(color: iconColor),
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
      textAlign: TextAlign.center,
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
              Flexible(child: textWidget),
            ]
          : [
              Flexible(child: textWidget),
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
          strokeWidth: 2.5,
          valueColor: AlwaysStoppedAnimation<Color>(
            textColor ?? _getTextColor(),
          ),
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
        return AppDimensions.buttonHeight;
      case AppButtonSize.medium:
        return AppDimensions.buttonHeight;
      case AppButtonSize.large:
        return AppDimensions.buttonHeightLarge;
    }
  }

  /// Obtient la taille de l'icône selon la taille du bouton
  double _getIconSize() {
    switch (widget.size) {
      case AppButtonSize.small:
        return 16;
      case AppButtonSize.medium:
        return 18;
      case AppButtonSize.large:
        return 20;
    }
  }

  /// Obtient l'espacement entre l'icône et le texte
  double _getIconSpacing() {
    switch (widget.size) {
      case AppButtonSize.small:
        return 4;
      case AppButtonSize.medium:
        return 6;
      case AppButtonSize.large:
        return 8;
    }
  }

  /// Obtient le style du texte selon la taille
  TextStyle _getTextStyle() {
    switch (widget.size) {
      case AppButtonSize.small:
        return AppTypography.caption.copyWith(fontWeight: FontWeight.w600);
      case AppButtonSize.medium:
        return AppTypography.button.copyWith(fontWeight: FontWeight.w600);
      case AppButtonSize.large:
        return AppTypography.button.copyWith(fontWeight: FontWeight.w600);
    }
  }

  /// Obtient la couleur du texte selon le style
  Color _getTextColor() {
    if (widget.customTextColor != null) return widget.customTextColor!;

    switch (widget.style) {
      case AppButtonStyle.primary:
      case AppButtonStyle.gradient:
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
      case AppButtonStyle.gradient:
        return AppColors.primary; // Fallback pour le gradient
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
        return 12;
      case AppButtonSize.medium:
        return 16;
      case AppButtonSize.large:
        return 28;
    }
  }

  /// Obtient le padding selon la taille
  EdgeInsetsGeometry _getPadding() {
    if (widget.customPadding != null) return widget.customPadding!;

    switch (widget.size) {
      case AppButtonSize.small:
        return const EdgeInsets.symmetric(horizontal: 16, vertical: 8);
      case AppButtonSize.medium:
        return const EdgeInsets.symmetric(horizontal: 20, vertical: 12);
      case AppButtonSize.large:
        return const EdgeInsets.symmetric(horizontal: 24, vertical: 16);
    }
  }

  /// Obtient la bordure selon le style
  Border? _getBorder() {
    switch (widget.style) {
      case AppButtonStyle.outline:
        return Border.all(color: AppColors.primary, width: 1.0);
      case AppButtonStyle.primary:
      case AppButtonStyle.gradient:
      case AppButtonStyle.secondary:
      case AppButtonStyle.text:
      case AppButtonStyle.success:
      case AppButtonStyle.error:
        return null;
    }
  }

  /// Obtient la décoration du bouton
  BoxDecoration _getButtonDecoration(bool isDark) {
    if (widget.style == AppButtonStyle.gradient) {
      return BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(
          widget.customBorderRadius ?? _getBorderRadius(),
        ),
      );
    }

    return BoxDecoration(
      color: _getBackgroundColor(isDark),
      borderRadius: BorderRadius.circular(
        widget.customBorderRadius ?? _getBorderRadius(),
      ),
      border: _getBorder(),
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

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:pocketly/core/constants/app_colors.dart';
import 'package:pocketly/core/constants/app_dimensions.dart';
import 'package:pocketly/core/constants/app_typography.dart';
import 'package:pocketly/generated/l10n/app_localizations.dart';

/// Service pour les notifications in-app (Flushbar) avec design professionnel
class InAppNotificationService {
  
  // ==================== NOTIFICATION STACKING ====================
  
  static int _notificationCount = 0;
  
  /// Calcule le décalage vertical pour l'empilement
  static EdgeInsets _getStackedMargin(int index) {
    final double baseMargin = AppDimensions.paddingM;
    final double stackOffset = AppDimensions.paddingXS; // Décalage entre chaque notification
    final double topMargin = baseMargin + (index * stackOffset);
    
    return EdgeInsets.fromLTRB(
      AppDimensions.paddingM,
      topMargin,
      AppDimensions.paddingM,
      0.0,
    );
  }
  
  /// Affiche une notification avec empilement
  static void _showStackedNotification(Flushbar notification, BuildContext context) {
    final currentIndex = _notificationCount++;
    final stackedNotification = Flushbar(
      title: notification.title,
      message: notification.message,
      icon: notification.icon,
      backgroundColor: notification.backgroundColor,
      borderColor: notification.borderColor,
      borderWidth: notification.borderWidth,
      borderRadius: notification.borderRadius,
      duration: notification.duration,
      flushbarPosition: notification.flushbarPosition,
      margin: _getStackedMargin(currentIndex),
      padding: notification.padding,
      titleText: notification.titleText,
      messageText: notification.messageText,
      mainButton: notification.mainButton,
    );
    
    // Utiliser addPostFrameCallback pour éviter l'erreur Navigator._debugLocked
    // Cela garantit que la notification est affichée après que le frame soit terminé
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (context.mounted) {
    stackedNotification.show(context);
      }
    });
    
    // Réinitialiser le compteur après un délai pour éviter l'accumulation
    Future.delayed(const Duration(seconds: 10), () {
      if (_notificationCount > 0) {
        _notificationCount = 0;
      }
    });
  }
  
  /// Réinitialise le système d'empilement
  static void resetStacking() {
    _notificationCount = 0;
  }
  
  /// Crée un arrière-plan adaptatif au thème avec AppColors
  static Color _getAdaptiveBackground(ThemeData theme, Color accentColor) {
    final isDark = theme.brightness == Brightness.dark;
    
    if (isDark) {
      // Mode sombre : utilise AppColors.surfaceDark avec une teinte de la couleur d'accent
      return Color.lerp(AppColors.surfaceDark, accentColor, 0.12) ?? AppColors.surfaceDark;
    } else {
      // Mode clair : utilise AppColors.surface avec une teinte subtile
      return Color.lerp(AppColors.surface, accentColor, 0.08) ?? AppColors.surface;
    }
  }
  
  /// Crée une couleur de bordure adaptative avec AppColors
  static Color _getAdaptiveBorderColor(ThemeData theme, Color accentColor) {
    final isDark = theme.brightness == Brightness.dark;
    
    if (isDark) {
      // Mode sombre : bordure avec AppColors.borderDark
      return Color.lerp(AppColors.borderDark, accentColor, 0.4) ?? AppColors.borderDark;
    } else {
      // Mode clair : bordure avec AppColors.borderLight
      return Color.lerp(AppColors.borderLight, accentColor, 0.3) ?? AppColors.borderLight;
    }
  }
  
  /// Crée une couleur d'icône adaptative
  static Color _getAdaptiveIconColor(ThemeData theme, Color accentColor) {
    final isDark = theme.brightness == Brightness.dark;
    
    if (isDark) {
      // Mode sombre : icône plus claire
      return Color.lerp(accentColor, AppColors.textOnDark, 0.15) ?? accentColor;
    } else {
      // Mode clair : icône plus foncée
      return Color.lerp(accentColor, AppColors.textPrimary, 0.1) ?? accentColor;
    }
  }
  
  /// Crée une icône animée avec style moderne
  static Widget _buildAnimatedIcon(IconData icon, {required Color color, required double size}) {
    return Container(
      width: size + 8,
      height: size + 8,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(
      icon,
      color: color,
      size: size,
      ),
    ).animate()
      .scale(duration: 300.ms, curve: Curves.elasticOut)
      .fadeIn(duration: 200.ms);
  }
  
  /// Crée un titre animé avec AppTypography
  static Widget _buildAnimatedTitle(String text, ThemeData theme) {
    final isDark = theme.brightness == Brightness.dark;
    return Text(
      text,
      style: AppTypography.small.copyWith(
        fontWeight: FontWeight.w600,
        color: isDark ? AppColors.textOnDark : AppColors.textPrimary,
      ),
    ).animate()
      .slideX(begin: 0.2, end: 0, duration: 400.ms, curve: Curves.easeOutCubic)
      .fadeIn(duration: 300.ms);
  }
  
  /// Crée un message animé avec AppTypography
  static Widget _buildAnimatedMessage(String text, ThemeData theme) {
    final isDark = theme.brightness == Brightness.dark;
    return Text(
      text,
      style: AppTypography.small.copyWith(
        color: isDark 
            ? AppColors.textSecondaryOnDark 
            : AppColors.textSecondary,
        height: 1.4,
      ),
    ).animate()
      .slideX(begin: 0.2, end: 0, duration: 500.ms, curve: Curves.easeOutCubic)
      .fadeIn(duration: 400.ms);
  }
  
  /// Crée un bouton d'action animé avec style moderne
  static Widget _buildAnimatedButton(String text, VoidCallback onPressed, ThemeData theme) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primary,
        padding: EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingM,
          vertical: AppDimensions.paddingS,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        ),
        backgroundColor: AppColors.primary.withValues(alpha: 0.1),
      ),
      child: Text(
        text,
        style: AppTypography.small.copyWith(
          fontWeight: FontWeight.w600,
          color: AppColors.primary,
        ),
      ),
    ).animate()
      .scale(duration: 200.ms, curve: Curves.easeOut)
      .fadeIn(duration: 300.ms);
  }
  /// Afficher une notification de succès avec design moderne
  static void showSuccess(
    BuildContext context, {
    String? title,
    String? message,
    Duration? duration,
  }) {
    final theme = Theme.of(context);
    final s = AppLocalizations.of(context);
    
    final notification = Flushbar(
      title: title ?? s?.notificationSuccess ?? 'Succès',
      message: message ?? s?.notificationSuccessMessage ?? 'Opération réussie',
      icon: _buildAnimatedIcon(
        Icons.check_circle_rounded,
        color: _getAdaptiveIconColor(theme, AppColors.success),
        size: 24.0,
      ),
      backgroundColor: _getAdaptiveBackground(theme, AppColors.success),
      borderColor: _getAdaptiveBorderColor(theme, AppColors.success),
      borderWidth: 1.0,
      borderRadius: BorderRadius.circular(AppDimensions.radiusL),
      duration: duration ?? const Duration(seconds: 4),
      flushbarPosition: FlushbarPosition.TOP,
      margin: _getStackedMargin(0),
      padding: EdgeInsets.all(AppDimensions.paddingM),
      boxShadows: [
        BoxShadow(
          color: AppColors.success.withValues(alpha: 0.2),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
      titleText: _buildAnimatedTitle(
        title ?? s?.notificationSuccess ?? 'Succès',
        theme,
      ),
      messageText: _buildAnimatedMessage(
        message ?? s?.notificationSuccessMessage ?? 'Opération réussie',
        theme,
      ),
    );
    
    _showStackedNotification(notification, context);
  }

  /// Afficher une notification d'erreur avec design moderne
  static void showError(
    BuildContext context, {
    String? title,
    String? message,
    Duration? duration,
  }) {
    final theme = Theme.of(context);
    final s = AppLocalizations.of(context);
    
    final notification = Flushbar(
      title: title ?? s?.notificationError ?? 'Erreur',
      message: message ?? s?.notificationErrorMessage ?? 'Une erreur est survenue',
      icon: _buildAnimatedIcon(
        Icons.error_rounded,
        color: _getAdaptiveIconColor(theme, AppColors.error),
        size: 24.0,
      ),
      backgroundColor: _getAdaptiveBackground(theme, AppColors.error),
      borderColor: _getAdaptiveBorderColor(theme, AppColors.error),
      borderWidth: 1.0,
      borderRadius: BorderRadius.circular(AppDimensions.radiusL),
      duration: duration ?? const Duration(seconds: 5),
      flushbarPosition: FlushbarPosition.TOP,
      margin: _getStackedMargin(0),
      padding: EdgeInsets.all(AppDimensions.paddingM),
      boxShadows: [
        BoxShadow(
          color: AppColors.error.withValues(alpha: 0.2),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
      titleText: _buildAnimatedTitle(
        title ?? s?.notificationError ?? 'Erreur',
        theme,
      ),
      messageText: _buildAnimatedMessage(
        message ?? s?.notificationErrorMessage ?? 'Une erreur est survenue',
        theme,
      ),
    );
    
    _showStackedNotification(notification, context);
  }

  /// Afficher une notification d'information avec design moderne
  static void showInfo(
    BuildContext context, {
    String? title,
    String? message,
    Duration? duration,
  }) {
    final theme = Theme.of(context);
    final s = AppLocalizations.of(context);
    
    final notification = Flushbar(
      title: title ?? s?.notificationInfo ?? 'Information',
      message: message ?? s?.notificationInfoMessage ?? 'Information importante',
      icon: _buildAnimatedIcon(
        Icons.info_rounded,
        color: _getAdaptiveIconColor(theme, AppColors.info),
        size: 24.0,
      ),
      backgroundColor: _getAdaptiveBackground(theme, AppColors.info),
      borderColor: _getAdaptiveBorderColor(theme, AppColors.info),
      borderWidth: 1.0,
      borderRadius: BorderRadius.circular(AppDimensions.radiusL),
      duration: duration ?? const Duration(seconds: 4),
      flushbarPosition: FlushbarPosition.TOP,
      margin: _getStackedMargin(0),
      padding: EdgeInsets.all(AppDimensions.paddingM),
      boxShadows: [
        BoxShadow(
          color: AppColors.info.withValues(alpha: 0.2),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
      titleText: _buildAnimatedTitle(
        title ?? s?.notificationInfo ?? 'Information',
        theme,
      ),
      messageText: _buildAnimatedMessage(
        message ?? s?.notificationInfoMessage ?? 'Information importante',
        theme,
      ),
    );
    
    _showStackedNotification(notification, context);
  }

  /// Afficher une notification d'avertissement avec design moderne
  static void showWarning(
    BuildContext context, {
    String? title,
    String? message,
    Duration? duration,
  }) {
    final theme = Theme.of(context);
    final s = AppLocalizations.of(context);
    
    final notification = Flushbar(
      title: title ?? s?.notificationWarning ?? 'Avertissement',
      message: message ?? s?.notificationWarningMessage ?? 'Attention requise',
      icon: _buildAnimatedIcon(
        Icons.warning_rounded,
        color: _getAdaptiveIconColor(theme, AppColors.warning),
        size: 24.0,
      ),
      backgroundColor: _getAdaptiveBackground(theme, AppColors.warning),
      borderColor: _getAdaptiveBorderColor(theme, AppColors.warning),
      borderWidth: 1.0,
      borderRadius: BorderRadius.circular(AppDimensions.radiusL),
      duration: duration ?? const Duration(seconds: 4),
      flushbarPosition: FlushbarPosition.TOP,
      margin: _getStackedMargin(0),
      padding: EdgeInsets.all(AppDimensions.paddingM),
      boxShadows: [
        BoxShadow(
          color: AppColors.warning.withValues(alpha: 0.2),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
      titleText: _buildAnimatedTitle(
        title ?? s?.notificationWarning ?? 'Avertissement',
        theme,
      ),
      messageText: _buildAnimatedMessage(
        message ?? s?.notificationWarningMessage ?? 'Attention requise',
        theme,
      ),
    );
    
    _showStackedNotification(notification, context);
  }

  /// Afficher une notification avec action et design moderne
  static Future<T?> showAction<T>(
    BuildContext context, {
    String? title,
    String? message,
    String? buttonText,
    required VoidCallback onButtonPressed,
    Duration? duration,
  }) {
    final theme = Theme.of(context);
    final s = AppLocalizations.of(context);
    
    final notification = Flushbar<T>(
      title: title ?? s?.notificationAction ?? 'Action requise',
      message: message ?? s?.notificationActionMessage ?? 'Une action est nécessaire',
      icon: _buildAnimatedIcon(
        Icons.touch_app_rounded,
        color: _getAdaptiveIconColor(theme, AppColors.primary),
        size: 24.0,
      ),
      backgroundColor: _getAdaptiveBackground(theme, AppColors.primary),
      borderColor: _getAdaptiveBorderColor(theme, AppColors.primary),
      borderWidth: 1.0,
      borderRadius: BorderRadius.circular(AppDimensions.radiusL),
      duration: duration,
      flushbarPosition: FlushbarPosition.TOP,
      margin: _getStackedMargin(0),
      padding: EdgeInsets.all(AppDimensions.paddingM),
      boxShadows: [
        BoxShadow(
          color: AppColors.primary.withValues(alpha: 0.2),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
      titleText: _buildAnimatedTitle(
        title ?? s?.notificationAction ?? 'Action requise',
        theme,
      ),
      messageText: _buildAnimatedMessage(
        message ?? s?.notificationActionMessage ?? 'Une action est nécessaire',
        theme,
      ),
      mainButton: _buildAnimatedButton(
        buttonText ?? s?.notificationActionButton ?? 'Action',
        onButtonPressed,
        theme,
      ),
    );
    
    _showStackedNotification(notification, context);
    return Future.value(null);
  }

  /// Afficher une notification de chargement avec design moderne
  static void showLoading(
    BuildContext context, {
    String? message,
    String? title,
  }) {
    final theme = Theme.of(context);
    final s = AppLocalizations.of(context);
    
    final notification = Flushbar(
      title: title ?? s?.notificationLoading ?? 'Chargement',
      message: message ?? s?.notificationLoadingMessage ?? 'Veuillez patienter...',
      icon: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: 0.1),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: SizedBox(
            width: 20,
            height: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2.5,
              valueColor: AlwaysStoppedAnimation<Color>(
                _getAdaptiveIconColor(theme, AppColors.primary),
              ),
            ),
          ),
        ),
      ).animate()
        .rotate(duration: 1000.ms)
        .then()
        .rotate(duration: 1000.ms),
      backgroundColor: _getAdaptiveBackground(theme, AppColors.primary),
      borderColor: _getAdaptiveBorderColor(theme, AppColors.primary),
      borderWidth: 1.0,
      borderRadius: BorderRadius.circular(AppDimensions.radiusL),
      duration: null, // Indéfinie
      flushbarPosition: FlushbarPosition.TOP,
      margin: _getStackedMargin(0),
      padding: EdgeInsets.all(AppDimensions.paddingM),
      boxShadows: [
        BoxShadow(
          color: AppColors.primary.withValues(alpha: 0.2),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
      titleText: _buildAnimatedTitle(
        title ?? s?.notificationLoading ?? 'Chargement',
        theme,
      ),
      messageText: _buildAnimatedMessage(
        message ?? s?.notificationLoadingMessage ?? 'Veuillez patienter...',
        theme,
      ),
    );
    
    _showStackedNotification(notification, context);
  }
}

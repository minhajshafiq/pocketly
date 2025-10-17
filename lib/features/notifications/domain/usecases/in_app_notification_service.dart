import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:pocketly/generated/l10n/app_localizations.dart';

/// Service pour les notifications in-app (Flushbar) avec design professionnel
class InAppNotificationService {
  
  // ==================== NOTIFICATION STACKING ====================
  
  static int _notificationCount = 0;
  
  /// Calcule le décalage vertical pour l'empilement
  static EdgeInsets _getStackedMargin(int index) {
    const double baseMargin = 16.0;
    const double stackOffset = 8.0; // Décalage entre chaque notification
    final double topMargin = baseMargin + (index * stackOffset);
    
    return EdgeInsets.fromLTRB(16.0, topMargin, 16.0, 0.0);
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
    
    stackedNotification.show(context);
    
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
  
  /// Crée un arrière-plan adaptatif au thème (non transparent)
  static Color _getAdaptiveBackground(ThemeData theme, Color accentColor) {
    final isDark = theme.brightness == Brightness.dark;
    
    if (isDark) {
      // Mode sombre : utilise la surface avec une teinte de la couleur d'accent
      return Color.lerp(theme.colorScheme.surface, accentColor, 0.1) ?? theme.colorScheme.surface;
    } else {
      // Mode clair : utilise la surface avec une teinte plus subtile
      return Color.lerp(theme.colorScheme.surface, accentColor, 0.05) ?? theme.colorScheme.surface;
    }
  }
  
  /// Crée une couleur de bordure adaptative
  static Color _getAdaptiveBorderColor(ThemeData theme, Color accentColor) {
    final isDark = theme.brightness == Brightness.dark;
    
    if (isDark) {
      // Mode sombre : bordure plus visible
      return Color.lerp(theme.colorScheme.outline, accentColor, 0.3) ?? theme.colorScheme.outline;
    } else {
      // Mode clair : bordure plus subtile
      return Color.lerp(theme.colorScheme.outline, accentColor, 0.2) ?? theme.colorScheme.outline;
    }
  }
  
  /// Crée une couleur d'icône adaptative
  static Color _getAdaptiveIconColor(ThemeData theme, Color accentColor) {
    final isDark = theme.brightness == Brightness.dark;
    
    if (isDark) {
      // Mode sombre : icône plus claire
      return Color.lerp(accentColor, Colors.white, 0.2) ?? accentColor;
    } else {
      // Mode clair : icône plus foncée
      return Color.lerp(accentColor, Colors.black, 0.1) ?? accentColor;
    }
  }
  
  /// Crée une icône animée
  static Widget _buildAnimatedIcon(IconData icon, {required Color color, required double size}) {
    return Icon(
      icon,
      color: color,
      size: size,
    ).animate()
      .scale(duration: 300.ms, curve: Curves.elasticOut)
      .fadeIn(duration: 200.ms);
  }
  
  /// Crée un titre animé
  static Widget _buildAnimatedTitle(String text, ThemeData theme) {
    return Text(
      text,
      style: theme.textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.w600,
        color: theme.colorScheme.onSurface,
      ),
    ).animate()
      .slideX(begin: 0.2, end: 0, duration: 400.ms, curve: Curves.easeOut)
      .fadeIn(duration: 300.ms);
  }
  
  /// Crée un message animé
  static Widget _buildAnimatedMessage(String text, ThemeData theme) {
    return Text(
      text,
      style: theme.textTheme.bodyMedium?.copyWith(
        color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
        height: 1.4,
      ),
    ).animate()
      .slideX(begin: 0.2, end: 0, duration: 500.ms, curve: Curves.easeOut)
      .fadeIn(duration: 400.ms);
  }
  
  /// Crée un bouton d'action animé
  static Widget _buildAnimatedButton(String text, VoidCallback onPressed, ThemeData theme) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: theme.colorScheme.primary,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
    ).animate()
      .scale(duration: 200.ms, curve: Curves.easeOut)
      .fadeIn(duration: 300.ms);
  }
  /// Afficher une notification de succès avec design professionnel
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
        color: _getAdaptiveIconColor(theme, Colors.green),
        size: 32.0,
      ),
      backgroundColor: _getAdaptiveBackground(theme, Colors.green),
      borderColor: _getAdaptiveBorderColor(theme, Colors.green),
      borderWidth: 1.5,
      borderRadius: BorderRadius.circular(20.0),
      duration: duration ?? const Duration(seconds: 4),
      flushbarPosition: FlushbarPosition.TOP,
      margin: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
      padding: const EdgeInsets.all(24.0),
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

  /// Afficher une notification d'erreur avec design professionnel
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
        color: _getAdaptiveIconColor(theme, Colors.red),
        size: 32.0,
      ),
      backgroundColor: _getAdaptiveBackground(theme, Colors.red),
      borderColor: _getAdaptiveBorderColor(theme, Colors.red),
      borderWidth: 1.5,
      borderRadius: BorderRadius.circular(20.0),
      duration: duration ?? const Duration(seconds: 5),
      flushbarPosition: FlushbarPosition.TOP,
      margin: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
      padding: const EdgeInsets.all(24.0),
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

  /// Afficher une notification d'information avec design professionnel
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
        color: _getAdaptiveIconColor(theme, Colors.blue),
        size: 32.0,
      ),
      backgroundColor: _getAdaptiveBackground(theme, Colors.blue),
      borderColor: _getAdaptiveBorderColor(theme, Colors.blue),
      borderWidth: 1.5,
      borderRadius: BorderRadius.circular(20.0),
      duration: duration ?? const Duration(seconds: 4),
      flushbarPosition: FlushbarPosition.TOP,
      margin: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
      padding: const EdgeInsets.all(24.0),
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

  /// Afficher une notification d'avertissement avec design professionnel
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
        color: _getAdaptiveIconColor(theme, Colors.orange),
        size: 32.0,
      ),
      backgroundColor: _getAdaptiveBackground(theme, Colors.orange),
      borderColor: _getAdaptiveBorderColor(theme, Colors.orange),
      borderWidth: 1.5,
      borderRadius: BorderRadius.circular(20.0),
      duration: duration ?? const Duration(seconds: 4),
      flushbarPosition: FlushbarPosition.TOP,
      margin: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
      padding: const EdgeInsets.all(24.0),
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

  /// Afficher une notification avec action et design professionnel
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
        color: _getAdaptiveIconColor(theme, theme.colorScheme.primary),
        size: 32.0,
      ),
      backgroundColor: _getAdaptiveBackground(theme, theme.colorScheme.primary),
      borderColor: _getAdaptiveBorderColor(theme, theme.colorScheme.primary),
      borderWidth: 1.5,
      borderRadius: BorderRadius.circular(20.0),
      duration: duration,
      flushbarPosition: FlushbarPosition.TOP,
      margin: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
      padding: const EdgeInsets.all(24.0),
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

  /// Afficher une notification de chargement avec design professionnel
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
      icon: SizedBox(
        width: 24,
        height: 24,
        child: CircularProgressIndicator(
          strokeWidth: 2.5,
          valueColor: AlwaysStoppedAnimation<Color>(_getAdaptiveIconColor(theme, theme.colorScheme.primary)),
        ),
      ).animate()
        .rotate(duration: 1000.ms)
        .then()
        .rotate(duration: 1000.ms),
      backgroundColor: _getAdaptiveBackground(theme, theme.colorScheme.primary),
      borderColor: _getAdaptiveBorderColor(theme, theme.colorScheme.primary),
      borderWidth: 1.5,
      borderRadius: BorderRadius.circular(20.0),
      duration: null, // Indéfinie
      flushbarPosition: FlushbarPosition.TOP,
      margin: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
      padding: const EdgeInsets.all(24.0),
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

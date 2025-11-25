import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:pocketly/core/errors/app_error.dart';
import 'package:pocketly/core/constants/app_dimensions.dart';
import 'package:pocketly/core/constants/app_icons.dart';

/// Service pour afficher des notifications d'erreur adaptatives.
///
/// Utilise SnackBar sur Android et Toast-like sur iOS.
class ErrorSnackbar {
  /// Affiche une notification d'erreur
  static void show(
    BuildContext context,
    AppError error, {
    VoidCallback? onRetry,
    Duration duration = const Duration(seconds: 4),
  }) {
    if (Platform.isIOS) {
      _showIOSNotification(
        context,
        error,
        onRetry: onRetry,
        duration: duration,
      );
    } else {
      _showAndroidSnackbar(
        context,
        error,
        onRetry: onRetry,
        duration: duration,
      );
    }
  }

  /// Affiche une SnackBar Material (Android)
  static void _showAndroidSnackbar(
    BuildContext context,
    AppError error, {
    VoidCallback? onRetry,
    Duration duration = const Duration(seconds: 4),
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    final backgroundColor = _getErrorColor(error.severity, colorScheme);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(_getMaterialIcon(error.severity), color: Colors.white),
            SizedBox(width: AppDimensions.paddingM),
            Expanded(
              child: Text(
                error.userMessage,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        backgroundColor: backgroundColor,
        duration: duration,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        ),
        action: onRetry != null
            ? SnackBarAction(
                label: 'Réessayer',
                textColor: Colors.white,
                onPressed: onRetry,
              )
            : null,
      ),
    );
  }

  /// Affiche une notification type Toast (iOS)
  static void _showIOSNotification(
    BuildContext context,
    AppError error, {
    VoidCallback? onRetry,
    Duration duration = const Duration(seconds: 4),
  }) {
    final overlay = Overlay.of(context);
    late OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => _IOSErrorNotification(
        error: error,
        onRetry: onRetry,
        onDismiss: () => overlayEntry.remove(),
      ),
    );

    overlay.insert(overlayEntry);

    // Auto-dismiss après la durée spécifiée
    Future.delayed(duration + 500.ms, () {
      if (overlayEntry.mounted) {
        overlayEntry.remove();
      }
    });
  }

  static IconData _getMaterialIcon(ErrorSeverity severity) {
    switch (severity) {
      case ErrorSeverity.info:
        return AppIcons.infoOutline;
      case ErrorSeverity.warning:
        return AppIcons.warning;
      case ErrorSeverity.error:
        return AppIcons.errorOutline;
      case ErrorSeverity.critical:
        return AppIcons.dangerous;
    }
  }

  static Color _getErrorColor(ErrorSeverity severity, ColorScheme colorScheme) {
    switch (severity) {
      case ErrorSeverity.info:
        return colorScheme.primary;
      case ErrorSeverity.warning:
        return Colors.orange;
      case ErrorSeverity.error:
        return colorScheme.error;
      case ErrorSeverity.critical:
        return Colors.red[900]!;
    }
  }
}

/// Widget de notification iOS style
class _IOSErrorNotification extends StatefulWidget {
  final AppError error;
  final VoidCallback? onRetry;
  final VoidCallback onDismiss;

  const _IOSErrorNotification({
    required this.error,
    this.onRetry,
    required this.onDismiss,
  });

  @override
  State<_IOSErrorNotification> createState() => _IOSErrorNotificationState();
}

class _IOSErrorNotificationState extends State<_IOSErrorNotification>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: 300.ms, vsync: this);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _dismiss() {
    _controller.reverse().then((_) => widget.onDismiss());
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final topPadding = mediaQuery.padding.top;

    return Positioned(
      top: topPadding + 8,
      left: 8,
      right: 8,
      child: GestureDetector(
        onVerticalDragEnd: (details) {
          if (details.primaryVelocity! < 0) {
            _dismiss();
          }
        },
        child: SlideTransition(
          position: Tween<Offset>(begin: Offset(0, -1), end: Offset.zero)
              .animate(
                CurvedAnimation(parent: _controller, curve: Curves.easeOut),
              ),
          child: FadeTransition(
            opacity: _controller,
            child: Container(
              padding: EdgeInsets.all(AppDimensions.paddingM),
              decoration: BoxDecoration(
                color: _getIOSBackgroundColor(widget.error.severity),
                borderRadius: BorderRadius.circular(AppDimensions.radiusL),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.2),
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Icon(
                        _getCupertinoIcon(widget.error.severity),
                        color: CupertinoColors.white,
                      ),
                      SizedBox(width: AppDimensions.paddingM),
                      Expanded(
                        child: Text(
                          widget.error.userMessage,
                          style: TextStyle(
                            color: CupertinoColors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      CupertinoButton(
                        padding: EdgeInsets.zero,
                        minimumSize: Size.zero,
                        onPressed: _dismiss,
                        child: Icon(
                          CupertinoIcons.xmark_circle_fill,
                          color: CupertinoColors.white.withValues(alpha: 0.8),
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                  if (widget.onRetry != null) ...[
                    SizedBox(height: AppDimensions.paddingS),
                    CupertinoButton(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppDimensions.paddingM,
                        vertical: AppDimensions.paddingS,
                      ),
                      color: CupertinoColors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(
                        AppDimensions.radiusM,
                      ),
                      onPressed: () {
                        _dismiss();
                        widget.onRetry?.call();
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            CupertinoIcons.refresh,
                            color: CupertinoColors.white,
                            size: 16,
                          ),
                          SizedBox(width: AppDimensions.paddingS),
                          Text(
                            'Réessayer',
                            style: TextStyle(
                              color: CupertinoColors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  IconData _getCupertinoIcon(ErrorSeverity severity) {
    switch (severity) {
      case ErrorSeverity.info:
        return CupertinoIcons.info_circle_fill;
      case ErrorSeverity.warning:
        return CupertinoIcons.exclamationmark_triangle_fill;
      case ErrorSeverity.error:
        return CupertinoIcons.xmark_circle_fill;
      case ErrorSeverity.critical:
        return CupertinoIcons.exclamationmark_octagon_fill;
    }
  }

  Color _getIOSBackgroundColor(ErrorSeverity severity) {
    switch (severity) {
      case ErrorSeverity.info:
        return CupertinoColors.systemBlue;
      case ErrorSeverity.warning:
        return CupertinoColors.systemOrange;
      case ErrorSeverity.error:
        return CupertinoColors.systemRed;
      case ErrorSeverity.critical:
        return CupertinoColors.destructiveRed;
    }
  }
}

/// Extension pour faciliter l'affichage des erreurs
extension ErrorSnackbarExtension on BuildContext {
  /// Affiche une notification d'erreur
  void showErrorSnackbar(
    AppError error, {
    VoidCallback? onRetry,
    Duration duration = const Duration(seconds: 4),
  }) {
    ErrorSnackbar.show(this, error, onRetry: onRetry, duration: duration);
  }
}

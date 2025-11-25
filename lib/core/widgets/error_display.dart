import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:pocketly/core/errors/app_error.dart';
import 'package:pocketly/core/constants/app_dimensions.dart';
import 'package:pocketly/core/constants/app_icons.dart';
import 'package:pocketly/core/constants/app_typography.dart';

/// Widget adaptatif pour afficher une erreur en plein écran.
///
/// Respecte les guidelines iOS (Cupertino) et Android (Material).
/// Utilisé dans les états d'erreur des écrans.
class ErrorDisplay extends StatelessWidget {
  final AppError error;
  final VoidCallback? onRetry;
  final VoidCallback? onDismiss;
  final bool showTechnicalDetails;

  const ErrorDisplay({
    super.key,
    required this.error,
    this.onRetry,
    this.onDismiss,
    this.showTechnicalDetails = false,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(AppDimensions.paddingXL),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icône d'erreur avec animation
            _buildErrorIcon(context)
                .animate()
                .scale(duration: 400.ms, curve: Curves.elasticOut)
                .shake(hz: 2, duration: 400.ms),

            SizedBox(height: AppDimensions.paddingL),

            // Message utilisateur
            Text(
              error.userMessage,
              style: AppTypography.title.copyWith(
                fontWeight: FontWeight.bold,
                color: _getErrorColor(context),
              ),
              textAlign: TextAlign.center,
            ).animate().fadeIn(delay: 200.ms, duration: 400.ms),

            // Détails techniques (debug uniquement)
            if (showTechnicalDetails) ...[
              SizedBox(height: AppDimensions.paddingM),
              Container(
                padding: EdgeInsets.all(AppDimensions.paddingM),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(AppDimensions.radiusS),
                  border: Border.all(
                    color: Theme.of(
                      context,
                    ).colorScheme.outline.withValues(alpha: 0.3),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Code: ${error.errorCode}',
                      style: AppTypography.caption.copyWith(
                        fontFamily: 'monospace',
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                    SizedBox(height: AppDimensions.paddingS),
                    Text(
                      error.technicalMessage,
                      style: AppTypography.caption.copyWith(
                        fontFamily: 'monospace',
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ).animate().fadeIn(delay: 300.ms),
            ],

            SizedBox(height: AppDimensions.paddingXL),

            // Boutons d'action
            Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (onRetry != null) ...[
                      _buildRetryButton(context),
                      if (onDismiss != null)
                        SizedBox(width: AppDimensions.paddingM),
                    ],
                    if (onDismiss != null) _buildDismissButton(context),
                  ],
                )
                .animate()
                .fadeIn(delay: 400.ms, duration: 400.ms)
                .slideY(begin: 0.2, end: 0, duration: 400.ms),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorIcon(BuildContext context) {
    final iconData = _getErrorIcon();
    final color = _getErrorColor(context);

    return Container(
      padding: EdgeInsets.all(AppDimensions.paddingL),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(iconData, size: 64, color: color),
    );
  }

  Widget _buildRetryButton(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoButton.filled(
        onPressed: onRetry,
        padding: EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingXL,
          vertical: AppDimensions.paddingM,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(CupertinoIcons.refresh, size: 20),
            SizedBox(width: AppDimensions.paddingS),
            Text('Réessayer'),
          ],
        ),
      );
    }

    return ElevatedButton.icon(
      onPressed: onRetry,
      icon: Icon(AppIcons.refresh),
      label: Text('Réessayer'),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingXL,
          vertical: AppDimensions.paddingM,
        ),
      ),
    );
  }

  Widget _buildDismissButton(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoButton(
        onPressed: onDismiss,
        padding: EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingXL,
          vertical: AppDimensions.paddingM,
        ),
        child: Text('Fermer'),
      );
    }

    return TextButton(
      onPressed: onDismiss,
      style: TextButton.styleFrom(
        padding: EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingXL,
          vertical: AppDimensions.paddingM,
        ),
      ),
      child: Text('Fermer'),
    );
  }

  IconData _getErrorIcon() {
    if (Platform.isIOS) {
      switch (error.severity) {
        case ErrorSeverity.info:
          return CupertinoIcons.info_circle;
        case ErrorSeverity.warning:
          return CupertinoIcons.exclamationmark_triangle;
        case ErrorSeverity.error:
          return CupertinoIcons.xmark_circle;
        case ErrorSeverity.critical:
          return CupertinoIcons.exclamationmark_octagon;
      }
    } else {
      switch (error.severity) {
        case ErrorSeverity.info:
          return AppIcons.infoOutline;
        case ErrorSeverity.warning:
          return AppIcons.warningOutline;
        case ErrorSeverity.error:
          return AppIcons.errorOutline;
        case ErrorSeverity.critical:
          return AppIcons.dangerous;
      }
    }
  }

  Color _getErrorColor(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    switch (error.severity) {
      case ErrorSeverity.info:
        return Platform.isIOS
            ? CupertinoColors.systemBlue
            : colorScheme.primary;
      case ErrorSeverity.warning:
        return Platform.isIOS ? CupertinoColors.systemOrange : Colors.orange;
      case ErrorSeverity.error:
        return Platform.isIOS ? CupertinoColors.systemRed : colorScheme.error;
      case ErrorSeverity.critical:
        return Platform.isIOS
            ? CupertinoColors.destructiveRed
            : Colors.red[900]!;
    }
  }
}

/// Widget compact pour afficher une erreur dans un widget existant.
///
/// Utilisé pour les petits espaces (ex: dans une Card).
class CompactErrorDisplay extends StatelessWidget {
  final AppError error;
  final VoidCallback? onRetry;

  const CompactErrorDisplay({super.key, required this.error, this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppDimensions.paddingM),
      decoration: BoxDecoration(
        color: _getErrorColor(context).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        border: Border.all(
          color: _getErrorColor(context).withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        children: [
          Icon(_getErrorIcon(), color: _getErrorColor(context), size: 24),
          SizedBox(width: AppDimensions.paddingM),
          Expanded(
            child: Text(
              error.userMessage,
              style: AppTypography.body.copyWith(
                color: _getErrorColor(context),
              ),
            ),
          ),
          if (onRetry != null) ...[
            SizedBox(width: AppDimensions.paddingM),
            if (Platform.isIOS)
              CupertinoButton(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                onPressed: onRetry,
                child: Icon(
                  CupertinoIcons.refresh,
                  color: _getErrorColor(context),
                ),
              )
            else
              IconButton(
                icon: Icon(AppIcons.refresh),
                color: _getErrorColor(context),
                onPressed: onRetry,
              ),
          ],
        ],
      ),
    ).animate().fadeIn(duration: 300.ms).slideY(begin: -0.2, end: 0);
  }

  IconData _getErrorIcon() {
    if (Platform.isIOS) {
      switch (error.severity) {
        case ErrorSeverity.info:
          return CupertinoIcons.info_circle_fill;
        case ErrorSeverity.warning:
          return CupertinoIcons.exclamationmark_triangle_fill;
        case ErrorSeverity.error:
          return CupertinoIcons.xmark_circle_fill;
        case ErrorSeverity.critical:
          return CupertinoIcons.exclamationmark_octagon_fill;
      }
    } else {
      switch (error.severity) {
        case ErrorSeverity.info:
          return AppIcons.info;
        case ErrorSeverity.warning:
          return AppIcons.warning;
        case ErrorSeverity.error:
          return AppIcons.error;
        case ErrorSeverity.critical:
          return AppIcons.dangerous;
      }
    }
  }

  Color _getErrorColor(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    switch (error.severity) {
      case ErrorSeverity.info:
        return Platform.isIOS
            ? CupertinoColors.systemBlue
            : colorScheme.primary;
      case ErrorSeverity.warning:
        return Platform.isIOS ? CupertinoColors.systemOrange : Colors.orange;
      case ErrorSeverity.error:
        return Platform.isIOS ? CupertinoColors.systemRed : colorScheme.error;
      case ErrorSeverity.critical:
        return Platform.isIOS
            ? CupertinoColors.destructiveRed
            : Colors.red[900]!;
    }
  }
}

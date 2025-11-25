import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocketly/core/errors/errors.dart';

/// Widget pour afficher les erreurs avec localisation
class LocalizedErrorDisplay extends StatelessWidget {
  final AppError error;
  final VoidCallback? onRetry;
  final String? customTitle;
  final String? customMessage;

  const LocalizedErrorDisplay({
    super.key,
    required this.error,
    this.onRetry,
    this.customTitle,
    this.customMessage,
  });

  @override
  Widget build(BuildContext context) {
    final isIOS = Platform.isIOS;

    if (isIOS) {
      return _buildIOSError(context);
    } else {
      return _buildAndroidError(context);
    }
  }

  Widget _buildIOSError(BuildContext context) {
    return CupertinoPageScaffold(
      child: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  ErrorLocalization.getErrorIcon(error),
                  size: 64,
                  color: ErrorLocalization.getErrorColor(error, context),
                ),
                const SizedBox(height: 16),
                Text(
                  customTitle ??
                      ErrorLocalization.getLocalizedErrorTitle(error, context),
                  style: CupertinoTheme.of(context).textTheme.navTitleTextStyle,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  customMessage ??
                      ErrorLocalization.getLocalizedUserMessage(error, context),
                  style: CupertinoTheme.of(context).textTheme.textStyle,
                  textAlign: TextAlign.center,
                ),
                if (onRetry != null) ...[
                  const SizedBox(height: 24),
                  CupertinoButton.filled(
                    onPressed: onRetry,
                    child: const Text('Réessayer'),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAndroidError(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                ErrorLocalization.getErrorIcon(error),
                size: 64,
                color: ErrorLocalization.getErrorColor(error, context),
              ),
              const SizedBox(height: 16),
              Text(
                customTitle ??
                    ErrorLocalization.getLocalizedErrorTitle(error, context),
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                customMessage ??
                    ErrorLocalization.getLocalizedUserMessage(error, context),
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              if (onRetry != null) ...[
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: onRetry,
                  child: const Text('Réessayer'),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// Extension pour faciliter l'utilisation avec AsyncValue
extension AsyncValueErrorDisplay<T> on AsyncValue<T> {
  /// Affiche l'erreur si présente
  Widget? buildErrorDisplay(BuildContext context, {VoidCallback? onRetry}) {
    return maybeWhen(
      error: (error, stackTrace) {
        final appError = ErrorHandler.handleError(error, stackTrace);
        return LocalizedErrorDisplay(error: appError, onRetry: onRetry);
      },
      orElse: () => null,
    );
  }
}

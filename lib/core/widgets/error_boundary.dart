import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocketly/core/constants/app_icons.dart';
import 'package:pocketly/core/errors/app_error.dart';
import 'package:pocketly/core/errors/error_notifier.dart';
import 'package:pocketly/core/widgets/error_snackbar.dart';

/// Widget boundary pour gérer automatiquement les erreurs.
///
/// Écoute le `errorNotifierProvider` et affiche automatiquement
/// les notifications d'erreur aux utilisateurs.
class ErrorBoundary extends ConsumerWidget {
  final Widget child;
  final bool showSnackbar;
  final void Function(AppError error)? onError;

  const ErrorBoundary({
    super.key,
    required this.child,
    this.showSnackbar = true,
    this.onError,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Écouter les changements d'erreur
    ref.listen<AppError?>(errorNotifierProvider, (previous, next) {
      if (next != null) {
        // Callback personnalisé
        onError?.call(next);

        // Afficher la notification si demandé
        if (showSnackbar) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (context.mounted) {
              context.showErrorSnackbar(next);
            }
          });
        }

        // Nettoyer l'erreur après l'avoir affichée
        Future.delayed(Duration(milliseconds: 100), () {
          ref.read(errorNotifierProvider.notifier).clearError();
        });
      }
    });

    return child;
  }
}

/// Widget pour afficher l'état d'un AsyncValue avec gestion d'erreurs
class AsyncValueBuilder<T> extends StatelessWidget {
  final AsyncValue<T> value;
  final Widget Function(T data) data;
  final Widget Function()? loading;
  final Widget Function(AppError error, VoidCallback retry)? error;
  final bool showCompactError;

  const AsyncValueBuilder({
    super.key,
    required this.value,
    required this.data,
    this.loading,
    this.error,
    this.showCompactError = false,
  });

  @override
  Widget build(BuildContext context) {
    return value.when(
      data: data,
      loading: () => loading?.call() ?? _defaultLoading(),
      error: (err, stack) {
        final appError = value.appError!;
        return error?.call(appError, () => value.maybeWhen(orElse: () {})) ??
            _defaultError(appError);
      },
    );
  }

  Widget _defaultLoading() {
    return Center(child: CircularProgressIndicator());
  }

  Widget _defaultError(AppError appError) {
    if (showCompactError) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            appError.userMessage,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.red, fontSize: 14),
          ),
        ),
      );
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(AppIcons.errorOutline, size: 48, color: Colors.red),
          SizedBox(height: 16),
          Text(
            appError.userMessage,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}

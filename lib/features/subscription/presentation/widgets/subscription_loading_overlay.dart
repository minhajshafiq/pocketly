import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pocketly/core/core.dart';

/// Overlay de chargement pendant les opérations d'abonnement
///
/// Affiche un indicateur de chargement avec un message
class SubscriptionLoadingOverlay extends StatelessWidget {
  final String message;

  const SubscriptionLoadingOverlay({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withValues(alpha: 0.5),
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Indicateur de chargement adaptatif
              if (Platform.isIOS)
                const CupertinoActivityIndicator(
                  radius: 20,
                )
              else
                const CircularProgressIndicator(),

              const SizedBox(height: 16),

              // Message
              Text(
                message,
                style: AppTypography.body.copyWith(
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

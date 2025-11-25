import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pocketly/core/core.dart';

/// Bouton d'achat d'abonnement adaptatif
///
/// Style iOS (Cupertino) ou Android (Material) selon la plateforme
class SubscriptionPurchaseButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;

  const SubscriptionPurchaseButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return _buildCupertinoButton();
    } else {
      return _buildMaterialButton();
    }
  }

  Widget _buildCupertinoButton() {
    return CupertinoButton.filled(
      onPressed: isLoading ? null : onPressed,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
      borderRadius: BorderRadius.circular(12),
      child: isLoading
          ? const CupertinoActivityIndicator(color: Colors.white)
          : Text(
              text,
              style: AppTypography.body.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
    );
  }

  Widget _buildMaterialButton() {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 2,
      ),
      child: isLoading
          ? const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            )
          : Text(
              text,
              style: AppTypography.body.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
    );
  }
}

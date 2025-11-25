import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocketly/core/core.dart';
import 'package:pocketly/features/currency/domain/entities/currency_entity.dart';
import 'package:pocketly/features/currency/presentation/providers/currency_providers.dart';

/// Widget pour afficher un montant avec la devise de l'utilisateur.
///
/// Utilise automatiquement la devise sélectionnée par l'utilisateur
/// et formate le montant en conséquence.
class CurrencyDisplayWidget extends ConsumerWidget {
  /// Le montant à afficher
  final double amount;

  /// Nombre de décimales (par défaut 2)
  final int decimals;

  /// Style du texte
  final TextStyle? style;

  /// Afficher le drapeau
  final bool showFlag;

  /// Afficher le code de la devise
  final bool showCode;

  const CurrencyDisplayWidget({
    super.key,
    required this.amount,
    this.decimals = 2,
    this.style,
    this.showFlag = false,
    this.showCode = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currencyAsync = ref.watch(currencyProvider);

    return currencyAsync.when(
      data: (currency) => _buildDisplay(currency),
      loading: () => _buildFallback(),
      error: (error, stack) => _buildFallback(),
    );
  }

  /// Construit l'affichage avec la devise
  Widget _buildDisplay(CurrencyEntity currency) {
    final formattedAmount = currency.formatAmount(amount, decimals: decimals);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showFlag) ...[
          Text(
            currency.flag,
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(width: 4),
        ],
        if (showCode) ...[
          Text(
            currency.code,
            style: style ?? AppTypography.body,
          ),
          const SizedBox(width: 4),
        ],
        Text(
          formattedAmount,
          style: style ?? AppTypography.body,
        ),
      ],
    );
  }

  /// Affichage de secours avec EUR
  Widget _buildFallback() {
    final formattedAmount = SupportedCurrencies.eur.formatAmount(
      amount,
      decimals: decimals,
    );

    return Text(
      formattedAmount,
      style: style ?? AppTypography.body,
    );
  }
}

/// Widget compact pour afficher uniquement le montant formaté
class CurrencyAmountText extends ConsumerWidget {
  /// Le montant à afficher
  final double amount;

  /// Nombre de décimales
  final int decimals;

  /// Style du texte
  final TextStyle? style;

  const CurrencyAmountText({
    super.key,
    required this.amount,
    this.decimals = 2,
    this.style,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currencyAsync = ref.watch(currencyProvider);

    return currencyAsync.when(
      data: (currency) => Text(
        currency.formatAmount(amount, decimals: decimals),
        style: style ?? AppTypography.body,
      ),
      loading: () => Text(
        SupportedCurrencies.eur.formatAmount(amount, decimals: decimals),
        style: style ?? AppTypography.body,
      ),
      error: (error, stack) => Text(
        SupportedCurrencies.eur.formatAmount(amount, decimals: decimals),
        style: style ?? AppTypography.body,
      ),
    );
  }
}

/// Widget pour afficher le symbole de la devise actuelle
class CurrencySymbolWidget extends ConsumerWidget {
  /// Style du texte
  final TextStyle? style;

  const CurrencySymbolWidget({
    super.key,
    this.style,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currencyAsync = ref.watch(currencyProvider);

    return currencyAsync.when(
      data: (currency) => Text(
        currency.symbol,
        style: style ?? AppTypography.body,
      ),
      loading: () => Text(
        SupportedCurrencies.eur.symbol,
        style: style ?? AppTypography.body,
      ),
      error: (error, stack) => Text(
        SupportedCurrencies.eur.symbol,
        style: style ?? AppTypography.body,
      ),
    );
  }
}

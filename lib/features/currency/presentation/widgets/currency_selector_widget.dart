import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocketly/core/core.dart';
import 'package:pocketly/features/currency/domain/entities/currency_entity.dart';
import 'package:pocketly/features/currency/presentation/providers/currency_providers.dart';

/// Widget pour sélectionner une devise.
///
/// Affiche un sélecteur adaptatif (iOS/Android) permettant
/// de choisir parmi les devises disponibles.
class CurrencySelectorWidget extends ConsumerWidget {
  /// Style d'affichage
  final CurrencySelectorStyle style;

  /// Afficher les drapeaux
  final bool showFlags;

  /// Callback appelé lors du changement de devise
  final void Function(CurrencyEntity)? onCurrencyChanged;

  const CurrencySelectorWidget({
    super.key,
    this.style = CurrencySelectorStyle.dropdown,
    this.showFlags = true,
    this.onCurrencyChanged,
  });

  bool get _isIOS => !kIsWeb && Platform.isIOS;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentCurrencyAsync = ref.watch(currencyProvider);
    final availableCurrenciesAsync = ref.watch(availableCurrenciesProvider);

    return availableCurrenciesAsync.when(
      data: (currencies) {
        return currentCurrencyAsync.when(
          data: (currentCurrency) {
            switch (style) {
              case CurrencySelectorStyle.dropdown:
                return _buildDropdown(context, ref, currentCurrency, currencies);
              case CurrencySelectorStyle.list:
                return _buildList(context, ref, currentCurrency, currencies);
              case CurrencySelectorStyle.compact:
                return _buildCompact(context, ref, currentCurrency, currencies);
            }
          },
          loading: () => const CircularProgressIndicator(),
          error: (error, stack) => Text('Error: $error'),
        );
      },
      loading: () => const CircularProgressIndicator(),
      error: (error, stack) => Text('Error: $error'),
    );
  }

  /// Construit un dropdown/picker adaptatif
  Widget _buildDropdown(
    BuildContext context,
    WidgetRef ref,
    CurrencyEntity current,
    List<CurrencyEntity> currencies,
  ) {
    if (_isIOS) {
      return _buildIOSPicker(context, ref, current, currencies);
    }
    return _buildAndroidDropdown(context, ref, current, currencies);
  }

  /// Picker iOS
  Widget _buildIOSPicker(
    BuildContext context,
    WidgetRef ref,
    CurrencyEntity current,
    List<CurrencyEntity> currencies,
  ) {
    return GestureDetector(
      onTap: () => _showIOSPicker(context, ref, current, currencies),
      child: Container(
        padding: EdgeInsets.all(AppDimensions.paddingM),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.borderLight),
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                if (showFlags) ...[
                  Text(current.flag, style: const TextStyle(fontSize: 24)),
                  SizedBox(width: AppDimensions.paddingS),
                ],
                Text(
                  '${current.code} (${current.symbol})',
                  style: AppTypography.body,
                ),
              ],
            ),
            const Icon(CupertinoIcons.chevron_down, size: 20),
          ],
        ),
      ),
    );
  }

  /// Dropdown Android
  Widget _buildAndroidDropdown(
    BuildContext context,
    WidgetRef ref,
    CurrencyEntity current,
    List<CurrencyEntity> currencies,
  ) {
    return DropdownButtonFormField<CurrencyEntity>(
      initialValue: current,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        ),
        contentPadding: EdgeInsets.all(AppDimensions.paddingM),
      ),
      items: currencies.map((currency) {
        return DropdownMenuItem(
          value: currency,
          child: Row(
            children: [
              if (showFlags) ...[
                Text(currency.flag, style: const TextStyle(fontSize: 24)),
                SizedBox(width: AppDimensions.paddingS),
              ],
              Text('${currency.code} (${currency.symbol})'),
            ],
          ),
        );
      }).toList(),
      onChanged: (currency) {
        if (currency != null) {
          _updateCurrency(ref, currency);
        }
      },
    );
  }

  /// Affiche le picker iOS
  void _showIOSPicker(
    BuildContext context,
    WidgetRef ref,
    CurrencyEntity current,
    List<CurrencyEntity> currencies,
  ) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => Container(
        height: 250,
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CupertinoButton(
                  child: const Text('Cancel'),
                  onPressed: () => Navigator.pop(context),
                ),
                CupertinoButton(
                  child: const Text('Done'),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            Expanded(
              child: CupertinoPicker(
                itemExtent: 40,
                onSelectedItemChanged: (index) {
                  _updateCurrency(ref, currencies[index]);
                },
                children: currencies.map((currency) {
                  return Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (showFlags) ...[
                          Text(currency.flag, style: const TextStyle(fontSize: 24)),
                          const SizedBox(width: 8),
                        ],
                        Text('${currency.code} (${currency.symbol})'),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Construit une liste de sélection
  Widget _buildList(
    BuildContext context,
    WidgetRef ref,
    CurrencyEntity current,
    List<CurrencyEntity> currencies,
  ) {
    return Column(
      children: currencies.map((currency) {
        final isSelected = currency.code == current.code;
        return ListTile(
          leading: showFlags
              ? Text(currency.flag, style: const TextStyle(fontSize: 24))
              : null,
          title: Text(currency.name),
          subtitle: Text('${currency.code} (${currency.symbol})'),
          trailing: isSelected
              ? Icon(Icons.check, color: AppColors.primary)
              : null,
          selected: isSelected,
          onTap: () => _updateCurrency(ref, currency),
        );
      }).toList(),
    );
  }

  /// Construit un affichage compact
  Widget _buildCompact(
    BuildContext context,
    WidgetRef ref,
    CurrencyEntity current,
    List<CurrencyEntity> currencies,
  ) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showFlags) ...[
          Text(current.flag, style: const TextStyle(fontSize: 20)),
          SizedBox(width: AppDimensions.paddingXS),
        ],
        Text(
          current.code,
          style: AppTypography.bodyBold,
        ),
        SizedBox(width: AppDimensions.paddingXS),
        GestureDetector(
          onTap: () => _showCurrencyDialog(context, ref, current, currencies),
          child: Icon(
            Icons.arrow_drop_down,
            color: AppColors.primary,
          ),
        ),
      ],
    );
  }

  /// Affiche un dialog de sélection
  void _showCurrencyDialog(
    BuildContext context,
    WidgetRef ref,
    CurrencyEntity current,
    List<CurrencyEntity> currencies,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Currency'),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView(
            shrinkWrap: true,
            children: currencies.map((currency) {
              final isSelected = currency.code == current.code;
              return ListTile(
                leading: showFlags
                    ? Text(currency.flag, style: const TextStyle(fontSize: 24))
                    : null,
                title: Text(currency.name),
                subtitle: Text('${currency.code} (${currency.symbol})'),
                trailing: isSelected
                    ? Icon(Icons.check, color: AppColors.primary)
                    : null,
                selected: isSelected,
                onTap: () {
                  _updateCurrency(ref, currency);
                  Navigator.pop(context);
                },
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  /// Met à jour la devise
  void _updateCurrency(WidgetRef ref, CurrencyEntity currency) {
    ref.read(currencyProvider.notifier).setCurrency(currency);
    onCurrencyChanged?.call(currency);
  }
}

/// Styles de sélecteur de devise
enum CurrencySelectorStyle {
  /// Dropdown/Picker adaptatif
  dropdown,

  /// Liste complète
  list,

  /// Affichage compact avec icône
  compact,
}

import 'package:freezed_annotation/freezed_annotation.dart';

part 'currency_entity.freezed.dart';
part 'currency_entity.g.dart';

/// Entity représentant une devise dans l'application.
///
/// Cette entité est utilisée pour gérer l'affichage des montants
/// dans différentes devises sans gestion de taux de change.
@freezed
sealed class CurrencyEntity with _$CurrencyEntity {
  const factory CurrencyEntity({
    /// Code ISO 4217 de la devise (ex: EUR, USD)
    required String code,

    /// Symbole de la devise (ex: €, $)
    required String symbol,

    /// Nom complet de la devise
    required String name,

    /// Emoji du drapeau du pays principal
    required String flag,
  }) = _CurrencyEntity;

  factory CurrencyEntity.fromJson(Map<String, dynamic> json) =>
      _$CurrencyEntityFromJson(json);
}

/// Extension pour les devises prédéfinies
extension CurrencyEntityX on CurrencyEntity {
  /// Formate un montant avec le symbole de la devise
  ///
  /// Règles de formatage:
  /// - Ajoute un espace entre le montant et le symbole
  /// - Masque les décimales si elles sont .00 (ex: 150.00 -> 150)
  /// - Position du symbole: avant pour USD/GBP, après pour EUR/JPY
  String formatAmount(double amount, {int decimals = 2}) {
    // Formater le montant avec les décimales
    String formattedAmount = amount.toStringAsFixed(decimals);

    // Masquer les décimales si elles sont .00
    if (decimals > 0 && formattedAmount.endsWith('.${'0' * decimals}')) {
      formattedAmount = amount.toStringAsFixed(0);
    }

    // Pour le dollar et la livre, le symbole va avant avec un espace
    if (code == 'USD' || code == 'GBP') {
      return '$symbol $formattedAmount';
    }

    // Pour l'euro et le yen, le symbole va après avec un espace
    return '$formattedAmount $symbol';
  }

  /// Vérifie si c'est la devise par défaut
  bool get isDefault => code == 'EUR';
}

/// Classe contenant toutes les devises disponibles
class SupportedCurrencies {
  SupportedCurrencies._();

  /// Euro - Devise par défaut
  static const CurrencyEntity eur = CurrencyEntity(
    code: 'EUR',
    symbol: '€',
    name: 'Euro',
    flag: '🇪🇺',
  );

  /// Dollar américain
  static const CurrencyEntity usd = CurrencyEntity(
    code: 'USD',
    symbol: '\$',
    name: 'US Dollar',
    flag: '🇺🇸',
  );

  /// Livre sterling
  static const CurrencyEntity gbp = CurrencyEntity(
    code: 'GBP',
    symbol: '£',
    name: 'British Pound',
    flag: '🇬🇧',
  );

  /// Yen japonais
  static const CurrencyEntity jpy = CurrencyEntity(
    code: 'JPY',
    symbol: '¥',
    name: 'Japanese Yen',
    flag: '🇯🇵',
  );

  /// Liste de toutes les devises supportées
  static const List<CurrencyEntity> all = [
    eur,
    usd,
    gbp,
    jpy,
  ];

  /// Récupère une devise par son code
  /// Retourne EUR si le code n'est pas trouvé
  static CurrencyEntity fromCode(String code) {
    return all.firstWhere(
      (currency) => currency.code == code,
      orElse: () => eur,
    );
  }

  /// Récupère la devise par défaut
  static CurrencyEntity get defaultCurrency => eur;
}

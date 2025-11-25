import 'package:pocketly/features/currency/domain/entities/currency_entity.dart';

/// Interface du repository pour la gestion des devises.
///
/// Cette interface définit les opérations de persistance
/// pour la devise sélectionnée par l'utilisateur.
abstract class CurrencyRepository {
  /// Récupère la devise actuellement sélectionnée par l'utilisateur.
  ///
  /// Retourne la devise par défaut (EUR) si aucune devise n'est sauvegardée.
  Future<CurrencyEntity> getUserCurrency();

  /// Définit la devise de l'utilisateur.
  ///
  /// [currency] La devise à sauvegarder.
  /// Lance une exception en cas d'erreur de sauvegarde.
  Future<void> setUserCurrency(CurrencyEntity currency);

  /// Réinitialise la devise à la valeur par défaut (EUR).
  Future<void> resetToDefault();

  /// Récupère toutes les devises supportées.
  ///
  /// Cette méthode retourne une liste hardcodée de devises.
  List<CurrencyEntity> getAllCurrencies();
}

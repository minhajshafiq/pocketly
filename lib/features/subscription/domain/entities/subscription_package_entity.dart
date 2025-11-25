import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pocketly/features/subscription/domain/entities/subscription_offer_entity.dart';

part 'subscription_package_entity.freezed.dart';
part 'subscription_package_entity.g.dart';

/// Entité représentant un package RevenueCat
///
/// Encapsule les données d'un package RevenueCat avec les informations
/// nécessaires pour afficher et acheter l'abonnement
@freezed
sealed class SubscriptionPackageEntity with _$SubscriptionPackageEntity {
  const factory SubscriptionPackageEntity({
    /// Identifiant du package
    required String identifier,

    /// Type d'offre
    required SubscriptionOfferType offerType,

    /// Identifiant du produit
    required String productIdentifier,

    /// Prix formaté
    required String priceString,

    /// Prix en nombre
    required double price,

    /// Code de devise
    required String currencyCode,

    /// Durée d'introduction (pour les essais gratuits)
    String? introPrice,

    /// Période d'introduction
    String? introPeriod,

    /// Package RevenueCat original (pour l'achat)
    /// Note: Ne peut pas être sérialisé, utilisé uniquement en runtime
    @JsonKey(includeFromJson: false, includeToJson: false) Object? package,
  }) = _SubscriptionPackageEntity;

  factory SubscriptionPackageEntity.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionPackageEntityFromJson(json);
}

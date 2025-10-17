import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

/// Classe qui centralise tous les icônes utilisés dans l'application.
///
/// Cette classe utilise les icônes Lucide pour une expérience visuelle cohérente
/// et moderne sur toutes les plateformes.
///
/// Usage:
/// ```dart
/// // Utilisation simple
/// Icon(AppIcons.home)
///
/// // Utilisation avec taille et couleur
/// Icon(AppIcons.home, size: 24, color: Colors.blue)
///
/// // Utilisation adaptative (iOS/Android)
/// Icon(AppIcons.adaptiveHome)
/// ```
class AppIcons {
  // Empêcher l'instanciation
  AppIcons._();

  // ==================== NAVIGATION ====================

  /// Icône de navigation vers la page d'accueil
  static IconData get home => LucideIcons.house;

  /// Icône de navigation vers le profil
  static IconData get profile => LucideIcons.user;

  /// Icône de navigation vers les paramètres
  static IconData get settings => LucideIcons.settings;

  /// Icône de navigation vers les transactions
  static IconData get transactions => LucideIcons.wallet;

  /// Icône de navigation vers les statistiques
  static IconData get stats => LucideIcons.chartBar;

  /// Icône de retour en arrière
  static IconData get back => LucideIcons.arrowLeft;

  /// Icône de fermeture (X)
  static IconData get close => LucideIcons.x;

  // ==================== ACTIONS ====================

  /// Icône d'ajout (+)
  static IconData get add => LucideIcons.plus;

  /// Icône de suppression
  static IconData get delete => LucideIcons.trash2;

  /// Icône de modification
  static IconData get edit => LucideIcons.pencil;

  /// Icône de sauvegarde
  static IconData get save => LucideIcons.check;

  /// Icône de recherche
  static IconData get search => LucideIcons.search;

  /// Icône de filtre
  static IconData get filter => LucideIcons.listFilterPlus;

  /// Icône de tri
  static IconData get sort => LucideIcons.arrowUpDown;

  /// Icône de partage
  static IconData get share => LucideIcons.share;

  /// Icône de favoris
  static IconData get favorite => LucideIcons.heart;

  /// Icône de favoris (outline)
  static IconData get favoriteOutline => LucideIcons.heart;

  // ==================== AUTHENTIFICATION ====================

  /// Icône de connexion
  static IconData get login => LucideIcons.logIn;

  /// Icône de déconnexion
  static IconData get logout => LucideIcons.logOut;

  /// Icône d'inscription
  static IconData get signup => LucideIcons.userPlus;

  /// Icône d'email
  static IconData get email => LucideIcons.mail;

  /// Icône de mot de passe
  static IconData get password => LucideIcons.lock;

  /// Icône de mot de passe visible
  static IconData get passwordVisible => LucideIcons.eye;

  /// Icône de mot de passe caché
  static IconData get passwordHidden => LucideIcons.eyeOff;

  /// Icône de Google
  static IconData get google => LucideIcons.rectangleGoggles;

  /// Icône d'Apple
  static IconData get apple => LucideIcons.apple;

  // ==================== FINANCES ====================

  /// Icône de revenus
  static IconData get income => LucideIcons.arrowDownLeft;

  /// Icône de dépenses
  static IconData get expense => LucideIcons.arrowUpRight;

  /// Icône de portefeuille
  static IconData get wallet => LucideIcons.wallet;

  /// Icône de carte bancaire
  static IconData get creditCard => LucideIcons.creditCard;

  /// Icône de transfert
  static IconData get transfer => LucideIcons.arrowRightLeft;

  /// Icône d'épargne
  static IconData get savings => LucideIcons.piggyBank;

  /// Icône de budget
  static IconData get budget => LucideIcons.chartPie;

  // ==================== CATÉGORIES DE DÉPENSES ====================

  /// Icône pour la catégorie alimentation
  static IconData get food => LucideIcons.utensils;

  /// Icône pour la catégorie transports
  static IconData get transport => LucideIcons.car;

  /// Icône pour la catégorie logement
  static IconData get housing => LucideIcons.house;

  /// Icône pour la catégorie loisirs
  static IconData get entertainment => LucideIcons.film;

  /// Icône pour la catégorie santé
  static IconData get health => LucideIcons.heart;

  /// Icône pour la catégorie éducation
  static IconData get education => LucideIcons.graduationCap;

  /// Icône pour la catégorie shopping
  static IconData get shopping => LucideIcons.shoppingBag;

  /// Icône pour la catégorie factures
  static IconData get bills => LucideIcons.receipt;

  /// Icône pour la catégorie cadeaux
  static IconData get gifts => LucideIcons.gift;

  /// Icône pour la catégorie vacances
  static IconData get travel => LucideIcons.plane;

  // ==================== NOTIFICATIONS ====================

  /// Icône de notification
  static IconData get notification => LucideIcons.bell;

  /// Icône de notification active
  static IconData get notificationActive => LucideIcons.bell;

  /// Icône de notification désactivée
  static IconData get notificationOff => LucideIcons.bellOff;

  // ==================== STATUTS ====================

  /// Icône de succès
  static IconData get success => LucideIcons.circleCheck;

  /// Icône d'erreur
  static IconData get error => LucideIcons.circleX;

  /// Icône d'avertissement
  static IconData get warning => LucideIcons.triangleAlert;

  /// Icône d'information
  static IconData get info => LucideIcons.info;

  // ==================== PREMIUM ====================

  /// Icône pour les fonctionnalités premium
  static IconData get premium => LucideIcons.crown;

  /// Icône pour les fonctionnalités premium (outline)
  static IconData get premiumOutline => LucideIcons.crown;

  /// Icône pour les achats in-app
  static IconData get purchase => LucideIcons.shoppingCart;

  // ==================== DIVERS ====================

  /// Icône de calendrier
  static IconData get calendar => LucideIcons.calendar;

  /// Icône d'horloge
  static IconData get clock => LucideIcons.clock;

  /// Icône de localisation
  static IconData get location => LucideIcons.mapPin;

  /// Icône de téléphone
  static IconData get phone => LucideIcons.phone;

  /// Icône de caméra
  static IconData get camera => LucideIcons.camera;

  /// Icône de galerie photo
  static IconData get gallery => LucideIcons.image;

  /// Icône de document
  static IconData get document => LucideIcons.fileText;

  /// Icône de lien
  static IconData get link => LucideIcons.link;

  /// Icône de téléchargement
  static IconData get download => LucideIcons.download;

  /// Icône d'envoi
  static IconData get upload => LucideIcons.upload;

  /// Icône de rafraîchissement
  static IconData get refresh => LucideIcons.refreshCw;

  // ==================== MÉTHODES UTILITAIRES ====================

  /// Obtient l'icône correspondant à une catégorie de dépense
  static IconData getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'food':
      case 'alimentation':
        return food;
      case 'transport':
      case 'transports':
        return transport;
      case 'housing':
      case 'logement':
        return housing;
      case 'entertainment':
      case 'loisirs':
        return entertainment;
      case 'health':
      case 'santé':
        return health;
      case 'education':
      case 'éducation':
        return education;
      case 'shopping':
      case 'achats':
        return shopping;
      case 'bills':
      case 'factures':
        return bills;
      case 'gifts':
      case 'cadeaux':
        return gifts;
      case 'travel':
      case 'voyages':
      case 'vacances':
        return travel;
      default:
        return LucideIcons.circle;
    }
  }

  /// Obtient l'icône correspondant à un type de transaction
  static IconData getTransactionTypeIcon(String type) {
    switch (type.toLowerCase()) {
      case 'income':
      case 'revenu':
        return income;
      case 'expense':
      case 'dépense':
        return expense;
      case 'transfer':
      case 'transfert':
        return transfer;
      default:
        return wallet;
    }
  }
}
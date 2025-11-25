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
  static IconData get transactions => LucideIcons.receipt;

  /// Icône de navigation vers les statistiques
  static IconData get stats => LucideIcons.chartBar;

  /// Icône de retour en arrière
  static IconData get back => LucideIcons.arrowLeft;

  /// Icône de flèche vers la droite
  static IconData get arrowRight => LucideIcons.chevronRight;

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

  /// Icône pour la langue/localisation
  static IconData get language => LucideIcons.languages;

  /// Icône pour la devise/monnaie
  static IconData get currency => LucideIcons.dollarSign;

  /// Icône pour le thème clair (soleil)
  static IconData get lightMode => LucideIcons.sun;

  /// Icône pour le thème sombre (lune)
  static IconData get darkMode => LucideIcons.moon;

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

  /// Icône de drapeau/objectif
  static IconData get flag => LucideIcons.flag;

  /// Icône de cible/objectif
  static IconData get target => LucideIcons.target;

  /// Icône pour afficher plus d'options
  static IconData get more => LucideIcons.tableOfContents;

  /// Icône pour les catégories personnalisées
  static IconData get custom => LucideIcons.sparkles;

  /// Icône pour les catégories par défaut
  static IconData get defaultIcon => LucideIcons.star;

  /// Icône de flèche vers la gauche (chevron)
  static IconData get chevronLeft => LucideIcons.chevronLeft;

  /// Icône de flèche vers la droite
  static IconData get chevronRight => LucideIcons.chevronRight;

  /// Icône de catégorie
  static IconData get category => LucideIcons.folder;

  /// Icône de répétition/récurrence
  static IconData get repeat => LucideIcons.repeat;

  /// Icône de notes
  static IconData get notes => LucideIcons.fileText;

  /// Icône de sablier/chargement
  static IconData get hourglass => LucideIcons.hourglass;

  /// Icône de flèche vers le haut
  static IconData get arrowUp => LucideIcons.arrowUp;

  /// Icône de flèche vers le bas
  static IconData get arrowDown => LucideIcons.arrowDown;

  /// Icône de cercle avec check (succès)
  static IconData get checkCircle => LucideIcons.circleCheck;

  /// Icône de personne/utilisateur
  static IconData get person => LucideIcons.user;

  /// Icône d'information (outline)
  static IconData get infoOutline => LucideIcons.info;

  /// Icône d'avertissement (outline)
  static IconData get warningOutline => LucideIcons.triangleAlert;

  /// Icône d'erreur (outline)
  static IconData get errorOutline => LucideIcons.circleX;

  /// Icône de danger
  static IconData get dangerous => LucideIcons.triangleAlert;

  /// Icône de flèche retour iOS
  static IconData get arrowBackIOS => LucideIcons.chevronLeft;

  /// Icône de flèche vers le bas (double)
  static IconData get keyboardDoubleArrowDown => LucideIcons.chevronsDown;

  /// Icône de flèche vers le haut (double)
  static IconData get keyboardDoubleArrowUp => LucideIcons.chevronsUp;

  /// Icône de flèche vers le bas (simple)
  static IconData get keyboardArrowDown => LucideIcons.chevronDown;

  /// Icône de cercle avec check (outline)
  static IconData get checkCircleOutline => LucideIcons.circleCheck;

  /// Icône de verrouillage
  static IconData get lock => LucideIcons.lock;

  /// Icône de graphique en barres
  static IconData get barChart => LucideIcons.chartBar;

  /// Icône de graphique linéaire
  static IconData get showChart => LucideIcons.trendingUp;

  /// Icône d'insights/analyses
  static IconData get insights => LucideIcons.brain;

  /// Icône d'historique
  static IconData get history => LucideIcons.history;

  /// Icône de lancement de fusée
  static IconData get rocketLaunch => LucideIcons.rocket;

  /// Icône d'étoile (rounded)
  static IconData get starRounded => LucideIcons.star;

  /// Icône d'étoile
  static IconData get star => LucideIcons.star;

  /// Icône de description/document
  static IconData get description => LucideIcons.fileText;

  /// Icône de chevron vers la droite (rounded)
  static IconData get chevronRightRounded => LucideIcons.chevronRight;

  /// Icône de calendrier mensuel
  static IconData get calendarMonth => LucideIcons.calendar;

  /// Icône d'épargne (rounded)
  static IconData get savingsRounded => LucideIcons.piggyBank;

  /// Icône de langue (rounded)
  static IconData get languageRounded => LucideIcons.languages;

  /// Icône de chat/bulle
  static IconData get chatBubble => LucideIcons.messageCircle;

  /// Icône de code
  static IconData get code => LucideIcons.code;

  /// Icône de fermeture (rounded)
  static IconData get closeRounded => LucideIcons.x;

  /// Icône de flèche vers l'avant iOS
  static IconData get arrowForwardIOS => LucideIcons.chevronRight;

  /// Icône de tendance à la hausse
  static IconData get trendingUp => LucideIcons.trendingUp;

  /// Icône de tendance à la baisse
  static IconData get trendingDown => LucideIcons.trendingDown;

  /// Icône de sablier vide
  static IconData get hourglassEmpty => LucideIcons.hourglass;

  /// Icône premium/workspace
  static IconData get workspacePremium => LucideIcons.crown;

  /// Icône de synchronisation
  static IconData get sync => LucideIcons.refreshCw;

  /// Icône de restaurant
  static IconData get restaurant => LucideIcons.utensils;

  /// Icône de voiture/directions
  static IconData get directionsCar => LucideIcons.car;

  /// Icône de favoris
  static IconData get favoriteRounded => LucideIcons.heart;

  /// Icône de jeux vidéo
  static IconData get sportsEsports => LucideIcons.gamepad2;

  /// Icône de monétisation
  static IconData get monetizationOn => LucideIcons.coins;

  /// Icône de catégorie
  static IconData get categoryRounded => LucideIcons.folder;

  /// Icône de lecture/play
  static IconData get playArrow => LucideIcons.play;

  /// Icône d'ajout en cercle
  static IconData get addCircle => LucideIcons.circlePlus;

  /// Icône de liste
  static IconData get list => LucideIcons.list;

  /// Icône de calendrier aujourd'hui
  static IconData get calendarToday => LucideIcons.calendar;

  /// Icône d'horloge/accès temps
  static IconData get accessTime => LucideIcons.clock;

  /// Icône de flèche vers le bas (dropdown)
  static IconData get arrowDropDown => LucideIcons.chevronDown;

  /// Icône d'aide
  static IconData get help => LucideIcons.info;

  /// Icône de caméra (alt)
  static IconData get cameraAlt => LucideIcons.camera;

  /// Icône de bibliothèque photo
  static IconData get photoLibrary => LucideIcons.image;

  /// Icône de portefeuille (account balance)
  static IconData get accountBalanceWallet => LucideIcons.wallet;

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

  /// Convertit un code d'icône (utilisé dans PocketIconPicker) en IconData
  /// 
  /// Cette méthode permet de convertir les codes d'icônes stockés dans l'entité Pocket
  /// en IconData pour l'affichage dans l'UI.
  /// 
  /// Usage:
  /// ```dart
  /// Icon(AppIcons.getPocketIcon('wallet'))
  /// Icon(AppIcons.getPocketIcon('shoppingBag'))
  /// ```
  static IconData getPocketIcon(String iconCode) {
    switch (iconCode) {
      // Finance
      case 'wallet':
        return LucideIcons.wallet;
      case 'savings':
      case 'piggy-bank':
        return LucideIcons.piggyBank;
      case 'creditCard':
        return LucideIcons.creditCard;
      case 'coins':
        return LucideIcons.coins;
      case 'dollar':
      case 'euro':
        return LucideIcons.dollarSign;
      case 'receipt':
        return LucideIcons.receipt;
      case 'chartPie':
        return LucideIcons.chartPie;
      case 'trendingUp':
        return LucideIcons.trendingUp;
      case 'trendingDown':
        return LucideIcons.trendingDown;

      // Alimentation
      case 'utensils':
      case 'food':
      case 'restaurant':
      case 'dining':
        return LucideIcons.utensils;
      case 'coffee':
        return LucideIcons.coffee;
      case 'cake':
        return LucideIcons.cake;
      case 'cookie':
        return LucideIcons.cookie;
      case 'fruit':
        return LucideIcons.apple;
      case 'wine':
      case 'beer':
        return LucideIcons.glassWater;

      // Transport
      case 'car':
      case 'directions_car':
      case 'transport':
        return LucideIcons.car;
      case 'bike':
        return LucideIcons.bike;
      case 'train':
        return LucideIcons.tramFront;
      case 'bus':
        return LucideIcons.bus;
      case 'plane':
      case 'flight':
      case 'travel':
        return LucideIcons.plane;
      case 'ship':
        return LucideIcons.ship;
      case 'fuel':
        return LucideIcons.droplet;

      // Loisirs
      case 'film':
      case 'movie':
      case 'cinema':
        return LucideIcons.film;
      case 'music':
        return LucideIcons.music;
      case 'gamepad':
      case 'games':
        return LucideIcons.gamepad2;
      case 'dumbbell':
      case 'sport':
        return LucideIcons.dumbbell;
      case 'book':
        return LucideIcons.book;
      case 'palette':
      case 'art':
        return LucideIcons.palette;
      case 'camera':
      case 'photo':
        return LucideIcons.camera;
      case 'trophy':
        return LucideIcons.trophy;

      // Services
      case 'house':
      case 'home':
        return LucideIcons.house;
      case 'wifi':
      case 'internet':
        return LucideIcons.wifi;
      case 'zap':
      case 'electricity':
        return LucideIcons.zap;
      case 'droplet':
      case 'water':
        return LucideIcons.droplet;
      case 'flame':
      case 'gas':
        return LucideIcons.flame;
      case 'phone':
        return LucideIcons.phone;
      case 'scissors':
        return LucideIcons.scissors;

      // Santé
      case 'heart':
      case 'health':
        return LucideIcons.heart;
      case 'stethoscope':
      case 'doctor':
        return LucideIcons.stethoscope;
      case 'pill':
      case 'medicine':
        return LucideIcons.pill;
      case 'activity':
        return LucideIcons.activity;

      // Shopping
      case 'shoppingBag':
      case 'shopping-bag':
      case 'shopping_bag':
      case 'shopping':
        return LucideIcons.shoppingBag;
      case 'shoppingCart':
      case 'cart':
        return LucideIcons.shoppingCart;
      case 'shirt':
      case 'clothing':
        return LucideIcons.shirt;
      case 'footprints':
      case 'shoes':
        return LucideIcons.footprints;
      case 'watch':
        return LucideIcons.watch;
      case 'smartphone':
        return LucideIcons.smartphone;
      case 'laptop':
        return LucideIcons.laptop;
      case 'tv':
        return LucideIcons.tv;
      case 'headphones':
        return LucideIcons.headphones;

      // Divers
      case 'gift':
        return LucideIcons.gift;
      case 'graduationCap':
      case 'education':
        return LucideIcons.graduationCap;
      case 'briefcase':
      case 'work':
        return LucideIcons.briefcase;
      case 'baby':
        return LucideIcons.baby;
      case 'dog':
        return LucideIcons.dog;
      case 'cat':
        return LucideIcons.cat;
      case 'leaf':
      case 'nature':
        return LucideIcons.leaf;
      case 'sun':
        return LucideIcons.sun;
      case 'moon':
        return LucideIcons.moon;
      case 'star':
        return LucideIcons.star;
      case 'heartHandshake':
      case 'charity':
        return LucideIcons.heartHandshake;
      case 'target':
        return LucideIcons.target;
      case 'flag':
        return LucideIcons.flag;
      case 'crown':
      case 'premium':
        return LucideIcons.crown;
      case 'sparkles':
        return LucideIcons.sparkles;
      case 'rocket':
        return LucideIcons.rocket;

      // Anciens codes (compatibilité)
      case 'shield':
      case 'security':
      case 'emergency':
      case 'longTerm':
      case 'lightbulb':
        return LucideIcons.piggyBank;
      case 'beach_access':
        return LucideIcons.plane;
      case 'build':
        return LucideIcons.piggyBank;
      case 'local_hospital':
        return LucideIcons.heart;
      case 'sports_esports':
        return LucideIcons.gamepad2;
      case 'subscriptions':
        return LucideIcons.receipt;
      case 'category':
        return LucideIcons.folder;

      // Par défaut
      default:
        return LucideIcons.wallet;
    }
  }
}

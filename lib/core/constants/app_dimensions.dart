import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Dimensions et espacements standardisés de l'application Pocketly.
///
/// Utilise flutter_screenutil pour garantir la responsivité
/// sur différentes tailles d'écrans (mobile, tablet, desktop).
///
/// Suit les guidelines Material Design et Apple HIG.
class AppDimensions {
  // ==================== ESPACEMENTS RESPONSIFS ====================

  /// Espacement très petit (4dp) - Pour les micro-ajustements
  static double get paddingXS => 4.w;

  /// Espacement petit (8dp) - Pour les éléments proches
  static double get paddingS => 8.w;

  /// Espacement moyen (16dp) - Standard pour la plupart des cas
  static double get paddingM => 16.w;

  /// Espacement large (24dp) - Pour séparer les sections
  static double get paddingL => 24.w;

  /// Espacement très large (32dp) - Pour les grandes séparations
  static double get paddingXL => 32.w;

  /// Espacement énorme (48dp) - Pour les séparations majeures
  static double get paddingXXL => 48.w;

  // ==================== PADDING UNIVERSEL ====================

  /// Padding horizontal universel pour toutes les pages
  /// Adapté selon la plateforme (iOS: 16dp, Android: 16dp)
  static double get pageHorizontalPadding => 16.w;

  /// Padding vertical pour les pages
  static double get pageVerticalPadding => 16.h;

  /// Padding horizontal pour les cartes et widgets internes
  static double get cardHorizontalPadding => 16.w;

  /// Padding vertical pour les cartes
  static double get cardVerticalPadding => 16.h;

  // ==================== BORDURES ARRONDIES ====================

  /// Rayon de bordure très petit (4dp)
  static double get radiusXS => 4.r;

  /// Rayon de bordure petit (8dp)
  static double get radiusS => 8.r;

  /// Rayon de bordure moyen (12dp) - Standard pour les cartes
  static double get radiusM => 12.r;

  /// Rayon de bordure large (16dp) - Pour les modals
  static double get radiusL => 16.r;

  /// Rayon de bordure très large (24dp) - Pour les grandes cartes
  static double get radiusXL => 24.r;

  /// Rayon de bordure énorme (32dp) - Pour les éléments spéciaux
  static double get radiusXXL => 32.r;

  // ==================== HAUTEURS FIXES ====================

  /// Hauteur standard d'un bouton (48dp)
  static double get buttonHeight => 48.h;

  /// Hauteur d'un bouton petit (40dp)
  static double get buttonHeightSmall => 40.h;

  /// Hauteur d'un bouton large (56dp)
  static double get buttonHeightLarge => 56.h;

  /// Hauteur d'un champ de texte (56dp)
  static double get textFieldHeight => 56.h;

  /// Hauteur de l'AppBar (56dp)
  static double get appBarHeight => 56.h;

  /// Hauteur d'un élément de liste (72dp)
  static double get listItemHeight => 72.h;

  /// Hauteur d'un élément de liste petit (56dp)
  static double get listItemHeightSmall => 56.h;

  /// Hauteur d'un élément de liste large (88dp)
  static double get listItemHeightLarge => 88.h;

  // ==================== LARGEURS RESPONSIVES ====================

  /// Largeur maximale pour le contenu sur tablet/desktop (600dp)
  static double get maxContentWidth => 600.w;

  /// Largeur du drawer de navigation (280dp)
  static double get drawerWidth => 280.w;

  /// Largeur d'une carte standard
  static double get cardWidth => double.infinity;

  /// Largeur d'un bouton standard
  static double get buttonWidth => double.infinity;

  // ==================== ICÔNES RESPONSIVES ====================

  /// Taille d'icône très petite (12dp)
  static double get iconXS => 12.w;

  /// Taille d'icône petite (16dp)
  static double get iconS => 16.w;

  /// Taille d'icône moyenne (24dp) - Standard
  static double get iconM => 24.w;

  /// Taille d'icône large (32dp)
  static double get iconL => 32.w;

  /// Taille d'icône très large (48dp)
  static double get iconXL => 48.w;

  /// Taille d'icône énorme (64dp)
  static double get iconXXL => 64.w;

  // ==================== TEXTE RESPONSIF ====================

  /// Taille de police pour les labels (10dp)
  static double get fontSizeLabel => 10.sp;

  /// Taille de police pour le texte très petit (12dp)
  static double get fontSizeXS => 12.sp;

  /// Taille de police pour le texte petit (14dp)
  static double get fontSizeS => 14.sp;

  /// Taille de police pour le corps de texte (16dp) - Standard
  static double get fontSizeM => 16.sp;

  /// Taille de police pour le texte large (18dp)
  static double get fontSizeL => 18.sp;

  /// Taille de police pour les titres (20dp)
  static double get fontSizeTitle => 20.sp;

  /// Taille de police pour les gros titres (24dp)
  static double get fontSizeHeading => 24.sp;

  /// Taille de police pour les très gros titres (28dp)
  static double get fontSizeDisplay => 28.sp;

  /// Taille de police pour les titres énormes (32dp)
  static double get fontSizeHero => 32.sp;

  // ==================== ÉLÉVATIONS/OMBRES ====================

  /// Élévation pour les cartes (2dp)
  static const double elevationCard = 2.0;

  /// Élévation pour les boutons (4dp)
  static const double elevationButton = 4.0;

  /// Élévation pour les modals (8dp)
  static const double elevationModal = 8.0;

  /// Élévation pour les menus (12dp)
  static const double elevationMenu = 12.0;

  /// Élévation pour les FAB (6dp)
  static const double elevationFAB = 6.0;

  // ==================== BREAKPOINTS RESPONSIVES ====================

  /// Breakpoint pour mobile (< 600dp)
  static const double mobileBreakpoint = 600.0;

  /// Breakpoint pour tablet (600dp - 1200dp)
  static const double tabletBreakpoint = 1200.0;

  /// Breakpoint pour desktop (> 1200dp)
  static const double desktopBreakpoint = 1200.0;

  // ==================== ANIMATIONS ====================

  /// Durée d'animation courte (200ms)
  static const Duration animationShort = Duration(milliseconds: 200);

  /// Durée d'animation moyenne (300ms)
  static const Duration animationMedium = Duration(milliseconds: 300);

  /// Durée d'animation longue (500ms)
  static const Duration animationLong = Duration(milliseconds: 500);

  // ==================== TOUCH TARGETS ====================

  /// Taille minimale pour les zones tactiles (44dp iOS, 48dp Android)
  static double get minTouchTarget => 44.w;

  /// Taille recommandée pour les boutons (48dp)
  static double get recommendedTouchTarget => 48.w;
}

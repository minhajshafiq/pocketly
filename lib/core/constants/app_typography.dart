import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

/// Typographie standardisée de l'application Pocketly.
///
/// Suit les guidelines Material Design 3 et Apple HIG
/// pour garantir une cohérence typographique sur toutes les plateformes.
class AppTypography {
  // ==================== STYLES DE TEXTE RESPONSIFS ====================

  /// Style pour les labels (très petit texte)
  static TextStyle get label => GoogleFonts.inter(
    fontSize: 10.sp,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
    height: 1.2,
  );

  /// Style pour le texte très petit
  static TextStyle get caption => GoogleFonts.inter(
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
    height: 1.3,
  );

  /// Style pour le texte petit
  static TextStyle get small => GoogleFonts.inter(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
    height: 1.4,
  );

  /// Style pour le corps de texte (standard)
  static TextStyle get body => GoogleFonts.inter(
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.15,
    height: 1.5,
  );

  /// Style pour le corps de texte en gras
  static TextStyle get bodyBold => GoogleFonts.inter(
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.15,
    height: 1.5,
  );

  /// Style pour le texte large
  static TextStyle get large => GoogleFonts.inter(
    fontSize: 18.sp,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.15,
    height: 1.4,
  );

  /// Style pour les titres (H6)
  static TextStyle get title => GoogleFonts.inter(
    fontSize: 20.sp,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.15,
    height: 1.3,
  );

  /// Style pour les gros titres (H5)
  static TextStyle get heading => GoogleFonts.inter(
    fontSize: 24.sp,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.0,
    height: 1.2,
  );

  /// Style pour les très gros titres (H4)
  static TextStyle get display => GoogleFonts.inter(
    fontSize: 28.sp,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.25,
    height: 1.1,
  );

  /// Style pour les titres héro (H1)
  static TextStyle get hero => GoogleFonts.inter(
    fontSize: 32.sp,
    fontWeight: FontWeight.w800,
    letterSpacing: -0.5,
    height: 1.0,
  );

  // ==================== STYLES SPÉCIALISÉS ====================

  /// Style pour les boutons
  static TextStyle get button => GoogleFonts.inter(
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
    height: 1.2,
  );

  /// Style pour les boutons petits
  static TextStyle get buttonSmall => GoogleFonts.inter(
    fontSize: 14.sp,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
    height: 1.2,
  );

  /// Style pour les boutons larges
  static TextStyle get buttonLarge => GoogleFonts.inter(
    fontSize: 18.sp,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
    height: 1.2,
  );

  /// Style pour les liens
  static TextStyle get link => GoogleFonts.inter(
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.15,
    height: 1.5,
    decoration: TextDecoration.underline,
  );

  /// Style pour les codes/monospace
  static TextStyle get code => GoogleFonts.inter(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.0,
    height: 1.4,
  );

  // ==================== STYLES PLATEFORME SPÉCIFIQUES ====================

  /// Style iOS pour les titres de navigation
  static TextStyle get iosNavTitle => GoogleFonts.inter(
    fontSize: 17.sp,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.41,
    height: 1.2,
  );

  /// Style iOS pour les boutons
  static TextStyle get iosButton => GoogleFonts.inter(
    fontSize: 17.sp,
    fontWeight: FontWeight.w400,
    letterSpacing: -0.41,
    height: 1.2,
  );

  /// Style iOS pour les cellules de liste
  static TextStyle get iosListCell => GoogleFonts.inter(
    fontSize: 17.sp,
    fontWeight: FontWeight.w400,
    letterSpacing: -0.41,
    height: 1.2,
  );

  /// Style Material pour les titres d'AppBar
  static TextStyle get materialAppBarTitle => GoogleFonts.inter(
    fontSize: 20.sp,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.0,
    height: 1.2,
  );

  /// Style Material pour les boutons
  static TextStyle get materialButton => GoogleFonts.inter(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    letterSpacing: 1.25,
    height: 1.2,
  );

  // ==================== STYLES THÉMATIQUES ====================

  /// Style pour les montants d'argent
  static TextStyle get money => GoogleFonts.inter(
    fontSize: 18.sp,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.0,
    height: 1.2,
  );

  /// Style pour les montants d'argent grands
  static TextStyle get moneyLarge => GoogleFonts.inter(
    fontSize: 24.sp,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.5,
    height: 1.1,
  );

  /// Style pour les dates
  static TextStyle get date => GoogleFonts.inter(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
    height: 1.3,
  );

  /// Style pour les descriptions
  static TextStyle get description => GoogleFonts.inter(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
    height: 1.4,
  );

  // ==================== STYLES D'ÉTAT ====================

  /// Style pour les messages de succès
  static TextStyle get success => GoogleFonts.inter(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.25,
    height: 1.3,
  );

  /// Style pour les messages d'erreur
  static TextStyle get error => GoogleFonts.inter(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.25,
    height: 1.3,
  );

  /// Style pour les messages d'avertissement
  static TextStyle get warning => GoogleFonts.inter(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.25,
    height: 1.3,
  );

  /// Style pour les messages d'information
  static TextStyle get info => GoogleFonts.inter(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.25,
    height: 1.3,
  );

  // ==================== STYLES D'ACCESSIBILITÉ ====================

  /// Style pour les textes d'accessibilité
  static TextStyle get accessibility => GoogleFonts.inter(
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
    height: 1.5,
  );

  /// Style pour les labels d'accessibilité
  static TextStyle get accessibilityLabel => GoogleFonts.inter(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.25,
    height: 1.3,
  );
}

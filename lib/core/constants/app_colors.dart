import 'package:flutter/cupertino.dart';

/// Couleurs standardisées de l'application Pocketly.
/// 
/// Suit les guidelines Material Design 3 et Apple HIG
/// pour garantir une cohérence visuelle sur toutes les plateformes.
class AppColors {
  // ==================== COULEURS PRIMAIRES ====================
  
  /// Couleur primaire de l'application (Indigo)
  static const Color primary = Color(0xFF6366F1);
  
  /// Couleur primaire variant (Indigo clair)
  static const Color primaryLight = Color(0xFF818CF8);
  
  /// Couleur primaire sombre (Indigo foncé)
  static const Color primaryDark = Color(0xFF4F46E5);
  
  /// Couleur secondaire (Violet)
  static const Color secondary = Color(0xFF8B5CF6);
  
  /// Couleur secondaire claire
  static const Color secondaryLight = Color(0xFFA78BFA);
  
  /// Couleur secondaire sombre
  static const Color secondaryDark = Color(0xFF7C3AED);

  // ==================== COULEURS DE SURFACE ====================
  
  /// Couleur de fond principale (Light mode)
  static const Color background = Color(0xFFF8FAFC);
  
  /// Couleur de surface (cartes, modals) (Light mode)
  static const Color surface = Color(0xFFFFFFFF);
  
  /// Couleur de surface variant (Light mode)
  static const Color surfaceVariant = Color(0xFFF8FAFC);
  
  /// Couleur de surface sombre (Dark mode)
  static const Color surfaceDark = Color(0xFF2A2A2A);
  
  /// Couleur de fond sombre (Dark mode)
  static const Color backgroundDark = Color(0xFF121212);

  // ==================== COULEURS DE TEXTE ====================
  
  /// Couleur de texte principal (Light mode)
  static const Color textPrimary = Color(0xFF1E293B);
  
  /// Couleur de texte secondaire (Light mode)
  static const Color textSecondary = Color(0xFF64748B);
  
  /// Couleur de texte tertiaire (Light mode)
  static const Color textTertiary = Color(0xFF94A3B8);
  
  /// Couleur de texte sur fond sombre (Dark mode)
  static const Color textOnDark = Color(0xFFFFFFFF);
  
  /// Couleur de texte secondaire sur fond sombre (Dark mode)
  static const Color textSecondaryOnDark = Color(0xFFAAAAAA);
  
  /// Couleur de texte tertiaire sur fond sombre (Dark mode)
  static const Color textTertiaryOnDark = Color(0xFFAAAAAA);

  // ==================== COULEURS D'ÉTAT ====================
  
  /// Couleur de succès (Vert)
  static const Color success = Color(0xFF10B981);
  
  /// Couleur de succès claire
  static const Color successLight = Color(0xFF34D399);
  
  /// Couleur de succès sombre
  static const Color successDark = Color(0xFF059669);
  
  /// Couleur d'avertissement (Orange)
  static const Color warning = Color(0xFFF59E0B);
  
  /// Couleur d'avertissement claire
  static const Color warningLight = Color(0xFFFBBF24);
  
  /// Couleur d'avertissement sombre
  static const Color warningDark = Color(0xFFD97706);
  
  /// Couleur d'erreur (Rouge)
  static const Color error = Color(0xFFEF4444);
  
  /// Couleur d'erreur claire
  static const Color errorLight = Color(0xFFF87171);
  
  /// Couleur d'erreur sombre
  static const Color errorDark = Color(0xFFDC2626);
  
  /// Couleur d'information (Bleu)
  static const Color info = Color(0xFF3B82F6);
  
  /// Couleur d'information claire
  static const Color infoLight = Color(0xFF60A5FA);
  
  /// Couleur d'information sombre
  static const Color infoDark = Color(0xFF2563EB);

  // ==================== COULEURS NEUTRES ====================
  
  /// Gris très clair
  static const Color grey50 = Color(0xFFF9FAFB);
  
  /// Gris clair
  static const Color grey100 = Color(0xFFF3F4F6);
  
  /// Gris moyen clair
  static const Color grey200 = Color(0xFFE5E7EB);
  
  /// Gris moyen
  static const Color grey300 = Color(0xFFD1D5DB);
  
  /// Gris moyen foncé
  static const Color grey400 = Color(0xFF9CA3AF);
  
  /// Gris foncé
  static const Color grey500 = Color(0xFF6B7280);
  
  /// Gris très foncé
  static const Color grey600 = Color(0xFF4B5563);
  
  /// Gris sombre
  static const Color grey700 = Color(0xFF374151);
  
  /// Gris très sombre
  static const Color grey800 = Color(0xFF1F2937);
  
  /// Gris noir
  static const Color grey900 = Color(0xFF111827);

  // ==================== COULEURS SPÉCIALES ====================
  
  /// Couleur de l'argent/monnaie
  static const Color money = Color(0xFF10B981);
  
  /// Couleur de dépense
  static const Color expense = Color(0xFFEF4444);
  
  /// Couleur de revenu
  static const Color income = Color(0xFF10B981);
  
  /// Couleur de transfert
  static const Color transfer = Color(0xFF3B82F6);

  // ==================== COULEURS IOS (CUPERTINO) ====================
  
  /// Bleu système iOS
  static const Color iosBlue = CupertinoColors.systemBlue;
  
  /// Vert système iOS
  static const Color iosGreen = CupertinoColors.systemGreen;
  
  /// Orange système iOS
  static const Color iosOrange = CupertinoColors.systemOrange;
  
  /// Rouge système iOS
  static const Color iosRed = CupertinoColors.systemRed;
  
  /// Violet système iOS
  static const Color iosPurple = CupertinoColors.systemPurple;
  
  /// Teal système iOS
  static const Color iosTeal = CupertinoColors.systemTeal;
  
  /// Indigo système iOS
  static const Color iosIndigo = CupertinoColors.systemIndigo;
  
  /// Gris système iOS
  static const Color iosGrey = CupertinoColors.systemGrey;

  // ==================== COULEURS DE THÈME ====================
  
  /// Couleur d'accent (pour les éléments importants)
  static const Color accent = primary;
  
  /// Couleur de focus (pour les éléments sélectionnés)
  static const Color focus = primaryLight;
  
  /// Couleur de hover (pour les interactions)
  static Color get hover => primaryLight.withValues(alpha: 0.1);
  
  /// Couleur de sélection
  static Color get selection => primaryLight.withValues(alpha: 0.2);

  // ==================== COULEURS DE BORDURE ====================
  
  /// Couleur de bordure claire
  static const Color borderLight = Color(0xFFE5E7EB);
  
  /// Couleur de bordure moyenne
  static const Color borderMedium = Color(0xFFD1D5DB);
  
  /// Couleur de bordure foncée
  static const Color borderDark = Color(0xFF9CA3AF);
  
  /// Couleur de bordure focus
  static const Color borderFocus = primary;

  // ==================== COULEURS DE DÉGRADÉ ====================
  
  /// Dégradé primaire
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, primaryLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  /// Dégradé secondaire
  static const LinearGradient secondaryGradient = LinearGradient(
    colors: [secondary, secondaryLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  /// Dégradé de succès
  static const LinearGradient successGradient = LinearGradient(
    colors: [success, successLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  /// Dégradé d'erreur
  static const LinearGradient errorGradient = LinearGradient(
    colors: [error, errorLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

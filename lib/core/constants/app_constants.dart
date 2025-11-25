/// Constantes globales de l'application Pocketly.
///
/// Contient les valeurs constantes utilisées dans toute l'application.
class AppConstants {
  AppConstants._();

  // ==================== VERSION ====================
  static const String appName = 'Pocketly';
  static const String appVersion = '1.0.0';
  static const String buildNumber = '1';

  // ==================== API ====================
  static const String apiBaseUrl = 'https://api.pocketly.com';
  static const Duration apiTimeout = Duration(seconds: 30);
  static const int maxRetries = 3;

  // ==================== CACHE ====================
  static const Duration cacheLifetime = Duration(hours: 24);
  static const int maxCacheSize = 50 * 1024 * 1024; // 50 MB

  // ==================== UI ====================
  static const double defaultPadding = 16.0;
  static const double defaultRadius = 12.0;
  static const Duration animationDuration = Duration(milliseconds: 300);

  // ==================== VALIDATION ====================
  static const int minPasswordLength = 8;
  static const int maxPasswordLength = 128;
  static const int minNameLength = 2;
  static const int maxNameLength = 50;

  // ==================== PREMIUM ====================
  static const int trialDays = 14;
  static const double premiumPrice = 9.99;
  static const String premiumCurrency = 'EUR';

  // ==================== NOTIFICATIONS ====================
  static const Duration notificationDelay = Duration(seconds: 2);
  static const int maxNotifications = 5;

  // ==================== FILES ====================
  static const int maxFileSize = 10 * 1024 * 1024; // 10 MB
  static const List<String> allowedImageTypes = ['jpg', 'jpeg', 'png', 'webp'];
  static const List<String> allowedDocumentTypes = [
    'pdf',
    'doc',
    'docx',
    'txt',
  ];
}

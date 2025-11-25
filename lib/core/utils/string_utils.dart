/// Utilitaires pour la manipulation des chaînes de caractères.
///
/// Fournit des fonctions helper pour formater, valider et manipuler les strings.
class StringUtils {
  StringUtils._();

  /// Capitalise la première lettre d'une chaîne
  static String capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }

  /// Capitalise chaque mot d'une chaîne
  static String capitalizeWords(String text) {
    if (text.isEmpty) return text;
    return text.split(' ').map((word) => capitalize(word)).join(' ');
  }

  /// Supprime les espaces en début et fin, et normalise les espaces multiples
  static String normalize(String text) {
    return text.trim().replaceAll(RegExp(r'\s+'), ' ');
  }

  /// Tronque une chaîne à une longueur donnée avec des points de suspension
  static String truncate(String text, int maxLength, {String suffix = '...'}) {
    if (text.length <= maxLength) return text;
    return text.substring(0, maxLength - suffix.length) + suffix;
  }

  /// Vérifie si une chaîne est vide ou ne contient que des espaces
  static bool isEmpty(String? text) {
    return text == null || text.trim().isEmpty;
  }

  /// Vérifie si une chaîne n'est pas vide
  static bool isNotEmpty(String? text) {
    return !isEmpty(text);
  }

  /// Supprime tous les caractères non alphanumériques
  static String removeSpecialCharacters(String text) {
    return text.replaceAll(RegExp(r'[^a-zA-Z0-9\s]'), '');
  }

  /// Supprime tous les espaces
  static String removeSpaces(String text) {
    return text.replaceAll(' ', '');
  }

  /// Remplace les caractères accentués par leurs équivalents non accentués
  static String removeAccents(String text) {
    const accents = 'ÀÁÂÃÄÅàáâãäåÒÓÔÕÖØòóôõöøÈÉÊËèéêëÌÍÎÏìíîïÙÚÛÜùúûüÇçÑñ';
    const noAccents = 'AAAAAAaaaaaaOOOOOOooooooEEEEeeeeIIIIiiiiUUUUuuuuCcNn';

    String result = text;
    for (int i = 0; i < accents.length; i++) {
      result = result.replaceAll(accents[i], noAccents[i]);
    }
    return result;
  }

  /// Génère un slug à partir d'une chaîne (pour URLs)
  static String toSlug(String text) {
    return removeAccents(text)
        .toLowerCase()
        .replaceAll(RegExp(r'[^a-z0-9\s-]'), '')
        .replaceAll(RegExp(r'\s+'), '-')
        .replaceAll(RegExp(r'-+'), '-')
        .trim();
  }

  /// Masque une partie d'un email (ex: "j***@example.com")
  static String maskEmail(String email) {
    if (!email.contains('@')) return email;

    final parts = email.split('@');
    final username = parts[0];
    final domain = parts[1];

    if (username.length <= 2) {
      return '${username[0]}*@$domain';
    }

    final maskedUsername =
        '${username[0]}${'*' * (username.length - 2)}${username[username.length - 1]}';
    return '$maskedUsername@$domain';
  }

  /// Masque un numéro de téléphone (ex: "06 ** ** 12 34")
  static String maskPhone(String phone) {
    final digits = phone.replaceAll(RegExp(r'[^\d]'), '');
    if (digits.length < 4) return phone;

    final visible = digits.substring(digits.length - 4);
    final masked = '*' * (digits.length - 4);

    return phone.replaceAll(digits, '$masked$visible');
  }

  /// Formate un numéro de téléphone français
  static String formatFrenchPhone(String phone) {
    final digits = phone.replaceAll(RegExp(r'[^\d]'), '');

    if (digits.length == 10 && digits.startsWith('0')) {
      return '${digits.substring(0, 2)} ${digits.substring(2, 4)} ${digits.substring(4, 6)} ${digits.substring(6, 8)} ${digits.substring(8, 10)}';
    }

    return phone;
  }

  /// Vérifie si une chaîne contient uniquement des lettres
  static bool isAlpha(String text) {
    return RegExp(r'^[a-zA-ZÀ-ÿ\s]+$').hasMatch(text);
  }

  /// Vérifie si une chaîne contient uniquement des chiffres
  static bool isNumeric(String text) {
    return RegExp(r'^[0-9]+$').hasMatch(text);
  }

  /// Vérifie si une chaîne contient uniquement des lettres et chiffres
  static bool isAlphaNumeric(String text) {
    return RegExp(r'^[a-zA-Z0-9À-ÿ\s]+$').hasMatch(text);
  }

  /// Vérifie si une chaîne est un email valide
  static bool isValidEmail(String email) {
    return RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    ).hasMatch(email);
  }

  /// Vérifie si une chaîne est un numéro de téléphone français valide
  static bool isValidFrenchPhone(String phone) {
    final digits = phone.replaceAll(RegExp(r'[^\d]'), '');
    return digits.length == 10 && digits.startsWith('0');
  }

  /// Génère un mot de passe aléatoire
  static String generatePassword({
    int length = 12,
    bool includeSymbols = true,
  }) {
    const letters = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
    const numbers = '0123456789';
    const symbols = '!@#\$%^&*()_+-=[]{}|;:,.<>?';

    String chars = letters + numbers;
    if (includeSymbols) chars += symbols;

    final random = DateTime.now().millisecondsSinceEpoch;
    String password = '';

    for (int i = 0; i < length; i++) {
      password += chars[random % chars.length];
    }

    return password;
  }

  /// Génère un identifiant unique simple
  static String generateId({int length = 8}) {
    const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    final random = DateTime.now().millisecondsSinceEpoch;
    String id = '';

    for (int i = 0; i < length; i++) {
      id += chars[random % chars.length];
    }

    return id;
  }

  /// Compte le nombre de mots dans une chaîne
  static int wordCount(String text) {
    if (text.trim().isEmpty) return 0;
    return text.trim().split(RegExp(r'\s+')).length;
  }

  /// Extrait les mots-clés d'une chaîne (mots de plus de 2 caractères)
  static List<String> extractKeywords(String text) {
    return text
        .toLowerCase()
        .replaceAll(RegExp(r'[^\w\s]'), '')
        .split(RegExp(r'\s+'))
        .where((word) => word.length > 2)
        .toSet()
        .toList();
  }

  /// Vérifie si une chaîne contient un mot spécifique (insensible à la casse)
  static bool containsWord(String text, String word) {
    return text.toLowerCase().contains(word.toLowerCase());
  }

  /// Remplace les caractères spéciaux par des espaces
  static String replaceSpecialCharsWithSpaces(String text) {
    return text.replaceAll(RegExp(r'[^\w\s]'), ' ');
  }

  /// Formate un nombre avec des espaces comme séparateurs de milliers
  static String formatNumber(int number) {
    return number.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match match) => '${match[1]} ',
    );
  }

  /// Formate une taille de fichier en format lisible
  static String formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    if (bytes < 1024 * 1024 * 1024)
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
  }
}

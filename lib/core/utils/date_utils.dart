/// Utilitaires pour la manipulation des dates.
///
/// Fournit des fonctions helper pour formater, comparer et manipuler les dates.
class DateUtils {
  DateUtils._();

  /// Formate une date en français (ex: "15 janvier 2024")
  static String formatDateFrench(DateTime date) {
    const months = [
      'janvier',
      'février',
      'mars',
      'avril',
      'mai',
      'juin',
      'juillet',
      'août',
      'septembre',
      'octobre',
      'novembre',
      'décembre',
    ];

    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

  /// Formate une date en format court (ex: "15/01/2024")
  static String formatDateShort(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  /// Formate une date en format ISO (ex: "2024-01-15")
  static String formatDateISO(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  /// Formate une date relative (ex: "il y a 2 jours", "dans 3 heures")
  static String formatDateRelative(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 0) {
      return 'il y a ${difference.inDays} jour${difference.inDays > 1 ? 's' : ''}';
    } else if (difference.inHours > 0) {
      return 'il y a ${difference.inHours} heure${difference.inHours > 1 ? 's' : ''}';
    } else if (difference.inMinutes > 0) {
      return 'il y a ${difference.inMinutes} minute${difference.inMinutes > 1 ? 's' : ''}';
    } else {
      return 'à l\'instant';
    }
  }

  /// Vérifie si une date est aujourd'hui
  static bool isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  /// Vérifie si une date est hier
  static bool isYesterday(DateTime date) {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return date.year == yesterday.year &&
        date.month == yesterday.month &&
        date.day == yesterday.day;
  }

  /// Vérifie si une date est demain
  static bool isTomorrow(DateTime date) {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return date.year == tomorrow.year &&
        date.month == tomorrow.month &&
        date.day == tomorrow.day;
  }

  /// Calcule l'âge en années
  static int calculateAge(DateTime birthDate) {
    final now = DateTime.now();
    int age = now.year - birthDate.year;

    if (now.month < birthDate.month ||
        (now.month == birthDate.month && now.day < birthDate.day)) {
      age--;
    }

    return age;
  }

  /// Vérifie si une date est dans le futur
  static bool isFuture(DateTime date) {
    return date.isAfter(DateTime.now());
  }

  /// Vérifie si une date est dans le passé
  static bool isPast(DateTime date) {
    return date.isBefore(DateTime.now());
  }

  /// Obtient le début de la journée
  static DateTime startOfDay(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  /// Obtient la fin de la journée
  static DateTime endOfDay(DateTime date) {
    return DateTime(date.year, date.month, date.day, 23, 59, 59, 999);
  }

  /// Obtient le début de la semaine (lundi)
  static DateTime startOfWeek(DateTime date) {
    final weekday = date.weekday;
    return date.subtract(Duration(days: weekday - 1));
  }

  /// Obtient la fin de la semaine (dimanche)
  static DateTime endOfWeek(DateTime date) {
    final weekday = date.weekday;
    return date.add(Duration(days: 7 - weekday));
  }

  /// Obtient le début du mois
  static DateTime startOfMonth(DateTime date) {
    return DateTime(date.year, date.month, 1);
  }

  /// Obtient la fin du mois
  static DateTime endOfMonth(DateTime date) {
    return DateTime(date.year, date.month + 1, 0);
  }

  /// Obtient le début de l'année
  static DateTime startOfYear(DateTime date) {
    return DateTime(date.year, 1, 1);
  }

  /// Obtient la fin de l'année
  static DateTime endOfYear(DateTime date) {
    return DateTime(date.year, 12, 31);
  }

  /// Ajoute des jours ouvrables (exclut les weekends)
  static DateTime addBusinessDays(DateTime date, int days) {
    DateTime result = date;
    int addedDays = 0;

    while (addedDays < days) {
      result = result.add(const Duration(days: 1));
      if (result.weekday < 6) {
        // Lundi = 1, Vendredi = 5
        addedDays++;
      }
    }

    return result;
  }

  /// Calcule le nombre de jours ouvrables entre deux dates
  static int businessDaysBetween(DateTime start, DateTime end) {
    int count = 0;
    DateTime current = start;

    while (current.isBefore(end)) {
      if (current.weekday < 6) {
        // Lundi = 1, Vendredi = 5
        count++;
      }
      current = current.add(const Duration(days: 1));
    }

    return count;
  }
}

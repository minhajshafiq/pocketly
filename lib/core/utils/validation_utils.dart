import 'package:pocketly/core/errors/errors.dart';

/// Utilitaires pour la validation de données.
///
/// Fournit des fonctions helper pour valider différents types de données.
class ValidationUtils {
  ValidationUtils._();

  /// Valide un email
  static void validateEmail(String email) {
    if (email.trim().isEmpty) {
      throw ValidationError(
        field: 'email',
        userMessage: 'L\'email ne peut pas être vide',
      );
    }

    if (email.length > 254) {
      throw ValidationError(
        field: 'email',
        userMessage: 'L\'email ne peut pas dépasser 254 caractères',
      );
    }

    if (!RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    ).hasMatch(email)) {
      throw ValidationError(
        field: 'email',
        userMessage: 'L\'email n\'est pas valide',
      );
    }
  }

  /// Valide un mot de passe
  static void validatePassword(String password) {
    if (password.isEmpty) {
      throw ValidationError(
        field: 'password',
        userMessage: 'Le mot de passe ne peut pas être vide',
      );
    }

    if (password.length < 8) {
      throw ValidationError(
        field: 'password',
        userMessage: 'Le mot de passe doit contenir au moins 8 caractères',
      );
    }

    if (password.length > 128) {
      throw ValidationError(
        field: 'password',
        userMessage: 'Le mot de passe ne peut pas dépasser 128 caractères',
      );
    }
  }

  /// Valide un nom
  static void validateName(String? name) {
    if (name == null || name.trim().isEmpty) {
      return; // Le nom est optionnel
    }

    if (name.trim().length < 2) {
      throw ValidationError(
        field: 'name',
        userMessage: 'Le nom doit contenir au moins 2 caractères',
      );
    }

    if (name.trim().length > 50) {
      throw ValidationError(
        field: 'name',
        userMessage: 'Le nom ne peut pas dépasser 50 caractères',
      );
    }
  }

  /// Valide un numéro de téléphone français
  static void validateFrenchPhone(String phone) {
    if (phone.trim().isEmpty) {
      throw ValidationError(
        field: 'phone',
        userMessage: 'Le numéro de téléphone ne peut pas être vide',
      );
    }

    final digits = phone.replaceAll(RegExp(r'[^\d]'), '');

    if (digits.length != 10) {
      throw ValidationError(
        field: 'phone',
        userMessage: 'Le numéro de téléphone doit contenir 10 chiffres',
      );
    }

    if (!digits.startsWith('0')) {
      throw ValidationError(
        field: 'phone',
        userMessage: 'Le numéro de téléphone doit commencer par 0',
      );
    }
  }

  /// Valide une URL
  static void validateUrl(String url) {
    if (url.trim().isEmpty) {
      throw ValidationError(
        field: 'url',
        userMessage: 'L\'URL ne peut pas être vide',
      );
    }

    if (url.length > 500) {
      throw ValidationError(
        field: 'url',
        userMessage: 'L\'URL ne peut pas dépasser 500 caractères',
      );
    }
  }

  /// Valide un âge
  static void validateAge(int age) {
    if (age < 0) {
      throw ValidationError(
        field: 'age',
        userMessage: 'L\'âge ne peut pas être négatif',
      );
    }

    if (age > 150) {
      throw ValidationError(
        field: 'age',
        userMessage: 'L\'âge ne peut pas dépasser 150 ans',
      );
    }
  }

  /// Valide un pourcentage
  static void validatePercentage(double percentage) {
    if (percentage < 0) {
      throw ValidationError(
        field: 'percentage',
        userMessage: 'Le pourcentage ne peut pas être négatif',
      );
    }

    if (percentage > 100) {
      throw ValidationError(
        field: 'percentage',
        userMessage: 'Le pourcentage ne peut pas dépasser 100%',
      );
    }
  }

  /// Valide une date de naissance
  static void validateBirthDate(DateTime birthDate) {
    final now = DateTime.now();

    if (birthDate.isAfter(now)) {
      throw ValidationError(
        field: 'birthDate',
        userMessage: 'La date de naissance ne peut pas être dans le futur',
      );
    }

    final age = now.year - birthDate.year;
    if (age < 13) {
      throw ValidationError(
        field: 'birthDate',
        userMessage: 'L\'utilisateur doit avoir au moins 13 ans',
      );
    }
  }

  /// Valide un montant monétaire
  static void validateAmount(double amount) {
    if (amount < 0) {
      throw ValidationError(
        field: 'amount',
        userMessage: 'Le montant ne peut pas être négatif',
      );
    }

    if (amount > 1000000) {
      throw ValidationError(
        field: 'amount',
        userMessage: 'Le montant ne peut pas dépasser 1 000 000€',
      );
    }
  }

  /// Valide un code postal français
  static void validateFrenchPostalCode(String postalCode) {
    if (postalCode.trim().isEmpty) {
      throw ValidationError(
        field: 'postalCode',
        userMessage: 'Le code postal ne peut pas être vide',
      );
    }

    final digits = postalCode.replaceAll(RegExp(r'[^\d]'), '');

    if (digits.length != 5) {
      throw ValidationError(
        field: 'postalCode',
        userMessage: 'Le code postal doit contenir 5 chiffres',
      );
    }
  }

  /// Valide un IBAN français
  static void validateFrenchIBAN(String iban) {
    if (iban.trim().isEmpty) {
      throw ValidationError(
        field: 'iban',
        userMessage: 'L\'IBAN ne peut pas être vide',
      );
    }

    final cleanIban = iban.replaceAll(RegExp(r'[^\w]'), '').toUpperCase();

    if (cleanIban.length != 27) {
      throw ValidationError(
        field: 'iban',
        userMessage: 'L\'IBAN français doit contenir 27 caractères',
      );
    }

    if (!cleanIban.startsWith('FR')) {
      throw ValidationError(
        field: 'iban',
        userMessage: 'L\'IBAN doit commencer par FR',
      );
    }
  }

  /// Valide un SIRET
  static void validateSIRET(String siret) {
    if (siret.trim().isEmpty) {
      throw ValidationError(
        field: 'siret',
        userMessage: 'Le SIRET ne peut pas être vide',
      );
    }

    final digits = siret.replaceAll(RegExp(r'[^\d]'), '');

    if (digits.length != 14) {
      throw ValidationError(
        field: 'siret',
        userMessage: 'Le SIRET doit contenir 14 chiffres',
      );
    }
  }

  /// Valide une couleur hexadécimale
  static void validateHexColor(String color) {
    if (color.trim().isEmpty) {
      throw ValidationError(
        field: 'color',
        userMessage: 'La couleur ne peut pas être vide',
      );
    }

    if (!RegExp(r'^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$').hasMatch(color)) {
      throw ValidationError(
        field: 'color',
        userMessage:
            'La couleur doit être au format hexadécimal (#RRGGBB ou #RGB)',
      );
    }
  }

  /// Valide une version (format X.Y.Z)
  static void validateVersion(String version) {
    if (version.trim().isEmpty) {
      throw ValidationError(
        field: 'version',
        userMessage: 'La version ne peut pas être vide',
      );
    }

    if (!RegExp(r'^\d+\.\d+\.\d+(-[a-zA-Z0-9]+)?$').hasMatch(version)) {
      throw ValidationError(
        field: 'version',
        userMessage: 'La version doit suivre le format X.Y.Z (ex: 1.0.0)',
      );
    }
  }

  /// Valide un UUID
  static void validateUUID(String uuid) {
    if (uuid.trim().isEmpty) {
      throw ValidationError(
        field: 'uuid',
        userMessage: 'L\'UUID ne peut pas être vide',
      );
    }

    if (!RegExp(
      r'^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$',
      caseSensitive: false,
    ).hasMatch(uuid)) {
      throw ValidationError(
        field: 'uuid',
        userMessage: 'L\'UUID n\'est pas valide',
      );
    }
  }

  /// Valide une longueur de chaîne
  static void validateStringLength(
    String text,
    String fieldName, {
    int? minLength,
    int? maxLength,
  }) {
    if (text.trim().isEmpty && minLength != null && minLength > 0) {
      throw ValidationError(
        field: fieldName,
        userMessage: 'Le champ ne peut pas être vide',
      );
    }

    if (minLength != null && text.length < minLength) {
      throw ValidationError(
        field: fieldName,
        userMessage: 'Le champ doit contenir au moins $minLength caractères',
      );
    }

    if (maxLength != null && text.length > maxLength) {
      throw ValidationError(
        field: fieldName,
        userMessage: 'Le champ ne peut pas dépasser $maxLength caractères',
      );
    }
  }

  /// Valide qu'une valeur n'est pas nulle
  static void validateNotNull<T>(T? value, String fieldName) {
    if (value == null) {
      throw ValidationError(
        field: fieldName,
        userMessage: 'Le champ ne peut pas être vide',
      );
    }
  }

  /// Valide qu'une liste n'est pas vide
  static void validateListNotEmpty<T>(List<T> list, String fieldName) {
    if (list.isEmpty) {
      throw ValidationError(
        field: fieldName,
        userMessage: 'La liste ne peut pas être vide',
      );
    }
  }

  /// Valide qu'une valeur est dans une plage donnée
  static void validateRange<T extends num>(
    T value,
    String fieldName,
    T min,
    T max,
  ) {
    if (value < min) {
      throw ValidationError(
        field: fieldName,
        userMessage: 'La valeur doit être au moins $min',
      );
    }

    if (value > max) {
      throw ValidationError(
        field: fieldName,
        userMessage: 'La valeur ne peut pas dépasser $max',
      );
    }
  }
}

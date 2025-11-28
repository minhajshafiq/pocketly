import 'package:pocketly/core/errors/errors.dart';
import '../entities/transaction_entity.dart';

/// Use case pour valider les données d'une transaction
class ValidateTransactionUseCase {
  /// Valide les données de la transaction selon les contraintes du schéma SQL
  static void validate({
    required String name,
    required double amount,
    required String categoryId,
    required String userId,
    required RecurrenceType recurrence,
    DateTime? recurrenceEndDate,
    int? recurrenceDayOfMonth,
  }) {
    // Validation du nom (non vide)
    if (name.trim().isEmpty) {
      throw const ValidationError(
        field: 'name',
        userMessage: 'Le nom ne peut pas être vide',
        technicalMessage: 'Transaction name is required',
      );
    }

    // Validation du montant (positif et dans la plage DECIMAL(10,2))
    if (amount <= 0) {
      throw ValidationError(
        field: 'amount',
        userMessage: 'Le montant doit être positif',
        technicalMessage: 'Amount must be positive: $amount',
      );
    }
    if (amount > 99999999.99) {
      throw ValidationError(
        field: 'amount',
        userMessage: 'Le montant ne peut pas dépasser 99,999,999.99',
        technicalMessage: 'Amount exceeds maximum: $amount > 99999999.99',
      );
    }

    // Validation de l'ID de catégorie (non vide UUID)
    if (categoryId.trim().isEmpty) {
      throw const ValidationError(
        field: 'categoryId',
        userMessage: 'L\'ID de catégorie ne peut pas être vide',
        technicalMessage: 'Category ID is required',
      );
    }

    // Validation de l'ID utilisateur (non vide)
    if (userId.isEmpty) {
      throw const ValidationError(
        field: 'userId',
        userMessage: 'L\'ID utilisateur ne peut pas être vide',
        technicalMessage: 'User ID is required',
      );
    }

    // Validation du jour du mois (1-31)
    if (recurrenceDayOfMonth != null && (recurrenceDayOfMonth < 1 || recurrenceDayOfMonth > 31)) {
      throw ValidationError(
        field: 'recurrenceDayOfMonth',
        userMessage: 'Le jour du mois doit être entre 1 et 31',
        technicalMessage: 'Invalid day of month: $recurrenceDayOfMonth',
      );
    }

    // Validation des contraintes de récurrence
    _validateRecurrenceConstraints(
      recurrence: recurrence,
      recurrenceEndDate: recurrenceEndDate,
    );
  }

  /// Valide les contraintes de récurrence selon le schéma SQL
  static void _validateRecurrenceConstraints({
    required RecurrenceType recurrence,
    DateTime? recurrenceEndDate,
  }) {
    if (recurrence == RecurrenceType.none) {
      // Si pas de récurrence, pas de date de fin
      if (recurrenceEndDate != null) {
        throw const ValidationError(
          field: 'recurrenceEndDate',
          userMessage: 'Une transaction non récurrente ne peut pas avoir de date de fin',
          technicalMessage: 'Recurrence end date not allowed for non-recurring transactions',
        );
      }
    } else {
      // Si récurrence, validation des dates
      if (recurrenceEndDate != null) {
        final now = DateTime.now();
        if (recurrenceEndDate.isBefore(now)) {
          throw ValidationError(
            field: 'recurrenceEndDate',
            userMessage: 'La date de fin de récurrence ne peut pas être dans le passé',
            technicalMessage: 'Recurrence end date is in the past: $recurrenceEndDate',
          );
        }
      }
    }
  }
}

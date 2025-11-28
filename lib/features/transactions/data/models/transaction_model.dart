import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/transaction_entity.dart';

part 'transaction_model.freezed.dart';
part 'transaction_model.g.dart';

/// Model pour les transactions (Freezed)
@freezed
sealed class TransactionModel with _$TransactionModel {
  const factory TransactionModel({
    String? id,
    required String name,
    required double amount,
    required DateTime date,
    @JsonKey(name: 'category_id') required String categoryId,
    required TransactionType type,
    @Default(RecurrenceType.none) RecurrenceType recurrence,
    @JsonKey(name: 'image_url') String? imageUrl,
    String? notes,
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'pocket_id') String? pocketId,
    @JsonKey(name: 'recurrence_group_id') int? recurrenceGroupId,
    @JsonKey(name: 'recurrence_start_date') DateTime? recurrenceStartDate,
    @JsonKey(name: 'recurrence_end_date') DateTime? recurrenceEndDate,
    @JsonKey(name: 'recurrence_day_of_month') int? recurrenceDayOfMonth,
    @JsonKey(name: 'is_recurrence_active') @Default(false) bool isRecurrenceActive,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _TransactionModel;

  const TransactionModel._();

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      _$TransactionModelFromJson(json);

  /// Conversion vers JSON pour Supabase
  /// Exclut les champs null et les champs gérés par la DB (id, created_at, updated_at)
  Map<String, dynamic> toJsonForSupabase() {
    final json = <String, dynamic>{
      'name': name,
      'amount': amount,
      'date': date.toIso8601String(),
      'category_id': categoryId,
      'type': type.name,
      'recurrence': recurrence.name,
      'user_id': userId,
    };

    // Ajouter is_recurrence_active seulement si c'est une transaction récurrente
    if (recurrence != RecurrenceType.none) {
      json['is_recurrence_active'] = isRecurrenceActive;
    }

    // Ajouter les champs optionnels seulement s'ils ne sont pas null
    if (id != null) json['id'] = id;
    if (imageUrl != null) json['image_url'] = imageUrl;
    if (notes != null) json['notes'] = notes;
    if (pocketId != null) json['pocket_id'] = pocketId;
    if (recurrenceGroupId != null) json['recurrence_group_id'] = recurrenceGroupId;
    if (recurrenceStartDate != null) json['recurrence_start_date'] = recurrenceStartDate!.toIso8601String();
    if (recurrenceEndDate != null) json['recurrence_end_date'] = recurrenceEndDate!.toIso8601String();
    if (recurrenceDayOfMonth != null) json['recurrence_day_of_month'] = recurrenceDayOfMonth;
    if (createdAt != null) json['created_at'] = createdAt!.toIso8601String();
    if (updatedAt != null) json['updated_at'] = updatedAt!.toIso8601String();

    return json;
  }
}

/// Extension pour la conversion entre TransactionModel et TransactionEntity
extension TransactionModelX on TransactionModel {
  /// Convertit le modèle en entité du domaine
  TransactionEntity toEntity() {
    return TransactionEntity(
      id: id,
      name: name,
      amount: amount,
      date: date,
      categoryId: categoryId,
      type: type,
      recurrence: recurrence,
      imageUrl: imageUrl,
      notes: notes,
      userId: userId,
      pocketId: pocketId,
      recurrenceGroupId: recurrenceGroupId,
      recurrenceStartDate: recurrenceStartDate,
      recurrenceEndDate: recurrenceEndDate,
      recurrenceDayOfMonth: recurrenceDayOfMonth,
      isRecurrenceActive: isRecurrenceActive,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  /// Vérifie si c'est une transaction récurrente (délègue vers l'entité)
  bool get isRecurring => toEntity().isRecurring;

  /// Calcule la prochaine date de récurrence (délègue vers l'entité)
  DateTime getNextOccurrence(DateTime currentDate) {
    return toEntity().getNextOccurrence(currentDate);
  }
}

/// Extension pour la conversion de TransactionEntity vers TransactionModel
extension TransactionEntityToModelX on TransactionEntity {
  /// Convertit l'entité en modèle de données
  TransactionModel toModel() {
    return TransactionModel(
      id: id,
      name: name,
      amount: amount,
      date: date,
      categoryId: categoryId,
      type: type,
      recurrence: recurrence,
      imageUrl: imageUrl,
      notes: notes,
      userId: userId,
      pocketId: pocketId,
      recurrenceGroupId: recurrenceGroupId,
      recurrenceStartDate: recurrenceStartDate,
      recurrenceEndDate: recurrenceEndDate,
      recurrenceDayOfMonth: recurrenceDayOfMonth,
      isRecurrenceActive: isRecurrenceActive,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

/// Extension pour les listes de TransactionModel
extension TransactionModelListX on List<TransactionModel> {
  /// Convertit une liste de models en entités
  List<TransactionEntity> toEntities() {
    return map((model) => model.toEntity()).toList();
  }
}

/// Extension pour les listes de TransactionEntity
extension TransactionEntityListToModelX on List<TransactionEntity> {
  /// Convertit une liste d'entités en models
  List<TransactionModel> toModels() {
    return map((entity) => entity.toModel()).toList();
  }
}

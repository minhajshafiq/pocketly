// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AuthUser _$AuthUserFromJson(Map<String, dynamic> json) => _AuthUser(
  id: json['id'] as String,
  email: json['email'] as String,
  phone: json['phone'] as String?,
  emailConfirmedAt: json['emailConfirmedAt'] == null
      ? null
      : DateTime.parse(json['emailConfirmedAt'] as String),
  phoneConfirmedAt: json['phoneConfirmedAt'] == null
      ? null
      : DateTime.parse(json['phoneConfirmedAt'] as String),
  lastSignInAt: json['lastSignInAt'] == null
      ? null
      : DateTime.parse(json['lastSignInAt'] as String),
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$AuthUserToJson(_AuthUser instance) => <String, dynamic>{
  'id': instance.id,
  'email': instance.email,
  'phone': instance.phone,
  'emailConfirmedAt': instance.emailConfirmedAt?.toIso8601String(),
  'phoneConfirmedAt': instance.phoneConfirmedAt?.toIso8601String(),
  'lastSignInAt': instance.lastSignInAt?.toIso8601String(),
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt?.toIso8601String(),
};

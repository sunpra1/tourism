// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../data/pojo/auth_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthBody _$AuthBodyFromJson(Map<String, dynamic> json) => AuthBody(
      email: json['email'] as String,
      password: json['password'] as String,
      authType: AuthBody._fromJson(json['role'] as String?),
    );

Map<String, dynamic> _$AuthBodyToJson(AuthBody instance) => <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'role': AuthBody._toJson(instance.authType),
    };

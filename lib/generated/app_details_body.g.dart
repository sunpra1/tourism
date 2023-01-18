// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../data/pojo/app_details_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppDetailsBody _$AppDetailsBodyFromJson(Map<String, dynamic> json) =>
    AppDetailsBody(
      flag: AppDetailsBody._fromJson(json['flag'] as String),
    )
      ..focusUser = json['focusUser'] as String
      ..officeId = json['officeId'] as int
      ..vendorId = json['vendorId'] as int;

Map<String, dynamic> _$AppDetailsBodyToJson(AppDetailsBody instance) =>
    <String, dynamic>{
      'focusUser': instance.focusUser,
      'flag': AppDetailsBody._toJson(instance.flag),
      'officeId': instance.officeId,
      'vendorId': instance.vendorId,
    };

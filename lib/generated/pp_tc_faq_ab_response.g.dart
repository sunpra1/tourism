// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../data/pojo/pp_tc_faq_ab_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PpTcFaqAbResponse _$PpTcFaqAbResponseFromJson(Map<String, dynamic> json) =>
    PpTcFaqAbResponse(
      code: json['code'] as String,
      success: json['success'] as bool,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : PpTcFaqAb.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PpTcFaqAbResponseToJson(PpTcFaqAbResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };

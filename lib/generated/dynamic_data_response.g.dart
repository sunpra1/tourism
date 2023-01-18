// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../data/pojo/dynamic_data_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DynamicDataResponse _$DynamicDataResponseFromJson(Map<String, dynamic> json) =>
    DynamicDataResponse(
      code: json['code'] as String,
      success: json['success'] as bool,
      message: json['message'] as String?,
      data: json['data'],
    );

Map<String, dynamic> _$DynamicDataResponseToJson(
        DynamicDataResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };

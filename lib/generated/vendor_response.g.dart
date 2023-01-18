// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../data/pojo/vendor_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VendorResponse _$VendorResponseFromJson(Map<String, dynamic> json) =>
    VendorResponse(
      code: json['code'] as String,
      success: json['success'] as bool,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : VendorDetails.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$VendorResponseToJson(VendorResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };

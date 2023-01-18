// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../data/pojo/vendors_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VendorsResponse _$VendorsResponseFromJson(Map<String, dynamic> json) =>
    VendorsResponse(
      code: json['code'] as String,
      success: json['success'] as bool,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Vendor.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$VendorsResponseToJson(VendorsResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };

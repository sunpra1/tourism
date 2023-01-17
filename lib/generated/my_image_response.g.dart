// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../data/pojo/my_image_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyImageResponse _$MyImageResponseFromJson(Map<String, dynamic> json) =>
    MyImageResponse(
      code: json['code'] as String,
      success: json['success'] as bool,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => MyImage.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MyImageResponseToJson(MyImageResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };

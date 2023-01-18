// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../data/pojo/my_images_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyImagesResponse _$MyImageResponseFromJson(Map<String, dynamic> json) =>
    MyImagesResponse(
      code: json['code'] as String,
      success: json['success'] as bool,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => MyImage.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MyImageResponseToJson(MyImagesResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };

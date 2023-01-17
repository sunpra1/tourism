// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../data/pojo/blogs_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BlogsResponse _$BlogsResponseFromJson(Map<String, dynamic> json) =>
    BlogsResponse(
      code: json['code'] as String,
      success: json['success'] as bool,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Blog.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BlogsResponseToJson(BlogsResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };

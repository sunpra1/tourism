// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../data/pojo/videos_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VideosDetailResponse _$VideoDetailResponseFromJson(Map<String, dynamic> json) =>
    VideosDetailResponse(
      code: json['code'] as String,
      success: json['success'] as bool,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => VideoDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$VideoDetailResponseToJson(
        VideosDetailResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };

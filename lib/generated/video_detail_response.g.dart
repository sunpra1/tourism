// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../data/pojo/video_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VideoDetailResponse _$VideoDetailResponseFromJson(Map<String, dynamic> json) =>
    VideoDetailResponse(
      code: json['code'] as String,
      success: json['success'] as bool,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => VideoDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$VideoDetailResponseToJson(
        VideoDetailResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };

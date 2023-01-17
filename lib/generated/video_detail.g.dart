// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../models/video_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VideoDetail _$VideoDetailFromJson(Map<String, dynamic> json) => VideoDetail(
      id: json['imageVideId'] as int,
      name: json['name'] as String,
      path: json['path'] as String,
      imagePath: json['imagePath'] as String?,
      shortDec: json['shortDesc'] as String,
      displayOrder: json['displayOrder'] as int,
    );

Map<String, dynamic> _$VideoDetailToJson(VideoDetail instance) =>
    <String, dynamic>{
      'imageVideId': instance.id,
      'name': instance.name,
      'path': instance.path,
      'imagePath': instance.imagePath,
      'shortDesc': instance.shortDec,
      'displayOrder': instance.displayOrder,
    };

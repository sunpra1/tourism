// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../models/blog.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Blog _$BlogFromJson(Map<String, dynamic> json) => Blog(
      blogId: json['blogId'] as String,
      title: json['title'] as String,
      subTitle: json['subTitle'] as String,
      shortDes: json['shortDess'] as String? ?? '',
      longDes: json['longDesc'] as String? ?? '',
      image: json['image'] as String?,
      image1: json['image1'] as String?,
      latitude: json['latitude'] as String?,
      longitude: json['longitude'] as String?,
    );

Map<String, dynamic> _$BlogToJson(Blog instance) => <String, dynamic>{
      'blogId': instance.blogId,
      'title': instance.title,
      'subTitle': instance.subTitle,
      'shortDess': instance.shortDes,
      'longDesc': instance.longDes,
      'image': instance.image,
      'image1': instance.image1,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../models/dashboard_item_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DashboardItemInfo _$DashboardItemInfoFromJson(Map<String, dynamic> json) =>
    DashboardItemInfo(
      blogId: json['blogId'] as String,
      title: json['title'] as String,
      subTitle: json['subTitle'] as String,
      image: json['image'] as String?,
      image1: json['image1'] as String?,
    );

Map<String, dynamic> _$DashboardItemInfoToJson(DashboardItemInfo instance) =>
    <String, dynamic>{
      'blogId': instance.blogId,
      'title': instance.title,
      'subTitle': instance.subTitle,
      'image': instance.image,
      'image1': instance.image1,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../models/dashboard_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DashboardItem _$DashboardItemFromJson(Map<String, dynamic> json) =>
    DashboardItem(
      typeName: json['typeName'] as String,
      dashboardItemInfoItems: (json['list'] as List<dynamic>)
          .map((e) => DashboardItemInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DashboardItemToJson(DashboardItem instance) =>
    <String, dynamic>{
      'typeName': instance.typeName,
      'list': instance.dashboardItemInfoItems,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../models/dashboard.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Dashboard _$DashboardFromJson(Map<String, dynamic> json) => Dashboard(
      dashBoardItems: (json['typeList'] as List<dynamic>)
          .map((e) => DashboardItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      dashboardTopSlider: (json['headerList'] as List<dynamic>)
          .map((e) => DashboardItemInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DashboardToJson(Dashboard instance) => <String, dynamic>{
      'typeList': instance.dashBoardItems,
      'headerList': instance.dashboardTopSlider,
    };

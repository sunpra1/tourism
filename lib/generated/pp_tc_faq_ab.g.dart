// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../models/pp_tc_faq_ab.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PpTcFaqAb _$PpTcFaqAbFromJson(Map<String, dynamic> json) => PpTcFaqAb(
      ppTcFaqAbDetailsList: (json['pptcfaqList'] as List<dynamic>)
          .map((e) => PpTcFaqAbDetails.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PpTcFaqAbToJson(PpTcFaqAb instance) => <String, dynamic>{
      'pptcfaqList': instance.ppTcFaqAbDetailsList,
    };

PpTcFaqAbDetails _$PpTcFaqAbDetailsFromJson(Map<String, dynamic> json) =>
    PpTcFaqAbDetails(
      content: json['content'] as String,
    );

Map<String, dynamic> _$PpTcFaqAbDetailsToJson(PpTcFaqAbDetails instance) =>
    <String, dynamic>{
      'content': instance.content,
    };

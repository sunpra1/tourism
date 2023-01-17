// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../data/pojo/nearby_places_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NearbyPlacesResponse _$NearbyPlacesResponseFromJson(
        Map<String, dynamic> json) =>
    NearbyPlacesResponse(
      code: json['code'] as String,
      success: json['success'] as bool,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Proximity.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NearbyPlacesResponseToJson(
        NearbyPlacesResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };

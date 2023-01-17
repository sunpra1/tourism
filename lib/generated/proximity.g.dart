// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../models/proximity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Proximity _$ProximityFromJson(Map<String, dynamic> json) => Proximity(
      list: (json['list'] as List<dynamic>)
          .map((e) => Blog.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProximityToJson(Proximity instance) => <String, dynamic>{
      'list': instance.list,
    };

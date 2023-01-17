// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../models/my_image.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyImage _$MyImageFromJson(Map<String, dynamic> json) => MyImage(
      imageId: json['imageVideId'] as int,
      name: json['name'] as String,
      path: json['path'] as String,
      shortDesc: json['shortDesc'] as String,
      displayOrder: json['displayOrder'] as int,
    );

Map<String, dynamic> _$MyImageToJson(MyImage instance) => <String, dynamic>{
      'imageVideId': instance.imageId,
      'name': instance.name,
      'path': instance.path,
      'shortDesc': instance.shortDesc,
      'displayOrder': instance.displayOrder,
    };

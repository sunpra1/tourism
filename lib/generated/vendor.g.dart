// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../models/vendor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Vendor _$VendorFromJson(Map<String, dynamic> json) => Vendor(
      vendorInfoId: json['vendorInfoId'] as String,
      name: json['name'] as String,
      location: json['location'] as String,
      country: json['country'] as String,
      emailId: json['emailId'] as String?,
      logo: json['logo'] as String?,
      banner: json['banner'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
    );

Map<String, dynamic> _$VendorToJson(Vendor instance) => <String, dynamic>{
      'vendorInfoId': instance.vendorInfoId,
      'name': instance.name,
      'location': instance.location,
      'country': instance.country,
      'emailId': instance.emailId,
      'logo': instance.logo,
      'banner': instance.banner,
      'phoneNumber': instance.phoneNumber,
    };

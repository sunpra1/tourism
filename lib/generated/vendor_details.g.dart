// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../models/vendor_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VendorDetails _$VendorDetailsFromJson(Map<String, dynamic> json) =>
    VendorDetails(
      vendorInfoId: json['vendorInfoId'] as String,
      name: json['name'] as String,
      location: json['location'] as String,
      state: json['state'] as String,
      zone: json['zone'] as String,
      district: json['district'] as String,
      city: json['city'] as String,
      country: json['country'] as String,
      zipCode: json['zipCode'] as String,
      emailId: json['emailId'] as String,
      website: json['website'] as String?,
      logo: json['logo'] as String?,
      banner: json['banner'] as String?,
      latitude: json['latitude'] as String?,
      longitude: json['longitude'] as String?,
      contactPerson: json['contactPerson'] as String,
      phoneNumber: json['phoneNumber'] as String,
      postalCode: json['postalCode'] as String,
      facebookLink: json['facebookLink'] as String?,
      youtubeLink: json['youtubeLink'] as String?,
      linkedInLink: json['linkedInLink'] as String?,
      instagramLink: json['instagramLink'] as String?,
      details: json['details'] as String,
    );

Map<String, dynamic> _$VendorDetailsToJson(VendorDetails instance) =>
    <String, dynamic>{
      'vendorInfoId': instance.vendorInfoId,
      'name': instance.name,
      'location': instance.location,
      'state': instance.state,
      'zone': instance.zone,
      'district': instance.district,
      'city': instance.city,
      'country': instance.country,
      'zipCode': instance.zipCode,
      'emailId': instance.emailId,
      'website': instance.website,
      'logo': instance.logo,
      'banner': instance.banner,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'contactPerson': instance.contactPerson,
      'phoneNumber': instance.phoneNumber,
      'postalCode': instance.postalCode,
      'facebookLink': instance.facebookLink,
      'youtubeLink': instance.youtubeLink,
      'linkedInLink': instance.linkedInLink,
      'instagramLink': instance.instagramLink,
      'details': instance.details,
    };

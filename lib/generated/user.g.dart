// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../models/user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      userId: json['userId'] as String? ?? '',
      userName: json['userName'] as String? ?? '',
      firstName: json['firstName'] as String? ?? '',
      lastName: json['lastName'] as String? ?? '',
      mobileNumber: json['mobileNumber'] as String? ?? '',
      gender: $enumDecodeNullable(_$GenderEnumMap, json['gender']) ??
          Gender.unSpecified,
      dob: json['dob'] as String? ?? '',
      country: json['country'] as String? ?? '',
      state: json['state'] as String? ?? '',
      city: json['city'] as String? ?? '',
      address: json['address'] as String? ?? '',
      profileId: json['profileId'] as String? ?? '',
      profileImage: json['profileImage'] as String? ?? '',
      profileShortImage: json['profileShorImage'] as String? ?? '',
      roleName: json['roleName'] == null
          ? UserRole.user
          : User._getRoleFromString(json['roleName'] as String),
      token: json['token'] as String? ?? '',
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'userId': instance.userId,
      'userName': instance.userName,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'mobileNumber': instance.mobileNumber,
      'gender': _$GenderEnumMap[instance.gender]!,
      'dob': instance.dob,
      'country': instance.country,
      'state': instance.state,
      'city': instance.city,
      'address': instance.address,
      'profileId': instance.profileId,
      'profileImage': instance.profileImage,
      'profileShorImage': instance.profileShortImage,
      'roleName': User._getStringFromRole(instance.roleName),
      'token': instance.token,
    };

const _$GenderEnumMap = {
  Gender.male: 'male',
  Gender.female: 'female',
  Gender.others: 'others',
  Gender.unSpecified: 'unSpecified',
};

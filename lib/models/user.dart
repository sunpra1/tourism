import 'dart:convert' as Convert;

import 'package:json_annotation/json_annotation.dart';

import 'gender.dart';

part '../generated/user.g.dart';

@JsonSerializable()
class User {
  @JsonKey(name: 'userId', defaultValue: '')
  String userId;

  @JsonKey(name: 'userName', defaultValue: '')
  String userName;

  @JsonKey(name: 'firstName', defaultValue: '')
  String firstName;

  @JsonKey(name: 'lastName', defaultValue: '')
  String lastName;

  @JsonKey(name: 'mobileNumber', defaultValue: '')
  String mobileNumber;

  @JsonKey(name: 'gender', defaultValue: Gender.unSpecified)
  Gender gender;

  @JsonKey(name: 'dob', defaultValue: '')
  String dob;

  @JsonKey(name: 'country', defaultValue: '')
  String country;

  @JsonKey(name: 'state', defaultValue: '')
  String state;

  @JsonKey(name: 'city', defaultValue: '')
  String city;

  @JsonKey(name: 'address', defaultValue: '')
  String address;

  @JsonKey(name: 'profileId', defaultValue: '')
  String profileId;

  @JsonKey(name: 'profileImage', defaultValue: '')
  String profileImage;

  @JsonKey(name: 'profileShorImage', defaultValue: '')
  String profileShortImage;

  @JsonKey(name: 'roleName', defaultValue: UserRole.user)
  UserRole roleName;

  @JsonKey(name: 'token', defaultValue: '')
  String token;

  User({
    required this.userId,
    required this.userName,
    required this.firstName,
    required this.lastName,
    required this.mobileNumber,
    required this.gender,
    required this.dob,
    required this.country,
    required this.state,
    required this.city,
    required this.address,
    required this.profileId,
    required this.profileImage,
    required this.profileShortImage,
    required this.roleName,
    required this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  String toString() {
    return Convert.jsonEncode(toJson());
  }

  static UserRole _getRole(String roleString) {
    UserRole value;
    switch (roleString) {
      case "Admin":
        value = UserRole.admin;
        break;
      case "User":
        value = UserRole.user;
        break;
      default:
        value = UserRole.user;
        break;
    }
    return value;
  }
}

enum UserRole { user, admin }

extension RequestEndPointExt on UserRole {
  String get value {
    String value;
    switch (this) {
      case UserRole.user:
        value = "User";
        break;
      case UserRole.admin:
        value = "Admin";
        break;
    }
    return value;
  }
}

import 'dart:convert' as Convert;

import 'gender.dart';

class User {
  static const _key_user_id = "userId";
  static const _key_user_name = "userName";
  static const _key_first_name = "firstName";
  static const _key_last_name = "lastName";
  static const _key_mobile_number = "mobileNumber";
  static const _key_gender = "gender";
  static const _key_dob = "dob";
  static const _key_country = "country";
  static const _key_state = "state";
  static const _key_city = "city";
  static const _key_address = "address";
  static const _key_profile_id = "profileId";
  static const _key_user_profile_id = "userProfileId";
  static const _key_profile_image = "profileImage";
  static const _key_profile_short_image = "profileShorImage";
  static const _key_role_name = "roleName";
  static const _key_token = "token";

  String userId = "";
  String userName = "";
  String firstName = "";
  String lastName = "";
  String mobileNumber = "";
  Gender gender = Gender.unSpeacified;
  String dob = "";
  String country = "";
  String state = "";
  String city = "";
  String address = "";
  String profileId = "";
  String profileImage = "";
  String profileShortImage = "";
  UserRole roleName = UserRole.user;
  String token = "";

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

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      userId: map[_key_user_id] ?? "",
      userName: map[_key_user_name] ?? "",
      firstName: map[_key_first_name] ?? "",
      lastName: map[_key_last_name] ?? "",
      mobileNumber: map[_key_mobile_number] ?? "",
      gender: GenderHelper.fromString(map[_key_gender] ?? ""),
      dob: map[_key_dob] ?? "",
      country: map[_key_country] ?? "",
      state: map[_key_state] ?? "",
      city: map[_key_city] ?? "",
      address: map[_key_address] ?? "",
      profileId: map[_key_profile_id] ?? map[_key_user_profile_id] ?? "",
      profileImage: map[_key_profile_image] ?? "",
      profileShortImage: map[_key_profile_short_image] ?? "",
      roleName: _getRole(map[_key_role_name] ?? ""),
      token: map[_key_token] ?? "",
    );
  }

  Map<String, dynamic> toMap() {
    return {
      _key_user_id: userId,
      _key_user_name: userName,
      _key_first_name: firstName,
      _key_mobile_number: mobileNumber,
      _key_last_name: lastName,
      _key_gender: gender.value,
      _key_country: country,
      _key_state: state,
      _key_city: city,
      _key_address: address,
      _key_user_profile_id: profileId,
      _key_profile_short_image: profileShortImage,
      _key_role_name: roleName.value,
      _key_token: token,
    };
  }

  @override
  String toString() {
    return Convert.jsonEncode(toMap());
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

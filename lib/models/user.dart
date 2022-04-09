import 'dart:convert' as Convert;

class User {
  static const _key_user_id = "userId";
  static const _key_user_name = "userName";
  static const _key_first_name = "firstName";
  static const _key_last_name = "lastName";
  static const _key_gender = "gender";
  static const _key_country = "country";
  static const _key_city = "city";
  static const _key_address = "address";
  static const _key_profile_id = "userProfileId";
  static const _key_profile_image = "profileImage";
  static const _key_role_name = "roleName";
  static const _key_token = "token";

  String userId;
  String userName;
  String firstName;
  String lastName;
  String gender;
  String dob;
  String country;
  String city;
  String address;
  String profileId;
  String profileImage;
  UserRole roleName;
  String token;

  User({
    this.userId = "",
    required this.userName,
    this.firstName = "",
    this.lastName = "",
    this.gender = "",
    this.dob = "",
    this.country = "",
    this.city = "",
    this.address = "",
    this.profileId = "",
    this.profileImage = "",
    this.roleName = UserRole.user,
    this.token = "",
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      userId: map[_key_user_id] ?? "",
      userName: map[_key_user_name] ?? "",
      firstName: map[_key_first_name] ?? "",
      lastName: map[_key_last_name] ?? "",
      gender: map[_key_gender] ?? "",
      city: map[_key_city] ?? "",
      country: map[_key_country] ?? "",
      address: map[_key_address] ?? "",
      profileId: map[_key_profile_id] ?? "",
      profileImage: map[_key_profile_image],
      roleName: _getRole(map[_key_role_name] ?? ""),
      token: map[_key_token] ?? "",
    );
  }

  Map<String, dynamic> toMap() {
    return {
      _key_user_id: userId,
      _key_user_name: userName,
      _key_first_name: firstName,
      _key_last_name: lastName,
      _key_gender: gender,
      _key_country: country,
      _key_city: city,
      _key_address: address,
      _key_profile_id: profileId,
      _key_profile_image: profileImage,
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

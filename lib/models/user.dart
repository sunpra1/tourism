import 'dart:convert' as Convert;

class User {
  static const _key_user_id = "userId";
  static const _key_user_name = "userName";
  static const _key_first_name = "firstName";
  static const _key_last_name = "lastName";
  static const _key_profile_id = "profileId";
  static const _key_profile_image = "profileImage";
  static const _key_role_name = "roleName";
  static const _key_token = "token";

  String userId;
  String userName;
  String firstName;
  String lastName;
  String profileId;
  String profileImage;
  UserRole roleName;
  String token;

  User({
    required this.userId,
    required this.userName,
    required this.firstName,
    required this.lastName,
    required this.profileId,
    required this.profileImage,
    required this.roleName,
    required this.token,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      userId: map[_key_user_id],
      userName: map[_key_user_name],
      firstName: map[_key_first_name],
      lastName: map[_key_last_name],
      profileId: map[_key_profile_id],
      profileImage: map[_key_profile_image],
      roleName: _getRole(map[_key_role_name]),
      token: map[_key_token],
    );
  }

  @override
  String toString() {
    return Convert.jsonEncode({
      _key_user_id: userId,
      _key_user_name: userName,
      _key_first_name: firstName,
      _key_last_name: lastName,
      _key_profile_id: profileId,
      _key_profile_image: profileImage,
      _key_role_name: roleName.value,
      _key_token: token,
    });
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

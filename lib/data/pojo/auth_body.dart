import 'package:json_annotation/json_annotation.dart';

part '../../generated/auth_body.g.dart';

@JsonSerializable()
class AuthBody {
  @JsonKey(name: 'email')
  String email;
  @JsonKey(name: 'password')
  String password;
  @JsonKey(name: 'role', fromJson: _fromJson, toJson: _toJson)
  AuthType authType;

  AuthBody(
      {required this.email, required this.password, required this.authType});

  factory AuthBody.fromJson(Map<String, dynamic> json) =>
      _$AuthBodyFromJson(json);

  Map<String, dynamic> toJson() => _$AuthBodyToJson(this);

  static AuthType _fromJson(String? value) {
    AuthType authType;
    switch (value) {
      case "User":
        authType = AuthType.register;
        break;
      default:
        authType = AuthType.login;
        break;
    }
    return authType;
  }

  static String? _toJson(AuthType authType) => authType.value;
}

enum AuthType { login, register }

extension AuthTypeExt on AuthType {
  String? get value {
    String? value;
    switch (this) {
      case AuthType.login:
        value = "User";
        break;
      case AuthType.register:
        value = null;
        break;
    }
    return value;
  }
}

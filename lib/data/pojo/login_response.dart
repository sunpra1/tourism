import 'package:json_annotation/json_annotation.dart';

import '../../models/user.dart';

part '../../generated/login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  @JsonKey(name: 'code')
  String code;
  @JsonKey(name: 'success')
  bool success;
  @JsonKey(name: 'message')
  String? message;
  @JsonKey(name: 'data')
  User? data;

  LoginResponse({
    required this.code,
    required this.success,
    required this.message,
    required this.data,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}

import 'package:json_annotation/json_annotation.dart';

import '../../models/dashboard.dart';

part '../../generated/dashboard_response.g.dart';

@JsonSerializable()
class DashboardResponse {
  @JsonKey(name: 'code')
  String code;
  @JsonKey(name: 'success')
  bool success;
  @JsonKey(name: 'message')
  String? message;
  @JsonKey(name: 'data')
  Dashboard? data;

  DashboardResponse({
    required this.code,
    required this.success,
    required this.message,
    required this.data,
  });

  factory DashboardResponse.fromJson(Map<String, dynamic> json) =>
      _$DashboardResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DashboardResponseToJson(this);
}

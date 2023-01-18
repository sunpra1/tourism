import 'package:json_annotation/json_annotation.dart';

part '../../generated/dynamic_data_response.g.dart';

@JsonSerializable()
class DynamicDataResponse {
  @JsonKey(name: 'code')
  String code;
  @JsonKey(name: 'success')
  bool success;
  @JsonKey(name: 'message')
  String? message;
  @JsonKey(name: 'data')
  dynamic data;

  DynamicDataResponse({
    required this.code,
    required this.success,
    required this.message,
    required this.data,
  });

  factory DynamicDataResponse.fromJson(Map<String, dynamic> json) =>
      _$DynamicDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DynamicDataResponseToJson(this);
}

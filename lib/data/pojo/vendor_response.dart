import 'package:json_annotation/json_annotation.dart';

import '../../models/vendor_details.dart';

part '../../generated/vendor_response.g.dart';

@JsonSerializable()
class VendorResponse {
  @JsonKey(name: 'code')
  String code;
  @JsonKey(name: 'success')
  bool success;
  @JsonKey(name: 'message')
  String? message;
  @JsonKey(name: 'data')
  VendorDetails? data;

  VendorResponse({
    required this.code,
    required this.success,
    required this.message,
    required this.data,
  });

  factory VendorResponse.fromJson(Map<String, dynamic> json) =>
      _$VendorResponseFromJson(json);

  Map<String, dynamic> toJson() => _$VendorResponseToJson(this);
}

import 'package:json_annotation/json_annotation.dart';
import 'package:tourism/models/vendor.dart';

part '../../generated/vendors_response.g.dart';

@JsonSerializable()
class VendorsResponse {
  @JsonKey(name: 'code')
  String code;
  @JsonKey(name: 'success')
  bool success;
  @JsonKey(name: 'message')
  String? message;
  @JsonKey(name: 'data')
  List<Vendor>? data;

  VendorsResponse({
    required this.code,
    required this.success,
    required this.message,
    required this.data,
  });

  factory VendorsResponse.fromJson(Map<String, dynamic> json) =>
      _$VendorsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$VendorsResponseToJson(this);
}

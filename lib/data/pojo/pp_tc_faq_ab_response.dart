import 'package:json_annotation/json_annotation.dart';

import '../../models/pp_tc_faq_ab.dart';

part '../../generated/pp_tc_faq_ab_response.g.dart';

@JsonSerializable()
class PpTcFaqAbResponse {
  @JsonKey(name: 'code')
  String code;
  @JsonKey(name: 'success')
  bool success;
  @JsonKey(name: 'message')
  String? message;
  @JsonKey(name: 'data')
  PpTcFaqAb? data;

  PpTcFaqAbResponse({
    required this.code,
    required this.success,
    required this.message,
    required this.data,
  });

  factory PpTcFaqAbResponse.fromJson(Map<String, dynamic> json) =>
      _$PpTcFaqAbResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PpTcFaqAbResponseToJson(this);
}

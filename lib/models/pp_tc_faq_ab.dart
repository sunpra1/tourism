import 'package:json_annotation/json_annotation.dart';

part '../generated/pp_tc_faq_ab.g.dart';

@JsonSerializable()
class PpTcFaqAb {
  @JsonKey(name: 'pptcfaqList')
  List<PpTcFaqAbDetails> ppTcFaqAbDetailsList;

  PpTcFaqAb({required this.ppTcFaqAbDetailsList});

  factory PpTcFaqAb.fromJson(Map<String, dynamic> json) =>
      _$PpTcFaqAbFromJson(json);

  Map<String, dynamic> toJson() => _$PpTcFaqAbToJson(this);
}

@JsonSerializable()
class PpTcFaqAbDetails {
  @JsonKey(name: 'content')
  String content;

  PpTcFaqAbDetails({required this.content});

  factory PpTcFaqAbDetails.fromJson(Map<String, dynamic> json) =>
      _$PpTcFaqAbDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$PpTcFaqAbDetailsToJson(this);
}

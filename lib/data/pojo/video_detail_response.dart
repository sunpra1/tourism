import 'package:json_annotation/json_annotation.dart';

import '../../models/video_detail.dart';

part '../../generated/video_detail_response.g.dart';

@JsonSerializable()
class VideoDetailResponse {
  @JsonKey(name: 'code')
  String code;
  @JsonKey(name: 'success')
  bool success;
  @JsonKey(name: 'message')
  String? message;
  @JsonKey(name: 'data')
  List<VideoDetail>? data;

  VideoDetailResponse({
    required this.code,
    required this.success,
    required this.message,
    required this.data,
  });

  factory VideoDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$VideoDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$VideoDetailResponseToJson(this);
}

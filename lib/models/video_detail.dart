import 'package:json_annotation/json_annotation.dart';

part '../generated/video_detail.g.dart';

@JsonSerializable()
class VideoDetail {
  @JsonKey(name: 'imageVideId')
  final int id;
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'path')
  final String path;
  @JsonKey(name: 'imagePath')
  final String? imagePath;
  @JsonKey(name: 'shortDesc')
  final String shortDec;
  @JsonKey(name: 'displayOrder')
  final int displayOrder;

  const VideoDetail({
    required this.id,
    required this.name,
    required this.path,
    required this.imagePath,
    required this.shortDec,
    required this.displayOrder,
  });

  factory VideoDetail.fromJson(Map<String, dynamic> json) =>
      _$VideoDetailFromJson(json);

  Map<String, dynamic> toJson() => _$VideoDetailToJson(this);
}

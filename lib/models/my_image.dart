import 'package:json_annotation/json_annotation.dart';

part '../generated/my_image.g.dart';

@JsonSerializable()
class MyImage {
  @JsonKey(name: 'imageVideId')
  int imageId;
  @JsonKey(name: 'name')
  String name;
  @JsonKey(name: 'path')
  String path;
  @JsonKey(name: 'shortDesc')
  String shortDesc;
  @JsonKey(name: 'displayOrder')
  int displayOrder;

  MyImage({
    required this.imageId,
    required this.name,
    required this.path,
    required this.shortDesc,
    required this.displayOrder,
  });

  factory MyImage.fromJson(Map<String, dynamic> json) =>
      _$MyImageFromJson(json);

  Map<String, dynamic> toJson() => _$MyImageToJson(this);
}

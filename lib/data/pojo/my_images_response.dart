import 'package:json_annotation/json_annotation.dart';

import '../../models/my_image.dart';

part '../../generated/my_image_response.g.dart';

@JsonSerializable()
class MyImagesResponse {
  @JsonKey(name: 'code')
  String code;
  @JsonKey(name: 'success')
  bool success;
  @JsonKey(name: 'message')
  String? message;
  @JsonKey(name: 'data')
  List<MyImage>? data;

  MyImagesResponse({
    required this.code,
    required this.success,
    required this.message,
    required this.data,
  });

  factory MyImagesResponse.fromJson(Map<String, dynamic> json) =>
      _$MyImageResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MyImageResponseToJson(this);
}

import 'package:json_annotation/json_annotation.dart';

import '../../models/blog.dart';

part '../../generated/blogs_response.g.dart';

@JsonSerializable()
class BlogsResponse {
  @JsonKey(name: 'code')
  String code;
  @JsonKey(name: 'success')
  bool success;
  @JsonKey(name: 'message')
  String? message;
  @JsonKey(name: 'data')
  List<Blog>? data;

  BlogsResponse({
    required this.code,
    required this.success,
    required this.message,
    required this.data,
  });

  factory BlogsResponse.fromJson(Map<String, dynamic> json) =>
      _$BlogsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BlogsResponseToJson(this);
}

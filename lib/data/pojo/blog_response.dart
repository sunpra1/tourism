import 'package:json_annotation/json_annotation.dart';

import '../../models/blog.dart';

part '../../generated/blog_response.g.dart';

@JsonSerializable()
class BlogResponse {
  @JsonKey(name: 'code')
  String code;
  @JsonKey(name: 'success')
  bool success;
  @JsonKey(name: 'message')
  String? message;
  @JsonKey(name: 'data')
  Blog? data;

  BlogResponse({
    required this.code,
    required this.success,
    required this.message,
    required this.data,
  });

  factory BlogResponse.fromJson(Map<String, dynamic> json) =>
      _$BlogResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BlogResponseToJson(this);
}

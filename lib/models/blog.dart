import 'package:json_annotation/json_annotation.dart';

part '../generated/blog.g.dart';

@JsonSerializable()
class Blog {
  @JsonKey(name: "blogId")
  final String blogId;
  @JsonKey(name: "title")
  final String title;
  @JsonKey(name: "subTitle")
  final String subTitle;
  @JsonKey(name: "shortDess", defaultValue: "")
  final String shortDes;
  @JsonKey(name: "longDesc", defaultValue: "")
  final String longDes;
  @JsonKey(name: "image")
  final String? image;
  @JsonKey(name: "image1")
  final String? image1;
  @JsonKey(name: "latitude")
  final String? latitude;
  @JsonKey(name: "longitude")
  final String? longitude;

  Blog({
    required this.blogId,
    required this.title,
    required this.subTitle,
    required this.shortDes,
    required this.longDes,
    required this.image,
    required this.image1,
    this.latitude,
    this.longitude,
  });

  factory Blog.fromJson(Map<String, dynamic> json) => _$BlogFromJson(json);

  Map<String, dynamic> toJson() => _$BlogToJson(this);

  static List<Blog> fromListMap(List<dynamic> listMap) {
    List<Blog> items = [];
    listMap.forEach((element) {
      items.add(Blog.fromJson(element));
    });
    return items;
  }
}

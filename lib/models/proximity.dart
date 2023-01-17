import 'package:json_annotation/json_annotation.dart';
import 'package:tourism/models/blog.dart';

part '../generated/proximity.g.dart';

@JsonSerializable()
class Proximity {
  @JsonKey(name: "list")
  final List<Blog> list;

  const Proximity({required this.list});

  factory Proximity.fromJson(Map<String, dynamic> json) =>
      _$ProximityFromJson(json);

  Map<String, dynamic> toJson() => _$ProximityToJson(this);
}

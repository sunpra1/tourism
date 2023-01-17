import 'package:json_annotation/json_annotation.dart';

import '../../models/proximity.dart';

part '../../generated/nearby_places_response.g.dart';

@JsonSerializable()
class NearbyPlacesResponse {
  @JsonKey(name: 'code')
  String code;
  @JsonKey(name: 'success')
  bool success;
  @JsonKey(name: 'message')
  String? message;
  @JsonKey(name: 'data')
  Proximity? data;

  NearbyPlacesResponse({
    required this.code,
    required this.success,
    required this.message,
    required this.data,
  });

  factory NearbyPlacesResponse.fromJson(Map<String, dynamic> json) =>
      _$NearbyPlacesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NearbyPlacesResponseToJson(this);
}

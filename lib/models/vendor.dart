import 'package:json_annotation/json_annotation.dart';

part '../generated/vendor.g.dart';

@JsonSerializable()
class Vendor {
  @JsonKey(name: 'vendorInfoId')
  final String vendorInfoId;
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'location')
  final String location;
  @JsonKey(name: 'country')
  final String country;
  @JsonKey(name: 'emailId')
  final String? emailId;
  @JsonKey(name: 'logo')
  final String? logo;
  @JsonKey(name: 'banner')
  final String? banner;
  @JsonKey(name: 'phoneNumber')
  final String? phoneNumber;

  const Vendor({
    required this.vendorInfoId,
    required this.name,
    required this.location,
    required this.country,
    required this.emailId,
    required this.logo,
    required this.banner,
    required this.phoneNumber,
  });

  factory Vendor.fromJson(Map<String, dynamic> json) =>
      _$VendorFromJson(json);

  Map<String, dynamic> toJson() => _$VendorToJson(this);
}

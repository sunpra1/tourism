import 'package:json_annotation/json_annotation.dart';

part '../generated/vendor_details.g.dart';

@JsonSerializable()
class VendorDetails {
  @JsonKey(name: 'vendorInfoId')
  String vendorInfoId;
  @JsonKey(name: 'name')
  String name;
  @JsonKey(name: 'location')
  String location;
  @JsonKey(name: 'state')
  String state;
  @JsonKey(name: 'zone')
  String zone;
  @JsonKey(name: 'district')
  String district;
  @JsonKey(name: 'city')
  String city;
  @JsonKey(name: 'country')
  String country;
  @JsonKey(name: 'zipCode')
  String zipCode;
  @JsonKey(name: 'emailId')
  String emailId;
  @JsonKey(name: 'website')
  String? website;
  @JsonKey(name: 'logo')
  String? logo;
  @JsonKey(name: 'banner')
  String? banner;
  @JsonKey(name: 'latitude')
  String? latitude;
  @JsonKey(name: 'longitude')
  String? longitude;
  @JsonKey(name: 'contactPerson')
  String contactPerson;
  @JsonKey(name: 'phoneNumber')
  String phoneNumber;
  @JsonKey(name: 'postalCode')
  String postalCode;
  @JsonKey(name: 'facebookLink')
  String? facebookLink;
  @JsonKey(name: 'youtubeLink')
  String? youtubeLink;
  @JsonKey(name: 'linkedInLink')
  String? linkedInLink;
  @JsonKey(name: 'instagramLink')
  String? instagramLink;
  @JsonKey(name: 'details')
  String details;

  VendorDetails({
    required this.vendorInfoId,
    required this.name,
    required this.location,
    required this.state,
    required this.zone,
    required this.district,
    required this.city,
    required this.country,
    required this.zipCode,
    required this.emailId,
    required this.website,
    required this.logo,
    required this.banner,
    required this.latitude,
    required this.longitude,
    required this.contactPerson,
    required this.phoneNumber,
    required this.postalCode,
    required this.facebookLink,
    required this.youtubeLink,
    required this.linkedInLink,
    required this.instagramLink,
    required this.details,
  });

  factory VendorDetails.fromJson(Map<String, dynamic> json) =>
      _$VendorDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$VendorDetailsToJson(this);
}

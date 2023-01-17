class VendorDetails {
  static const _key_vendor_info_id = "vendorInfoId";
  static const _key_name = "name";
  static const _key_location = "location";
  static const _key_state = "state";
  static const _key_zone = "zone";
  static const _key_district = "district";
  static const _key_city = "city";
  static const _key_country = "country";
  static const _key_zipCode = "zipCode";
  static const _key_email_id = "emailId";
  static const _key_website = "website";
  static const _key_logo = "logo";
  static const _key_banner = "banner";
  static const _key_latitude = "latitude";
  static const _key_longitude = "longitude";
  static const _key_contact_person = "contactPerson";
  static const _key_phone_number = "phoneNumber";
  static const _key_postal_code = "postalCode";
  static const _key_facebook_link = "facebookLink";
  static const _key_youtube_link = "youtubeLink";
  static const _key_linked_in_link = "linkedInLink";
  static const _key_instagram_link = "instagramLink";
  static const _key_details = "details";

  String vendorInfoId;
  String name;
  String location;
  String state;
  String zone;
  String district;
  String city;
  String country;
  String zipCode;
  String emailId;
  String? website;
  String? logo;
  String? banner;
  String? latitude;
  String? longitude;
  String contactPerson;
  String phoneNumber;
  String postalCode;
  String? facebookLink;
  String? youtubeLink;
  String? linkedInLink;
  String? instagramLink;
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

  factory VendorDetails.formMap(Map<String, dynamic> map) {
    return VendorDetails(
      vendorInfoId: map[_key_vendor_info_id],
      name: map[_key_name],
      location: map[_key_location],
      state: map[_key_state],
      zone: map[_key_zone],
      district: map[_key_district],
      city: map[_key_city],
      country: map[_key_country],
      zipCode: map[_key_zipCode],
      emailId: map[_key_email_id],
      website: map[_key_website],
      logo: map[_key_logo],
      banner: map[_key_banner],
      latitude: map[_key_latitude],
      longitude: map[_key_longitude],
      contactPerson: map[_key_contact_person],
      phoneNumber: map[_key_phone_number],
      postalCode: map[_key_postal_code],
      facebookLink: map[_key_facebook_link],
      youtubeLink: map[_key_youtube_link],
      linkedInLink: map[_key_linked_in_link],
      instagramLink: map[_key_instagram_link],
      details: map[_key_details],
    );
  }
}

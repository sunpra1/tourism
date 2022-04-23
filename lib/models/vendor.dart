class Vendor {
  static const _key_vendor_info_id = "vendorInfoId";
  static const _key_name = "name";
  static const _key_location = "location";
  static const _key_country = "country";
  static const _key_email_id = "emailId";
  static const _key_logo = "logo";
  static const _key_banner = "banner";
  static const _key_phone_number = "phoneNumber";

  final String vendorInfoId;
  final String name;
  final String location;
  final String country;
  final String emailId;
  final String logo;
  final String banner;
  final String phoneNumber;

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

  factory Vendor.fromMap(Map<String, dynamic> map) {
    return Vendor(
      vendorInfoId: map[_key_vendor_info_id],
      name: map[_key_name],
      location: map[_key_location],
      country: map[_key_country],
      emailId: map[_key_email_id],
      logo: map[_key_logo],
      banner: map[_key_banner],
      phoneNumber: map[_key_phone_number],
    );
  }

  static List<Vendor> fromListMap(List<dynamic> listMap) {
    List<Vendor> items = [];
    listMap.forEach((element) {
      items.add(Vendor.fromMap(element));
    });
    return items;
  }
}

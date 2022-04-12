class AppDetailsBody{
  static const _key_flag = "flag";
  static const _key_focus_user = "focusUser";
  static const _key_office_id = "officeId";
  static const _key_vendor_id = "vendorId";

  String focusUser = "All";
  FlagType flag;
  int officeId = 0;
  int vendorId = 0;

  AppDetailsBody({required this.flag});

  Map<String, dynamic> toMap() {
    return {
      _key_flag: flag.value,
      _key_focus_user: focusUser,
      _key_office_id: officeId,
      _key_vendor_id: vendorId,
    };
  }
}

enum FlagType{
  privacyPolicy,
  aboutUS,
  termsAndCondition
}

extension FlagTypeExt on FlagType{
  String get value{
    String value;
    switch(this){
      case FlagType.privacyPolicy:
        value = "PP";
        break;
      case FlagType.aboutUS:
        value = "AB";
        break;
      case FlagType.termsAndCondition:
        value = "TC";
        break;
    }
    return value;
  }
}
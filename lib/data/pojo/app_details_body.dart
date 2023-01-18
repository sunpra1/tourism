import 'package:json_annotation/json_annotation.dart';

part '../../generated/app_details_body.g.dart';

@JsonSerializable()
class AppDetailsBody {
  @JsonKey(name: 'focusUser')
  String focusUser = "All";
  @JsonKey(name: 'flag', fromJson: _fromJson, toJson: _toJson)
  FlagType flag;
  @JsonKey(name: 'officeId')
  int officeId = 0;
  @JsonKey(name: 'vendorId')
  int vendorId = 0;

  AppDetailsBody({required this.flag});

  factory AppDetailsBody.fromJson(Map<String, dynamic> json) =>
      _$AppDetailsBodyFromJson(json);

  Map<String, dynamic> toJson() => _$AppDetailsBodyToJson(this);

  static String _toJson(FlagType value) => value.value;

  static FlagType _fromJson(String value) {
    FlagType flagType;
    switch (value) {
      case "PP":
        flagType = FlagType.privacyPolicy;
        break;
      case "AB":
        flagType = FlagType.aboutUS;
        break;
      default:
        flagType = FlagType.termsAndCondition;
        break;
    }
    return flagType;
  }
}

enum FlagType { privacyPolicy, aboutUS, termsAndCondition }

extension FlagTypeExt on FlagType {
  String get value {
    String value;
    switch (this) {
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

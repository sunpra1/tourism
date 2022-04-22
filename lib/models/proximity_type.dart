enum ProximityType { nearMe, whereToStay }

extension ProximityTypeExt on ProximityType {
  String get value {
    String value;
    switch (this) {
      case ProximityType.nearMe:
        value = "Place";
        break;
      case ProximityType.whereToStay:
        value = "Hotel";
        break;
    }
    return value;
  }
}

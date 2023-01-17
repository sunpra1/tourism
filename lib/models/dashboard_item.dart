import 'package:json_annotation/json_annotation.dart';
import 'package:tourism/models/dashboard_item_info.dart';

part '../generated/dashboard_item.g.dart';

@JsonSerializable()
class DashboardItem {
  static const String _key_type_name = "typeName";
  static const String _key_list = "list";
  @JsonKey(name: 'typeName')
  String typeName;
  @JsonKey(name: 'list')
  List<DashboardItemInfo> dashboardItemInfoItems;

  DashboardItem({required this.typeName, required this.dashboardItemInfoItems});

  factory DashboardItem.fromJson(Map<String, dynamic> json) =>
      _$DashboardItemFromJson(json);

  Map<String, dynamic> toJson() => _$DashboardItemToJson(this);

  factory DashboardItem.fromMap(Map<String, dynamic> map) {
    return DashboardItem(
      typeName: map[_key_type_name],
      dashboardItemInfoItems: DashboardItemInfo.fromListMap(map[_key_list]),
    );
  }

  static List<DashboardItem> fromListMap(List<dynamic> listMap) {
    List<DashboardItem> items = [];
    listMap.forEach((element) {
      items.add(DashboardItem.fromMap(element));
    });
    return items;
  }
}

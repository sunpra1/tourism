import 'package:tourism/models/dashboard_item_info.dart';

class DashboardItem {
  static const String _key_type_name = "typeName";
  static const String _key_list = "list";

  String typeName;
  List<DashboardItemInfo> dashboardItemInfoItems;

  DashboardItem({required this.typeName, required this.dashboardItemInfoItems});

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

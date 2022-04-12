import 'package:tourism/models/dashboard_item.dart';

class Dashboard {
  static const _key_dashboard_item = "typeList";

  List<DashboardItem> dashBoardItems;

  Dashboard({required this.dashBoardItems});

  factory Dashboard.fromMap(Map<String, dynamic> map) {
    return Dashboard(
      dashBoardItems: DashboardItem.fromListMap(map[_key_dashboard_item]),
    );
  }
}

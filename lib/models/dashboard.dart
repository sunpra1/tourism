import 'package:tourism/models/dashboard_item.dart';
import 'package:tourism/models/dashboard_item_info.dart';

class Dashboard {
  static const _key_dashboard_item = "typeList";
  static const _key_dashboard_top_slider = "headerList";

  List<DashboardItem> dashBoardItems;
  List<DashboardItemInfo> dashboardTopSlider;

  Dashboard({required this.dashBoardItems, required this.dashboardTopSlider});

  factory Dashboard.fromMap(Map<String, dynamic> map) {
    return Dashboard(
      dashBoardItems: DashboardItem.fromListMap(map[_key_dashboard_item]),
      dashboardTopSlider:
          DashboardItemInfo.fromListMap(map[_key_dashboard_top_slider]),
    );
  }
}

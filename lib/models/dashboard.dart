import 'package:json_annotation/json_annotation.dart';
import 'package:tourism/models/dashboard_item.dart';
import 'package:tourism/models/dashboard_item_info.dart';

part '../generated/dashboard.g.dart';

@JsonSerializable()
class Dashboard {
  @JsonKey(name: 'typeList')
  List<DashboardItem> dashBoardItems;
  @JsonKey(name: 'headerList')
  List<DashboardItemInfo> dashboardTopSlider;

  Dashboard({required this.dashBoardItems, required this.dashboardTopSlider})
      : super();

  factory Dashboard.fromJson(Map<String, dynamic> json) =>
      _$DashboardFromJson(json);

  Map<String, dynamic> toJson() => _$DashboardToJson(this);
}

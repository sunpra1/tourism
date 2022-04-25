import 'package:flutter/material.dart';
import 'package:tourism/models/dashboard.dart';
import 'package:tourism/models/dashboard_item.dart';
import 'package:tourism/screens/loading_screen.dart';

import '../models/api_response.dart';
import '../utils/api_request.dart';
import '../widgets/carousel.dart';
import '../widgets/image_gallery_slider.dart';
import '../widgets/image_slider.dart';
import '../widgets/separator.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  Future<Dashboard?> _getDashboardDetails(BuildContext context) async {
    APIResponse response = await APIRequest<Map<String, dynamic>>(
      requestType: RequestType.get,
      requestEndPoint: RequestEndPoint.dashBoardItems,
    ).make();
    if (response.success)
      return Dashboard.fromMap(response.data);
    else
      return null;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getDashboardDetails(context),
      builder: (_, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return LoadingScreen();
        }
        Dashboard dashboard = snapshot.data as Dashboard;

        return Container(
          height: double.infinity,
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Carousel(
                  dashboardItemInfos: dashboard.dashboardTopSlider,
                ),
                Separator(),
                ListView.builder(
                  primary: false,
                  shrinkWrap: true,
                  itemBuilder: (_, index) => HomeItem(
                    dashboardItem: dashboard.dashBoardItems[index],
                    position: index,
                    isLast: index == dashboard.dashBoardItems.length - 1,
                  ),
                  itemCount: dashboard.dashBoardItems.length,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class HomeItem extends StatelessWidget {
  final DashboardItem dashboardItem;
  final int position;
  final bool isLast;

  const HomeItem({
    Key? key,
    required this.dashboardItem,
    required this.position,
    required this.isLast,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        position % 2 == 0
            ? ImageGallerySlider(
                dashboardItem: dashboardItem,
              )
            : ImageSlider(
                dashboardItem: dashboardItem,
                showDetailsAtTop: true,
              ),
        Separator(
          isLast: isLast,
        )
      ],
    );
  }
}

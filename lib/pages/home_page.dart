import 'package:flutter/material.dart';
import 'package:tourism/models/dashboard.dart';
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
                ImageGallerySlider(
                  dashboardItem: dashboard.dashBoardItems[0],
                ),
                Separator(),
                ImageSlider(
                  dashboardItem: dashboard.dashBoardItems[1],
                ),
                Separator(),
                ImageSlider(
                  dashboardItem: dashboard.dashBoardItems[2],
                  showDetailsAtTop: true,
                ),
                Separator(),
                ImageGallerySlider(
                  dashboardItem: dashboard.dashBoardItems[3],
                ),
                Separator(
                  isLast: true,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

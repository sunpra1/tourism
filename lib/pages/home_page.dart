import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:tourism/data/api_service.dart';
import 'package:tourism/models/dashboard.dart';
import 'package:tourism/models/dashboard_item.dart';
import 'package:tourism/pages/failed_getting_data.dart';
import 'package:tourism/screens/loading_screen.dart';
import 'package:tourism/utils/utils.dart';

import '../data/pojo/dashboard_response.dart';
import '../widgets/carousel.dart';
import '../widgets/image_gallery_slider.dart';
import '../widgets/image_slider.dart';
import '../widgets/separator.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<Dashboard?> _getDashboardDetails() async {
    try {
      DashboardResponse dashboardResponse =
          await APIService(Utils.getDioWithInterceptor()).getDashboardData();
      if (dashboardResponse.success)
        return dashboardResponse.data;
      else
        return null;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  _retry() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Dashboard?>(
      future: _getDashboardDetails(),
      builder: (_, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return LoadingScreen();
        }
        Dashboard? dashboard = snapshot.data;

        if (dashboard == null) {
          return FailedGettingData(
            onClick: _retry,
          );
        }

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

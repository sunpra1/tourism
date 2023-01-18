import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tourism/models/dashboard_item_info.dart';
import 'package:tourism/screens/view_blog_screen.dart';

import '../utils/k.dart';
import 'carousel_indicator.dart';

class Carousel extends StatefulWidget {
  final List<DashboardItemInfo> dashboardItemInfos;

  Carousel({Key? key, required this.dashboardItemInfos}) : super(key: key);

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  int currentPageIndex = 0;

  void _onPageChanged(int index) {
    setState(() {
      currentPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: double.infinity,
      child: Card(
        margin: EdgeInsets.zero,
        elevation: 8,
        shadowColor: Colors.black,
        child: GridTile(
          child: PageView.builder(
            onPageChanged: _onPageChanged,
            pageSnapping: true,
            itemBuilder: (_, index) => CarouselItem(
                dashboardItemInfo: widget.dashboardItemInfos[index]),
            itemCount: widget.dashboardItemInfos.length,
            scrollDirection: Axis.horizontal,
          ),
          footer: GridTileBar(
            title: Center(
              child: CarouselIndicator(
                  itemCount: widget.dashboardItemInfos.length,
                  currentPageIndex: currentPageIndex),
            ),
          ),
        ),
      ),
    );
  }
}
//

class CarouselItem extends StatelessWidget {
  final DashboardItemInfo dashboardItemInfo;

  const CarouselItem({Key? key, required this.dashboardItemInfo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () => Navigator.of(context).pushNamed(
          ViewBlogScreen.routeName,
          arguments: dashboardItemInfo.blogId,
        ),
        child:
            dashboardItemInfo.image == null && dashboardItemInfo.image1 == null
                ? Image.asset(
                    "assets/images/app_logo.png",
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  )
                : Image.network(
                    "${K.imageBaseUrl}${(dashboardItemInfo.image != null && dashboardItemInfo.image1 == null) ? dashboardItemInfo.image != null : (dashboardItemInfo.image == null && dashboardItemInfo.image1 != null) ? dashboardItemInfo.image1 : Random().nextInt(9) % 2 == 0 ? dashboardItemInfo.image : dashboardItemInfo.image1}",
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, widget, loadingProgress) {
                      if (loadingProgress == null) return widget;
                      return Center(
                        child: SizedBox(
                          height: 32,
                          width: 32,
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        ),
                      );
                    },
                  ),
      ),
    );
  }
}

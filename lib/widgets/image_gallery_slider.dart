import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tourism/models/dashboard_item.dart';
import 'package:tourism/models/dashboard_item_info.dart';
import 'package:tourism/utils/api_request.dart';

import '../screens/view_destination_screen.dart';
import 'slider_footer.dart';
import 'slider_header.dart';

class ImageGallerySlider extends StatefulWidget {
  final DashboardItem dashboardItem;

  ImageGallerySlider({Key? key, required this.dashboardItem}) : super(key: key);

  @override
  State<ImageGallerySlider> createState() => _ImageGallerySliderState();
}

class _ImageGallerySliderState extends State<ImageGallerySlider> {
  int currentPageIndex = 0;

  void _onPageChanged(int index) {
    setState(() {
      currentPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double padding = 0.0;
    final double headerHeight = 24.0;
    final double footerHeight = 48.0;
    final double availableWidth =
        MediaQuery.of(context).size.width - padding * 2;
    final double mainGridTileSize = (availableWidth * 3) / 5;
    final containerHeight =
        mainGridTileSize + padding * 2 + headerHeight + footerHeight;
    final double secondaryGridTileSize = (mainGridTileSize - 16) / 2;

    return Container(
      height: containerHeight,
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SliderHeader(
              headerHeight: headerHeight,
              title: widget.dashboardItem.typeName.toUpperCase(),
            ),
            Container(
              width: double.infinity,
              height: mainGridTileSize,
              child: PageView.builder(
                onPageChanged: _onPageChanged,
                pageSnapping: true,
                itemCount: widget.dashboardItem.dashboardItemInfoItems.length,
                itemBuilder: (_, index) => ImageGalleryItem(
                  mainGridTileSize: mainGridTileSize,
                  secondaryGridTileSize: secondaryGridTileSize,
                  dashboardItemInfo:
                      widget.dashboardItem.dashboardItemInfoItems[index],
                ),
              ),
            ),
            SliderFooter(
              currentPageIndex: currentPageIndex,
              itemCount: widget.dashboardItem.dashboardItemInfoItems.length,
              carouselPageIndicatorWidth: mainGridTileSize,
              footerHeight: footerHeight,
            ),
          ],
        ),
      ),
    );
  }
}

class ImageGalleryItem extends StatelessWidget {
  final double mainGridTileSize;
  final double secondaryGridTileSize;
  final DashboardItemInfo dashboardItemInfo;

  const ImageGalleryItem({
    Key? key,
    required this.mainGridTileSize,
    required this.secondaryGridTileSize,
    required this.dashboardItemInfo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          width: mainGridTileSize,
          child: GestureDetector(
            onTap: () {

            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: GridTile(
                child: Image.network(
                  "https://${APIRequest.baseUrl}/${dashboardItemInfo.image}",
                  fit: BoxFit.cover,
                ),
                header: GridTileBar(
                  backgroundColor: Colors.black54,
                  title: Text(
                    dashboardItemInfo.title,
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium
                        ?.copyWith(color: Colors.white),
                  ),
                  subtitle: Text(
                    dashboardItemInfo.subTitle,
                    maxLines: 3,
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall
                        ?.copyWith(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: secondaryGridTileSize,
              width: secondaryGridTileSize,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  "https://${APIRequest.baseUrl}/${dashboardItemInfo.image1}",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              height: secondaryGridTileSize,
              width: secondaryGridTileSize,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      "https://${APIRequest.baseUrl}/${dashboardItemInfo.image}",
                      fit: BoxFit.cover,
                    ),
                    Center(
                      child: Text(
                        "+${Random().nextInt(150)}",
                        style:
                            Theme.of(context).textTheme.displayLarge?.copyWith(
                                  color: Colors.white,
                                ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

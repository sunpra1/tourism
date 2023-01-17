import 'package:flutter/material.dart';

import '../models/dashboard_item.dart';
import '../models/dashboard_item_info.dart';
import '../screens/view_blog_screen.dart';
import '../utils/api_request.dart';
import 'image_slider_footer.dart';
import 'slider_header.dart';

class ImageSlider extends StatefulWidget {
  final DashboardItem dashboardItem;
  final bool showDetailsAtTop;

  ImageSlider(
      {Key? key, required this.dashboardItem, this.showDetailsAtTop = false})
      : super(key: key);

  @override
  State<ImageSlider> createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  @override
  Widget build(BuildContext context) {
    final double padding = 0.0;
    final double headerHeight = 32.0;
    final double footerHeight = 48.0;
    final double availableWidth =
        MediaQuery.of(context).size.width - padding * 2;
    final double mainGridTileSize = (availableWidth * 3) / 5;
    final containerHeight =
        mainGridTileSize + padding * 2 + headerHeight + footerHeight;

    return Container(
      height: containerHeight,
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SliderHeader(
              headerHeight: headerHeight,
              title: widget.dashboardItem.typeName.toUpperCase(),
            ),
            Container(
              width: double.infinity,
              height: mainGridTileSize,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.dashboardItem.dashboardItemInfoItems.length,
                itemBuilder: (_, index) => ImageSliderItem(
                  mainGridTileSize: mainGridTileSize,
                  isLastItem: index ==
                      widget.dashboardItem.dashboardItemInfoItems.length - 1,
                  dashboardItemInfo:
                      widget.dashboardItem.dashboardItemInfoItems[index],
                  showDetailsAtTop: widget.showDetailsAtTop,
                ),
              ),
            ),
            ImageSliderFooter(
                imageWidth: mainGridTileSize, footerHeight: footerHeight)
          ],
        ),
      ),
    );
  }
}

class ImageSliderItem extends StatelessWidget {
  final double mainGridTileSize;
  final bool isLastItem;
  final DashboardItemInfo dashboardItemInfo;
  final bool showDetailsAtTop;

  ImageSliderItem({
    Key? key,
    required this.mainGridTileSize,
    required this.isLastItem,
    required this.dashboardItemInfo,
    this.showDetailsAtTop = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(ViewBlogScreen.routeName,
              arguments: dashboardItemInfo.blogId);
        },
        child: Padding(
          padding: EdgeInsets.only(
            left: 16.0,
            right: isLastItem ? 16.0 : 0.0,
          ),
          child: Container(
            width: mainGridTileSize,
            height: mainGridTileSize,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: GridTile(
                child: dashboardItemInfo.image == null
                    ? Image.asset(
                        "assets/images/app_logo.png",
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                      )
                    : Image.network(
                        "https://${APIRequest.baseUrl}${dashboardItemInfo.image}",
                        fit: BoxFit.cover,
                        loadingBuilder: (context, widget, loadingProgress) {
                          if (loadingProgress == null) return widget;
                          return Center(
                            child: LinearProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          );
                        },
                      ),
                header: showDetailsAtTop
                    ? GridTileBar(
                        backgroundColor: Colors.black54,
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              dashboardItemInfo.title,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium
                                  ?.copyWith(color: Colors.white),
                            )
                          ],
                        ),
                        subtitle: Text(
                          dashboardItemInfo.subTitle,
                          maxLines: 3,
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall
                              ?.copyWith(color: Colors.white),
                        ),
                      )
                    : SizedBox.shrink(),
                footer: !showDetailsAtTop
                    ? GridTileBar(
                        backgroundColor: Colors.black54,
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              dashboardItemInfo.title,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium
                                  ?.copyWith(color: Colors.white),
                            )
                          ],
                        ),
                        subtitle: Text(
                          dashboardItemInfo.subTitle,
                          maxLines: 3,
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall
                              ?.copyWith(color: Colors.white),
                        ),
                      )
                    : SizedBox.shrink(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

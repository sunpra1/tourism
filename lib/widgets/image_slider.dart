import 'package:flutter/material.dart';
import 'package:tourism/widgets/image_slider_footer.dart';
import 'package:tourism/widgets/slider_header.dart';

class ImageSlider extends StatefulWidget {
  const ImageSlider({Key? key}) : super(key: key);

  @override
  State<ImageSlider> createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  final List<String> images = [
    "assets/images/carousel1.jpg",
    "assets/images/carousel2.jpg",
    "assets/images/carousel3.jpg"
  ];

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
            ),
            Container(
              width: double.infinity,
              height: mainGridTileSize,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: images.length,
                itemBuilder: (_, index) => ImageSliderItem(
                    mainGridTileSize: mainGridTileSize,
                    isLastItem: index == images.length - 1),
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

  const ImageSliderItem({
    Key? key,
    required this.mainGridTileSize,
    required this.isLastItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
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
            child: Image.asset(
              "assets/images/carousel1.jpg",
              fit: BoxFit.cover,
            ),
            footer: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: GridTileBar(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "LOG TAG",
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall
                          ?.copyWith(color: Colors.white),
                    ),
                    Text(
                      "Arhirappilly",
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium
                          ?.copyWith(color: Colors.white),
                    )
                  ],
                ),
                subtitle: Text(
                  "30 Mar, 2022",
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
    );
  }
}

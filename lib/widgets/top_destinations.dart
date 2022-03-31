import 'package:flutter/material.dart';
import 'package:tourism/widgets/slider_footer.dart';
import 'package:tourism/widgets/slider_header.dart';

import '../screens/view_destination_screen.dart';

class TopDestinations extends StatefulWidget {
  const TopDestinations({Key? key}) : super(key: key);

  @override
  State<TopDestinations> createState() => _TopDestinationsState();
}

class _TopDestinationsState extends State<TopDestinations> {
  final List<String> images = [
    "assets/images/carousel1.jpg",
    "assets/images/carousel2.jpg",
    "assets/images/carousel3.jpg"
  ];

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
            ),
            Container(
              width: double.infinity,
              height: mainGridTileSize,
              child: PageView.builder(
                onPageChanged: _onPageChanged,
                pageSnapping: true,
                itemCount: images.length,
                itemBuilder: (_, index) => TopDestinationItem(
                  mainGridTileSize: mainGridTileSize,
                  secondaryGridTileSize: secondaryGridTileSize,
                ),
              ),
            ),
            SliderFooter(
              currentPageIndex: currentPageIndex,
              itemCount: images.length,
              carouselPageIndicatorWidth: mainGridTileSize,
              footerHeight: footerHeight,
            ),
          ],
        ),
      ),
    );
  }
}

class TopDestinationItem extends StatelessWidget {
  final double mainGridTileSize;
  final double secondaryGridTileSize;

  const TopDestinationItem(
      {Key? key,
      required this.mainGridTileSize,
      required this.secondaryGridTileSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          width: mainGridTileSize,
          child: GestureDetector(
            onTap: (){ Navigator.of(context).pushNamed(ViewDestinationScreen.routeName); },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: GridTile(
                child: Image.asset(
                  "assets/images/carousel1.jpg",
                  fit: BoxFit.cover,
                ),
                header: GridTileBar(
                  title: Text(
                    "WATERFALLS",
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall
                        ?.copyWith(color: Colors.white),
                  ),
                  subtitle: Text(
                    "Arhirappilly",
                    style: Theme.of(context)
                        .textTheme
                        .displayMedium
                        ?.copyWith(color: Colors.white),
                  ),
                ),
                footer: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 12.0,
                  ),
                  child: Text(
                    "Located around 63 km from Kathmandu district, it is a great spot for picnic.",
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
                child: Image.asset(
                  "assets/images/carousel1.jpg",
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
                    Image.asset(
                      "assets/images/carousel1.jpg",
                      fit: BoxFit.cover,
                    ),
                    Center(
                      child: Text(
                        "+51",
                        style:
                            Theme.of(context).textTheme.displayLarge?.copyWith(
                                  color: Colors.white,
                                ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}

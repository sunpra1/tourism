import 'package:flutter/material.dart';

class Carousel extends StatefulWidget {
  const Carousel({Key? key}) : super(key: key);

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
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
    return Container(
        height: 220,
        width: double.infinity,
        child: GridTile(
          child: PageView.builder(
            onPageChanged: _onPageChanged,
            pageSnapping: true,
            itemBuilder: (_, index) => CarouselItem(image: images[index]),
            itemCount: images.length,
            scrollDirection: Axis.horizontal,
          ),
          footer: GridTileBar(
            title: Center(
              child: CarouselIndicator(
                  itemCount: images.length, currentPageIndex: currentPageIndex),
            ),
          ),
        ));
  }
}

class CarouselItem extends StatelessWidget {
  final String image;

  const CarouselItem({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      image,
      width: MediaQuery.of(context).size.width,
      fit: BoxFit.cover,
    );
  }
}

class CarouselIndicator extends StatelessWidget {
  final int currentPageIndex;
  final int itemCount;

  CarouselIndicator(
      {Key? key, required this.itemCount, required this.currentPageIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemBuilder: (_, index) => Padding(
        padding: const EdgeInsets.all(2.0),
        child: Container(
          height: 12,
          width: 12,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: currentPageIndex == index ? Colors.black : Colors.grey),
        ),
      ),
      itemCount: itemCount,
    );
  }
}

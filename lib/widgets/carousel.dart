import 'package:flutter/material.dart';

import 'carousel_indicator.dart';

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

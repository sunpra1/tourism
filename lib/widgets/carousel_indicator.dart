import 'package:flutter/material.dart';


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
              color: currentPageIndex == index ? Theme.of(context).colorScheme.primary : Colors.grey),
        ),
      ),
      itemCount: itemCount,
    );
  }
}
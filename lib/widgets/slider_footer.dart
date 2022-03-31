import 'package:flutter/material.dart';

import 'carousel_indicator.dart';

class SliderFooter extends StatelessWidget {
  final double carouselPageIndicatorWidth;
  final double footerHeight;
  final int currentPageIndex;
  final int itemCount;

  const SliderFooter({
    Key? key,
    required this.currentPageIndex,
    required this.itemCount,
    required this.carouselPageIndicatorWidth,
    required this.footerHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
        child: Row(
          children: [
            SizedBox(
              width: carouselPageIndicatorWidth,
              child: Center(
                child: CarouselIndicator(
                  itemCount: itemCount,
                  currentPageIndex: currentPageIndex,
                ),
              ),
            ),
            Expanded(
              child: TextButton(
                onPressed: () {},
                child: Text(
                  "VIEW ALL",
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: Theme.of(context).colorScheme.secondary),
                ),
              ),
            ),
          ],
        ),
      ),
      height: footerHeight,
    );
  }
}

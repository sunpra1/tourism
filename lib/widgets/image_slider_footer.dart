import 'package:flutter/material.dart';

import 'carousel_indicator.dart';

class ImageSliderFooter extends StatelessWidget {
  final double imageWidth;
  final double footerHeight;

  const ImageSliderFooter({
    Key? key,
    required this.imageWidth,
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
              width: imageWidth,
            ),
            Expanded(
              child: TextButton(
                onPressed: () {},
                child: Text(
                  "VIEW ALL",
                  style: Theme.of(context)
                      .textTheme
                      .labelSmall
                      ?.copyWith(color: Theme.of(context).colorScheme.secondary),
                ),
              ),
            )
          ],
        ),
      ),
      height: footerHeight,
    );
  }
}
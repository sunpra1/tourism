import 'package:flutter/material.dart';

import '../widgets/carousel.dart';
import '../widgets/image_slider.dart';
import '../widgets/separator.dart';
import '../widgets/top_destinations.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Carousel(),
            Separator(),
            TopDestinations(),
            Separator(),
            ImageSlider(),
            Separator(
              isLast: true,
            ),
          ],
        ),
      ),
    );
  }
}

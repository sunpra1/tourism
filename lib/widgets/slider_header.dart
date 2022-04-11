import 'package:flutter/material.dart';

class SliderHeader extends StatelessWidget {
  final double headerHeight;
  final String title;

  const SliderHeader({
    Key? key,
    required this.headerHeight,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: Text(title),
      ),
      height: headerHeight,
    );
  }
}

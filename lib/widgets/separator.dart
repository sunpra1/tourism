import 'package:flutter/material.dart';

class Separator extends StatelessWidget {
  final bool isLast;
  final double height;

  const Separator({Key? key, this.isLast = false, this.height = 12.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: height,
            child: Container(
              color: Colors.grey.shade300,
            ),
          ),
          if (!isLast)
            SizedBox(
              height: 24,
            ),
        ],
      ),
    );
  }
}

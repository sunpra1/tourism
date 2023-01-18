import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class FeelsLonelyHerePage extends StatelessWidget {
  final String message;

  const FeelsLonelyHerePage({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.white,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              "assets/images/feels_lonely.png",
              width: 200.0,
              height: 220.0,
              fit: BoxFit.fill,
            ),
            SizedBox(
              height: 6,
            ),
            Text(
              "It feels lonely here.",
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  ?.copyWith(color: Colors.black),
            ),
            SizedBox(
              height: 6,
            ),
            Text(
              message,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(color: Colors.black..withOpacity(0.6)),
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';

class AppTheme {
  static const String fontFamilySans = "Sans";
  static const String fontFamilyRoboto = "Roboto";
  static TextTheme textTheme = TextTheme(
    labelSmall:
        const TextStyle(fontFamily: AppTheme.fontFamilySans, fontSize: 11),
    labelMedium:
        const TextStyle(fontFamily: AppTheme.fontFamilySans, fontSize: 14),
    labelLarge:
        const TextStyle(fontFamily: AppTheme.fontFamilySans, fontSize: 16),
    titleLarge:
        const TextStyle(fontFamily: AppTheme.fontFamilySans, fontSize: 18),
    displayLarge:
        const TextStyle(fontFamily: AppTheme.fontFamilySans, fontSize: 24),
    displayMedium:
        const TextStyle(fontFamily: AppTheme.fontFamilySans, fontSize: 20),
  );
  static ColorScheme colorScheme = ColorScheme.fromSwatch(
    primarySwatch: Colors.blue,
    primaryColorDark: Colors.blue.shade800,
    accentColor: Colors.red.shade800,
  );
  static LinearGradient gradient = LinearGradient(
    colors: [
      Colors.blue,
      Colors.red.shade800,
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    stops: const [0.0, 1.0],
    tileMode: TileMode.clamp,
  );
  static BoxDecoration backgroundGradient = BoxDecoration(
    gradient: LinearGradient(
      colors: [
        Colors.blue,
        Colors.red.shade800,
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      stops: const [0.0, 1.0],
      tileMode: TileMode.clamp,
    ),
  );
}

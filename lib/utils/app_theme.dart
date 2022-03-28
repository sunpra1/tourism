import 'package:flutter/material.dart';

class AppTheme {
  static const String fontFamilySans = "Sans";
  static const String fontFamilyRoboto = "Roboto";
  static TextTheme textTheme = ThemeData.light().textTheme.copyWith(
        headline1: const TextStyle(fontFamily: AppTheme.fontFamilySans),
        headline2: const TextStyle(fontFamily: AppTheme.fontFamilySans),
        headline3: const TextStyle(fontFamily: AppTheme.fontFamilySans),
        headline4: const TextStyle(fontFamily: AppTheme.fontFamilySans),
        headline5: const TextStyle(fontFamily: AppTheme.fontFamilySans),
        headline6: const TextStyle(fontFamily: AppTheme.fontFamilySans),
        labelSmall: const TextStyle(fontFamily: AppTheme.fontFamilySans, fontSize: 12),
        labelMedium: const TextStyle(fontFamily: AppTheme.fontFamilySans, fontSize: 14),
        labelLarge: const TextStyle(fontFamily: AppTheme.fontFamilySans, fontSize: 16),
        titleLarge: const TextStyle(fontFamily: AppTheme.fontFamilySans, fontSize: 18),
      );
  static ColorScheme colorScheme =
      ColorScheme.fromSwatch(primarySwatch: Colors.blue)
          .copyWith(secondary: Colors.purple);
  static BoxDecoration backgroundGradient = BoxDecoration(
    gradient: LinearGradient(
      colors: [
        Colors.green,
        Colors.green.shade800,
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      stops: const [0.0, 1.0],
      tileMode: TileMode.clamp,
    ),
  );
}
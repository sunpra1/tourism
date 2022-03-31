import 'package:flutter/material.dart';

class BottomNavigationBarMenu {
  final BottomNavigationBarMenuType bottomNavigationBarMenuType;
  final IconData? icon;

  BottomNavigationBarMenu({required this.bottomNavigationBarMenuType, required this.icon});

  static String getOptionString(BottomNavigationBarMenuType drawerMenuType) {
    String value;
    switch (drawerMenuType) {
      case BottomNavigationBarMenuType.nearMe:
        value = "Near Me";
        break;
      case BottomNavigationBarMenuType.whereToStay:
        value = "Where to Stay";
        break;
      case BottomNavigationBarMenuType.essentials:
        value = "Essentials";
        break;
      case BottomNavigationBarMenuType.createStory:
        value = "Create Story";
        break;
      case BottomNavigationBarMenuType.askAQuery:
        value = "Ask a Query";
        break;
      case BottomNavigationBarMenuType.restrooms:
        value = "Restrooms";
        break;
      case BottomNavigationBarMenuType.audioGuide:
        value = "Audio Guide";
        break;
    }
    return value;
  }
}

enum BottomNavigationBarMenuType {
  nearMe,
  whereToStay,
  essentials,
  createStory,
  askAQuery,
  restrooms,
  audioGuide,
}

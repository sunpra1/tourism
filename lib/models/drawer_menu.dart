import 'package:flutter/material.dart';

class DrawerMenu {
  final DrawerMenuType drawerMenuType;
  final IconData? icon;

  DrawerMenu({required this.drawerMenuType, required this.icon});

  static String getOptionString(DrawerMenuType drawerMenuType) {
    String value;
    switch (drawerMenuType) {
      case DrawerMenuType.home:
        value = "HOME";
        break;
    }
    return value;
  }
}

enum DrawerMenuType { home }

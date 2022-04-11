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
      case DrawerMenuType.blog:
        value = "BLOG";
        break;
      case DrawerMenuType.images:
        value = "IMAGES";
        break;
      case DrawerMenuType.videos:
        value = "VIDEOS";
        break;
    }
    return value;
  }
}

enum DrawerMenuType { home, blog, images, videos }

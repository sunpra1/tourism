import 'package:flutter/material.dart';

class DrawerMenu {
  final DrawerMenuType drawerMenuType;
  final IconData? icon;

  DrawerMenu({required this.drawerMenuType, required this.icon});
}

enum DrawerMenuType { home, blog, images, videos, aboutUs, privacyPolicy, termsAndCondition, }

extension DrawerMenuTypeExt on DrawerMenuType{
  String get value {
    String value;
    switch (this) {
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
      case DrawerMenuType.aboutUs:
        value = "ABOUT PANCHPOKHARI";
        break;
      case DrawerMenuType.privacyPolicy:
        value = "PRIVICY POLICY";
        break;
      case DrawerMenuType.termsAndCondition:
        value = "TERMS & CONDITION";
        break;
    }
    return value;
  }
}
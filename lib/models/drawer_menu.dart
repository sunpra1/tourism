import 'package:flutter/cupertino.dart';

class DrawerMenu {
  final DrawerMenuType drawerMenuType;
  final IconData? icon;

  DrawerMenu({required this.drawerMenuType, required this.icon});

  static String getOptionString(DrawerMenuType drawerMenuType) {
    String value;
    switch (drawerMenuType) {
      case DrawerMenuType.login:
        value = "LOGIN";
        break;
      case DrawerMenuType.register:
        value = "REGISTER";
        break;
      case DrawerMenuType.home:
        value = "HOME";
        break;
      case DrawerMenuType.places:
        value = "PLACES";
        break;
    }
    return value;
  }
}

enum DrawerMenuType { login, register, home, places }

import 'package:flutter/material.dart';

import '../models/drawer_menu.dart';

class ActiveDrawerMenuProvider with ChangeNotifier {
  DrawerMenuType activeDrawerMenuType = DrawerMenuType.home;

  void setActiveDrawerMenu(DrawerMenuType activeDrawerMenuType) {
    this.activeDrawerMenuType = activeDrawerMenuType;
    notifyListeners();
  }
}

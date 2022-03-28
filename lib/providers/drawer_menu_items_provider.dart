import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tourism/models/drawer_menu.dart';

class DrawerMenuItemsProvider with ChangeNotifier {
  List<DrawerMenu> drawerMenus = [
    DrawerMenu(
        drawerMenuType: DrawerMenuType.home,
        icon: FaIcon(FontAwesomeIcons.home).icon),
    DrawerMenu(
        drawerMenuType: DrawerMenuType.places,
        icon: FaIcon(FontAwesomeIcons.map).icon)
  ];
}
